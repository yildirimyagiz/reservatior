import { prismaManager } from "../../lib/prisma";
import { EventDispatcher } from "../../core/events/event-dispatcher";

interface CrossSellCandidate {
  targetId: string;
  targetType: "AGENT" | "TENANT" | "LANDLORD";
  listingId: string;
  propertyId: string;
  matchScore: number;
  reason: string;
}

interface ServiceCrossSell {
  service: string;
  description: string;
  matchScore: number;
  targetUrl: string;
}

export class CrossSellEngine {
  async findPropertyCrossSell(tenantId: string, region: string = "US"): Promise<CrossSellCandidate[]> {
    const prisma = prismaManager.getClient(region);
    const candidates: CrossSellCandidate[] = [];

    const tenant = await prisma.tenant.findUnique({
      where: { id: tenantId },
      include: {
        Lease: {
          include: {
            listing: { include: { property: true } },
          },
          orderBy: { createdAt: "desc" },
          take: 3,
        },
      },
    });

    if (!tenant || tenant.Lease.length === 0) return candidates;

    const lastLease = tenant.Lease[0];
    const lastProperty = lastLease.listing?.property;
    if (!lastProperty) return candidates;

    const similarListings = await prisma.listing.findMany({
      where: {
        status: "ACTIVE",
        NOT: { id: lastLease.listingId },
        property: {
          ...(lastProperty.city ? { city: lastProperty.city } : {}),
          price: {
            gte: lastProperty.price ? Number(lastProperty.price) * 0.7 : 0,
            lte: lastProperty.price ? Number(lastProperty.price) * 1.3 : 999999999,
          },
        },
      },
      include: { agent: true, property: true },
      take: 3,
    });

    for (const listing of similarListings) {
      candidates.push({
        targetId: tenantId,
        targetType: "TENANT",
        listingId: listing.id,
        propertyId: listing.propertyId || "",
        matchScore: 0.85,
        reason: `Similar to your property at ${lastProperty.city}`,
      });
    }

    if (similarListings.length > 0) {
      EventDispatcher.emit("CROSS_SELL_OPPORTUNITY" as any, {
        tenantId,
        region,
        recommendations: similarListings.map(l => l.id),
      });
    }

    return candidates;
  }

  async findAgentUpgradePath(agentId: string, region: string = "US"): Promise<ServiceCrossSell[]> {
    const prisma = prismaManager.getClient(region);
    const services: ServiceCrossSell[] = [];

    const agent = await prisma.agent.findUnique({
      where: { id: agentId },
      include: {
        agentPerformances: { orderBy: { endDate: "desc" }, take: 4 },
        subscriptions: true,
      },
    });

    if (!agent) return services;

    const hasSubscription = (agent.subscriptions?.length || 0) > 0;
    const totalDeals = agent.agentPerformances?.reduce((s, p) => s + p.dealsClosed, 0) || 0;

    if (!hasSubscription) {
      services.push({
        service: "AGENT_SUBSCRIPTION",
        description: "Unlock premium lead allocation and priority listing distribution",
        matchScore: 0.9,
        targetUrl: "/agent/upgrade",
      });
    }

    if (totalDeals > 5) {
      services.push({
        service: "AI_BROCHURE_GENERATION",
        description: "Automated property brochure generation with AI staging",
        matchScore: 0.8,
        targetUrl: "/agent/ai-brochure",
      });

      services.push({
        service: "PERFORMANCE_ANALYTICS",
        description: "Advanced analytics dashboard for your listings",
        matchScore: 0.75,
        targetUrl: "/agent/analytics",
      });
    }

    return services;
  }

  async findLandlordCrossSell(orgId: string, region: string = "US"): Promise<ServiceCrossSell[]> {
    const prisma = prismaManager.getClient(region);
    const services: ServiceCrossSell[] = [];

    const org = await prisma.organization.findUnique({
      where: { id: orgId },
      include: {
        properties: {
          include: {
            listings: true,
            maintenanceWorkOrders: { orderBy: { createdAt: "desc" }, take: 5 },
          },
        },
      },
    });

    if (!org) return services;

    const totalProperties = org.properties?.length || 0;
    const openWorkOrders = org.properties?.reduce(
      (s, p) => s + (p.maintenanceWorkOrders?.filter(w => w.status !== "DONE" && w.status !== "CANCELLED").length || 0),
      0
    ) || 0;

    if (totalProperties >= 3) {
      services.push({
        service: "PROPERTY_MANAGEMENT",
        description: "Let us manage your properties end-to-end",
        matchScore: 0.85,
        targetUrl: "/landlord/management",
      });
    }

    if (openWorkOrders > 3) {
      services.push({
        service: "MAINTENANCE_AUTOMATION",
        description: "Automated maintenance workflow and vendor matching",
        matchScore: 0.8,
        targetUrl: "/landlord/maintenance",
      });
    }

    services.push({
      service: "TAX_REPORTING",
      description: "Automated tax reports for your rental income",
      matchScore: 0.7,
      targetUrl: "/landlord/tax",
    });

    return services;
  }

  async findReferralOpportunity(entityId: string, entityType: "TENANT" | "AGENT" | "LANDLORD", region: string = "US"): Promise<CrossSellCandidate[]> {
    const prisma = prismaManager.getClient(region);
    const candidates: CrossSellCandidate[] = [];

    if (entityType === "TENANT") {
      const tenant = await prisma.tenant.findUnique({
        where: { id: entityId },
        include: { Lease: { take: 1, include: { listing: true } } },
      });

      if (tenant) {
        const otherTenants = await prisma.tenant.findMany({
          where: {
            id: { not: entityId },
            Lease: {
              some: {
                listing: { property: { city: tenant.Lease[0]?.listing?.property?.city || undefined } },
              },
            },
          },
          take: 3,
        });

        for (const t of otherTenants) {
          candidates.push({
            targetId: t.id,
            targetType: "TENANT",
            listingId: "",
            propertyId: "",
            matchScore: 0.6,
            reason: "Referral opportunity: same city tenant",
          });
        }
      }
    }

    if (entityType === "AGENT") {
      const agent = await prisma.agent.findUnique({
        where: { id: entityId },
        include: { agentTeams: { include: { members: true } } },
      });

      if (agent && (!agent.agentTeams || agent.agentTeams.length === 0)) {
        const topAgents = await prisma.agent.findMany({
          where: {
            id: { not: entityId },
            isActive: true,
          },
          take: 3,
          orderBy: { createdAt: "asc" },
        });

        for (const a of topAgents) {
          candidates.push({
            targetId: a.id,
            targetType: "AGENT",
            listingId: "",
            propertyId: "",
            matchScore: 0.5,
            reason: "Team collaboration opportunity",
          });
        }
      }
    }

    return candidates;
  }
}

export const crossSellEngine = new CrossSellEngine();
