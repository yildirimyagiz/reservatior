import { PrismaClient } from "@prisma/client";
import { prismaManager } from "../lib/prisma";

export class REOPortfolioService {
  private db: PrismaClient;

  constructor(region?: string) {
    this.db = prismaManager.getClient(region);
  }

  withDB(db: PrismaClient): this {
    const clone = Object.create(this);
    clone.db = db;
    return clone;
  }

  async createPortfolio(data: {
    orgId: string;
    name: string;
    description?: string;
    ownerType: string;
    primaryCountry?: string;
    primaryRegion?: string;
    metadata?: any;
  }) {
    return this.db.institutionalPortfolio.create({
      data: {
        orgId: data.orgId,
        name: data.name,
        description: data.description,
        ownerType: data.ownerType as any,
        primaryCountry: data.primaryCountry,
        primaryRegion: data.primaryRegion,
        metadata: data.metadata,
      },
    });
  }

  async addProperty(portfolioId: string, propertyId: string, data: {
    orgId: string;
    purchasePrice: number;
    currentValue: number;
    equityStake?: number;
    monthlyIncome?: number;
    occupancyStatus?: string;
    leaseEndDate?: Date;
    metadata?: any;
  }) {
    const annualIncome = (data.monthlyIncome ?? 0) * 12;
    const capRate = data.currentValue > 0
      ? (annualIncome / data.currentValue) * 100
      : null;

    const holding = await this.db.$transaction(async (tx) => {
      const h = await tx.portfolioHolding.create({
        data: {
          portfolioId,
          propertyId,
          orgId: data.orgId,
          purchasePrice: data.purchasePrice,
          currentValue: data.currentValue,
          equityStake: data.equityStake ?? 1.0,
          monthlyIncome: data.monthlyIncome ?? 0,
          annualIncome,
          capRate,
          occupancyStatus: data.occupancyStatus ?? "VACANT",
          leaseEndDate: data.leaseEndDate,
          unrealizedGain: data.currentValue - data.purchasePrice,
          metadata: data.metadata,
        },
      });

      await tx.institutionalPortfolio.update({
        where: { id: portfolioId },
        data: {
          totalProperties: { increment: 1 },
          totalValue: { increment: data.currentValue },
          monthlyRentalIncome: { increment: data.monthlyIncome ?? 0 },
        },
      });

      return h;
    });

    return holding;
  }

  async calculatePortfolioMetrics(portfolioId: string) {
    const portfolio = await this.db.institutionalPortfolio.findUnique({
      where: { id: portfolioId },
      include: { holdings: true },
    });

    if (!portfolio) throw new Error("Portfolio not found");

    const holdings = portfolio.holdings;
    const totalValue = holdings.reduce((s, h) => s + Number(h.currentValue), 0);
    const totalPurchasePrice = holdings.reduce((s, h) => s + Number(h.purchasePrice), 0);
    const totalDebt = holdings.reduce((s, h) => {
      const debt = Number(h.currentValue) - Number(h.currentValue) * h.equityStake;
      return s + Math.max(debt, 0);
    }, 0);
    const equity = totalValue - totalDebt;
    const occupiedCount = holdings.filter((h) => h.occupancyStatus === "OCCUPIED").length;
    const occupancyRate = holdings.length > 0 ? occupiedCount / holdings.length : 0;
    const totalMonthlyIncome = holdings.reduce((s, h) => s + Number(h.monthlyIncome), 0);
    const avgNOI = holdings.length > 0 ? totalMonthlyIncome * 12 / holdings.length : 0;

    const weightedCapRate =
      totalValue > 0
        ? holdings.reduce((s, h) => {
            const weight = Number(h.currentValue) / totalValue;
            return s + (h.capRate ?? 0) * weight;
          }, 0)
        : null;

    const totalAppreciation = holdings.reduce((s, h) => {
      return s + (Number(h.currentValue) - Number(h.purchasePrice));
    }, 0);

    const updated = await this.db.institutionalPortfolio.update({
      where: { id: portfolioId },
      data: {
        totalProperties: holdings.length,
        totalValue,
        totalDebt,
        equity,
        occupancyRate,
        averageNOI: avgNOI,
        weightedCapRate,
        monthlyRentalIncome: totalMonthlyIncome,
        netOperatingIncome: totalMonthlyIncome,
        totalAppreciation,
      },
    });

    return updated;
  }

  async updateHoldingIncome(holdingId: string, monthlyIncome: number) {
    const holding = await this.db.portfolioHolding.findUnique({
      where: { id: holdingId },
    });

    if (!holding) throw new Error("PortfolioHolding not found");

    const annualIncome = monthlyIncome * 12;
    const capRate = Number(holding.currentValue) > 0
      ? (annualIncome / Number(holding.currentValue)) * 100
      : null;

    const incomeDelta = monthlyIncome - Number(holding.monthlyIncome);

    const updated = await this.db.$transaction(async (tx) => {
      const h = await tx.portfolioHolding.update({
        where: { id: holdingId },
        data: {
          monthlyIncome,
          annualIncome,
          capRate,
          noi: annualIncome,
        },
      });

      await tx.institutionalPortfolio.update({
        where: { id: holding.portfolioId },
        data: {
          monthlyRentalIncome: { increment: incomeDelta },
          netOperatingIncome: { increment: incomeDelta },
        },
      });

      return h;
    });

    return updated;
  }

