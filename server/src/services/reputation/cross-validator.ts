import { prismaManager } from "../../lib/prisma";

interface ValidationResult {
  validated: boolean;
  confidence: number;
  discrepancies: string[];
  crossScore: number;
}

export class CrossValidator {
  async validateAgent(agentId: string, region: string = "US"): Promise<ValidationResult> {
    const prisma = prismaManager.getClient(region);

    const agent = await prisma.agent.findUnique({
      where: { id: agentId },
      include: {
        Review: true,
        agentPerformances: true,
      },
    });

    if (!agent) throw new Error("Agent not found");

    const disputes = await prisma.escrowDispute.findMany({
      where: {
        status: { in: ["RESOLVED", "CLOSED", "ESCALATED"] },
        escrowAccount: {
          reservation: {
            listing: { agentId },
          },
        },
      },
    });

    const discrepancies: string[] = [];
    const reviews = agent.Review || [];
    const tenantReviews = reviews.filter(r => r.targetType === "TENANT");
    const landlordReviews = reviews.filter(r => r.targetType === "LANDLORD");

    const avgTenantScore = tenantReviews.reduce((s, r) => s + (r.rating || 0), 0) / Math.max(tenantReviews.length, 1) / 5;
    const avgLandlordScore = landlordReviews.reduce((s, r) => s + (r.rating || 0), 0) / Math.max(landlordReviews.length, 1) / 5;

    if (Math.abs(avgTenantScore - avgLandlordScore) > 0.3 && tenantReviews.length > 0 && landlordReviews.length > 0) {
      discrepancies.push(`Large gap between tenant (${avgTenantScore.toFixed(2)}) and landlord (${avgLandlordScore.toFixed(2)}) scores`);
    }

    const performances = agent.agentPerformances || [];
    const leadToDealRatio = performances.reduce((s, p) => s + p.leadsGenerated, 0) > 0
      ? performances.reduce((s, p) => s + p.dealsClosed, 0) / performances.reduce((s, p) => s + p.leadsGenerated, 0)
      : 0;

    const totalDeals = performances.reduce((s, p) => s + p.dealsClosed, 0);
    const disputeRatio = totalDeals > 0 ? disputes.length / totalDeals : 0;

    if (disputeRatio > 0.2 && totalDeals > 5) {
      discrepancies.push(`High dispute ratio: ${(disputeRatio * 100).toFixed(1)}% of deals`);
    }

    const crossScore = Math.max(0, 1 - discrepancies.length * 0.15);

    return {
      validated: discrepancies.length === 0,
      confidence: crossScore,
      discrepancies,
      crossScore: Math.round(crossScore * 100) / 100,
    };
  }

  async validateTenant(tenantId: string, region: string = "US"): Promise<ValidationResult> {
    const prisma = prismaManager.getClient(region);
    const discrepancies: string[] = [];

    const tenant = await prisma.tenant.findUnique({
      where: { id: tenantId },
      include: {
        Payment: true,
        Lease: { include: { contracts: true } },
        disputes: true,
      },
    });

    if (!tenant) throw new Error("Tenant not found");

    const totalPayments = tenant.Payment.length;
    const onTime = tenant.Payment.filter(p => p.status === "PAID" && p.paymentDate && p.dueDate && new Date(p.paymentDate) <= new Date(p.dueDate)).length;
    const paymentRatio = totalPayments > 0 ? onTime / totalPayments : 0;

    if (paymentRatio < 0.5 && totalPayments > 3) {
      discrepancies.push(`Low on-time payment ratio: ${(paymentRatio * 100).toFixed(0)}%`);
    }

    const terminatedLeases = tenant.Lease.filter(l => l.status === "TERMINATED").length;
    const totalLeases = tenant.Lease.length;
    if (terminatedLeases > 0 && totalLeases > 1) {
      discrepancies.push(`${terminatedLeases}/${totalLeases} leases terminated early`);
    }

    const disputeRatio = tenant.disputes?.length || 0;
    if (disputeRatio > 2 && totalLeases > 1) {
      discrepancies.push(`Multiple disputes (${disputeRatio}) across ${totalLeases} leases`);
    }

    const crossScore = Math.max(0, 1 - discrepancies.length * 0.2);

    return {
      validated: discrepancies.length === 0,
      confidence: crossScore,
      discrepancies,
      crossScore: Math.round(crossScore * 100) / 100,
    };
  }

