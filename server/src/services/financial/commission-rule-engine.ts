export type AgentType = "FREELANCE" | "OFFICE" | "ENTERPRISE";

export interface CommissionContext {
  countryCode: string;
  agentType: AgentType;
  agentId?: string;
  orgId?: string;
  listingId?: string;
  transactionAmount: number;
  currency: string;
  campaignTag?: string;
  isFirstTransaction?: boolean;
  volumeYtd?: number;
  listingOptimizationStatus?: "OPTIMIZED" | "STANDARD";
}

export interface RuleBreakdown {
  countryBaseRate: number;
  regulatoryCeiling: number | null;
  marketAdjustment: number;
  agentTypeModifier: number;
  campaignIncentive: number;
  volumeIncentive: number;
  dualSidedAdjustment: number;
  policyPlatformRate: number;
  policyPartnerRate: number;
  policyAgentRate: number;
}

export interface CommissionResult {
  finalRate: number;
  finalAmount: number;
  platformShare: number;
  agentShare: number;
  supplierShare: number;
  breakdown: RuleBreakdown;
  appliedRules: string[];
  calculationType: "Performance-Based Value Sharing" | "Direct Agent Rewards" | "Standard";
  warnings: string[];
}

const FALLBACK_COUNTRY_RULES: Record<string, { baseRate: number; ceiling: number }> = {
  TR: { baseRate: 0.04, ceiling: 0.10 },
  US: { baseRate: 0.05, ceiling: 0.12 },
  DE: { baseRate: 0.045, ceiling: 0.08 },
  AE: { baseRate: 0.04, ceiling: 0.10 },
  GB: { baseRate: 0.035, ceiling: 0.08 },
  GE: { baseRate: 0.04, ceiling: 0.10 },
  AZ: { baseRate: 0.04, ceiling: 0.10 },
  RU: { baseRate: 0.04, ceiling: 0.10 },
  GR: { baseRate: 0.05, ceiling: 0.12 },
};

const FALLBACK_MARKET_ADJUSTMENTS: Record<string, number> = {
  TR: 0.002, US: 0.0, DE: -0.002, AE: 0.005, GB: 0.0,
  GE: 0.001, AZ: 0.001, RU: 0.001, GR: -0.005,
};

const FALLBACK_AGENT_MODIFIERS: Record<AgentType, number> = {
  FREELANCE: -0.005, OFFICE: 0.0, ENTERPRISE: -0.01,
};

const FALLBACK_CAMPAIGN_INCENTIVES: Record<string, number> = {
  "summer-sale": -0.002, "new-listing": -0.003,
  "first-booking": -0.005, "holiday-promo": -0.002, "volume-discount": -0.003,
};

async function loadDbCountryRules(countryCode: string, agentType: AgentType) {
  try {
    const { prisma } = await import("../../lib/prisma");
    const rules = await prisma.countryCommissionRule.findMany({
      where: {
        countryCode,
        isActive: true,
        effectiveFrom: { lte: new Date() },
        OR: [{ effectiveUntil: null }, { effectiveUntil: { gte: new Date() } }],
      },
      orderBy: { effectiveFrom: "desc" },
    });

    if (rules.length === 0) return null;

    const agentRule = rules.find((r: { agentType: string }) => r.agentType === agentType) || rules[0];
    return {
      baseRate: Number(agentRule.baseCommissionRate),
      ceiling: agentRule.regulatoryCeiling ? Number(agentRule.regulatoryCeiling) : null,
      marketAdjustment: agentRule.marketAdjustment ? Number(agentRule.marketAdjustment) : null,
      volumeIncentives: agentRule.volumeIncentives as Record<string, number> | null,
      campaignTags: agentRule.campaignTags as Record<string, number> | null,
      ruleId: agentRule.id,
    };
  } catch {
    return null;
  }
}

function getVolumeIncentive(volumeYtd: number): number {
  if (volumeYtd >= 1_000_000) return -0.003;
  if (volumeYtd >= 500_000) return -0.002;
  if (volumeYtd >= 100_000) return -0.001;
  return 0;
}

