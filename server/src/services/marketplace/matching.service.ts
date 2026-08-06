/**
 * Marketplace Matching Service
 * 
 * Manages supply-demand matching, ranking, and recommendations.
 * Provides network effects for the rental marketplace.
 * Handles demand analysis, supply analysis, matching algorithms, ranking, and recommendations.
 */

import { prisma } from "../../lib/prisma";

export enum MatchType {
  TENANT_PROPERTY = "TENANT_PROPERTY",
  LANDLORD_AGENT = "LANDLORD_AGENT",
  BUYER_PROPERTY = "BUYER_PROPERTY",
  INVESTOR_PROPERTY = "INVESTOR_PROPERTY",
}

export enum MatchStatus {
  PENDING = "PENDING",
  ACCEPTED = "ACCEPTED",
  REJECTED = "REJECTED",
  EXPIRED = "EXPIRED",
}

export interface Match {
  id: string;
  matchType: MatchType;
  fromEntityId: string;
  toEntityId: string;
  matchScore: number; // 0-100
  compatibilityScore: number; // 0-100
  status: MatchStatus;
  factors: { factor: string; score: number }[];
  metadata?: any;
  createdAt: Date;
  expiresAt?: Date;
}

export interface DemandSignal {
  entityType: string;
  entityId: string;
  criteria: any;
  urgency: number; // 0-100
  budget: number;
  location: string;
  timestamp: Date;
}

export interface SupplySignal {
  entityType: string;
  entityId: string;
  attributes: any;
  availability: boolean;
  price: number;
  location: string;
  timestamp: Date;
}

export class MarketplaceMatchingService {
  /**
   * Analyze demand for properties
   */
  async analyzeDemand(location: string, propertyType?: string): Promise<DemandSignal[]> {
    const properties = await prisma.property.findMany({
      where: { city: location },
      take: 100,
    });

    // Create mock demand signals based on properties
    const demandSignals: DemandSignal[] = properties.map(property => ({
      entityType: "TENANT",
      entityId: property.id,
      criteria: {
        bedrooms: property.bedrooms,
        budget: property.aiOpportunityScore || 50,
        preferredAreas: [property.city],
      },
      urgency: Math.random() * 100,
      budget: property.aiOpportunityScore || 1000,
      location: property.city,
      timestamp: new Date(),
    }));

    return demandSignals;
  }

  /**
   * Analyze supply of properties
   */
  async analyzeSupply(location: string, propertyType?: string): Promise<SupplySignal[]> {
    const where: any = { city: location };
    if (propertyType) where.type = propertyType;

    const properties = await prisma.property.findMany({
      where,
      take: 100,
    });

    const supplySignals: SupplySignal[] = properties.map(property => ({
      entityType: "PROPERTY",
      entityId: property.id,
      attributes: {
        bedrooms: property.bedrooms,
        bathrooms: property.bathrooms,
        areaSqm: property.areaSqm,
      },
      availability: property.listingType === "RENTAL" as any,
      price: property.aiOpportunityScore || 50,
      location: property.city,
      timestamp: new Date(),
    }));

    return supplySignals;
  }

  /**
   * Match tenant to property
   */
  async matchTenantToProperty(tenantId: string, propertyId: string): Promise<Match> {
    const property = await prisma.property.findUnique({ where: { id: propertyId } });

    if (!property) {
      throw new Error("Property not found");
    }

    const factors: { factor: string; score: number }[] = [];

    // Budget compatibility (using AI score as proxy)
    const budgetScore = this.calculateBudgetCompatibility(
      1000,
      property.aiOpportunityScore || 50
    );
    factors.push({ factor: "Budget Compatibility", score: budgetScore });

    // AI opportunity score
    const aiScore = property.aiOpportunityScore || 50;
    factors.push({ factor: "AI Opportunity Score", score: aiScore });

    // Location score
    const locationScore = property.aiNeighborhoodScore || 50;
    factors.push({ factor: "Location Score", score: locationScore });

    const matchScore = factors.reduce((sum, f) => sum + f.score, 0) / factors.length;
    const compatibilityScore = (budgetScore + aiScore + locationScore) / 3;

    return {
      id: `match-${Date.now()}`,
      matchType: MatchType.TENANT_PROPERTY,
      fromEntityId: tenantId,
      toEntityId: propertyId,
      matchScore: Math.round(matchScore),
      compatibilityScore: Math.round(compatibilityScore),
      status: MatchStatus.PENDING,
      factors,
      metadata: { property },
      createdAt: new Date(),
      expiresAt: new Date(Date.now() + 7 * 24 * 60 * 60 * 1000), // 7 days
    };
  }

