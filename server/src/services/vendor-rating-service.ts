import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class VendorRatingService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.vendorRating, "vendorRating");
  }

  async getByOrg(orgId: string, params?: { skip?: number; take?: number }) {
    return this.model.findMany({
      where: { orgId },
      orderBy: { createdAt: "desc" },
      skip: params?.skip ?? 0,
      take: params?.take ?? 20,
    });
  }

  async getTopRated(orgId: string, limit = 5) {
    return this.model.findMany({
      where: { orgId },
      orderBy: { rating: "desc" },
      take: limit,
    });
  }

  async getByVendor(vendorId: string) {
    return this.model.findMany({
      where: { vendorId },
      orderBy: { createdAt: "desc" },
    });
  }

  async getRatings(vendorId: string) {
    const ratings = await this.model.findMany({ where: { vendorId } });
    if (!ratings.length) {
      return { vendorId, averageRating: 0, totalRatings: 0 };
    }
    const avg = ratings.reduce((sum: number, r: any) => sum + (r.rating || 0), 0) / ratings.length;
    return {
      vendorId,
      averageRating: Math.round(avg * 100) / 100,
      totalRatings: ratings.length,
      distribution: ratings.reduce((acc: Record<number, number>, r: any) => {
        acc[r.rating] = (acc[r.rating] || 0) + 1;
        return acc;
      }, {}),
    };
  }
}

export const vendorRatingService = new VendorRatingService();
