import { prisma } from "../../lib/prisma";
import { tenantTrustScoreService } from "./tenant-trust-score.service";
import { landlordTrustScoreService } from "./landlord-trust-score.service";
import { agentReputationService } from "./agent-reputation.service";
import { propertyTrustScoreService } from "./property-trust-score.service";
import { transactionTrustScoreService } from "./transaction-trust-score.service";
import { trustGraphService } from "./trust-graph.service";

interface TrustCalculationResult {
  entityType: string;
  entityId: string;
  overallScore: number;
  tier: string;
  riskFactors: string[];
  positiveFactors: string[];
  timestamp: Date;
}

const TIER_THRESHOLDS = [
  { min: 90, tier: "DIAMOND" },
  { min: 75, tier: "PLATINUM" },
  { min: 55, tier: "GOLD" },
  { min: 35, tier: "SILVER" },
  { min: 0, tier: "BRONZE" },
];

function assignTier(score: number): string {
  for (const { min, tier } of TIER_THRESHOLDS) {
    if (score >= min) return tier;
  }
  return "BRONZE";
}

interface TrustInsight {
  type: "RISK" | "OPPORTUNITY" | "WARNING" | "INFO";
  message: string;
  confidence: number;
  relatedEntities: Array<{ type: string; id: string }>;
}

