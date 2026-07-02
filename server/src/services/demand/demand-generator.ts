import { prismaManager } from "../../lib/prisma";
import { EventDispatcher } from "../../core/events/event-dispatcher";

interface DemandSignal {
  type: "SEARCH" | "VIEWING" | "INQUIRY" | "FAVORITE" | "LEASE_COMPLETED" | "LEASE_EXPIRING";
  tenantId?: string;
  contactId?: string;
  listingId?: string;
  propertyId?: string;
  region: string;
  metadata?: Record<string, any>;
}

interface DemandRecommendation {
  listingId: string;
  propertyId: string;
  matchScore: number;
  reason: string;
  agentId?: string;
}

export class DemandGenerator {
  async processSignal(signal: DemandSignal): Promise<DemandRecommendation[]> {
    const prisma = prismaManager.getClient(signal.region);

    if (signal.type === "SEARCH" || signal.type === "INQUIRY") {
      return this.generateFromSearch(signal, prisma);
    }

    if (signal.type === "LEASE_COMPLETED") {
      return this.generateFromLeaseCompletion(signal, prisma);
    }

    if (signal.type === "VIEWING" || signal.type === "FAVORITE") {
      return this.generateSimilarListings(signal, prisma);
    }

    if (signal.type === "LEASE_EXPIRING") {
      return this.generateRenewalAlternatives(signal, prisma);
    }

    return [];
  }

  async generateDemandForRegion(region: string, limit: number = 50): Promise<DemandRecommendation[]> {
    const prisma = prismaManager.getClient(region);
    const recommendations: DemandRecommendation[] = [];

    const expiringLeases = await prisma.lease.findMany({
      where: {
        status: "ACTIVE",
        endDate: {
          lte: new Date(Date.now() + 60 * 24 * 60 * 60 * 1000),
          gte: new Date(),
        },
      },
      include: { tenant: true, listing: { include: { property: true } } },
      take: limit,
    });

    for (const lease of expiringLeases) {
      const similar = await this.findSimilarListings(
        lease.listing.propertyId,
        lease.listing.property?.city,
        lease.listing.price,
        region,
        3,
      );

      for (const rec of similar) {
        recommendations.push({
          listingId: rec.id,
          propertyId: rec.propertyId || "",
          matchScore: 0.8,
          reason: `Your lease is ending soon. Similar property available.`,
          agentId: rec.agentId || undefined,
        });
      }

      if (similar.length > 0) {
        EventDispatcher.emit("DEMAND_GENERATED" as any, {
          type: "LEASE_EXPIRING_CROSS_SELL",
          tenantId: lease.tenantId,
          region,
          recommendations: similar.map((s: any) => s.id),
        });
      }
    }

    const recentViewings = await prisma.propertyViewing.findMany({
      where: {
        scheduledAt: { gte: new Date(Date.now() - 7 * 24 * 60 * 60 * 1000) },
        status: "COMPLETED",
      },
      include: {
        property: true,
        assignedTo: true,
      },
      take: limit,
    });

    for (const viewing of recentViewings) {
      const similar = await this.findSimilarListings(
        viewing.propertyId,
        viewing.property?.city,
        viewing.property?.price,
        region,
        2,
      );

      for (const rec of similar) {
        recommendations.push({
          listingId: rec.id,
          propertyId: rec.propertyId || "",
          matchScore: 0.7,
          reason: `Based on your recent property viewing.`,
          agentId: rec.agentId || undefined,
        });
      }
    }

    return recommendations;
  }

  private async generateFromSearch(signal: DemandSignal, prisma: any): Promise<DemandRecommendation[]> {
    const searchParams = signal.metadata || {};
    const listings = await prisma.listing.findMany({
      where: {
        status: "ACTIVE",
        ...(searchParams.city ? { property: { city: searchParams.city } } : {}),
        ...(searchParams.maxPrice ? { price: { lte: searchParams.maxPrice } } : {}),
        ...(searchParams.propertyType ? { type: searchParams.propertyType } : {}),
      },
      include: { agent: true, property: true },
      take: 5,
      orderBy: { createdAt: "desc" },
    });

    return listings.map((l: any) => ({
      listingId: l.id,
      propertyId: l.propertyId || "",
      matchScore: 0.6,
      reason: `Matches your recent search criteria.`,
      agentId: l.agentId || undefined,
    }));
  }

  private async generateFromLeaseCompletion(signal: DemandSignal, prisma: any): Promise<DemandRecommendation[]> {
    const listing = signal.listingId
      ? await prisma.listing.findUnique({
          where: { id: signal.listingId },
          include: { property: true },
        })
      : null;

    if (!listing?.property) return [];

    const similar = await this.findSimilarListings(
      listing.property.id,
      listing.property.city,
      listing.price,
      signal.region,
      4,
    );

    return similar.map((l: any) => ({
      listingId: l.id,
      propertyId: l.propertyId || "",
      matchScore: 0.85,
      reason: `Your lease is complete! Here are similar properties.`,
      agentId: l.agentId || undefined,
    }));
  }

  private async generateSimilarListings(signal: DemandSignal, prisma: any): Promise<DemandRecommendation[]> {
    if (!signal.propertyId && !signal.listingId) return [];

    const listing = signal.listingId
      ? await prisma.listing.findUnique({ where: { id: signal.listingId }, include: { property: true } })
      : signal.propertyId
        ? await prisma.listing.findFirst({ where: { propertyId: signal.propertyId }, include: { property: true } })
        : null;

    if (!listing?.property) return [];

    const similar = await this.findSimilarListings(
      listing.property.id,
      listing.property.city,
      listing.price,
      signal.region,
      3,
    );

    return similar.map((l: any) => ({
      listingId: l.id,
      propertyId: l.propertyId || "",
      matchScore: 0.75,
      reason: `Similar to a property you recently viewed.`,
      agentId: l.agentId || undefined,
    }));
  }

  private async generateRenewalAlternatives(signal: DemandSignal, prisma: any): Promise<DemandRecommendation[]> {
    if (!signal.propertyId) return [];

    const similar = await this.findSimilarListings(signal.propertyId, undefined, undefined, signal.region, 3);
    return similar.map((l: any) => ({
      listingId: l.id,
      propertyId: l.propertyId || "",
      matchScore: 0.7,
      reason: `Your lease is ending. Consider these alternatives.`,
      agentId: l.agentId || undefined,
    }));
  }

  private async findSimilarListings(
    propertyId: string,
    city?: string,
    price?: number,
    region?: string,
    limit: number = 3,
  ): Promise<any[]> {
    const prisma = prismaManager.getClient(region || "US");

    const priceFloor = price ? price * 0.7 : 0;
    const priceCeil = price ? price * 1.3 : 999999999;

    return prisma.listing.findMany({
      where: {
        status: "ACTIVE",
        propertyId: { not: propertyId },
        ...(city ? { property: { city } } : {}),
        ...(price ? { price: { gte: priceFloor, lte: priceCeil } } : {}),
      },
      take: limit,
      orderBy: { createdAt: "desc" },
    });
  }
}

export const demandGenerator = new DemandGenerator();
