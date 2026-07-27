/**
 * Autonomous Decision Engine
 * Phase 5 — Core Orchestrator
 *
 * Combines:
 *   User Passport (who is asking)
 *   Market Passport (what does the market look like)
 *   Property Passport (what assets are available)
 *   Agent Passport (who can execute)
 *
 * Outputs structured, explainable decisions:
 *   BUY_PROPERTY | INVEST | RENT | WAIT | ALERT | PRICE_ADJUST | MATCH
 */

import { PrismaClient } from '@prisma/client';
import { eventBus } from '../core/events/event-bus';

const prisma = new PrismaClient();

// ─── Decision Types ────────────────────────────────────────────────────────────

export type DecisionType =
  | 'BUY_PROPERTY'
  | 'INVEST_PROPERTY'
  | 'RENT_PROPERTY'
  | 'HOLD_AND_WAIT'
  | 'PRICE_ADJUST'
  | 'AGENT_MATCH'
  | 'PORTFOLIO_REBALANCE'
  | 'MARKET_ENTRY'
  | 'MARKET_EXIT'
  | 'OPPORTUNITY_ALERT';

export type DecisionConfidence = 'VERY_HIGH' | 'HIGH' | 'MEDIUM' | 'LOW';
export type DecisionPriority = 'CRITICAL' | 'HIGH' | 'MEDIUM' | 'LOW';

export interface DecisionContext {
  userId?: string;
  agentId?: string;
  propertyId?: string;
  countryIsoCode?: string;
  citySlug?: string;
  portfolioId?: string;
}

export type DecisionGoal = 'RENTAL_YIELD' | 'CAPITAL_APPRECIATION' | 'DIVERSIFICATION' | 'PORTFOLIO_GROWTH';
export type DecisionTimeline = 'SHORT' | 'MEDIUM' | 'LONG';
export type DecisionRisk = 'LOW' | 'MEDIUM' | 'HIGH';

export interface DecisionConstraints {
  budget?: { min?: number; max?: number; currency?: string };
  timeline?: DecisionTimeline;
  riskTolerance?: DecisionRisk;
  goal?: DecisionGoal;
  preferredPropertyTypes?: string[];
  preferredLocations?: string[];
}

export interface DecisionRequest {
  requestId: string;
  type: 'INVESTMENT_ADVICE' | 'PROPERTY_MATCH' | 'PRICING_STRATEGY' | 'PORTFOLIO_REVIEW' | 'MARKET_ENTRY';
  context: DecisionContext;
  constraints?: DecisionConstraints;
}

export interface DecisionCandidate {
  propertyId?: string;
  score: number;
  expectedYield?: number;
  expectedAppreciation?: number;
  riskLevel: DecisionRisk;
  reasoning: string[];
  agentId?: string;
  agentScore?: number;
}

export interface DecisionOutput {
  requestId: string;
  decisionType: DecisionType;
  confidence: DecisionConfidence;
  priority: DecisionPriority;
  primaryRecommendation: string;
  candidates: DecisionCandidate[];
  explanation: string;
  reasoning: string[];
  alternativeActions: string[];
  expiresAt: Date;
  generatedAt: Date;
  metadata: {
    userPassportVersion?: string;
    marketPassportVersion?: string;
    propertyPassportVersion?: string;
    agentPassportVersion?: string;
    modelsUsed: string[];
  };
}

// ─── Engine Lazy Loaders ───────────────────────────────────────────────────────

async function loadInvestmentEngine() {
  const mod = await import('./investment-decision-engine');
  return new mod.InvestmentDecisionEngine();
}

async function loadMatchingEngine() {
  const mod = await import('./matching-decision-engine');
  return new mod.MatchingDecisionEngine();
}

async function loadPricingEngine() {
  const mod = await import('./pricing-decision-engine');
  return new mod.PricingDecisionEngine();
}

async function loadPortfolioOptimizer() {
  const mod = await import('./portfolio-optimizer');
  return new mod.PortfolioOptimizer();
}

async function loadExplanationEngine() {
  const mod = await import('./decision-explanation-engine');
  return new mod.DecisionExplanationEngine();
}

// ─── Decision Engine ───────────────────────────────────────────────────────────

