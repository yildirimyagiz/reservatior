export interface CommissionPolicyData {
  id?: string;
  orgId: string;
  countryCode: string;
  agentType?: "FREELANCE" | "OFFICE" | "ENTERPRISE";
  platformRate: number;
  partnerRate: number;
  settlementTiming: string;
  maxInstallments: number;
  defaultInstallments: number;
  installmentInterest: number;
  minCommission?: number;
  maxCommission?: number;
  requiresApproval: boolean;
  approvalThreshold?: number;
  isActive: boolean;
  effectiveFrom: Date;
  effectiveUntil?: Date;
}

export interface SettlementPolicyData {
  id?: string;
  orgId: string;
  name: string;
  countryCode: string;
  settlementType: string;
  upfrontPercent: number;
  installmentCount: number;
  installmentFrequency: string;
  interestRate: number;
  earlySettlementDiscount: number;
  earlySettlementDays: number;
  latePenaltyRate: number;
  lateGraceDays: number;
  minCommissionAmount?: number;
  minInstallmentAmount?: number;
  isActive: boolean;
  effectiveFrom: Date;
  effectiveUntil?: Date;
}

export interface PricingPolicyData {
  id?: string;
  orgId: string;
  name: string;
  countryCode: string;
  maxDiscountPct: number;
  minPriceFloor?: number;
  strategy: string;
  minAdjustmentPct: number;
  maxAdjustmentPct: number;
  adjustmentFrequency: string;
  highSeasonMultiplier: number;
  lowSeasonMultiplier: number;
  aiOptimizationEnabled: boolean;
  minConfidenceThreshold?: number;
  isActive: boolean;
  effectiveFrom: Date;
  effectiveUntil?: Date;
}

export interface PolicyResult {
  platformRate: number;
  partnerRate: number;
  settlementTiming: string;
  maxInstallments: number;
  defaultInstallments: number;
  installmentInterest: number;
  strategy: string;
  maxDiscountPct: number;
  source: "database" | "default";
  policyId?: string;
}

async function loadActivePolicy<T>(
  model: any,
  where: Record<string, any>
): Promise<T | null> {
  try {
    const { prisma } = await import("../../lib/prisma");
    const record = await model.findFirst({
      where: { ...where, isActive: true, deletedAt: null },
      orderBy: { effectiveFrom: "desc" },
    });
    return record as T | null;
  } catch {
    return null;
  }
}

export async function getCommissionPolicy(
  orgId: string,
  countryCode: string,
  agentType?: string
): Promise<PolicyResult> {
  const record = await loadActivePolicy<any>(
    { findFirst: (args: any) => import("../../lib/prisma").then((m: any) => m.prisma.commissionPolicy.findFirst(args)) }
      .findFirst,
    { orgId, countryCode, agentType: agentType || undefined }
  );

  if (record) {
    return {
      platformRate: Number(record.platformRate),
      partnerRate: Number(record.partnerRate),
      settlementTiming: record.settlementTiming,
      maxInstallments: record.maxInstallments,
      defaultInstallments: record.defaultInstallments,
      installmentInterest: Number(record.installmentInterest),
      strategy: "standard",
      maxDiscountPct: 0,
      source: "database",
      policyId: record.id,
    };
  }

  return {
    platformRate: 0.30,
    partnerRate: 0.10,
    settlementTiming: "INSTALLMENT",
    maxInstallments: 12,
    defaultInstallments: 6,
    installmentInterest: 0.10,
    strategy: "standard",
    maxDiscountPct: 0,
    source: "default",
  };
}

export async function getSettlementPolicy(
  orgId: string,
  countryCode: string,
  settlementType?: string
): Promise<{
  settlementType: string;
  upfrontPercent: number;
  installmentCount: number;
  installmentFrequency: string;
  interestRate: number;
  earlySettlementDiscount: number;
  earlySettlementDays: number;
  latePenaltyRate: number;
  lateGraceDays: number;
  source: "database" | "default";
  policyId?: string;
}> {
  const record = await loadActivePolicy<any>(
    { findFirst: (args: any) => import("../../lib/prisma").then((m: any) => m.prisma.settlementPolicy.findFirst(args)) }
      .findFirst,
    { orgId, countryCode, settlementType: settlementType || undefined }
  );

  if (record) {
    return {
      settlementType: record.settlementType,
      upfrontPercent: Number(record.upfrontPercent),
      installmentCount: record.installmentCount,
      installmentFrequency: record.installmentFrequency,
      interestRate: Number(record.interestRate),
      earlySettlementDiscount: Number(record.earlySettlementDiscount),
      earlySettlementDays: record.earlySettlementDays,
      latePenaltyRate: Number(record.latePenaltyRate),
      lateGraceDays: record.lateGraceDays,
      source: "database",
      policyId: record.id,
    };
  }

  return {
    settlementType: settlementType || "INSTALLMENT",
    upfrontPercent: 50,
    installmentCount: 6,
    installmentFrequency: "MONTHLY",
    interestRate: 0.10,
    earlySettlementDiscount: 0.05,
    earlySettlementDays: 30,
    latePenaltyRate: 0.02,
    lateGraceDays: 15,
    source: "default",
  };
}

export async function getPricingPolicy(
  orgId: string,
  countryCode: string
): Promise<{
  maxDiscountPct: number;
  minPriceFloor?: number;
  strategy: string;
  minAdjustmentPct: number;
  maxAdjustmentPct: number;
  adjustmentFrequency: string;
  highSeasonMultiplier: number;
  lowSeasonMultiplier: number;
  aiOptimizationEnabled: boolean;
  minConfidenceThreshold?: number;
  source: "database" | "default";
  policyId?: string;
}> {
  const record = await loadActivePolicy<any>(
    { findFirst: (args: any) => import("../../lib/prisma").then((m: any) => m.prisma.pricingPolicy.findFirst(args)) }
      .findFirst,
    { orgId, countryCode }
  );

  if (record) {
    return {
      maxDiscountPct: Number(record.maxDiscountPct),
      minPriceFloor: record.minPriceFloor ? Number(record.minPriceFloor) : undefined,
      strategy: record.strategy,
      minAdjustmentPct: Number(record.minAdjustmentPct),
      maxAdjustmentPct: Number(record.maxAdjustmentPct),
      adjustmentFrequency: record.adjustmentFrequency,
      highSeasonMultiplier: Number(record.highSeasonMultiplier),
      lowSeasonMultiplier: Number(record.lowSeasonMultiplier),
      aiOptimizationEnabled: record.aiOptimizationEnabled,
      minConfidenceThreshold: record.minConfidenceThreshold ? Number(record.minConfidenceThreshold) : undefined,
      source: "database",
      policyId: record.id,
    };
  }

  return {
    maxDiscountPct: 0.30,
    minPriceFloor: 0.70,
    strategy: "DYNAMIC",
    minAdjustmentPct: -0.20,
    maxAdjustmentPct: 0.20,
    adjustmentFrequency: "DAILY",
    highSeasonMultiplier: 1.20,
    lowSeasonMultiplier: 0.85,
    aiOptimizationEnabled: false,
    minConfidenceThreshold: 0.7,
    source: "default",
  };
}
