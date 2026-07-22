import { describe, expect, it, mock } from "bun:test";
import { SmartRankingService } from "../smart-ranking-service";
import { defaultRankingConfig } from "../smart-ranking-config";
import { PriceOptimizationRecommendationService } from "../../ai/price-optimization-recommendation";

mock.module("../../../lib/prisma", () => ({
  prisma: {
    listing: {
      findUnique: async () => null,
      findMany: async () => [],
      update: async () => ({}),
      count: async () => 0,
      aggregate: async () => ({ _avg: {}, _sum: {} }),
      groupBy: async () => [],
    },
    listingStatusHistory: { findMany: async () => [] },
    aIPriceOptimization: { findFirst: async () => null, updateMany: async () => ({}), count: async () => 0 },
    notification: { create: async () => ({}) },
    financialRecord: { create: async () => ({}) },
    commission: { aggregate: async () => ({ _sum: { amount: 0 } }) },
    $transaction: async (fn: any) => fn(undefined),
  },
}));

mock.module("../../../core/events/event-bus", () => ({
  eventBus: { publish: () => {} },
}));

mock.module("../../../core/events/domain-events", () => ({
  DomainEvents: {
    LISTING_BOOSTED: "listing.boosted",
    BOOST_SCORE_UPDATED: "boost.score.updated",
    VACANCY_THRESHOLD_REACHED: "vacancy.threshold.reached",
    VACANCY_ANALYZED: "vacancy.analyzed",
    RANKING_RECALCULATED: "ranking.recalculated",
  },
}));

describe("Smart Ranking Service", () => {
  const service = new SmartRankingService();

  it("should calculate ranking score from weighted formula", async () => {
    const score = await service.calculateRankingScore({
      id: "test-1",
      title: "Test Property",
      description: "A nice property",
      photos: ["photo1.jpg", "photo2.jpg", "photo3.jpg"],
      qualityScore: 0.8,
      agentReputation: 0.9,
      isVerified: true,
      boostScore: 1.0,
      createdAt: new Date(),
      updatedAt: new Date(),
      likes: 10,
      saves: 5,
      chatRequests: 3,
    });

    expect(score).toBeGreaterThan(0);
    expect(score).toBeLessThanOrEqual(1.0);
  });

  it("should handle minimum quality scores", async () => {
    const score = await service.calculateRankingScore({
      id: "test-2",
      qualityScore: 0,
      agentReputation: 0,
      isVerified: false,
      boostScore: 0,
      createdAt: new Date(Date.now() - 365 * 24 * 60 * 60 * 1000),
      updatedAt: new Date(Date.now() - 365 * 24 * 60 * 60 * 1000),
    });

    expect(score).toBeGreaterThanOrEqual(0);
    expect(score).toBeLessThanOrEqual(0.5);
  });

  it("should return higher score for optimized listings", async () => {
    const normal = await service.calculateRankingScore({
      id: "normal",
      qualityScore: 0.5,
      agentReputation: 0.5,
      isVerified: true,
      boostScore: 0.5,
      createdAt: new Date(),
      updatedAt: new Date(),
      likes: 5,
      saves: 2,
    });

    const optimized = await service.calculateRankingScore({
      id: "optimized",
      isOptimizedForSpeed: true,
      qualityScore: 0.5,
      agentReputation: 0.5,
      isVerified: true,
      boostScore: 0.5 * (defaultRankingConfig.boost.optimizationBoostMultiplier || 1.5),
      createdAt: new Date(),
      updatedAt: new Date(),
      likes: 5,
      saves: 2,
    });

    expect(optimized).toBeGreaterThanOrEqual(normal);
  });

  it("should have correct config weights summing to 1.0", () => {
    const w = defaultRankingConfig.weights;
    const total = w.qualityScore + w.trustScore + w.boostScore + w.freshnessScore + w.engagementScore;
    expect(total).toBeCloseTo(1.0, 2);
  });
});

describe("Price Optimization Recommendation", () => {
  it("should generate fallback recommendation when AI is unavailable", async () => {
    const result = await PriceOptimizationRecommendationService.generateRecommendation({
      listingId: "test-123",
      currentPrice: 100000,
      currency: "USD",
      vacancyDays: 45,
    });

    expect(result).not.toBeNull();
    expect(result!.listingId).toBe("test-123");
    expect(result!.currentPrice).toBe(100000);
    expect(result!.recommendedDiscount).toBeGreaterThanOrEqual(0.05);
    expect(result!.recommendedDiscount).toBeLessThanOrEqual(0.07);
    expect(result!.reasons.length).toBeGreaterThan(0);
  });

  it("should recommend higher discount for longer vacancy", async () => {
    const short = await PriceOptimizationRecommendationService.generateRecommendation({
      listingId: "l1", currentPrice: 100000, currency: "USD", vacancyDays: 20,
    });
    const long = await PriceOptimizationRecommendationService.generateRecommendation({
      listingId: "l2", currentPrice: 100000, currency: "USD", vacancyDays: 90,
    });

    expect(short).not.toBeNull();
    expect(long).not.toBeNull();
    expect(long!.recommendedDiscount).toBeGreaterThanOrEqual(short!.recommendedDiscount);
  });
});

describe("Smart Ranking Config", () => {
  it("should have valid optimization range", () => {
    expect(defaultRankingConfig.optimization.minOptimizationRate).toBeGreaterThanOrEqual(0.05);
    expect(defaultRankingConfig.optimization.maxOptimizationRate).toBeLessThanOrEqual(0.07);
    expect(defaultRankingConfig.optimization.minOptimizationRate).toBeLessThan(
      defaultRankingConfig.optimization.maxOptimizationRate
    );
  });

  it("should have ascending notification timing", () => {
    const timings = defaultRankingConfig.notificationTimingDays;
    for (let i = 1; i < timings.length; i++) {
      expect(timings[i]).toBeGreaterThan(timings[i - 1]);
    }
  });
});
