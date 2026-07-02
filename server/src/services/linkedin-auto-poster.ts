import { prisma } from "../lib/prisma";
import { shareToLinkedInPerson, shareToLinkedInCompany } from "./linkedin";

const POLL_INTERVAL_MS = 30 * 60 * 1000;
const ELIGIBLE_LISTING_TYPES = ["BOOKING"];
const SHARE_JOURNAL: Set<string> = new Set();

function eligibleCategory(categorySlug?: string | null): boolean {
  if (!categorySlug) return false;
  const slugs = [
    "hotel", "serviced-apartment", "residence",
    "corporate-housing", "short-term-rental", "vacation-rental",
    "business-travel", "serviced-flat", "apartment-hotel",
    "office-rental", "corporate-office",
  ];
  return slugs.some((s) => categorySlug.toLowerCase().includes(s));
}

function buildShareText(property: {
  name: string; city?: string | null; country?: string | null;
  listingType: string; listingPrice?: number | null; currency?: string | null;
}): string {
  const location = [property.city, property.country].filter(Boolean).join(", ");
  const price = property.listingPrice
    ? `${property.currency || "USD"} ${property.listingPrice.toLocaleString()}`
    : "";
  const lines = [
    `🏢 ${property.name}`,
    location ? `📍 ${location}` : "",
    price ? `💰 ${price}` : "",
    `📋 Type: ${property.listingType}`,
    "",
    `Discover more on Reservatior — the premium real estate platform with AI-powered search.`,
    `#RealEstate #BusinessTravel #CorporateHousing #Reservatior`,
  ];
  return lines.filter(Boolean).join("\n");
}

async function shareToAll(text: string, propertyId: string): Promise<boolean> {
  const accessToken = process.env.LINKEDIN_ACCESS_TOKEN;
  if (!accessToken) {
    console.warn("[LinkedInAutoPoster] LINKEDIN_ACCESS_TOKEN not set");
    return false;
  }

  const personUrn = process.env.LINKEDIN_PERSON_URN;
  const companyId = process.env.LINKEDIN_COMPANY_ID;

  let anySuccess = false;

  // Personal profile share
  if (personUrn) {
    const result = await shareToLinkedInPerson(accessToken, personUrn, text);
    if (result.success) {
      console.log(`[LinkedInAutoPoster] Shared to profile: ${propertyId} (${result.postId})`);
      anySuccess = true;
    } else {
      console.error(`[LinkedInAutoPoster] Profile share failed for ${propertyId}: ${result.error}`);
    }
  }

  // Company page share
  if (companyId) {
    const result = await shareToLinkedInCompany(accessToken, text);
    if (result.success) {
      console.log(`[LinkedInAutoPoster] Shared to company: ${propertyId} (${result.postId})`);
      anySuccess = true;
    } else {
      console.error(`[LinkedInAutoPoster] Company share failed for ${propertyId}: ${result.error}`);
    }
  }

  return anySuccess;
}

async function shareNewProperties(): Promise<number> {
  const since = new Date(Date.now() - POLL_INTERVAL_MS);

  const properties = await prisma.property.findMany({
    where: {
      listingType: { in: ELIGIBLE_LISTING_TYPES as any },
      createdAt: { gte: since },
      published: true,
    },
    select: {
      id: true, name: true, city: true, country: true,
      listingType: true, listingPrice: true, currency: true,
      category: { select: { slug: true } },
    },
    take: 10,
  });

  let shared = 0;
  for (const p of properties) {
    if (SHARE_JOURNAL.has(p.id)) continue;
    if (!eligibleCategory(p.category?.slug)) continue;

    const text = buildShareText(p);
    const ok = await shareToAll(text, p.id);
    if (ok) {
      SHARE_JOURNAL.add(p.id);
      shared++;
    }
  }

  return shared;
}

export async function startLinkedInAutoPoster(): Promise<void> {
  const accessToken = process.env.LINKEDIN_ACCESS_TOKEN;
  if (!accessToken) {
    console.log("[LinkedInAutoPoster] Disabled — LINKEDIN_ACCESS_TOKEN not configured");
    return;
  }

  console.log("[LinkedInAutoPoster] Started (polling every 30 min)");

  const initialCount = await shareNewProperties();
  if (initialCount > 0) {
    console.log(`[LinkedInAutoPoster] Shared ${initialCount} existing properties`);
  }

  setInterval(async () => {
    try {
      const count = await shareNewProperties();
      if (count > 0) {
        console.log(`[LinkedInAutoPoster] Shared ${count} new properties`);
      }
    } catch (e) {
      console.error("[LinkedInAutoPoster] Poll error:", e);
    }
  }, POLL_INTERVAL_MS);
}