  /**
   * Calculate budget compatibility
   */
  private calculateBudgetCompatibility(budget: number, price: number): number {
    const ratio = price / budget;
    if (ratio <= 0.8) return 100;
    if (ratio <= 1.0) return 80;
    if (ratio <= 1.2) return 60;
    if (ratio <= 1.5) return 40;
    return 20;
  }

  /**
   * Calculate size compatibility
   */
  private calculateSizeCompatibility(tenantBedrooms: number, propertyBedrooms: number): number {
    const diff = Math.abs(tenantBedrooms - propertyBedrooms);
    if (diff === 0) return 100;
    if (diff === 1) return 80;
    if (diff === 2) return 60;
    return 40;
  }

  /**
   * Rank matches by score
   */
  async rankMatches(matches: Match[]): Promise<Match[]> {
    return matches.sort((a, b) => b.matchScore - a.matchScore);
  }

  /**
   * Get recommendations for an entity
   */
  async getRecommendations(
    entityType: string,
    entityId: string,
    limit: number = 10
  ): Promise<Match[]> {
    let matches: Match[] = [];

    if (entityType === "TENANT") {
      const properties = await prisma.property.findMany({ take: limit * 2 });
      for (const property of properties) {
        try {
          const match = await this.matchTenantToProperty(entityId, property.id);
          matches.push(match);
        } catch (error) {
          // Skip failed matches
        }
      }
    }

    const rankedMatches = await this.rankMatches(matches);
    return rankedMatches.slice(0, limit);
  }

  /**
   * Get marketplace statistics
   */
  async getMarketplaceStats(location: string): Promise<any> {
    const [demand, supply] = await Promise.all([
      this.analyzeDemand(location),
      this.analyzeSupply(location),
    ]);

    const demandCount = demand.length;
    const supplyCount = supply.length;
    const avgDemandBudget = demand.length > 0
      ? demand.reduce((sum, d) => sum + d.budget, 0) / demand.length
      : 0;
    const avgSupplyPrice = supply.length > 0
      ? supply.reduce((sum, s) => sum + s.price, 0) / supply.length
      : 0;

    const supplyDemandRatio = demandCount > 0 ? supplyCount / demandCount : 0;

    return {
      location,
      demandCount,
      supplyCount,
      avgDemandBudget: Math.round(avgDemandBudget),
      avgSupplyPrice: Math.round(avgSupplyPrice),
      supplyDemandRatio: Math.round(supplyDemandRatio * 100) / 100,
      marketHealth: this.calculateMarketHealth(supplyDemandRatio),
    };
  }

  /**
   * Calculate market health score
   */
  private calculateMarketHealth(ratio: number): string {
    if (ratio >= 1.2) return "BUYERS_MARKET";
    if (ratio >= 0.8) return "BALANCED";
    return "SELLERS_MARKET";
  }

  /**
   * Create match
   */
  async createMatch(match: Omit<Match, "id" | "createdAt">): Promise<Match> {
    // In production, store match in database
    return {
      ...match,
      id: `match-${Date.now()}`,
      createdAt: new Date(),
    };
  }

  /**
   * Update match status
   */
  async updateMatchStatus(matchId: string, status: MatchStatus): Promise<Match> {
    // In production, update in database
    return {
      id: matchId,
      matchType: MatchType.TENANT_PROPERTY,
      fromEntityId: "",
      toEntityId: "",
      matchScore: 0,
      compatibilityScore: 0,
      status,
      factors: [],
      createdAt: new Date(),
    };
  }

  /**
   * Get match history
   */
  async getMatchHistory(entityId: string, limit: number = 20): Promise<Match[]> {
    // In production, fetch from database
    return [];
  }
}

export const marketplaceMatchingService = new MarketplaceMatchingService();
