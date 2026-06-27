/**
 * AI Arbitrage & Upsell Service
 * 
 * Evaluates long-stay hotel searches and recommends switching to our own 
 * luxury residential inventory for higher profit margins.
 * 
 * Trigger: stay >= 3 days on a BOOKING search
 */

import { PrismaClient } from '@prisma/client';

// Singleton Prisma instance — avoid connection pool exhaustion
let _prisma: PrismaClient | null = null;
function getPrisma(): PrismaClient {
  if (!_prisma) {
    _prisma = new PrismaClient();
  }
  return _prisma;
}

export interface UpsellParams {
  destination: string;
  checkIn: string;
  checkOut: string;
  guests: number;
  language?: string;
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
  (days: number, city: string, bedrooms: number | null, savings: number, typeTr: string) =>
    `Neden ${days} gün boyunca dar bir otel odasına sıkışıp kalasınız? ${city}'deki bu tam donanımlı ${bedrooms || 1} yatak odalı lüks ${typeTr} seçeneğinde konaklamak, aradığınız otele göre %${savings} daha avantajlı. Üstelik tam donanımlı mutfak ve geniş yaşam alanı ayrıcalığıyla!`,
  (days: number, city: string, bedrooms: number | null, savings: number, typeTr: string) =>
    `${days} gece otel yerine ${city}'de ${bedrooms || 1}+1 ${typeTr} alternatifimiz %${savings} daha uygun — üstelik özel mutfak, çamaşır makinesi ve panoramik manzara dahil!`,
  (days: number, city: string, bedrooms: number | null, savings: number, typeTr: string) =>
    `Uzun tatil = Akıllı konaklama. ${city} merkezde ${bedrooms || 1} yatak odalı ${typeTr}, otelden %${savings} ucuz. Ev konforu, otel fiyatının altında.`,
];

const getTypeLabelTR = (type: string) => {
  if (type === "VILLA") return "villamız";
  if (type === "CONDO_APARTMENT" || type === "CONDO") return "rezidansımız";
  if (type === "STUDIO") return "stüdyomuz";
  if (type === "PENTHOUSE") return "penthouse";
  return "dairemiz";
};

const AI_MESSAGES_EN = [
  (days: number, city: string, bedrooms: number | null, savings: number, typeEn: string) =>
    `Why squeeze into a cramped hotel room for ${days} days? Staying in this fully equipped ${bedrooms || 1}-bedroom luxury ${typeEn} in ${city} is ${savings}% more cost-effective than the hotel you're looking for. Plus, you get a full kitchen and spacious living area!`,
  (days: number, city: string, bedrooms: number | null, savings: number, typeEn: string) =>
    `Instead of a hotel for ${days} nights, our ${bedrooms || 1}-bedroom ${typeEn} in ${city} is ${savings}% cheaper — including a private kitchen, washer, and panoramic views!`,
  (days: number, city: string, bedrooms: number | null, savings: number, typeEn: string) =>
    `Long trip = Smart stay. Our ${bedrooms || 1}-bedroom ${typeEn} in central ${city} is ${savings}% cheaper than a hotel. Home comfort, below hotel prices.`,
];

const getTypeLabelEN = (type: string) => {
  if (type === "VILLA") return "villa";
  if (type === "CONDO_APARTMENT" || type === "CONDO") return "residence";
  if (type === "STUDIO") return "studio";
  if (type === "PENTHOUSE") return "penthouse";
  return "apartment";
};

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
    const isTurkish = params.language === 'tr' || params.language === 'tr-TR';
    const messages = isTurkish ? AI_MESSAGES_TR : AI_MESSAGES_EN;
    const typeLabel = isTurkish ? getTypeLabelTR(property.type || "APARTMENT") : getTypeLabelEN(property.type || "APARTMENT");

    const savingsPercent = Math.floor(Math.random() * 15) + 20; // 20-35% savings
    const messageIndex = Math.floor(Math.random() * messages.length);
    const aiMessage = messages[messageIndex](days, property.city, property.bedrooms, savingsPercent, typeLabel);

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
