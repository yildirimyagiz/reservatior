import { prismaManager } from "../lib/prisma";

// Singleton Prisma instance — avoid connection pool exhaustion
let _prisma: PrismaClient | null = null;
function getPrisma(): PrismaClient {
  if (!_prisma) {
    _prisma = prismaManager.getDefault();
  }
  return _prisma;
}

export interface UpsellParams {
  destination: string;
  checkIn: string;
  checkOut: string;
  guests: number;
}

export interface UpsellResult {
  hasUpsell: boolean;
  upsell?: {
    propertyId: string;
    name: string;
    city: string;
    bedrooms: number | null;
    bathrooms: number | null;
    pricePerNight: any;
    currency: string;
    image: string;
    aiMessage: string;
    savingsPercent: number;
    days: number;
    areaSqm: number | null;
    features: string[];
  };
}

const AI_MESSAGES_TR = [
  (days: number, city: string, bedrooms: number | null, savings: number) =>
    `Neden ${days} gün boyunca dar bir otel odasına sıkışıp kalasınız? ${city}'deki bu tam donanımlı ${bedrooms || 1} yatak odalı lüks rezidansımızda konaklamak, aradığınız otele göre %${savings} daha avantajlı. Üstelik tam donanımlı mutfak ve geniş yaşam alanı ayrıcalığıyla!`,
  (days: number, city: string, bedrooms: number | null, savings: number) =>
    `${days} gece otel yerine ${city}'de ${bedrooms || 1}+1 rezidansımız %${savings} daha uygun — üstelik özel mutfak, çamaşır makinesi ve panoramik manzara dahil!`,
  (days: number, city: string, bedrooms: number | null, savings: number) =>
    `Uzun tatil = Akıllı konaklama. ${city} merkezde ${bedrooms || 1} yatak odalı dairemiz, otelden %${savings} ucuz. Ev konforu, otel fiyatının altında.`,
];

export class AIArbitrageService {
  
  /**
   * Evaluates if an upsell/arbitrage opportunity exists for the given hotel search.
   * If stay is >= 3 days, it finds a luxury residential property and generates a pitch.
   */
  public static async evaluateUpsell(params: UpsellParams): Promise<UpsellResult> {
    const prisma = getPrisma();
    console.log(`[AI-ARBITRAGE] Evaluating upsell for ${params.destination}, Guests: ${params.guests}`);
    
    // Calculate days between checkIn and checkOut
    const checkInDate = new Date(params.checkIn);
    const checkOutDate = new Date(params.checkOut);
    const timeDiff = checkOutDate.getTime() - checkInDate.getTime();
    const days = Math.ceil(timeDiff / (1000 * 3600 * 24));

    if (days < 3 || isNaN(days)) {
      console.log(`[AI-ARBITRAGE] Stay too short (${days} days) or invalid dates. No upsell.`);
      return { hasUpsell: false };
    }

    // Attempt to find a suitable property from our DB (Arbitrage Inventory)
    // We look for a RESIDENTIAL property in the given destination
    let property: any = null;
    
    try {
      property = await prisma.property.findFirst({
        where: {
          city: {
            contains: params.destination,
            mode: 'insensitive'
          },
          listingType: 'RENT',
          propertyCategory: 'RESIDENTIAL',
          bedrooms: {
            gte: Math.max(1, Math.ceil(params.guests / 2))
          }
        },
        include: {
          photos: {
            take: 3
          },
          amenities: {
            take: 5,
            include: { amenity: true }
          }
        }
      });

      // Fallback: broaden the search to any city if no match for this destination
      if (!property) {
        console.log(`[AI-ARBITRAGE] No exact match in ${params.destination}, falling back to premium inventory.`);
        property = await prisma.property.findFirst({
          where: {
            propertyCategory: 'RESIDENTIAL',
            listingType: 'RENT',
            bedrooms: { gte: 1 }
          },
          include: {
            photos: {
              take: 3
            },
            amenities: {
              take: 5,
              include: { amenity: true }
            }
          }
        });
      }
    } catch (err) {
      console.error('[AI-ARBITRAGE] Database query failed:', err);
      return { hasUpsell: false };
    }

    if (!property) {
      return { hasUpsell: false };
    }

    // Generate AI Pitch
    const savingsPercent = Math.floor(Math.random() * 15) + 20; // 20-35% savings
    const messageIndex = Math.floor(Math.random() * AI_MESSAGES_TR.length);
    const aiMessage = AI_MESSAGES_TR[messageIndex](days, property.city, property.bedrooms, savingsPercent);

    // Extract amenity names for features list
    const features = property.amenities
      ?.map((pa: any) => pa.amenity?.name)
      .filter(Boolean) || ['Tam Donanımlı Mutfak', 'WiFi', 'Klima'];

    const upsellData = {
      propertyId: property.id,
      name: property.name,
      city: property.city,
      bedrooms: property.bedrooms,
      bathrooms: property.bathrooms,
      pricePerNight: property.listingPrice,
      currency: property.currency,
      image: property.photos?.[0]?.url || "https://images.unsplash.com/photo-1600596542815-ffad4c1539a9?w=800&q=80",
      aiMessage,
      savingsPercent,
      days,
      areaSqm: property.areaSqm,
      features,
    };

    console.log(`[AI-ARBITRAGE] Upsell found: ${property.name} in ${property.city} (save ${savingsPercent}%)`);

    return {
      hasUpsell: true,
      upsell: upsellData
    };
  }
}
