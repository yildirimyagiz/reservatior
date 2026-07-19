import { PrismaClient } from "@prisma/client";
import { prismaManager } from "../lib/prisma";

export class PurchaseIntentService {
  private db: PrismaClient;

  constructor(region?: string) {
    this.db = prismaManager.getClient(region);
  }

  withDB(db: PrismaClient): this {
    const clone = Object.create(this);
    clone.db = db;
    return clone;
  }

  async createIntent(data: {
    orgId: string;
    leaseId: string;
    propertyId: string;
    tenantId: string;
    targetPrice?: number;
    estimatedDownPmt?: number;
    monthlySavings?: number;
    savingsGoal?: number;
    mortgagePreApproved?: boolean;
    maxMortgageAmount?: number;
    preferredLender?: string;
    trustScoreAtIntent?: number;
    targetPurchaseDate?: Date;
    leaseEndSynchronizes?: boolean;
    metadata?: any;
  }) {
    const intent = await this.db.purchaseIntent.create({
      data: {
        orgId: data.orgId,
        leaseId: data.leaseId,
        propertyId: data.propertyId,
        tenantId: data.tenantId,
        targetPrice: data.targetPrice,
        estimatedDownPmt: data.estimatedDownPmt,
        monthlySavings: data.monthlySavings,
        savingsGoal: data.savingsGoal,
        mortgagePreApproved: data.mortgagePreApproved ?? false,
        maxMortgageAmount: data.maxMortgageAmount,
        preferredLender: data.preferredLender,
        trustScoreAtIntent: data.trustScoreAtIntent,
        targetPurchaseDate: data.targetPurchaseDate,
        leaseEndSynchronizes: data.leaseEndSynchronizes ?? true,
        metadata: data.metadata,
        status: "INTENT_DECLARED",
        readinessTier: "EXPLORING",
        buyerReadinessScore: 0,
      },
    });

    await this.calculateReadinessScore(intent.id);
    return intent;
  }

  async updateSavings(intentId: string, amount: number) {
    const intent = await this.db.purchaseIntent.update({
      where: { id: intentId },
      data: {
        currentSavings: { increment: amount },
        lastActivityAt: new Date(),
      },
    });

    await this.calculateReadinessScore(intentId);
    return this.db.purchaseIntent.findUnique({ where: { id: intentId } });
  }

  async calculateReadinessScore(intentId: string) {
    const intent = await this.db.purchaseIntent.findUnique({
      where: { id: intentId },
      include: {
        lease: {
          include: {
            Payment: true,
          },
        },
        tenant: true,
        property: true,
        equityAccumulations: true,
      },
    });

    if (!intent) throw new Error("PurchaseIntent not found");

    // 1. Savings Progress (40%)
    const savingsGoal = Number(intent.savingsGoal || 0);
    const currentSavings = Number(intent.currentSavings || 0);
    const savingsProgress = savingsGoal > 0 ? Math.min(currentSavings / savingsGoal, 1) : 0;
    const savingsScore = savingsProgress * 100;

    // 2. Trust Score (25%)
    const trustScore = intent.trustScoreAtIntent ?? (intent.tenant as any)?.overallScore ?? 0;
    const trustScoreNormalized = Math.min(Math.max(trustScore, 0), 100);

    // 3. Lease History (20%)
    const payments = (intent.lease as any)?.Payment || [];
    const totalPayments = payments.length;
    const onTimePayments = payments.filter((p: any) => {
      if (!p.paymentDate || !p.dueDate) return false;
      return new Date(p.paymentDate) <= new Date(p.dueDate);
    }).length;
    const leaseHistoryScore = totalPayments > 0 ? (onTimePayments / totalPayments) * 100 : 50;

    // 4. Income Stability (15%)
    const tenant = intent.tenant as any;
    let incomeStability = 50;
    if (tenant?.creditScore) {
      incomeStability = Math.min(tenant.creditScore / 8.5, 100);
    }
    if (tenant?.employmentStartDate) {
      const yearsEmployed = (Date.now() - new Date(tenant.employmentStartDate).getTime()) / (365.25 * 24 * 3600 * 1000);
      incomeStability = Math.min(incomeStability + yearsEmployed * 2, 100);
    }

    const rawScore =
      savingsScore * 0.4 +
      trustScoreNormalized * 0.25 +
      leaseHistoryScore * 0.2 +
      incomeStability * 0.15;

    const score = Math.round(Math.min(Math.max(rawScore, 0), 100));

    let tier: string = "EXPLORING";
    if (score >= 90) tier = "CLOSING";
    else if (score >= 75) tier = "MORTGAGE_APPROVED";
    else if (score >= 60) tier = "ACTIVE_BUYER";
    else if (score >= 40) tier = "QUALIFIED";
    else if (score >= 20) tier = "SAVING";

    await this.db.purchaseIntent.update({
      where: { id: intentId },
      data: {
        buyerReadinessScore: score,
        readinessTier: tier as any,
      },
    });

    return { score, tier, breakdown: { savingsScore, trustScoreNormalized, leaseHistoryScore, incomeStability } };
  }