  async createREOProperty(data: {
    orgId: string;
    propertyId?: string;
    portfolioId?: string;
    status: string;
    propertyType: string;
    loanId?: string;
    borrowerName?: string;
    originalLoanAmount?: number;
    outstandingBalance?: number;
    asIsValue?: number;
    afterRepairValue?: number;
    estimatedRepairCost?: number;
    lastAppraisalDate?: Date;
    appraisalCompany?: string;
    assetManagerId?: string;
    propertyManagerId?: string;
    maintenanceVendorId?: string;
    carryingCost?: number;
    insuranceCost?: number;
    taxLiability?: number;
    targetDisposalDate?: Date;
    dispositionStrategy?: string;
    expectedRecoveryRate?: number;
    metadata?: any;
  }) {
    return this.db.rEOProperty.create({
      data: {
        orgId: data.orgId,
        propertyId: data.propertyId,
        portfolioId: data.portfolioId,
        status: data.status as any,
        propertyType: data.propertyType as any,
        loanId: data.loanId,
        borrowerName: data.borrowerName,
        originalLoanAmount: data.originalLoanAmount,
        outstandingBalance: data.outstandingBalance,
        asIsValue: data.asIsValue,
        afterRepairValue: data.afterRepairValue,
        estimatedRepairCost: data.estimatedRepairCost,
        lastAppraisalDate: data.lastAppraisalDate,
        appraisalCompany: data.appraisalCompany,
        assetManagerId: data.assetManagerId,
        propertyManagerId: data.propertyManagerId,
        maintenanceVendorId: data.maintenanceVendorId,
        carryingCost: data.carryingCost ?? 0,
        insuranceCost: data.insuranceCost ?? 0,
        taxLiability: data.taxLiability ?? 0,
        targetDisposalDate: data.targetDisposalDate,
        dispositionStrategy: data.dispositionStrategy,
        expectedRecoveryRate: data.expectedRecoveryRate,
        metadata: data.metadata,
      },
    });
  }

  async updateREOStatus(
    reoId: string,
    status: string,
    metadata?: {
      notes?: string;
      previousStatus?: string;
      changedBy?: string;
    }
  ) {
    const reo = await this.db.rEOProperty.findUnique({ where: { id: reoId } });
    if (!reo) throw new Error("REOProperty not found");

    const updateData: any = { status };

    if (status === "SOLD" || status === "TRANSFERRED") {
      updateData.soldAt = new Date();
    }
    if (status === "LISTED_FOR_SALE" || status === "SHORT_SALE_LISTED") {
      updateData.listedAt = new Date();
    }

    if (metadata) {
      const existingMeta = (reo.metadata as any) || {};
      updateData.metadata = {
        ...existingMeta,
        statusHistory: [
          ...(existingMeta.statusHistory || []),
          {
            from: metadata.previousStatus ?? reo.status,
            to: status,
            at: new Date().toISOString(),
            notes: metadata.notes,
            changedBy: metadata.changedBy,
          },
        ],
      };
    }

    return this.db.rEOProperty.update({
      where: { id: reoId },
      data: updateData,
    });
  }

  async getOrgPortfolioSummary(orgId: string) {
    const [portfolios, reoProperties] = await Promise.all([
      this.db.institutionalPortfolio.findMany({
        where: { orgId },
        include: { holdings: true },
        orderBy: { createdAt: "desc" },
      }),
      this.db.rEOProperty.findMany({
        where: { orgId },
        orderBy: { createdAt: "desc" },
      }),
    ]);

    const portfolioSummaries = portfolios.map((p) => {
      const holdings = p.holdings || [];
      const totalValue = holdings.reduce((s, h) => s + Number(h.currentValue), 0);
      const totalMonthlyIncome = holdings.reduce((s, h) => s + Number(h.monthlyIncome), 0);
      const occupiedCount = holdings.filter((h) => h.occupancyStatus === "OCCUPIED").length;

      return {
        ...p,
        computedMetrics: {
          totalValue,
          totalHoldings: holdings.length,
          occupancyRate: holdings.length > 0 ? occupiedCount / holdings.length : 0,
          monthlyRentalIncome: totalMonthlyIncome,
        },
      };
    });

    const reoSummary = {
      total: reoProperties.length,
      byStatus: reoProperties.reduce((acc: Record<string, number>, r) => {
        acc[r.status] = (acc[r.status] || 0) + 1;
        return acc;
      }, {}),
      totalCarryingCost: reoProperties.reduce((s, r) => s + Number(r.carryingCost), 0),
      totalOutstandingBalance: reoProperties.reduce((s, r) => s + Number(r.outstandingBalance || 0), 0),
    };

    return { portfolios: portfolioSummaries, reoSummary, reoProperties };
  }
}

export const reoPortfolioService = new REOPortfolioService();