export async function evaluateCommissionRules(context: CommissionContext): Promise<CommissionResult> {
  const warnings: string[] = [];
  const appliedRules: string[] = [];

  const dbRules = await loadDbCountryRules(context.countryCode, context.agentType);
  const policyResult = context.orgId
    ? await (async () => {
        try {
          const { getCommissionPolicy } = await import("./commission-policy-service");
          return await getCommissionPolicy(context.orgId!, context.countryCode, context.agentType);
        } catch {
          return null as any;
        }
      })()
    : null;

  let baseRate: number;
  let ceiling: number | null;
  let marketAdjustment: number;
  let agentTypeModifier: number;
  let campaignIncentives: Record<string, number>;
  let volumeIncentives: Record<string, number>;
  let dbRuleId: string | null = null;

  if (dbRules) {
    baseRate = dbRules.baseRate;
    ceiling = dbRules.ceiling;
    marketAdjustment = dbRules.marketAdjustment ?? FALLBACK_MARKET_ADJUSTMENTS[context.countryCode] ?? 0;
    agentTypeModifier = dbRules.baseRate - baseRate;
    campaignIncentives = (dbRules.campaignTags as Record<string, number>) ?? FALLBACK_CAMPAIGN_INCENTIVES;
    volumeIncentives = (dbRules.volumeIncentives as Record<string, number>) ?? {};
    dbRuleId = dbRules.ruleId;
    appliedRules.push(`db_rule:${dbRuleId}=${(baseRate * 100).toFixed(2)}%`);
  } else {
    const fallback = FALLBACK_COUNTRY_RULES[context.countryCode] || { baseRate: 0.04, ceiling: 0.10 };
    baseRate = fallback.baseRate;
    ceiling = fallback.ceiling;
    marketAdjustment = FALLBACK_MARKET_ADJUSTMENTS[context.countryCode] || 0;
    agentTypeModifier = FALLBACK_AGENT_MODIFIERS[context.agentType];
    campaignIncentives = FALLBACK_CAMPAIGN_INCENTIVES;
    appliedRules.push(`fallback_country_rate:${context.countryCode}=${(baseRate * 100).toFixed(2)}%`);
  }

  appliedRules.push(`country_base_rate=${(baseRate * 100).toFixed(2)}%`);
  if (ceiling !== null) {
    appliedRules.push(`regulatory_ceiling=${(ceiling * 100).toFixed(2)}%`);
  }

  const afterMarket = baseRate + marketAdjustment;
  appliedRules.push(`market_adjustment=${(marketAdjustment * 100).toFixed(2)}%`);

  const afterAgentType = Math.max(0, afterMarket + agentTypeModifier);
  appliedRules.push(`agent_type_modifier:${context.agentType}=${(agentTypeModifier * 100).toFixed(2)}%`);

  let campaignIncentive = 0;
  if (context.campaignTag && campaignIncentives[context.campaignTag]) {
    campaignIncentive = campaignIncentives[context.campaignTag];
    appliedRules.push(`campaign_incentive:${context.campaignTag}=${(campaignIncentive * 100).toFixed(2)}%`);
  }

  if (context.isFirstTransaction) {
    campaignIncentive += -0.005;
    appliedRules.push("first_transaction_bonus:-0.50%");
  }

  const volumeAmount = context.volumeYtd ?? 0;
  let volumeIncentive = volumeIncentives[String(volumeAmount)] ?? 0;
  if (volumeIncentive === 0) {
    volumeIncentive = getVolumeIncentive(volumeAmount);
  }
  if (volumeIncentive !== 0) {
    appliedRules.push(`volume_incentive:ytd=${volumeAmount}=${(volumeIncentive * 100).toFixed(2)}%`);
  }

  let tentativeRate = afterAgentType + campaignIncentive + volumeIncentive;

  if (ceiling !== null && tentativeRate > ceiling) {
    warnings.push(`Rate ${(tentativeRate * 100).toFixed(2)}% exceeds regulatory ceiling of ${(ceiling * 100).toFixed(2)}%. Capped.`);
    tentativeRate = ceiling;
  }

  let calculationType: CommissionResult["calculationType"] = "Standard";
  const hasAgentOptimization = context.agentType === "FREELANCE" || context.listingOptimizationStatus === "OPTIMIZED";
  if (hasAgentOptimization && (campaignIncentive < 0 || volumeIncentive < 0)) {
    calculationType = "Performance-Based Value Sharing";
  } else if (context.agentType === "FREELANCE") {
    calculationType = "Direct Agent Rewards";
  }

  const dualSidedAdjustment = context.listingOptimizationStatus === "OPTIMIZED" ? 0.035 : 0;

  const finalRate = Math.max(0, tentativeRate);
  const finalAmount = context.transactionAmount * finalRate;

  const platRate = policyResult && policyResult.source === "database" ? policyResult.platformRate : 0.30;
  const partnerRate = policyResult && policyResult.source === "database" ? policyResult.partnerRate : 0.10;
  const agentRate = 1 - platRate - partnerRate;

  const platformShare = finalAmount * platRate;
  const agentShare = finalAmount * agentRate;
  const supplierShare = finalAmount * partnerRate;

  if (policyResult && policyResult.source === "database") {
    appliedRules.push(`policy:${policyResult.policyId}=platform=${(platRate * 100).toFixed(0)}%/partner=${(partnerRate * 100).toFixed(0)}%/agent=${(agentRate * 100).toFixed(0)}%`);
  } else {
    appliedRules.push("policy:default=platform=30%/partner=10%/agent=60%");
  }

  const breakdown: RuleBreakdown = {
    countryBaseRate: baseRate,
    regulatoryCeiling: ceiling,
    marketAdjustment,
    agentTypeModifier,
    campaignIncentive,
    volumeIncentive,
    dualSidedAdjustment,
    policyPlatformRate: platRate,
    policyPartnerRate: partnerRate,
    policyAgentRate: agentRate,
  };

  return {
    finalRate,
    finalAmount,
    platformShare,
    agentShare,
    supplierShare,
    breakdown,
    appliedRules,
    calculationType,
    warnings,
  };
}