export class DecisionEngine {
  /**
   * Central decision dispatch — routes to the right engine based on request type
   */
  async decide(request: DecisionRequest): Promise<DecisionOutput> {
    const startTime = Date.now();
    console.log(`[DecisionEngine] Processing: ${request.requestId} type=${request.type}`);

    let output: DecisionOutput;

    switch (request.type) {
      case 'INVESTMENT_ADVICE': {
        const engine = await loadInvestmentEngine();
        output = await engine.decide(request);
        break;
      }
      case 'PROPERTY_MATCH': {
        const engine = await loadMatchingEngine();
        output = await engine.decide(request);
        break;
      }
      case 'PRICING_STRATEGY': {
        const engine = await loadPricingEngine();
        output = await engine.decide(request);
        break;
      }
      case 'PORTFOLIO_REVIEW': {
        const optimizer = await loadPortfolioOptimizer();
        output = await optimizer.decide(request);
        break;
      }
      case 'MARKET_ENTRY': {
        output = await this.decideMarketEntry(request);
        break;
      }
      default:
        throw new Error(`[DecisionEngine] Unknown request type: ${(request as any).type}`);
    }

    // Enrich explanation
    const explanationEngine = await loadExplanationEngine();
    output.explanation = await explanationEngine.explain(output);

    const duration = Date.now() - startTime;
    console.log(`[DecisionEngine] Decision done in ${duration}ms — ${output.decisionType} confidence=${output.confidence}`);

    // Emit decision event
    await eventBus.publish(
      'decision.generated.v1',
      {
        requestId: request.requestId,
        decisionType: output.decisionType,
        confidence: output.confidence,
        userId: request.context.userId,
        propertyId: request.context.propertyId,
        countryIsoCode: request.context.countryIsoCode,
      },
      'decision-engine'
    );

    return output;
  }

  /**
   * Market Entry decision — combines market + user passport data
   */
  private async decideMarketEntry(request: DecisionRequest): Promise<DecisionOutput> {
    const { countryIsoCode, citySlug, userId } = request.context;

    let marketScore = 70;
    let liquidityScore = 70;
    let demandScore = 70;

    if (countryIsoCode) {
      const location = await prisma.location.findFirst({
        where: { country: countryIsoCode }
      });

      if (location) {
        const marketPassport = await (prisma as any).marketIntelligenceProfile?.findFirst({
          where: { locationId: location.id },
          orderBy: { updatedAt: 'desc' }
        }).catch(() => null);

        if (marketPassport) {
          marketScore = marketPassport.overallScore ?? 70;
          liquidityScore = marketPassport.liquidityScore ?? 70;
          demandScore = marketPassport.demandScore ?? 70;
        }
      }
    }

    const entryScore = (marketScore * 0.4 + liquidityScore * 0.3 + demandScore * 0.3);
    const shouldEnter = entryScore >= 65;

    return {
      requestId: request.requestId,
      decisionType: shouldEnter ? 'MARKET_ENTRY' : 'HOLD_AND_WAIT',
      confidence: entryScore >= 80 ? 'HIGH' : entryScore >= 65 ? 'MEDIUM' : 'LOW',
      priority: entryScore >= 80 ? 'HIGH' : 'MEDIUM',
      primaryRecommendation: shouldEnter
        ? `Enter ${citySlug ?? countryIsoCode ?? 'target market'} — score: ${entryScore.toFixed(1)}`
        : `Hold — market not optimal (score: ${entryScore.toFixed(1)})`,
      candidates: [],
      explanation: '',
      reasoning: [
        `Market score: ${marketScore.toFixed(1)}`,
        `Liquidity score: ${liquidityScore.toFixed(1)}`,
        `Demand score: ${demandScore.toFixed(1)}`,
        `Composite entry score: ${entryScore.toFixed(1)}`,
      ],
      alternativeActions: shouldEnter
        ? ['Start with a pilot property', 'Engage local market agent', 'Monitor for 30 days before committing']
        : ['Revisit in 30–60 days', 'Monitor key market triggers', 'Consider adjacent markets'],
      expiresAt: new Date(Date.now() + 7 * 24 * 60 * 60 * 1000),
      generatedAt: new Date(),
      metadata: {
        modelsUsed: ['MarketIntelligenceProfile'],
      },
    };
  }
}

export const decisionEngine = new DecisionEngine();
