import { prisma } from "../lib/prisma";
import { twitterBot } from "./twitter-bot";

const POLL_INTERVAL_MS = 60 * 60 * 1000;
const SHARE_JOURNAL: Set<string> = new Set();

function buildTweet(listing: {
  title?: string | null;
  description?: string | null;
  price?: number | string | null;
  priceCurrency?: string | null;
  property: {
    name: string;
    city?: string | null;
    country?: string | null;
    listingType: string;
    listingPrice?: number | string | null;
    currency?: string | null;
  };
}): string {
  const title = listing.title || listing.property.name;
  const location = [listing.property.city, listing.property.country].filter(Boolean).join(", ");
  const rawPrice = listing.price ?? listing.property.listingPrice;
  const price = rawPrice ? `${listing.priceCurrency || listing.property.currency || "USD"} ${Number(rawPrice).toLocaleString()}` : "";
  const desc = (listing.description || "").slice(0, 180);

  const tweet = [
    `🏡 ${title}`,
    location ? `📍 ${location}` : "",
    price ? `💰 ${price}` : "",
    desc ? `\n${desc}` : "",
    `\n🌐 reservatior.com`,
    `\n#Reservatior #${listing.property.country?.replace(/\s/g, "") || "RealEstate"} #${listing.property.city?.replace(/\s/g, "") || "Luxury"}`,
  ].filter(Boolean).join("\n");

  return tweet.slice(0, 280);
}

async function shareListing(listingId: string): Promise<boolean> {
  const listing = await prisma.listing.findUnique({
    where: { id: listingId },
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
            where: { deletedAt: null, isPrimary: true },
            select: { url: true },
            take: 1,
          },
        },
      },
    },
  });

  if (!listing) return false;

  const text = buildTweet(listing);
  const imageUrl = listing.property.propertyPhotos[0]?.url;

  try {
    const result = await twitterBot.postTweet({
      text,
      media: imageUrl ? [imageUrl] : undefined,
    });

    console.log(`[TwitterAutoPoster] Posted listing ${listingId}: ${result?.data?.id}`);

    return true;
  } catch (error) {
    console.error(`[TwitterAutoPoster] Failed to post listing ${listingId}:`, error);

    return false;
  }
}

async function shareNewListings(): Promise<number> {
  const since = new Date(Date.now() - POLL_INTERVAL_MS);

  const postedIds = await prisma.socialPost.findMany({
    where: { platform: "TWITTER_X", listingId: { not: null } },
    select: { listingId: true },
  });
  const alreadyPosted = new Set(postedIds.map((p) => p.listingId));

  const listings = await prisma.listing.findMany({
    where: {
      status: { in: ["AVAILABLE", "BOOKED"] },
      createdAt: { gte: since },
      property: { listingStatus: { not: "DRAFT" } },
    },
    select: { id: true },
    take: 5,
  });

  let shared = 0;
  for (const l of listings) {
    if (alreadyPosted.has(l.id) || SHARE_JOURNAL.has(l.id)) continue;
    const ok = await shareListing(l.id);
    if (ok) {
      SHARE_JOURNAL.add(l.id);
      shared++;
    }
  }

  return shared;
}

export async function startTwitterAutoPoster(): Promise<void> {
  if (!process.env.TWITTER_BOT_ACCESS_TOKEN) {
    console.log("[TwitterAutoPoster] Disabled — TWITTER_BOT_ACCESS_TOKEN not configured");
    return;
  }

  console.log("[TwitterAutoPoster] Started (polling every 60 min)");

  const initialCount = await shareNewListings();
  if (initialCount > 0) {
    console.log(`[TwitterAutoPoster] Shared ${initialCount} existing listings`);
  }

  setInterval(async () => {
    try {
      const count = await shareNewListings();
      if (count > 0) {
        console.log(`[TwitterAutoPoster] Shared ${count} new listings`);
      }
    } catch (e) {
      console.error("[TwitterAutoPoster] Poll error:", e);
    }
  }, POLL_INTERVAL_MS);
}
