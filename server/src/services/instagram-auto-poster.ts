import { prisma } from "../lib/prisma";
import {
  createImageMediaContainer,
  createVideoMediaContainer,
  createCarouselContainer,
  publishMediaContainer,
} from "./instagram";
import { generateInstagramContent, ListingData } from "./instagram-content-ai";

const POLL_INTERVAL_MS = 60 * 60 * 1000;

type SocialPostStatus = "DRAFT" | "PENDING_APPROVAL" | "SCHEDULED" | "PUBLISHED" | "FAILED" | "ARCHIVED";

interface InstagramConfig {
  socialAccountId: string;
  igUserId: string;
  accessToken: string;
}

// ── Config ────────────────────────────────────────────────────────────────────

async function getConfig(): Promise<InstagramConfig | null> {
  const account = await prisma.socialAccount.findFirst({
    where: { platform: "INSTAGRAM", isActive: true },
    orderBy: { createdAt: "desc" },
  });
  if (!account?.accessToken || !account.igUserId) return null;
  return {
    socialAccountId: account.id,
    igUserId: account.igUserId,
    accessToken: account.accessToken,
  };
}

// ── Media ─────────────────────────────────────────────────────────────────────

async function collectMedia(
  listingId: string,
  propertyId: string,
): Promise<{ mediaUrls: string[]; hasVideo: boolean }> {
  const photos = await prisma.propertyPhoto.findMany({
    where: { propertyId, deletedAt: null },
    orderBy: { sortOrder: "asc" },
    take: 5,
  });

  const videos = await prisma.videoContent.findMany({
    where: {
      OR: [{ listingId }, { propertyId }],
      url: { not: null },
      status: { in: ["PUBLISHED", "COMPLETED"] },
    },
    orderBy: { createdAt: "desc" },
    take: 3,
  });

  const urls: string[] = [];
  for (const v of videos) {
    if (v.url) urls.push(v.url);
  }
  for (const p of photos) {
    if (urls.length >= 10) break;
    urls.push(p.url);
  }

  return { mediaUrls: urls, hasVideo: videos.length > 0 };
}

// ── Posting ───────────────────────────────────────────────────────────────────

async function shareListing(
  config: InstagramConfig,
  listing: ListingData,
): Promise<boolean> {
  const { mediaUrls, hasVideo } = await collectMedia(listing.id, listing.propertyId);
  if (mediaUrls.length === 0) return false;

  const aiContent = await generateInstagramContent(listing);
  const fullCaption = `${aiContent.caption}\n\n${aiContent.hashtags.map((h) => `#${h}`).join(" ")}`;

  // Save SocialAIContent record
  const socialAi = await prisma.socialAIContent.create({
    data: {
      orgId: "default",
      listingId: listing.id,
      contentType: "POST",
      prompt: `Auto-generated caption for ${listing.title || listing.property.name}`,
      generatedText: aiContent.caption,
      generatedHashtags: aiContent.hashtags,
      model: "reservatior-ai-v1",
      approved: true,
      approvedAt: new Date(),
    },
  });

  let result;
  if (mediaUrls.length === 1 && hasVideo) {
    const container = await createVideoMediaContainer(config.igUserId, mediaUrls[0], fullCaption, config.accessToken);
    if (!container.success) {
      await savePost(config, listing.id, "FAILED", fullCaption, aiContent.hashtags, mediaUrls, socialAi.id, container.error);
      return false;
    }
    result = await publishMediaContainer(config.igUserId, container.mediaId!, config.accessToken);
  } else if (mediaUrls.length === 1) {
    const container = await createImageMediaContainer(config.igUserId, mediaUrls[0], fullCaption, config.accessToken);
    if (!container.success) {
      await savePost(config, listing.id, "FAILED", fullCaption, aiContent.hashtags, mediaUrls, socialAi.id, container.error);
      return false;
    }
    result = await publishMediaContainer(config.igUserId, container.mediaId!, config.accessToken);
  } else {
    result = await createCarouselContainer(config.igUserId, mediaUrls, fullCaption, config.accessToken);
  }

  await savePost(
    config, listing.id,
    result.success ? "PUBLISHED" : "FAILED",
    fullCaption, aiContent.hashtags, mediaUrls,
    socialAi.id, result.mediaId, result.error,
  );

  return result.success;
}

async function savePost(
  config: InstagramConfig,
  listingId: string,
  status: SocialPostStatus,
  content: string,
  hashtags: string[],
  mediaUrls: string[],
  aiGenerationId?: string,
  externalPostId?: string,
  failureReason?: string,
) {
  await prisma.socialPost.create({
    data: {
      orgId: "default",
      socialAccountId: config.socialAccountId,
      listingId,
      platform: "INSTAGRAM",
      postType: "LISTING_NEW",
      status,
      content,
      mediaUrls,
      hashtags,
      aiGenerationId,
      externalPostId,
      failureReason,
      ...(status === "PUBLISHED" ? { publishedAt: new Date() } : {}),
    },
  });
}

// ── Polling ───────────────────────────────────────────────────────────────────

export async function shareNewListings(): Promise<number> {
  const config = await getConfig();
  if (!config) return 0;

  const since = new Date(Date.now() - POLL_INTERVAL_MS);

  const postedIds = await prisma.socialPost.findMany({
    where: { platform: "INSTAGRAM", listingId: { not: null } },
    select: { listingId: true },
  });
  const alreadyPosted = new Set(postedIds.map((p) => p.listingId));

  const listings = await prisma.listing.findMany({
    where: {
      status: { in: ["AVAILABLE", "BOOKED"] },
      createdAt: { gte: since },
      property: { listingStatus: { not: "DRAFT" } },
    },
    select: {
      id: true,
      propertyId: true,
      title: true,
      description: true,
      price: true,
      priceCurrency: true,
      type: true,
      status: true,
      property: {
        select: {
          name: true,
          city: true,
          country: true,
          notes: true,
          listingType: true,
          listingPrice: true,
          currency: true,
          propertyCategory: true,
        },
      },
    },
    take: 5,
  });

  let shared = 0;
  for (const listing of listings) {
    if (alreadyPosted.has(listing.id)) continue;
    const rawPrice = listing.price ?? listing.property.listingPrice;
    const ok = await shareListing(config, {
      ...listing,
      price: rawPrice ? Number(rawPrice) : null,
      property: {
        ...listing.property,
        listingPrice: listing.property.listingPrice ? Number(listing.property.listingPrice) : null,
      },
    });
    if (ok) shared++;
  }

  return shared;
}

// ── Start ─────────────────────────────────────────────────────────────────────

export async function startInstagramAutoPoster(): Promise<void> {
  const config = await getConfig();
  if (!config) {
    console.log("[InstagramAutoPoster] Disabled — no active Instagram SocialAccount found in DB");
    return;
  }

  console.log("[InstagramAutoPoster] Started (polling every 60 min)");

  const initialCount = await shareNewListings();
  if (initialCount > 0) {
    console.log(`[InstagramAutoPoster] Shared ${initialCount} existing listings`);
  }

  setInterval(async () => {
    try {
      const count = await shareNewListings();
      if (count > 0) {
        console.log(`[InstagramAutoPoster] Shared ${count} new listings`);
      }
    } catch (e) {
      console.error("[InstagramAutoPoster] Poll error:", e);
    }
  }, POLL_INTERVAL_MS);
}
