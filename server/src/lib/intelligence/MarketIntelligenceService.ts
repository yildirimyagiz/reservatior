import { PrismaClient, ListingType } from "@prisma/client";
import { Decimal } from "@prisma/client/runtime/library";
import { prismaManager } from "../prisma";

const prisma = prismaManager.getDefault();

export interface ScrapedData {
  price: number;
  currency: string;
  sourceName: string;
  externalUrl: string;
}

const COUNTRY_SCRAPER_MAP: Record<string, string[]> = {
  "Turkey": ["SAHIBINDEN", "HEPSIEMLAK", "ZINGAT"],
  "USA": ["ZILLOW", "REDFIN", "REALTOR_COM", "AIRBNB"],
  "UK": ["RIGHTMOVE", "ZOOPLA", "AIRBNB"],
  "Brazil": ["VIVAREAL", "ZAP_IMOVEIS", "AIRBNB"],
  "Japan": ["SUUMO", "LIFULL", "RAKUTEN_TRAVEL"],
  "China": ["LIANJIA", "ANJUKE", "TRIP_COM"],
  "India": ["MAGICBRICKS", "99ACRES", "MAKEMYTRIP"],
  "Russia": ["CIAN", "AVITO", "OSTROVOK"],
  "Mexico": ["INMUEBLES24", "DESPEGAR"],
  "Thailand": ["DDPROPERTY", "AGODA"],
  "Argentina": ["ZONAPROP", "MERCADOLIBRE"],
  "Singapore": ["PROPERTYGURU", "99_CO"],
  "Australia": ["REALESTATE_AU", "DOMAIN_AU"],
  "New Zealand": ["TRADEME", "REALESTATE_NZ"]
};

export class MarketIntelligenceService {
  /**
   * Main entry point to synchronize our internal listing price with external market competitors
   */
  static async syncPropertyPrice(propertyId: string, orgId: string) {
    // 1. Fetch our local property data
    const property = await prisma.property.findUnique({
      where: { id: propertyId },
      include: {
        listings: {
          where: { status: "AVAILABLE" },
          take: 1
        }
      }
    });

    if (!property || property.listings.length === 0) {
      throw new Error("No active listing found for this property to compare.");
    }

    const currentListing = property.listings[0];
    const ourPrice = Number(currentListing.price || 0);
    const listingType = (currentListing.type as unknown as ListingType);

    // 2. UNIVERSAL COUNTRY-SPECIFIC SCRAPER SELECTION
    // We look up the best source for this specific country
    const country = property.country || "USA";
    const availableSources = COUNTRY_SCRAPER_MAP[country] || ["AIRBNB", "BOOKING"];
    
    // Pick the most relevant source (First one is primary local leader)
    const sourceName = availableSources[0];
    
    // 3. SECURE SCRAPING ENGINE (MOCK for prototype)
    // Here we would call Puppeteer/Cheerio/BrightData
    const externalData = await this.scrapeExternalListing(sourceName, "https://mock-external-source.com/listing/" + propertyId);

    // 4. Calculate Savings & Difference
    const competitorPrice = externalData.price;
    const priceDifference = competitorPrice - ourPrice;
    const savingsPercentage = (priceDifference / competitorPrice) * 100;

    // 5. Update or Create MarketRateComparison
    // Cast to any to bypass the "marketRateComparison does not exist" IDE error 
    // until 'npx prisma generate' is run.
    const comparison = await (prisma as any).marketRateComparison.upsert({
      where: { 
        // Compound unique key defined across all 20+ schemas: propertyId + sourceName
        propertyId_sourceName: { propertyId, sourceName }
      },
      update: {
        competitorPrice: new Decimal(competitorPrice),
        ourPrice: new Decimal(ourPrice),
        priceDifference: new Decimal(priceDifference),
        savingsPercentage: savingsPercentage,
        status: "SYNCED",
        lastCheckedAt: new Date()
      },
      create: {
        orgId: orgId,
        propertyId: propertyId,
        listingId: currentListing.id,
        listingType: listingType,
        sourceName: sourceName,
        externalUrl: externalData.externalUrl,
        competitorPrice: new Decimal(competitorPrice),
        competitorCurrency: externalData.currency,
        ourPrice: new Decimal(ourPrice),
        priceDifference: new Decimal(priceDifference),
        savingsPercentage: savingsPercentage,
        status: "SYNCED"
      }
    });

    return comparison;
  }

  /**
   * The core scraping engine that visits external sites
   */
  private static async scrapeExternalListing(source: string, url: string): Promise<ScrapedData> {
    // PROTOTYPE UNIVERSAL LOGIC:
    // This simulates country-specific fee structures and market markup
    await new Promise(r => setTimeout(r, 800));

    let mockMarkup = 1.15; // Global base markup (15%)
    
    // Regional Adjustments
    if (source === "AIRBNB") mockMarkup = 1.20;
    if (source === "SAHIBINDEN") mockMarkup = 1.08;
    if (source === "ZILLOW") mockMarkup = 1.06;
    if (source === "SUUMO") mockMarkup = 1.10;
    
    const basePrice = 100; // Mock current price point
    
    return {
      price: basePrice * mockMarkup,
      currency: "USD",
      sourceName: source,
      externalUrl: url
    };
  }
}
