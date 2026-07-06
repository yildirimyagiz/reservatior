export interface ListingData {
  id: string;
  title?: string | null;
  description?: string | null;
  price?: number | null;
  priceCurrency?: string | null;
  type: string;
  property: {
    name: string;
    city?: string | null;
    country?: string | null;
    listingType: string;
    listingPrice?: number | null;
    currency?: string | null;
    propertyCategory?: string | null;
    notes?: string | null;
  };
}

export async function generateInstagramContent(
  listing: ListingData,
): Promise<{ caption: string; hashtags: string[] }> {
  const location = [listing.property.city, listing.property.country].filter(Boolean).join(", ");
  const price = listing.price ?? listing.property.listingPrice;
  const priceStr = price ? `${listing.priceCurrency || listing.property.currency || "USD"} ${Number(price).toLocaleString()}` : "";

  const caption = buildCaption({
    name: listing.title || listing.property.name,
    description: listing.description || listing.property.notes || undefined,
    location,
    price: priceStr,
    listingType: listing.property.listingType,
  });

  const hashtags = buildHashtags(listing.property);

  return { caption, hashtags };
}

function buildCaption(data: {
  name: string;
  description?: string;
  location: string;
  price: string;
  listingType: string;
}): string {
  const desc = (data.description || "").slice(0, 180);

  return [
    desc,
    `${data.name}${data.location ? ` — ${data.location}` : ""}`,
    data.price ? `💰 ${data.price}` : "",
    `📋 ${formatType(data.listingType)}`,
    "",
    `✨ Exclusive listing on @reservatior`,
    `🔗 Link in bio to book / inquire`,
  ]
    .filter(Boolean)
    .join("\n");
}

function buildHashtags(property: {
  country?: string | null;
  city?: string | null;
  listingType: string;
  propertyCategory?: string | null;
}): string[] {
  const tags = [
    "Reservatior",
    property.country?.replace(/\s/g, "") || "Global",
    property.city?.replace(/\s/g, "") || "Luxury",
    "RealEstate",
    "LuxuryLiving",
    "DreamHome",
  ];
  if (property.propertyCategory) {
    tags.push(property.propertyCategory);
  }
  return [...new Set(tags)];
}

function formatType(type: string): string {
  switch (type) {
    case "SALE": return "For Sale";
    case "RENT": return "For Rent";
    case "BOOKING": return "Available for Booking";
    default: return type;
  }
}
