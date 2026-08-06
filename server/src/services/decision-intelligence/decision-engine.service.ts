/**
 * Decision Intelligence Engine Service
 * 
 * The top-level decision-making layer that sits on top of Trust, Analytics, and AI.
 * Implements the pipeline: Data → Analytics → AI Prediction → Decision → Automatic Action
 * 
 * Provides automatic recommendations for:
 * - Tenant trust level decisions (deposit amount, payment method, owner alerts)
 * - Property risk assessment
 * - Price recommendations
 * - Maintenance prioritization
 * - Investment opportunities
 */

import { prisma } from "../../lib/prisma";
import { tenantTrustScoreService } from "../trust/tenant-trust-score.service";
import { landlordTrustScoreService } from "../trust/landlord-trust-score.service";
import { agentReputationService } from "../trust/agent-reputation.service";
import { propertyTrustScoreService } from "../trust/property-trust-score.service";
import { transactionTrustScoreService } from "../trust/transaction-trust-score.service";
import { predictionService, PredictionModel, PredictionHorizon } from "../data-intelligence/prediction.service";

export enum DecisionType {
  TENANT_TRUST_DECISION = "TENANT_TRUST_DECISION",
  PROPERTY_RISK_DECISION = "PROPERTY_RISK_DECISION",
  PRICE_RECOMMENDATION = "PRICE_RECOMMENDATION",
  MAINTENANCE_PRIORITY = "MAINTENANCE_PRIORITY",
  INVESTMENT_OPPORTUNITY = "INVESTMENT_OPPORTUNITY",
  PAYMENT_METHOD_DECISION = "PAYMENT_METHOD_DECISION",
  DEPOSIT_RECOMMENDATION = "DEPOSIT_RECOMMENDATION",
}

export enum DecisionAction {
  APPROVE = "APPROVE",
  REJECT = "REJECT",
  REQUIRE_ADDITIONAL_VERIFICATION = "REQUIRE_ADDITIONAL_VERIFICATION",
  INCREASE_DEPOSIT = "INCREASE_DEPOSIT",
  ADJUST_PRICE = "ADJUST_PRICE",
  SCHEDULE_MAINTENANCE = "SCHEDULE_MAINTENANCE",
  ALERT_OWNER = "ALERT_OWNER",
  ALERT_AGENT = "ALERT_AGENT",
  MONITOR = "MONITOR",
}

export interface Decision {
  id: string;
  type: DecisionType;
  entityType: string;
  entityId: string;
  recommendedAction: DecisionAction;
  confidence: number; // 0-1
  reasoning: string;
  factors: { factor: string; impact: number }[];
  suggestedValue?: number;
  metadata?: any;
  createdAt: Date;
}

export class DecisionEngineService {
  /**
   * Make tenant trust decision
   * Determines deposit amount, payment method, and alerts based on tenant trust score
   */
  async makeTenantTrustDecision(tenantId: string): Promise<Decision> {
    const trustProfile = await tenantTrustScoreService.calculateTrustScore(tenantId);
    const trustScore = trustProfile.overallScore;
    const paymentScore = trustProfile.paymentScore;
    const behaviorScore = trustProfile.behaviorScore;

    let recommendedAction: DecisionAction;
    let suggestedValue: number | undefined;
    let reasoning: string;
    const factors: { factor: string; impact: number }[] = [];

    // Decision logic
    if (trustScore >= 80) {
      recommendedAction = DecisionAction.APPROVE;
      suggestedValue = 1; // 1 month deposit
      reasoning = "High trust tenant. Standard deposit and payment terms.";
      factors.push({ factor: "Trust Score", impact: 0.8 });
    } else if (trustScore >= 60) {
      recommendedAction = DecisionAction.APPROVE;
      suggestedValue = 2; // 2 month deposit
      reasoning = "Moderate trust tenant. Increased deposit recommended.";
      factors.push({ factor: "Trust Score", impact: 0.6 });
    } else if (trustScore >= 40) {
      recommendedAction = DecisionAction.INCREASE_DEPOSIT;
      suggestedValue = 3; // 3 month deposit
      reasoning = "Low trust tenant. High deposit and additional verification required.";
      factors.push({ factor: "Trust Score", impact: -0.4 });
      factors.push({ factor: "Payment Score", impact: paymentScore / 100 });
    } else {
      recommendedAction = DecisionAction.REJECT;
      reasoning = "Very low trust tenant. Reject or require manual review.";
      factors.push({ factor: "Trust Score", impact: -0.8 });
    }

    // Additional factors
    factors.push({ factor: "Payment Score", impact: (paymentScore - 50) / 100 });
    factors.push({ factor: "Behavior Score", impact: (behaviorScore - 50) / 100 });

    const confidence = 0.7 + (trustScore / 100) * 0.2;

    return {
      id: `decision-${Date.now()}`,
      type: DecisionType.TENANT_TRUST_DECISION,
      entityType: "TENANT",
      entityId: tenantId,
      recommendedAction,
      confidence,
      reasoning,
      factors,
      suggestedValue,
      metadata: { trustScore, paymentScore, behaviorScore },
      createdAt: new Date(),
    };
  }

