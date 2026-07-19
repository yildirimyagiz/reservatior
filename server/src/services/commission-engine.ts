import { prisma } from "../lib/prisma";

export interface CommissionCalculation {
  sourceType: string;
  sourceId: string;
  type: "AGENT_SALE" | "FURNITURE_COMMISSION" | "REFERRAL" | "PLATFORM_FEE";
  basisAmount: number;
  rate: number;
  agentId?: string;
  campaignId?: string;
  orgId?: string;
}

export class CommissionEngine {
  async calculate(commission: CommissionCalculation) {
    const amount = commission.basisAmount * (commission.rate / 100);

    let platformShare = amount * 0.30;
    let agentShare = amount * 0.60;
    let supplierShare = amount * 0.10;

    if (commission.agentId) {
      const agent = await prisma.agent.findUnique({ where: { id: commission.agentId } });
      if (agent) {
        const agentRate = agent.baseCommissionRate / 100;
        agentShare = amount * agentRate;
        platformShare = amount - agentShare - supplierShare;
      }
    }

    let bonusAmount = 0;
    if (commission.campaignId) {
      const campaign = await prisma.campaign.findUnique({ where: { id: commission.campaignId } });
      if (campaign?.agentBonusRate) {
        bonusAmount = amount * (campaign.agentBonusRate / 100);
        agentShare += bonusAmount;
        platformShare -= bonusAmount;
      }
    }

    const created = await prisma.commission.create({
      data: {
        orgId: commission.orgId || "",
        sourceType: commission.sourceType,
        sourceId: commission.sourceId,
        agentId: commission.agentId,
        type: commission.type as any,
        basis: commission.rate > 0 ? "percentage" : "fixed",
        basisAmount: commission.basisAmount,
        rate: commission.rate,
        amount,
        platformShare,
        agentShare,
        supplierShare,
        partnerShare: 0,
        status: "CALCULATED",
        calculatedAt: new Date(),
        campaignId: commission.campaignId,
      }
    });

    const shares = [
      { type: "PLATFORM" as const, entityType: "PLATFORM", entityId: null as string | null },
      ...(agentShare > 0 ? [{ type: "AGENT" as const, entityType: "AGENT", entityId: commission.agentId || null }] : []),
      ...(supplierShare > 0 ? [{ type: "SUPPLIER" as const, entityType: "SUPPLIER", entityId: null as string | null }] : []),
    ];

    for (const share of shares) {
      await prisma.revenueShare.create({
        data: {
          orgId: commission.orgId || "",
          commissionId: created.id,
          type: share.type,
          entityType: share.entityType,
          entityId: share.entityId || undefined,
          amount: share.type === "PLATFORM" ? platformShare : share.type === "AGENT" ? agentShare : supplierShare,
          currency: "USD",
        }
      });
    }

    return created;
  }

  async approve(commissionId: string) {
    return prisma.commission.update({
      where: { id: commissionId },
      data: { status: "APPROVED", approvedAt: new Date() }
    });
  }

  async markPaid(commissionId: string, paymentRef: string) {
    return prisma.commission.update({
      where: { id: commissionId },
      data: { status: "PAID", paidAt: new Date(), paymentRef }
    });
  }

  async getAgentSummary(agentId: string) {
    const commissions = await prisma.commission.findMany({
      where: { agentId },
      orderBy: { createdAt: "desc" }
    });

    const total = commissions.reduce((sum, c) => sum + Number(c.amount), 0);
    const paid = commissions.filter(c => c.status === "PAID").reduce((sum, c) => sum + Number(c.amount), 0);
    const pending = commissions
      .filter(c => c.status === "PENDING" || c.status === "CALCULATED" || c.status === "APPROVED")
      .reduce((sum, c) => sum + Number(c.amount), 0);

    return { total, paid, pending, count: commissions.length, commissions };
  }

  async getPlatformSummary(orgId: string, startDate?: Date, endDate?: Date) {
    const where: any = { orgId, type: "PLATFORM" };
    if (startDate || endDate) {
      where.createdAt = {};
      if (startDate) where.createdAt.gte = startDate;
      if (endDate) where.createdAt.lte = endDate;
    }

    const shares = await prisma.revenueShare.findMany({ where });

    const total = shares.reduce((sum, s) => sum + Number(s.amount), 0);
    return { total, count: shares.length };
  }
}

export const commissionEngine = new CommissionEngine();
