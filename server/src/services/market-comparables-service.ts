import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class MarketComparablesService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.marketComparables, "marketComparables");
  }

  async getByProperty(propertyId: string) {
    return this.model.findMany({
      where: { propertyId },
      orderBy: { createdAt: "desc" },
    });
  }

  async addComparable(data: {
    propertyId: string;
    comparablePropertyId?: string;
    address?: string;
    price?: number;
    squareFootage?: number;
    bedrooms?: number;
    bathrooms?: number;
    distance?: number;
    metadata?: any;
  }) {
    return this.model.create({
      data: {
        ...data,
        createdAt: new Date(),
      },
    });
  }

  async removeComparable(id: string) {
    return this.model.delete({ where: { id } });
  }

  async getAdjustedPrice(propertyId: string) {
    const comparables = await this.model.findMany({
      where: { propertyId },
    });

    if (!comparables.length) {
      return { propertyId, adjustedPrice: null, comparableCount: 0 };
    }

    const prices = comparables.filter((c: any) => c.price).map((c: any) => c.price);
    const avgPrice = prices.length ? prices.reduce((a: number, b: number) => a + b, 0) / prices.length : 0;

    return {
      propertyId,
      adjustedPrice: Math.round(avgPrice),
      comparableCount: comparables.length,
      priceRange: prices.length ? { min: Math.min(...prices), max: Math.max(...prices) } : null,
    };
  }
}

export const marketComparablesService = new MarketComparablesService();