  /**
   * Make property risk decision
   * Assesses property risk and recommends actions
   */
  async makePropertyRiskDecision(propertyId: string): Promise<Decision> {
    const trustProfile = await propertyTrustScoreService.calculateTrustScore(propertyId);
    const trustScore = trustProfile.overallScore;
    const conditionScore = trustProfile.conditionScore;
    const locationScore = trustProfile.locationScore;

    let recommendedAction: DecisionAction;
    let reasoning: string;
    const factors: { factor: string; impact: number }[] = [];

    if (trustScore >= 75) {
      recommendedAction = DecisionAction.APPROVE;
      reasoning = "Low risk property. Suitable for standard listing.";
      factors.push({ factor: "Trust Score", impact: 0.75 });
    } else if (trustScore >= 50) {
      recommendedAction = DecisionAction.MONITOR;
      reasoning = "Moderate risk property. Monitor performance and condition.";
      factors.push({ factor: "Trust Score", impact: 0.5 });
    } else {
      recommendedAction = DecisionAction.SCHEDULE_MAINTENANCE;
      reasoning = "High risk property. Schedule maintenance and inspection.";
      factors.push({ factor: "Trust Score", impact: -0.5 });
    }

    factors.push({ factor: "Condition Score", impact: (conditionScore - 50) / 100 });
    factors.push({ factor: "Location Score", impact: (locationScore - 50) / 100 });

    const confidence = 0.65 + (trustScore / 100) * 0.25;

    return {
      id: `decision-${Date.now()}`,
      type: DecisionType.PROPERTY_RISK_DECISION,
      entityType: "PROPERTY",
      entityId: propertyId,
      recommendedAction,
      confidence,
      reasoning,
      factors,
      metadata: { trustScore, conditionScore, locationScore },
      createdAt: new Date(),
    };
  }

  /**
   * Make price recommendation
   * Uses AI prediction to recommend optimal price
   */
  async makePriceRecommendation(propertyId: string): Promise<Decision> {
    const prediction = await predictionService.predictPropertyValuation(
      propertyId,
      PredictionHorizon.MEDIUM_TERM
    );

    const property = await prisma.property.findUnique({
      where: { id: propertyId },
    });

    const currentPrice = property?.aiOpportunityScore || 50;
    const predictedPrice = prediction.predictedValue;
    const priceDiff = ((predictedPrice - currentPrice) / currentPrice) * 100;

    let recommendedAction: DecisionAction;
    let suggestedValue: number;
    let reasoning: string;
    const factors: { factor: string; impact: number }[] = [];

    factors.push({ factor: "AI Prediction", impact: prediction.confidence - 0.5 });
    factors.push({ factor: "Price Difference", impact: priceDiff / 100 });

    if (priceDiff > 10) {
      recommendedAction = DecisionAction.ADJUST_PRICE;
      suggestedValue = predictedPrice;
      reasoning = `Price ${priceDiff.toFixed(1)}% below optimal. Recommend increase to ${predictedPrice}.`;
    } else if (priceDiff < -10) {
      recommendedAction = DecisionAction.ADJUST_PRICE;
      suggestedValue = predictedPrice;
      reasoning = `Price ${Math.abs(priceDiff).toFixed(1)}% above optimal. Recommend decrease to ${predictedPrice}.`;
    } else {
      recommendedAction = DecisionAction.APPROVE;
      suggestedValue = currentPrice;
      reasoning = "Price within optimal range.";
    }

    const confidence = prediction.confidence;

    return {
      id: `decision-${Date.now()}`,
      type: DecisionType.PRICE_RECOMMENDATION,
      entityType: "PROPERTY",
      entityId: propertyId,
      recommendedAction,
      confidence,
      reasoning,
      factors,
      suggestedValue,
      metadata: { currentPrice, predictedPrice, priceDiff },
      createdAt: new Date(),
    };
  }

