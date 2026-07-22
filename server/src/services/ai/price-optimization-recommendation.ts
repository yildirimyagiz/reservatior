import { GoogleGenerativeAI } from "@google/generative-ai";
import { prisma } from "../../lib/prisma";

const apiKey = process.env.GEMINI_API_KEY || "AIzaSy_MOCK_KEY_FOR_DEV";
const genAI = new GoogleGenerativeAI(apiKey);

export interface PriceOptimizationInput {
  listingId: string;
  currentPrice: number;
  currency: string;
  vacancyDays: number;
  marketDemand?: number; // 0-1
  seasonality?: string;
  conversionRate?: number;
  averageViewingCount?: number;
  savedCount?: number;
  chatRequests?: number;
}

export interface PriceOptimizationRecommendation {
  listingId: string;
  currentPrice: number;
  recommendedPrice: number;
  recommendedDiscount: number; // e.g. 0.06 for 6%
  confidence: number; // 0-1
  estimatedVacancyReduction: number; // e.g. 0.32 for 32%
  estimatedRevenueImpact: number;
  estimatedRentalProbability: number; // 0-1
  marketDemandScore: number;
  reasons: string[];
  comparableAnalysis: {
    similarCount: number;
    avgPrice: number;
    avgVacancyDays: number;
  };
  generatedAt: Date;
}

export class PriceOptimizationRecommendationService {
  static async generateRecommendation(input: PriceOptimizationInput): Promise<PriceOptimizationRecommendation | null> {
    console.log(`[PriceOptimizationAI] Generating recommendation for listing ${input.listingId}...`);

    // Try AI first
    try {
      const model = genAI.getGenerativeModel({ model: "gemini-2.5-flash" });

      const prompt = `
        You are a Real Estate Pricing Optimization AI.
        Analyze this listing and recommend a price optimization.

        Current Price: ${input.currentPrice} ${input.currency}
        Days Vacant: ${input.vacancyDays}
        Market Demand (0-1): ${input.marketDemand ?? 0.5}
        Conversion Rate: ${input.conversionRate ?? 0.05}
        Avg Viewings: ${input.averageViewingCount ?? 0}
        Saved Count: ${input.savedCount ?? 0}
        Chat Requests: ${input.chatRequests ?? 0}
        Seasonality: ${input.seasonality ?? "normal"}

        Recommend a discount between 5% and 7%.
        Provide estimated vacancy reduction and revenue impact.

        Respond ONLY with a valid JSON object:
        {
          "recommendedDiscount": number (0.05-0.07),
          "confidence": number (0-1),
          "estimatedVacancyReduction": number (0-1),
          "estimatedRentalProbability": number (0-1),
          "marketDemandScore": number (0-1),
          "reasons": string[],
          "comparableAnalysis": { "similarCount": number, "avgPrice": number, "avgVacancyDays": number }
        }
      `;

      const response = await model.generateContent(prompt);
      const text = response.response.text();
      const jsonMatch = text.match(/\{[\s\S]*\}/);
      if (jsonMatch) {
        const data = JSON.parse(jsonMatch[0]);
        const discount = Math.max(0.05, Math.min(0.07, data.recommendedDiscount));
        const recommendedPrice = input.currentPrice * (1 - discount);
        const estimatedRevenueImpact = -(input.currentPrice - recommendedPrice) * (data.estimatedRentalProbability ?? 0.5);

        return {
          listingId: input.listingId,
          currentPrice: input.currentPrice,
          recommendedPrice: Math.round(recommendedPrice * 100) / 100,
          recommendedDiscount: discount,
          confidence: data.confidence ?? 0.5,
          estimatedVacancyReduction: data.estimatedVacancyReduction ?? 0.2,
          estimatedRevenueImpact: Math.round(estimatedRevenueImpact * 100) / 100,
          estimatedRentalProbability: data.estimatedRentalProbability ?? 0.5,
          marketDemandScore: data.marketDemandScore ?? 0.5,
          reasons: data.reasons ?? ["AI recommendation based on market analysis"],
          comparableAnalysis: data.comparableAnalysis ?? { similarCount: 0, avgPrice: input.currentPrice, avgVacancyDays: 45 },
          generatedAt: new Date(),
        };
      }
    } catch (err) {
      console.warn(`[PriceOptimizationAI] AI generation failed, using fallback: ${err}`);
    }

    // Fallback: rule-based recommendation
    return this.fallbackRecommendation(input);
  }

  static async acceptRecommendation(listingId: string, source: "AI" | "OWNER" | "AGENT" | "SYSTEM" = "AI"): Promise<void> {
    const opt = await prisma.aIPriceOptimization.findFirst({
      where: { listingId, isApplied: false },
      orderBy: { generatedAt: "desc" },
    });

    if (!opt) throw new Error("No pending optimization found for this listing");

    await prisma.aIPriceOptimization.update({
      where: { id: opt.id },
      data: { isApplied: true, appliedAt: new Date(), acceptedAt: new Date() },
    });

    const discount = opt.recommendedDiscount
      ? Number(opt.recommendedDiscount)
      : 1 - Number(opt.recommendedPrice) / Number(opt.currentPrice);

    // Import and call smart ranking service to activate boost
    const { smartRankingService } = await import("../ranking/smart-ranking-service");
    await smartRankingService.activateOptimizationBoost(
      listingId,
      Number(discount.toFixed(4)),
      "AI price optimization accepted",
      source
    );
  }

  static async declineRecommendation(listingId: string, reason?: string): Promise<void> {
    await prisma.aIPriceOptimization.updateMany({
      where: { listingId, isApplied: false },
      data: { declinedAt: new Date(), rejectionReason: reason || "Owner declined" },
    });

    const { eventBus } = await import("../../core/events/event-bus");
    const { DomainEvents } = await import("../../core/events/domain-events");
    eventBus.publish(DomainEvents.PRICE_OPTIMIZATION_DECLINED, { listingId, reason }, "AIOS");
  }

  private static fallbackRecommendation(input: PriceOptimizationInput): PriceOptimizationRecommendation {
    // Simple rule-based fallback
    const discount = input.vacancyDays > 60 ? 0.07 : input.vacancyDays > 30 ? 0.06 : 0.05;
    const confidence = 0.4;
    const estimatedVacancyReduction = Math.min(0.5, 0.1 + input.vacancyDays * 0.003);
    const recommendedPrice = input.currentPrice * (1 - discount);

    return {
      listingId: input.listingId,
      currentPrice: input.currentPrice,
      recommendedPrice: Math.round(recommendedPrice * 100) / 100,
      recommendedDiscount: discount,
      confidence,
      estimatedVacancyReduction,
      estimatedRevenueImpact: Math.round(-(input.currentPrice - recommendedPrice) * 0.5 * 100) / 100,
      estimatedRentalProbability: Math.min(0.9, 0.3 + input.vacancyDays * 0.005),
      marketDemandScore: input.marketDemand ?? 0.5,
      reasons: [
        `Property has been vacant for ${input.vacancyDays} days`,
        "Standard discount applied based on vacancy duration",
        "Recommend monitoring for 2 weeks after adjustment",
      ],
      comparableAnalysis: {
        similarCount: 0,
        avgPrice: input.currentPrice,
        avgVacancyDays: 45,
      },
      generatedAt: new Date(),
    };
  }
}