export const aiTrustEngineService = {
  async calculateAllTrustScores(entityType: string, entityId: string, orgId?: string): Promise<TrustCalculationResult[]> {
    const results: TrustCalculationResult[] = [];

    try {
      switch (entityType) {
        case "TENANT":
          const tenantProfile = await tenantTrustScoreService.calculateTrustScore(entityId, orgId);
          results.push({
            entityType: "TENANT",
            entityId,
            overallScore: tenantProfile.overallScore,
            tier: assignTier(tenantProfile.overallScore),
            riskFactors: (tenantProfile.riskFactors as any) as string[] || [],
            positiveFactors: [],
            timestamp: tenantProfile.lastCalculatedAt,
          });
          break;

        case "LANDLORD":
          const landlordProfile = await landlordTrustScoreService.calculateTrustScore(entityId, orgId);
          results.push({
            entityType: "LANDLORD",
            entityId,
            overallScore: landlordProfile.overallScore,
            tier: assignTier(landlordProfile.overallScore),
            riskFactors: (landlordProfile.riskFactors as any) as string[] || [],
            positiveFactors: [],
            timestamp: landlordProfile.lastCalculatedAt,
          });
          break;

        case "AGENT":
          const agentProfile = await agentReputationService.calculateReputationScore(entityId);
          results.push({
            entityType: "AGENT",
            entityId,
            overallScore: agentProfile.overallScore,
            tier: assignTier(agentProfile.overallScore),
            riskFactors: [],
            positiveFactors: [],
            timestamp: agentProfile.lastCalculatedAt,
          });
          break;

        case "PROPERTY":
          const propertyProfile = await propertyTrustScoreService.calculateTrustScore(entityId);
          results.push({
            entityType: "PROPERTY",
            entityId,
            overallScore: propertyProfile.overallScore,
            tier: assignTier(propertyProfile.overallScore),
            riskFactors: [],
            positiveFactors: [],
            timestamp: propertyProfile.lastCalculatedAt,
          });
          break;

        case "TRANSACTION":
          const transactionProfile = await transactionTrustScoreService.calculateTrustScore(entityId, "RENTAL");
          results.push({
            entityType: "TRANSACTION",
            entityId,
            overallScore: transactionProfile.overallScore,
            tier: assignTier(transactionProfile.overallScore),
            riskFactors: (transactionProfile.riskFactors as any) as string[] || [],
            positiveFactors: [],
            timestamp: transactionProfile.lastCalculatedAt,
          });
          break;
      }
    } catch (error) {
      console.error(`Error calculating trust score for ${entityType}:${entityId}`, error);
    }

    return results;
  },

  async generateTrustInsights(entityType: string, entityId: string): Promise<TrustInsight[]> {
    const insights: TrustInsight[] = [];
    const results = await this.calculateAllTrustScores(entityType, entityId);

    for (const result of results) {
      if (result.overallScore < 40) {
        insights.push({
          type: "RISK",
          message: `${result.entityType} has low trust score (${result.overallScore}). Review risk factors: ${result.riskFactors.join(", ")}`,
          confidence: 0.9,
          relatedEntities: [{ type: result.entityType, id: result.entityId }],
        });
      }

      if (result.overallScore >= 80) {
        insights.push({
          type: "OPPORTUNITY",
          message: `${result.entityType} has excellent trust score (${result.overallScore}). Consider for premium features.`,
          confidence: 0.85,
          relatedEntities: [{ type: result.entityType, id: result.entityId }],
        });
      }

      if (result.riskFactors.length > 2) {
        insights.push({
          type: "WARNING",
          message: `${result.entityType} has multiple risk factors. Address: ${result.riskFactors.slice(0, 2).join(", ")}`,
          confidence: 0.75,
          relatedEntities: [{ type: result.entityType, id: result.entityId }],
        });
      }
    }

    return insights;
  },

  async analyzeTrustRelationships(entityType: string, entityId: string) {
    const trustPropagation = await trustGraphService.calculateTrustPropagation(entityType, entityId, 2);
    const trustPath = await trustGraphService.getTrustPath(entityType, entityId, "PROPERTY", entityId);

    const relatedEntities = Array.from(trustPropagation.entries()).map(([key, score]) => {
      const [type, id] = key.split(":");
      return { type, id, propagatedScore: score };
    });

    return {
      relatedEntities,
      trustPath,
      propagationDepth: 2,
      totalRelatedEntities: relatedEntities.length,
    };
  },

  async batchCalculateTrustScores(entityIds: Array<{ type: string; id: string }>, orgId?: string) {
    const results: TrustCalculationResult[] = [];

    for (const { type, id } of entityIds) {
      const entityResults = await this.calculateAllTrustScores(type, id, orgId);
      results.push(...entityResults);
    }

    return results;
  },

  async detectTrustAnomalies(threshold: number = 30) {
    const anomalies = await trustGraphService.detectTrustAnomalies(threshold);
    const insights: TrustInsight[] = [];

    for (const node of anomalies) {
      insights.push({
        type: "RISK",
        message: `Trust anomaly detected for ${node.entityType}:${node.entityId} with score ${node.trustScore}`,
        confidence: 0.95,
        relatedEntities: [{ type: node.entityType, id: node.entityId }],
      });
    }

    return insights;
  },

  async getTrustReport(entityType: string, entityId: string) {
    const scores = await this.calculateAllTrustScores(entityType, entityId);
    const insights = await this.generateTrustInsights(entityType, entityId);
    const relationships = await this.analyzeTrustRelationships(entityType, entityId);

    return {
      scores,
      insights,
      relationships,
      generatedAt: new Date(),
    };
  },

  async updateTrustGraphAfterTransaction(transactionId: string, transactionType: string) {
    const transactionProfile = await transactionTrustScoreService.calculateTrustScore(transactionId, transactionType);

    await trustGraphService.updateNodeScore("TRANSACTION", transactionId, transactionProfile.overallScore);

    return {
      transactionId,
      overallScore: transactionProfile.overallScore,
      graphUpdated: true,
    };
  },

  async getSystemTrustOverview() {
    const stats = await trustGraphService.getGraphStatistics();
    const anomalies = await this.detectTrustAnomalies(30);

    return {
      statistics: stats,
      anomalyCount: anomalies.length,
      systemHealth: stats.averageTrustScore >= 70 ? "HEALTHY" : stats.averageTrustScore >= 50 ? "MODERATE" : "AT_RISK",
      lastUpdated: new Date(),
    };
  },

  async recommendTrustImprovements(entityType: string, entityId: string) {
    const insights = await this.generateTrustInsights(entityType, entityId);
    const recommendations: string[] = [];

    for (const insight of insights) {
      if (insight.type === "RISK" || insight.type === "WARNING") {
        recommendations.push(insight.message);
      }
    }

    if (recommendations.length === 0) {
      recommendations.push("Trust score is healthy. Continue current practices.");
    }

    return {
      recommendations,
      priority: recommendations.length > 2 ? "HIGH" : recommendations.length > 0 ? "MEDIUM" : "LOW",
      generatedAt: new Date(),
    };
  },
};