  /**
   * Make maintenance priority decision
   * Prioritizes maintenance based on property condition and tenant impact
   */
  async makeMaintenancePriorityDecision(propertyId: string): Promise<Decision> {
    const trustProfile = await propertyTrustScoreService.calculateTrustScore(propertyId);
    const conditionScore = trustProfile.conditionScore;
    const locationScore = trustProfile.locationScore;

    let recommendedAction: DecisionAction;
    let reasoning: string;
    const factors: { factor: string; impact: number }[] = [];

    factors.push({ factor: "Condition Score", impact: (50 - conditionScore) / 100 });
    factors.push({ factor: "Location Score", impact: (50 - locationScore) / 100 });

    if (conditionScore < 40) {
      recommendedAction = DecisionAction.SCHEDULE_MAINTENANCE;
      reasoning = "Critical condition issues. Immediate maintenance required.";
    } else if (conditionScore < 60) {
      recommendedAction = DecisionAction.SCHEDULE_MAINTENANCE;
      reasoning = "Below average condition. Schedule maintenance soon.";
    } else if (conditionScore < 75) {
      recommendedAction = DecisionAction.MONITOR;
      reasoning = "Acceptable condition. Monitor for deterioration.";
    } else {
      recommendedAction = DecisionAction.APPROVE;
      reasoning = "Good condition. No immediate maintenance needed.";
    }

    const confidence = 0.7 + ((100 - conditionScore) / 100) * 0.2;

    return {
      id: `decision-${Date.now()}`,
      type: DecisionType.MAINTENANCE_PRIORITY,
      entityType: "PROPERTY",
      entityId: propertyId,
      recommendedAction,
      confidence,
      reasoning,
      factors,
      metadata: { conditionScore, locationScore },
      createdAt: new Date(),
    };
  }

  /**
   * Make investment opportunity decision
   * Combines trust, prediction, and market analysis
   */
  async makeInvestmentOpportunityDecision(propertyId: string): Promise<Decision> {
    const trustProfile = await propertyTrustScoreService.calculateTrustScore(propertyId);
    const prediction = await predictionService.predictPropertyValuation(
      propertyId,
      PredictionHorizon.LONG_TERM
    );

    const trustScore = trustProfile.overallScore;
    const predictedValue = prediction.predictedValue;
    const confidence = prediction.confidence;

    let recommendedAction: DecisionAction;
    let reasoning: string;
    const factors: { factor: string; impact: number }[] = [];

    factors.push({ factor: "Trust Score", impact: (trustScore - 50) / 100 });
    factors.push({ factor: "Predicted Value", impact: (predictedValue - 50) / 100 });
    factors.push({ factor: "Prediction Confidence", impact: confidence - 0.5 });

    if (trustScore >= 70 && predictedValue >= 70 && confidence >= 0.8) {
      recommendedAction = DecisionAction.APPROVE;
      reasoning = "High confidence investment opportunity with strong fundamentals.";
    } else if (trustScore >= 50 && predictedValue >= 60 && confidence >= 0.6) {
      recommendedAction = DecisionAction.MONITOR;
      reasoning = "Moderate investment opportunity. Monitor market conditions.";
    } else {
      recommendedAction = DecisionAction.REJECT;
      reasoning = "Low confidence or poor fundamentals. Not recommended.";
    }

    const finalConfidence = (trustScore + predictedValue) / 200 * confidence;

    return {
      id: `decision-${Date.now()}`,
      type: DecisionType.INVESTMENT_OPPORTUNITY,
      entityType: "PROPERTY",
      entityId: propertyId,
      recommendedAction,
      confidence: finalConfidence,
      reasoning,
      factors,
      metadata: { trustScore, predictedValue, confidence },
      createdAt: new Date(),
    };
  }

  /**
   * Make payment method decision
   * Recommends payment method based on trust profile
   */
  async makePaymentMethodDecision(tenantId: string): Promise<Decision> {
    const trustProfile = await tenantTrustScoreService.calculateTrustScore(tenantId);
    const trustScore = trustProfile.overallScore;
    const paymentScore = trustProfile.paymentScore;

    let recommendedAction: DecisionAction;
    let reasoning: string;
    const factors: { factor: string; impact: number }[] = [];

    factors.push({ factor: "Trust Score", impact: (trustScore - 50) / 100 });
    factors.push({ factor: "Payment Score", impact: (paymentScore - 50) / 100 });

    if (trustScore >= 75 && paymentScore >= 75) {
      recommendedAction = DecisionAction.APPROVE;
      reasoning = "High trust tenant. All payment methods available.";
    } else if (trustScore >= 50 && paymentScore >= 50) {
      recommendedAction = DecisionAction.REQUIRE_ADDITIONAL_VERIFICATION;
      reasoning = "Moderate trust. Require additional verification for certain payment methods.";
    } else {
      recommendedAction = DecisionAction.ALERT_OWNER;
      reasoning = "Low trust tenant. Alert owner and restrict payment methods.";
    }

    const confidence = 0.6 + (paymentScore / 100) * 0.3;

    return {
      id: `decision-${Date.now()}`,
      type: DecisionType.PAYMENT_METHOD_DECISION,
      entityType: "TENANT",
      entityId: tenantId,
      recommendedAction,
      confidence,
      reasoning,
      factors,
      metadata: { trustScore, paymentScore },
      createdAt: new Date(),
    };
  }

