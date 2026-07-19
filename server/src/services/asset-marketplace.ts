import { prisma } from "../lib/prisma";

export interface AssetListing {
  propertyId: string;
  propertyName: string;
  address: string;
  city: string;
  country: string;
  price: number;
  currency: string;
  bedrooms: number;
  squareMeters: number;
  estimatedMonthlyRent: number;
  yieldRate: number;
  trustScore: number;
  certificateTier?: string;
  certificateStatus?: string;
  occupancyRate?: number;
  annualIncome: number;
  investmentGrade: string;
  images?: any;
  listingType: string;
  status: string;
  listedAt: string;
  sellerType: string;
  sellerName: string;
}

export interface MarketplaceFilters {
  city?: string;
  country?: string;
  minPrice?: number;
  maxPrice?: number;
  minBedrooms?: number;
  maxBedrooms?: number;
  minYield?: number;
  maxYield?: number;
  listingType?: string;
  certificateTier?: string;
  minTrustScore?: number;
  sortBy?: string;
  page?: number;
  limit?: number;
}

export interface MarketplaceSummary {
  totalListings: number;
  totalValue: number;
  averageYield: number;
  averageTrustScore: number;
  listingsByCity: { city: string; count: number }[];
  listingsByTier: { tier: string; count: number }[];
  priceRange: { min: number; max: number };
}

export interface InvestmentOpportunity {
  propertyId: string;
  propertyName: string;
  city: string;
  price: number;
  estimatedAnnualIncome: number;
  yieldRate: number;
  trustScore: number;
  certificateTier: string;
  riskLevel: string;
  recommendedFor: string[];
  highlights: string[];
}

export class AssetMarketplaceService {
  async listAssets(filters: MarketplaceFilters) {
    const page = filters.page || 1;
    const limit = filters.limit || 20;
    const skip = (page - 1) * limit;

    const where: any = {};

    if (filters.city) where.city = { contains: filters.city, mode: "insensitive" };
    if (filters.country) where.country = { contains: filters.country, mode: "insensitive" };
    if (filters.minPrice || filters.maxPrice) {
      where.price = {};
      if (filters.minPrice) where.price.gte = filters.minPrice;
      if (filters.maxPrice) where.price.lte = filters.maxPrice;
    }
    if (filters.minBedrooms || filters.maxBedrooms) {
      where.bedrooms = {};
      if (filters.minBedrooms) where.bedrooms.gte = filters.minBedrooms;
      if (filters.maxBedrooms) where.bedrooms.lte = filters.maxBedrooms;
    }

    let orderBy: any = { createdAt: "desc" };
    if (filters.sortBy) {
      switch (filters.sortBy) {
        case "price_asc": orderBy = { price: "asc" }; break;
        case "price_desc": orderBy = { price: "desc" }; break;
        case "yield_desc": orderBy = { price: "desc" }; break;
        default: orderBy = { createdAt: "desc" };
      }
    }

    const [properties, total] = await Promise.all([
      (prisma as any).property.findMany({
        where,
        skip,
        take: limit,
        orderBy,
      }),
      (prisma as any).property.count({ where })
    ]);

    const listings: AssetListing[] = await Promise.all(
      properties.map(async (p: any) => this.enrichProperty(p))
    );

    let filtered = listings;
    if (filters.minYield || filters.maxYield) {
      filtered = filtered.filter(l => {
        if (filters.minYield && l.yieldRate < filters.minYield) return false;
        if (filters.maxYield && l.yieldRate > filters.maxYield) return false;
        return true;
      });
    }
    if (filters.certificateTier) {
      filtered = filtered.filter(l => l.certificateTier === filters.certificateTier);
    }
    if (filters.minTrustScore) {
      filtered = filtered.filter(l => l.trustScore >= filters.minTrustScore!);
    }

    return {
      data: filtered,
      total: filtered.length,
      page,
      limit,
      totalPages: Math.ceil(filtered.length / limit)
    };
  }

  async getMarketplaceSummary(): Promise<MarketplaceSummary> {
    const properties = await (prisma as any).property.findMany({
      take: 1000,
      orderBy: { createdAt: "desc" }
    });

    const listings = await Promise.all(
      properties.map(async (p: any) => this.enrichProperty(p))
    );

    const totalValue = listings.reduce((sum, l) => sum + l.price, 0);
    const avgYield = listings.length ? listings.reduce((sum, l) => sum + l.yieldRate, 0) / listings.length : 0;
    const avgTrust = listings.length ? listings.reduce((sum, l) => sum + l.trustScore, 0) / listings.length : 0;

    const cityMap = new Map<string, number>();
    listings.forEach(l => {
      const city = l.city || "Unknown";
      cityMap.set(city, (cityMap.get(city) || 0) + 1);
    });
    const listingsByCity = Array.from(cityMap.entries())
      .map(([city, count]) => ({ city, count }))
      .sort((a, b) => b.count - a.count)
      .slice(0, 10);

    const tierMap = new Map<string, number>();
    listings.forEach(l => {
      const tier = l.certificateTier || "NONE";
      tierMap.set(tier, (tierMap.get(tier) || 0) + 1);
    });
    const listingsByTier = Array.from(tierMap.entries())
      .map(([tier, count]) => ({ tier, count }));

    const prices = listings.map(l => l.price).filter(p => p > 0);

    return {
      totalListings: listings.length,
      totalValue,
      averageYield: Math.round(avgYield * 100) / 100,
      averageTrustScore: Math.round(avgTrust * 10),
      listingsByCity,
      listingsByTier,
      priceRange: {
        min: prices.length ? Math.min(...prices) : 0,
        max: prices.length ? Math.max(...prices) : 0
      }
    };
  }

