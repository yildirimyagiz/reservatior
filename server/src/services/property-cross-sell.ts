import { prismaManager } from "../lib/prisma";

export interface CrossSellProperty {
  type: string;
  id: string;
  name: string;
  description: string;
  address: string;
  city: string;
  country: string;
  lat: number;
  lng: number;
  rating: number;
  starRating: number;
  photos: string[];
  amenities: string[];
  bedrooms: number;
  bathrooms: number;
  areaSqm: number;
  currency: string;
  listingPrice: number;
  listingType: string;
  propertyUrl: string;
  region: string;
}

const RESIDENTIAL_TYPES = [
  "APARTMENT",
  "STUDIO",
  "PENTHOUSE",
  "FLAT_MAISONETTE",
  "CONDO_APARTMENT",
  "CONDO",
  "TOWNHOUSE",
  "VILLA",
  "CABIN_TINY_HOUSE",
  "ADU_GUEST_HOUSE",
];

export class PropertyCrossSellService {
  async findPropertiesByCity(params: {
    destination: string;
    excludePropertyName?: string;
    maxResults?: number;
  }): Promise<CrossSellProperty[]> {
    const { destination, excludePropertyName, maxResults = 10 } = params;

    const allResults: CrossSellProperty[] = [];
    const seen = new Set<string>();

    // Try all active regions + default
    const regionsToTry = [...new Set([
      ...prismaManager.getActiveRegions(),
      "US", "TR", "UK", "DE", "FR", "ES", "IT", "AE",
    ])];

    for (const region of regionsToTry) {
      try {
        const db = prismaManager.getClient(region);

        const where: any = {
          city: { contains: destination, mode: "insensitive" },
          type: { in: RESIDENTIAL_TYPES },
          listingStatus: "AVAILABLE",
          listingType: { in: ["RENT", "BOOKING"] },
          listingPrice: { not: null },
        };

        if (excludePropertyName) {
          where.name = { not: { equals: excludePropertyName } };
        }

        const properties = await db.property.findMany({
          where,
          take: maxResults,
          include: {
            photos: {
              take: 5,
              orderBy: { isPrimary: "desc" },
            },
          },
          orderBy: { createdAt: "desc" },
        });

        for (const p of properties) {
          if (seen.has(p.id)) continue;
          seen.add(p.id);

          const amenities: string[] = [];
          if (p.poolType) amenities.push("Pool");
          if (p.garageCapacity && p.garageCapacity > 0) amenities.push("Parking");
          if (p.viewType) amenities.push(`${p.viewType} View`);
          if (p.basementType) amenities.push("Basement");
          if (p.parkingSpaces && p.parkingSpaces > 0) amenities.push(`${p.parkingSpaces} Parking Spaces`);
          if (p.smartHomeFeatures?.length) amenities.push(...p.smartHomeFeatures);
          if (p.securityFeatures?.length) amenities.push(...p.securityFeatures);
          if (p.outdoorFeatures?.length) amenities.push(...p.outdoorFeatures);
          if (p.accessibilityFeatures?.length) amenities.push(...p.accessibilityFeatures);
          if (p.heatingType) amenities.push("Heating");
          if (p.coolingType) amenities.push("Air Conditioning");
          if (p.waterfrontType) amenities.push("Waterfront");

          const photos = p.photos
            ?.filter((ph: any) => ph.url)
            .map((ph: any) => ph.url) ?? [];

          allResults.push({
            type: p.type || "APARTMENT",
            id: `${region}-${p.id}`,
            name: p.name,
            description: p.notes || p.name,
            address: p.addressLine1,
            city: p.city,
            country: p.country,
            lat: p.lat || 0,
            lng: p.lng || 0,
            rating: 0,
            starRating: 0,
            photos,
            amenities,
            bedrooms: p.bedrooms || 1,
            bathrooms: p.bathrooms || 1,
            areaSqm: p.areaSqm || 0,
            currency: p.currency || "USD",
            listingPrice: Number(p.listingPrice || 0),
            listingType: p.listingType,
            propertyUrl: `/property/${p.id}`,
            region,
          });
        }
      } catch (err) {
        continue;
      }
    }

    allResults.sort((a, b) => a.listingPrice - b.listingPrice);
    return allResults.slice(0, maxResults);
  }
}

export const propertyCrossSellService = new PropertyCrossSellService();