  async recordEquityAccumulation(
    intentId: string,
    periodStart: Date,
    periodEnd: Date,
    rentPaid: number,
    equityPortion: number
  ) {
    const intent = await this.db.purchaseIntent.findUnique({
      where: { id: intentId },
      include: { equityAccumulations: { orderBy: { periodStart: "desc" }, take: 1 } },
    });

    if (!intent) throw new Error("PurchaseIntent not found");

    const previousCumulative = intent.equityAccumulations.length > 0
      ? Number(intent.equityAccumulations[0].cumulativeEquity)
      : 0;

    const cumulativeEquity = previousCumulative + equityPortion;

    const record = await this.db.equityAccumulation.create({
      data: {
        intentId,
        orgId: intent.orgId,
        periodStart,
        periodEnd,
        rentPaid,
        equityPortion,
        cumulativeEquity,
        savingsAdded: 0,
        paymentStatus: "COMPLETED",
      },
    });

    await this.calculateReadinessScore(intentId);
    return record;
  }

  async getJourneySummary(intentId: string) {
    const intent = await this.db.purchaseIntent.findUnique({
      where: { id: intentId },
      include: {
        lease: true,
        property: true,
        tenant: true,
        equityAccumulations: { orderBy: { periodStart: "asc" } },
        conversionWorkflow: true,
      },
    });

    if (!intent) throw new Error("PurchaseIntent not found");

    const totalEquity = intent.equityAccumulations.reduce(
      (sum, ea) => sum + Number(ea.equityPortion), 0
    );

    const totalRentPaid = intent.equityAccumulations.reduce(
      (sum, ea) => sum + Number(ea.rentPaid), 0
    );

    const savingsGoal = Number(intent.savingsGoal || 0);
    const currentSavings = Number(intent.currentSavings || 0);
    const savingsProgressPct = savingsGoal > 0 ? (currentSavings / savingsGoal) * 100 : 0;

    const conversionEligible =
      intent.buyerReadinessScore >= 75 &&
      currentSavings >= (Number(intent.estimatedDownPmt || 0)) &&
      intent.conversionWorkflow === null;

    const daysUntilTarget = intent.targetPurchaseDate
      ? Math.ceil((new Date(intent.targetPurchaseDate).getTime() - Date.now()) / (1000 * 60 * 60 * 24))
      : null;

    return {
      intentId: intent.id,
      status: intent.status,
      readinessTier: intent.readinessTier,
      buyerReadinessScore: intent.buyerReadinessScore,
      financials: {
        currentSavings,
        savingsGoal,
        savingsProgressPct: Math.round(savingsProgressPct * 100) / 100,
        targetPrice: intent.targetPrice,
        estimatedDownPmt: intent.estimatedDownPmt,
        totalEquityAccumulated: totalEquity,
        totalRentPaid,
      },
      timeline: {
        targetPurchaseDate: intent.targetPurchaseDate,
        daysUntilTarget,
        leaseEndSynchronizes: intent.leaseEndSynchronizes,
        declaredAt: intent.declaredAt,
        lastActivityAt: intent.lastActivityAt,
      },
      conversionEligible,
      hasConversionStarted: !!intent.conversionWorkflow,
      property: intent.property,
      tenant: intent.tenant,
    };
  }

  async startConversion(intentId: string, purchasePrice: number, downPayment: number) {
    const intent = await this.db.purchaseIntent.findUnique({
      where: { id: intentId },
      include: { conversionWorkflow: true, equityAccumulations: true },
    });

    if (!intent) throw new Error("PurchaseIntent not found");
    if (intent.conversionWorkflow) throw new Error("Conversion already started");

    const totalEquity = intent.equityAccumulations.reduce(
      (sum, ea) => sum + Number(ea.equityPortion), 0
    );

    const equityApplied = Math.min(totalEquity, purchasePrice);
    const remainingBalance = purchasePrice - equityApplied - downPayment;
    const mortgageAmount = Math.max(remainingBalance, 0);

    const conversion = await this.db.$transaction(async (tx) => {
      const conv = await tx.ownershipConversion.create({
        data: {
          intentId,
          orgId: intent.orgId,
          purchasePrice,
          equityApplied,
          remainingBalance,
          downPayment,
          mortgageAmount,
          buyerContactId: intent.tenantId,
          sellerOrgId: intent.orgId,
        },
      });

      await tx.purchaseIntent.update({
        where: { id: intentId },
        data: {
          status: "UNDER_CONTRACT",
          lastActivityAt: new Date(),
        },
      });

      return conv;
    });

    return conversion;
  }

  async getOrgIntents(
    orgId: string,
    filters?: {
      status?: string;
      readinessTier?: string;
      page?: number;
      limit?: number;
    }
  ) {
    const page = filters?.page ?? 1;
    const limit = filters?.limit ?? 20;
    const where: any = { orgId };
    if (filters?.status) where.status = filters.status;
    if (filters?.readinessTier) where.readinessTier = filters.readinessTier;

    const [data, total] = await Promise.all([
      this.db.purchaseIntent.findMany({
        where,
        skip: (page - 1) * limit,
        take: limit,
        orderBy: { createdAt: "desc" },
        include: {
          property: { select: { id: true, name: true, address: true } },
          tenant: { select: { id: true, firstName: true, lastName: true, email: true } },
        },
      }),
      this.db.purchaseIntent.count({ where }),
    ]);

    return { data, total, page, limit };
  }
}

export const purchaseIntentService = new PurchaseIntentService();