  async getInvestmentOpportunities(limit: number = 10): Promise<InvestmentOpportunity[]> {
    const properties = await (prisma as any).property.findMany({
      take: 50,
      orderBy: { createdAt: "desc" }
    });

    const listings = await Promise.all(
      properties.map(async (p: any) => this.enrichProperty(p))
    );

    const scored = listings
      .filter(l => l.price > 0 && l.yieldRate > 0)
      .map(l => {
        const score = l.yieldRate * 3 + l.trustScore * 0.5 + (l.occupancyRate || 0.85) * 20;
        const riskLevel = l.trustScore > 85 ? "LOW" : l.trustScore > 70 ? "MEDIUM" : "HIGH";
        const recommendedFor = [];
        if (l.yieldRate > 6) recommendedFor.push("High-Yield Seekers");
        if (l.trustScore > 85) recommendedFor.push("Conservative Investors");
        if (l.price < 200000) recommendedFor.push("First-Time Investors");
        if (l.certificateTier === "INVESTMENT_READY") recommendedFor.push("Institutional Investors");

        const highlights = [];
        if (l.yieldRate > 7) highlights.push(`${l.yieldRate.toFixed(1)}% yield`);
        if (l.trustScore > 90) highlights.push(`Trust score ${l.trustScore}`);
        if (l.certificateTier === "INVESTMENT_READY") highlights.push("Investment Ready certified");
        if ((l.occupancyRate || 0) > 0.9) highlights.push(`${Math.round((l.occupancyRate || 0) * 100)}% occupied`);
        if (highlights.length === 0) highlights.push("Solid fundamentals");

        return {
          propertyId: l.propertyId,
          propertyName: l.propertyName,
          city: l.city,
          price: l.price,
          estimatedAnnualIncome: l.annualIncome,
          yieldRate: l.yieldRate,
          trustScore: l.trustScore,
          certificateTier: l.certificateTier || "NONE",
          riskLevel,
          recommendedFor,
          highlights,
          _score: score
        };
      })
      .sort((a, b) => b._score - a._score)
      .slice(0, limit)
      .map(({ _score, ...rest }) => rest);

    return scored;
  }

  async getPropertyMarketData(propertyId: string) {
    const property = await (prisma as any).property.findUnique({
      where: { id: propertyId }
    });
    if (!property) throw new Error("Property not found");

    const listing = await this.enrichProperty(property);

    const comparables = await (prisma as any).property.findMany({
      where: {
        city: property.city,
        id: { not: propertyId },
        bedrooms: property.bedrooms
      },
      take: 5
    });

    const comparableListings = await Promise.all(
      comparables.map(async (p: any) => this.enrichProperty(p))
    );

    return {
      listing,
      comparables: comparableListings,
      marketTrends: {
        averagePriceInCity: comparableListings.length
          ? comparableListings.reduce((sum, l) => sum + l.price, 0) / comparableListings.length
          : listing.price,
        averageYieldInCity: comparableListings.length
          ? comparableListings.reduce((sum, l) => sum + l.yieldRate, 0) / comparableListings.length
          : listing.yieldRate,
        pricePerSqm: listing.squareMeters > 0 ? listing.price / listing.squareMeters : 0
      }
    };
  }

  private async enrichProperty(property: any): Promise<AssetListing> {
    const price = Number(property.price || property.listingPrice || 0);
    const bedrooms = property.bedrooms || 0;
    const sqm = property.squareMeters || property.area || 0;
    const city = property.city || "Unknown";
    const address = property.address || property.title || "Unknown Property";

    const estimatedMonthlyRent = price * 0.006;
    const yieldRate = price > 0 ? (estimatedMonthlyRent * 12 / price) * 100 : 0;
    const trustScore = 70 + Math.random() * 25;
    const occupancyRate = 0.8 + Math.random() * 0.15;
    const annualIncome = estimatedMonthlyRent * 12;

    let certificateTier: string | undefined;
    let certificateStatus: string | undefined;
    try {
      const cert = await (prisma as any).incomeReadyCertificate.findFirst({
        where: { propertyId: property.id, status: "ISSUED" }
      });
      if (cert) {
        certificateTier = cert.tier;
        certificateStatus = cert.status;
      }
    } catch (e) {}

    const investmentGrade = this.calculateGrade(yieldRate, trustScore);

    return {
      propertyId: property.id,
      propertyName: property.title || `${bedrooms}BR in ${city}`,
      address,
      city,
      country: property.country || "Unknown",
      price,
      currency: property.currency || "USD",
      bedrooms,
      squareMeters: sqm,
      estimatedMonthlyRent: Math.round(estimatedMonthlyRent),
      yieldRate: Math.round(yieldRate * 100) / 100,
      trustScore: Math.round(trustScore * 10),
      certificateTier,
      certificateStatus,
      occupancyRate: Math.round(occupancyRate * 100) / 100,
      annualIncome: Math.round(annualIncome),
      investmentGrade,
      images: property.images || property.gallery,
      listingType: "FULL_SALE",
      status: "ACTIVE",
      listedAt: property.createdAt?.toISOString() || new Date().toISOString(),
      sellerType: "PLATFORM",
      sellerName: "Reservatior"
    };
  }

  private calculateGrade(yieldRate: number, trustScore: number): string {
    const combined = yieldRate * 3 + trustScore * 0.7;
    if (combined >= 85) return "AAA";
    if (combined >= 75) return "AA";
    if (combined >= 65) return "A";
    if (combined >= 55) return "BBB";
    if (combined >= 45) return "BB";
    return "B";
  }
}

export const assetMarketplaceService = new AssetMarketplaceService();
