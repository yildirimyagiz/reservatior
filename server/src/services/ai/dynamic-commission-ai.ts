import { GoogleGenerativeAI } from "@google/generative-ai";
import { CommissionContext, CommissionResult } from "../financial/commission-rule-engine";

export interface DynamicAdjustmentInput {
  context: CommissionContext;
  baseResult: CommissionResult;
}

export interface DynamicAdjustmentOutput {
  adjustedRate: number;
  adjustmentRationale: string[];
  marketDifficulty: "LOW" | "MEDIUM" | "HIGH" | "VERY_HIGH";
  agentPerformanceTier: "BRONZE" | "SILVER" | "GOLD" | "PLATINUM";
  seasonalFactor: number;
  confidence: number;
}

const SEASONAL_FACTORS: Record<string, number> = {
  "01": 0.8, "02": 0.7, "03": 0.9, "04": 1.0, "05": 1.1, "06": 1.2,
  "07": 1.3, "08": 1.2, "09": 1.0, "10": 0.9, "11": 0.8, "12": 0.7,
};

const MARKET_DIFFICULTY_THRESHOLDS: Record<string, { vacancy: number; competition: number; absorption: number }> = {
  TR: { vacancy: 8, competition: 0.7, absorption: 60 },
  US: { vacancy: 5, competition: 0.8, absorption: 75 },
  DE: { vacancy: 4, competition: 0.6, absorption: 80 },
  AE: { vacancy: 10, competition: 0.75, absorption: 55 },
  GB: { vacancy: 4, competition: 0.7, absorption: 78 },
  default: { vacancy: 6, competition: 0.65, absorption: 65 },
};

const AGENT_PERFORMANCE_TIERS = {
  PLATINUM: { minVolume: 1_000_000, modifier: -0.008 },
  GOLD: { minVolume: 500_000, modifier: -0.005 },
  SILVER: { minVolume: 100_000, modifier: -0.002 },
  BRONZE: { minVolume: 0, modifier: 0 },
} as const;

export class DynamicCommissionAI {
  static async adjust(input: DynamicAdjustmentInput): Promise<DynamicAdjustmentOutput> {
    const rationale: string[] = [];
    const { context, baseResult } = input;

    const seasonalFactor = this.getSeasonalFactor();
    if (seasonalFactor !== 1.0) {
      rationale.push(`Seasonal adjustment: ${((seasonalFactor - 1) * 100).toFixed(0)}%`);
    }

    const marketDifficulty = this.evaluateMarketDifficulty(context.countryCode);
    rationale.push(`Market difficulty: ${marketDifficulty}`);

    const agentPerformanceTier = this.evaluateAgentPerformance(context.volumeYtd ?? 0);
    rationale.push(`Agent tier: ${agentPerformanceTier}`);

    let adjustedRate = baseResult.finalRate * seasonalFactor;
    const tierModifier = AGENT_PERFORMANCE_TIERS[agentPerformanceTier].modifier;
    adjustedRate += tierModifier;

    if (tierModifier !== 0) {
      rationale.push(`Agent performance modifier: ${(tierModifier * 100).toFixed(2)}%`);
    }

    if (marketDifficulty === "VERY_HIGH") {
      adjustedRate += 0.005;
      rationale.push("Very high market difficulty surcharge: +0.50%");
    } else if (marketDifficulty === "HIGH") {
      adjustedRate += 0.003;
      rationale.push("High market difficulty surcharge: +0.30%");
    } else if (marketDifficulty === "LOW") {
      adjustedRate -= 0.003;
      rationale.push("Low market difficulty discount: -0.30%");
    }

    if (context.listingOptimizationStatus === "OPTIMIZED") {
      adjustedRate -= 0.003;
      rationale.push("Optimized listing discount: -0.30%");
    }

    if (context.isFirstTransaction) {
      adjustedRate -= 0.005;
      rationale.push("First transaction welcome discount: -0.50%");
    }

    adjustedRate = Math.max(0.01, Math.min(0.20, adjustedRate));

    const confidence = this.getConfidence();

    const aiAdjusted = await this.tryAiAdjustment(baseResult, context, marketDifficulty, agentPerformanceTier, seasonalFactor);
    if (aiAdjusted !== null) {
      adjustedRate = aiAdjusted.rate;
      rationale.push(aiAdjusted.reasoning);
    }

    return {
      adjustedRate,
      adjustmentRationale: rationale,
      marketDifficulty,
      agentPerformanceTier,
      seasonalFactor,
      confidence,
    };
  }

  private static getSeasonalFactor(): number {
    const month = (new Date().getMonth() + 1).toString().padStart(2, "0");
    return SEASONAL_FACTORS[month] || 1.0;
  }

  private static evaluateMarketDifficulty(countryCode: string): DynamicAdjustmentOutput["marketDifficulty"] {
    const thresholds = MARKET_DIFFICULTY_THRESHOLDS[countryCode] || MARKET_DIFFICULTY_THRESHOLDS.default;
    const { vacancy, competition, absorption } = thresholds;
    const score = (vacancy / 12) * 0.4 + competition * 0.35 + (1 - absorption / 100) * 0.25;
    if (score >= 0.7) return "VERY_HIGH";
    if (score >= 0.5) return "HIGH";
    if (score >= 0.3) return "MEDIUM";
    return "LOW";
  }

  private static evaluateAgentPerformance(volumeYtd: number): DynamicAdjustmentOutput["agentPerformanceTier"] {
    if (volumeYtd >= AGENT_PERFORMANCE_TIERS.PLATINUM.minVolume) return "PLATINUM";
    if (volumeYtd >= AGENT_PERFORMANCE_TIERS.GOLD.minVolume) return "GOLD";
    if (volumeYtd >= AGENT_PERFORMANCE_TIERS.SILVER.minVolume) return "SILVER";
    return "BRONZE";
  }

  private static getConfidence(): number {
    try {
      const apiKey = process.env.GEMINI_API_KEY;
      if (apiKey && !apiKey.includes("MOCK")) return 0.85;
    } catch {}
    return 0.65;
  }

  private static async tryAiAdjustment(
    baseResult: CommissionResult,
    context: CommissionContext,
    marketDifficulty: string,
    agentPerformanceTier: string,
    seasonalFactor: number,
  ): Promise<{ rate: number; reasoning: string } | null> {
    const apiKey = process.env.GEMINI_API_KEY;
    if (!apiKey || apiKey.includes("MOCK")) return null;

    try {
      const genAI = new GoogleGenerativeAI(apiKey);
      const model = genAI.getGenerativeModel({ model: "gemini-2.5-flash" });

      const prompt = `You are a Commission Rate Optimization AI.
Given base commission rate ${(baseResult.finalRate * 100).toFixed(2)}% for country ${context.countryCode},
agent type ${context.agentType}, market difficulty ${marketDifficulty},
agent performance tier ${agentPerformanceTier}, seasonal factor ${seasonalFactor},
transaction amount ${context.transactionAmount} ${context.currency}.

Respond ONLY: { "adjustedRate": number (0.01-0.15), "reasoning": string }`;

      const response = await model.generateContent(prompt);
      const text = response.response.text();
      const jsonMatch = text.match(/\{[\s\S]*\}/);
      if (!jsonMatch) return null;

      const parsed = JSON.parse(jsonMatch[0]);
      if (parsed.adjustedRate > 0 && parsed.adjustedRate < 0.20) {
        return { rate: parsed.adjustedRate, reasoning: `AI: ${parsed.reasoning || "ML-based optimization"}` };
      }
    } catch {}
    return null;
  }
}
