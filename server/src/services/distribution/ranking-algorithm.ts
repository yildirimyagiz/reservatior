export interface ListingRankingInput {
  listingId: string;
  propertyId: string;
  agentId: string;
  agentScore: number;
  listingQualityScore: number;
  historicalConversionRate: number;
  platformRevenuePotential: number;
  daysListed: number;
  viewCount: number;
  inquiryCount: number;
  priceCompetitiveness: number;
  agentWorkload: number;
}

export interface ListingRankingOutput {
  listingId: string;
  finalScore: number;
  breakdown: {
    agentScore: number;
    qualityScore: number;
    conversionScore: number;
    revenueScore: number;
    freshnessScore: number;
    engagementScore: number;
    workloadScore: number;
  };
  priority: "HIGH" | "MEDIUM" | "LOW";
}

export class RankingAlgorithm {
  private readonly WEIGHTS = {
    agentScore: 0.20,
    qualityScore: 0.20,
    conversionScore: 0.25,
    revenueScore: 0.15,
    freshnessScore: 0.08,
    engagementScore: 0.07,
    workloadScore: 0.05,
  };

  score(listing: ListingRankingInput): ListingRankingOutput {
    const normalizedAgentScore = Math.min(listing.agentScore, 1);
    const normalizedQuality = Math.min(listing.listingQualityScore, 1);
    const normalizedConversion = Math.min(listing.historicalConversionRate, 1);
    const normalizedRevenue = Math.min(listing.platformRevenuePotential / 1000, 1);
    const freshness = Math.max(0, 1 - listing.daysListed / 365);
    const engagement = Math.min((listing.viewCount + listing.inquiryCount * 3) / 100, 1);
    const workloadNormalized = Math.max(0, 1 - listing.agentWorkload / 50);

    const agentScore = normalizedAgentScore * this.WEIGHTS.agentScore;
    const qualityScore = normalizedQuality * this.WEIGHTS.qualityScore;
    const conversionScore = normalizedConversion * this.WEIGHTS.conversionScore;
    const revenueScore = normalizedRevenue * this.WEIGHTS.revenueScore;
    const freshnessScore = freshness * this.WEIGHTS.freshnessScore;
    const engagementScore = engagement * this.WEIGHTS.engagementScore;
    const workloadScore = workloadNormalized * this.WEIGHTS.workloadScore;

    const finalScore = agentScore + qualityScore + conversionScore + revenueScore + freshnessScore + engagementScore + workloadScore;

    let priority: "HIGH" | "MEDIUM" | "LOW";
    if (finalScore >= 0.7) priority = "HIGH";
    else if (finalScore >= 0.4) priority = "MEDIUM";
    else priority = "LOW";

    return {
      listingId: listing.listingId,
      finalScore: Math.round(finalScore * 100) / 100,
      breakdown: {
        agentScore: Math.round(normalizedAgentScore * 100) / 100,
        qualityScore: Math.round(normalizedQuality * 100) / 100,
        conversionScore: Math.round(normalizedConversion * 100) / 100,
        revenueScore: Math.round(normalizedRevenue * 100) / 100,
        freshnessScore: Math.round(freshness * 100) / 100,
        engagementScore: Math.round(engagement * 100) / 100,
        workloadScore: Math.round(workloadNormalized * 100) / 100,
      },
      priority,
    };
  }

  rank(listings: ListingRankingInput[]): ListingRankingOutput[] {
    const scored = listings.map(l => this.score(l));
    scored.sort((a, b) => b.finalScore - a.finalScore);
    return scored;
  }
}

export const rankingAlgorithm = new RankingAlgorithm();
