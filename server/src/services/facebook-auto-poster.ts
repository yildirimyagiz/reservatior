import { prisma } from "../lib/prisma";
import { createImageMediaContainer, createCarouselContainer } from "./instagram";

const POLL_INTERVAL_MS = 60 * 60 * 1000;

interface FacebookConfig {
  pageId: string;
  accessToken: string;
}

async function getConfig(): Promise<FacebookConfig | null> {
  const pageId = process.env.META_PAGE_ID;
  const accessToken = process.env.META_ACCESS_TOKEN;
  if (!pageId || !accessToken) return null;
  return { pageId, accessToken };
}

function buildPost(data: {
  name: string;
  city?: string | null;
  country?: string | null;
  listingType: string;
  price?: string;
  description?: string | null;
}): string {
  const location = [data.city, data.country].filter(Boolean).join(", ");
  const desc = (data.description || "").slice(0, 300);

  return [
    desc,
    `${data.name}${location ? ` \u2014 ${location}` : ""}`,
    data.price ? `\uD83D\uDCB0 ${data.price}` : "",
    `\uD83D\uDCCB ${data.listingType}`,
    "",
    `\u2728 Exclusive listing on Reservatior`,
    `\uD83D\uDD17 Link in comments`,
  ].filter(Boolean).join("\n");
}

async function postToFacebookPage(
  config: FacebookConfig,
  message: string,
  photoUrls: string[],
): Promise<boolean> {
  // Post with photo(s) to Facebook Page feed
  const url = `https://graph.facebook.com/v21.0/${config.pageId}/feed`;

  const params: Record<string, string> = {
    message,
    access_token: config.accessToken,
  };

  if (photoUrls.length === 1) {
    params.attached_media = JSON.stringify([{ media_fbid: "", url: photoUrls[0] }]);
  }

  try {
    const res = await fetch(url, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(params),
    });
    const data = await res.json();
    return res.ok;
  } catch {
    return false;
  }
}

async function shareNewListings(): Promise<number> {
  const config = await getConfig();
  if (!config) return 0;

  const since = new Date(Date.now() - POLL_INTERVAL_MS);

  const postedIds = await prisma.socialPost.findMany({
    where: { platform: "FACEBOOK", listingId: { not: null } },
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
      title: true,
      description: true,
      price: true,
      priceCurrency: true,
      property: {
        select: {
          name: true,
          city: true,
          country: true,
          listingType: true,
          listingPrice: true,
          currency: true,
          propertyPhotos: {
            where: { deletedAt: null },
            orderBy: { sortOrder: "asc" },
            select: { url: true },
            take: 3,
          },
        },
      },
    },
    take: 5,
  });

  let shared = 0;
  for (const l of listings) {
    if (alreadyPosted.has(l.id)) continue;

    const rawPrice = l.price ?? l.property.listingPrice;
    const priceStr = rawPrice ? `${l.priceCurrency || l.property.currency || "USD"} ${Number(rawPrice).toLocaleString()}` : undefined;

    const message = buildPost({
      name: l.title || l.property.name,
      city: l.property.city,
      country: l.property.country,
      listingType: l.property.listingType,
      price: priceStr,
      description: l.description || undefined,
    });

    const photoUrls = l.property.propertyPhotos.map((p) => p.url);
    const ok = await postToFacebookPage(config, message, photoUrls);

    await prisma.socialPost.create({
      data: {
        orgId: "default",
        socialAccountId: config.pageId,
        listingId: l.id,
        platform: "FACEBOOK",
        postType: "LISTING_NEW",
        status: ok ? "PUBLISHED" : "FAILED",
        content: message,
        mediaUrls: photoUrls,
        hashtags: ["Reservatior", l.property.country || "RealEstate"],
        publishedAt: ok ? new Date() : undefined,
        failureReason: ok ? undefined : "Facebook API error",
      },
    });

    if (ok) shared++;
  }

  return shared;
}

export async function startFacebookAutoPoster(): Promise<void> {
  const config = await getConfig();
  if (!config) {
    console.log("[FacebookAutoPoster] Disabled — META_PAGE_ID / META_ACCESS_TOKEN not configured");
    return;
  }

  console.log("[FacebookAutoPoster] Started (polling every 60 min)");

  const initialCount = await shareNewListings();
  if (initialCount > 0) {
    console.log(`[FacebookAutoPoster] Shared ${initialCount} existing listings`);
  }

  setInterval(async () => {
    try {
      const count = await shareNewListings();
      if (count > 0) {
        console.log(`[FacebookAutoPoster] Shared ${count} new listings`);
      }
    } catch (e) {
      console.error("[FacebookAutoPoster] Poll error:", e);
    }
  }, POLL_INTERVAL_MS);
}