  /**
   * Make deposit recommendation
   * Calculates optimal deposit amount based on risk
   */
  async makeDepositRecommendation(tenantId: string, propertyId: string): Promise<Decision> {
    const tenantDecision = await this.makeTenantTrustDecision(tenantId);
    const propertyDecision = await this.makePropertyRiskDecision(propertyId);

    const tenantTrustScore = tenantDecision.metadata?.trustScore || 50;
    const propertyTrustScore = propertyDecision.metadata?.trustScore || 50;

    const combinedRisk = 1 - ((tenantTrustScore + propertyTrustScore) / 200);
    let suggestedValue: number;
    let recommendedAction: DecisionAction;
    let reasoning: string;

    if (combinedRisk < 0.2) {
      suggestedValue = 1;
      recommendedAction = DecisionAction.APPROVE;
      reasoning = "Low risk combination. 1 month deposit sufficient.";
    } else if (combinedRisk < 0.4) {
      suggestedValue = 2;
      recommendedAction = DecisionAction.APPROVE;
      reasoning = "Moderate risk. 2 month deposit recommended.";
    } else if (combinedRisk < 0.6) {
      suggestedValue = 3;
      recommendedAction = DecisionAction.INCREASE_DEPOSIT;
      reasoning = "High risk. 3 month deposit required.";
    } else {
      suggestedValue = 4;
      recommendedAction = DecisionAction.REJECT;
      reasoning = "Very high risk. 4+ month deposit or reject.";
    }

    const confidence = 0.7 + (1 - combinedRisk) * 0.2;

    return {
      id: `decision-${Date.now()}`,
      type: DecisionType.DEPOSIT_RECOMMENDATION,
      entityType: "TRANSACTION",
      entityId: `${tenantId}-${propertyId}`,
      recommendedAction,
      confidence,
      reasoning,
      factors: [
        { factor: "Tenant Trust", impact: (tenantTrustScore - 50) / 100 },
        { factor: "Property Trust", impact: (propertyTrustScore - 50) / 100 },
      ],
      suggestedValue,
      metadata: { tenantTrustScore, propertyTrustScore, combinedRisk },
      createdAt: new Date(),
    };
  }

  /**
   * Execute automatic action based on decision
   */
  async executeDecision(decision: Decision): Promise<boolean> {
    // In production, this would trigger actual actions:
    // - Send alerts
    // - Update database
    // - Trigger workflows
    // - Send notifications

    console.log(`[DecisionEngine] Executing decision: ${decision.recommendedAction} for ${decision.entityType}:${decision.entityId}`);
    console.log(`[DecisionEngine] Reasoning: ${decision.reasoning}`);

    // Store decision in database for audit trail
    // await prisma.decision.create({ data: decision });

    return true;
  }

  /**
   * Get decision summary for an entity
   */
  async getDecisionSummary(entityType: string, entityId: string): Promise<any> {
    const decisions: Decision[] = [];

    try {
      if (entityType === "TENANT") {
        decisions.push(await this.makeTenantTrustDecision(entityId));
        decisions.push(await this.makePaymentMethodDecision(entityId));
      } else if (entityType === "PROPERTY") {
        decisions.push(await this.makePropertyRiskDecision(entityId));
        decisions.push(await this.makePriceRecommendation(entityId));
        decisions.push(await this.makeMaintenancePriorityDecision(entityId));
        decisions.push(await this.makeInvestmentOpportunityDecision(entityId));
      }
    } catch (error) {
      console.error(`Failed to generate decisions for ${entityType}:${entityId}:`, error);
    }

    const avgConfidence = decisions.length > 0
      ? decisions.reduce((sum, d) => sum + d.confidence, 0) / decisions.length
      : 0;

    const actionCounts = decisions.reduce((acc, d) => {
      acc[d.recommendedAction] = (acc[d.recommendedAction] || 0) + 1;
      return acc;
    }, {} as Record<string, number>);

    return {
      entityType,
      entityId,
      totalDecisions: decisions.length,
      avgConfidence: Math.round(avgConfidence * 100) / 100,
      actionCounts,
      decisions,
    };
  }
}

export const decisionEngineService = new DecisionEngineService();