  async validateLandlord(orgId: string, region: string = "US"): Promise<ValidationResult> {
    const prisma = prismaManager.getClient(region);
    const discrepancies: string[] = [];

    const organization = await prisma.organization.findUnique({
      where: { id: orgId },
      include: {
        properties: {
          include: {
            listings: { include: { reviews: true } },
            maintenanceWorkOrders: true,
          },
        },
      },
    });

    if (!organization) throw new Error("Organization not found");

    const properties = organization.properties || [];
    const totalListings = properties.reduce((s, p) => s + (p.listings?.length || 0), 0);
    const totalWorkOrders = properties.reduce((s, p) => s + (p.maintenanceWorkOrders?.length || 0), 0);
    const openWorkOrders = properties.reduce((s, p) => s + (p.maintenanceWorkOrders?.filter(w => !["DONE", "CANCELLED"].includes(w.status)).length || 0), 0);

    if (openWorkOrders > 3 && totalWorkOrders > 5) {
      discrepancies.push(`${openWorkOrders}/${totalWorkOrders} maintenance work orders still open`);
    }

    const allReviews = properties.flatMap(p => p.listings?.flatMap(l => l.reviews || []) || []);
    const lowScoreReviews = allReviews.filter(r => (r.score || 0) < 3);
    if (lowScoreReviews.length > 2 && allReviews.length > 5) {
      discrepancies.push(`${lowScoreReviews.length}/${allReviews.length} reviews below 3.0`);
    }

    const crossScore = Math.max(0, 1 - discrepancies.length * 0.2);

    return {
      validated: discrepancies.length === 0,
      confidence: crossScore,
      discrepancies,
      crossScore: Math.round(crossScore * 100) / 100,
    };
  }

  async crossCheckTransaction(transactionId: string, region: string = "US"): Promise<ValidationResult> {
    const prisma = prismaManager.getClient(region);
    const discrepancies: string[] = [];

    const transaction = await prisma.agentEscrowTransaction.findUnique({
      where: { id: transactionId },
      include: {
        wallet: { include: { agent: true } },
        escrowAccount: {
          include: {
            disputes: true,
            releases: true,
            statusHistory: true,
          },
        },
      },
    });

    if (!transaction) throw new Error("Transaction not found");
    if (!transaction.escrowAccount) return { validated: true, confidence: 1, discrepancies: [], crossScore: 1 };

    const escrow = transaction.escrowAccount;
    const totalBlocked = await prisma.agentEscrowTransaction.count({
      where: { escrowAccountId: escrow.id, status: "BLOCKED" },
    });

    const totalReleased = escrow.releases?.filter(r => r.status === "COMPLETED").length || 0;

    if (escrow.status === "FULLY_RELEASED" && totalBlocked > 0) {
      discrepancies.push(`Escrow FULLY_RELEASED but ${totalBlocked} transactions still BLOCKED`);
    }

    if (escrow.status === "DISPUTED") {
      const unresolvedDisputes = escrow.disputes?.filter(d => d.status !== "RESOLVED" && d.status !== "CLOSED").length || 0;
      if (unresolvedDisputes > 0) {
        discrepancies.push(`${unresolvedDisputes} unresolved dispute(s) on escrow account`);
      }
    }

    const crossScore = Math.max(0, 1 - discrepancies.length * 0.25);

    return {
      validated: discrepancies.length === 0,
      confidence: crossScore,
      discrepancies,
      crossScore: Math.round(crossScore * 100) / 100,
    };
  }
}

export const crossValidator = new CrossValidator();
