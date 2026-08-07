/**
 * REOS v5 — Decision OS: Decision Pipeline Engine
 *
 * The pipeline executes in strict order:
 *
 *   1. Knowledge Enrichment  → Pull graph data (neighborhood, demand, trends)
 *   2. AI Signal Collection  → Gather predictions from AI agents
 *   3. Policy Constraint Check → What is allowed by Policy OS?
 *   4. Action Scoring        → Score each candidate action
 *   5. Decision Selection    → Pick highest-scoring allowed action
 *   6. Decision Emission     → Publish DecisionGenerated event
 *
 * User overrides are first-class citizens:
 *   - DecisionOverridden event is emitted to the event bus
 *   - Knowledge OS learns from it (feedback loop)
 */

import {
  type DecisionContext,
  type Decision,
  type DecisionReasoning,
  type BlockedAction,
  type RecommendedAction,
  type AISignal,
  type DecisionOverride,
} from './decision-types';
import { eventBus } from '../events/event-bus';
import { CognitiveEvents } from '../domain/events/event-catalog';
import { PolicyOSClient } from '../policy/policy-os.client';

// Action → Saga mapping (Workflow OS integration)
const ACTION_TO_SAGA: Partial<Record<RecommendedAction, string>> = {
  CORPORATE_MASTER_LEASE:  'CorporateLeaseSaga',
  LONG_TERM_RENT:          'LongTermRentalSaga',
  SHORT_TERM_RENT:         'ShortTermBookingSaga',
  SELL:                    'PropertySaleSaga',
  FRACTIONAL_INVESTMENT:   'FractionalInvestmentSaga',
  AUCTION:                 'AuctionSaga',
  INSTALLMENT_SALE:        'InstallmentSaleSaga',
  OFF_MARKET_DEAL:         'OffMarketDealSaga',
};

// Action → Partner agents mapping
const ACTION_TO_AGENTS: Partial<Record<RecommendedAction, string[]>> = {
  CORPORATE_MASTER_LEASE: ['KW Partner Network', 'Corporate Relocation Desk'],
  FRACTIONAL_INVESTMENT:  ['Investor Network', 'Fund Partners'],
  OFF_MARKET_DEAL:        ['Off-Market Brokers', 'HNWI Network'],
  AUCTION:                ['Auction Partners', 'Legal OS'],
};

// ─── Decision Pipeline ────────────────────────────────────────────────────────

export class DecisionPipeline {
  /**
   * Run the full decision pipeline for the given context.
   * Returns a Decision with recommended action, confidence, reasoning, and saga trigger.
   */
  async run(ctx: DecisionContext): Promise<Decision> {
    console.log(`\n[DecisionOS] 🧠 Running pipeline for property: ${ctx.propertyId ?? ctx.requestId}`);

    // Step 3 — Policy constraints (always evaluated first to build blocklist)
    const blockedActions = await this.evaluatePolicyConstraints(ctx);
    const blockedSet = new Set(blockedActions.map(b => b.action));

    // Step 4 — Score every candidate action
    const scores = this.scoreActions(ctx, blockedSet);

    // Step 5 — Select best allowed action
    const sorted = scores
      .filter(s => !blockedSet.has(s.action))
      .sort((a, b) => b.score - a.score);

    if (sorted.length === 0) {
      throw new Error('[DecisionOS] All actions are blocked by policy constraints.');
    }

    const best = sorted[0];
    const confidence = parseFloat(best.score.toFixed(2));

    // Build reasoning chain
    const reasoning: DecisionReasoning[] = [
      ...this.buildKnowledgeReasoning(ctx),
      ...this.buildAIReasoning(ctx.aiSignals, best.action),
      {
        source: 'BUSINESS_OBJECTIVE',
        signal: `Objective: ${ctx.objective}`,
        weight: 0.15,
      },
    ];

    const decision: Decision = {
      requestId: ctx.requestId,
      recommendedAction: best.action,
      confidence,
      reasoning,
      blockedActions,
      suggestedSaga: ACTION_TO_SAGA[best.action],
      suggestedAgents: ACTION_TO_AGENTS[best.action],
      generatedAt: new Date().toISOString(),
      overridable: true, // Always overridable — user is in control
    };

    // Step 6 — Publish cognitive event
    eventBus.publish(
      CognitiveEvents.DECISION_GENERATED,
      {
        requestId: ctx.requestId,
        propertyId: ctx.propertyId,
        action: decision.recommendedAction,
        confidence: decision.confidence,
        suggestedSaga: decision.suggestedSaga,
      },
      'DecisionPipeline',
    );

    console.log(`[DecisionOS] ✅ Decision: ${decision.recommendedAction} (${(confidence * 100).toFixed(0)}% confidence)`);
    return decision;
  }

  /**
   * Process a user override. The user disagrees with the AI recommendation.
   * This feeds back into the Knowledge OS learning loop.
   */
  applyOverride(override: DecisionOverride): void {
    console.log(
      `[DecisionOS] ⚠️  Override by actor ${override.actorId}: ` +
      `${override.originalDecision} → ${override.overrideAction} | Reason: ${override.reason}`
    );

    // Emit override event → Knowledge OS will subscribe and update graph
    eventBus.publish(
      CognitiveEvents.RECOMMENDATION_REJECTED,
      {
        requestId: override.requestId,
        originalAction: override.originalDecision,
        overrideAction: override.overrideAction,
        reason: override.reason,
        actorId: override.actorId,
        overriddenAt: override.overriddenAt,
      },
      'DecisionPipeline',
    );

    // Emit knowledge update (Learning Loop entry point)
    eventBus.publish(
      CognitiveEvents.KNOWLEDGE_UPDATED,
      {
        source: 'user_override',
        propertyId: override.requestId,
        learnedPreference: override.overrideAction,
        rejectedRecommendation: override.originalDecision,
      },
      'DecisionPipeline',
    );
  }

  // ─── Private: Policy Constraints ─────────────────────────────────────────

  private async evaluatePolicyConstraints(ctx: DecisionContext): Promise<BlockedAction[]> {
    const blocked: BlockedAction[] = [];

    // Use the Policy OS JSON Logic engine
    const isAllowed = await PolicyOSClient.isPublishingAllowed({
      countryCode: ctx.countryCode,
      userId: ctx.actorId,
      propertyType: ctx.propertyType,
    });

    if (!isAllowed) {
      blocked.push({
        action: 'SHORT_TERM_RENT',
        reason: 'KYC verification required in this region before publishing.',
        ruleId: 'comp-de',
      });
    }

    // Layer on explicit policy constraints from context
    for (const constraint of ctx.policyConstraints) {
      if (!constraint.allows && constraint.restrictedActions) {
        for (const action of constraint.restrictedActions) {
          if (!blocked.find(b => b.action === action)) {
            blocked.push({
              action,
              reason: constraint.reason ?? constraint.ruleName,
              ruleId: constraint.ruleId,
            });
          }
        }
      }
    }

    if (blocked.length > 0) {
      eventBus.publish(CognitiveEvents.POLICY_EVALUATED, {
        requestId: ctx.requestId,
        blockedActions: blocked.map(b => b.action),
      }, 'DecisionPipeline');
    }

    return blocked;
  }

  // ─── Private: Action Scoring ─────────────────────────────────────────────

  private scoreActions(
    ctx: DecisionContext,
    blocked: Set<RecommendedAction>,
  ): Array<{ action: RecommendedAction; score: number }> {
    const k = ctx.knowledge;
    const objective = ctx.objective;

    const candidates: RecommendedAction[] = [
      'SELL', 'LONG_TERM_RENT', 'SHORT_TERM_RENT',
      'CORPORATE_MASTER_LEASE', 'FRACTIONAL_INVESTMENT',
      'AUCTION', 'HOLD', 'OFF_MARKET_DEAL', 'INSTALLMENT_SALE',
    ];

    return candidates.map(action => {
      let score = 0.1; // base

      // Knowledge signals
      if (action === 'SHORT_TERM_RENT' && k.touristDemandPresent) score += 0.3;
      if (action === 'CORPORATE_MASTER_LEASE' && k.corporateDemandPresent) score += 0.35;
      if (action === 'FRACTIONAL_INVESTMENT' && k.investorInterestLevel === 'HIGH') score += 0.30;
      if (action === 'LONG_TERM_RENT' && k.neighborhoodDemandScore > 70) score += 0.25;
      if (action === 'SELL' && k.marketTrend === 'RISING') score += 0.20;
      if (action === 'HOLD' && k.marketTrend === 'FALLING') score += 0.15;
      if (action === 'AUCTION' && k.marketTrend === 'FALLING') score += 0.10;

      // Rental yield boost
      if (['LONG_TERM_RENT', 'CORPORATE_MASTER_LEASE', 'SHORT_TERM_RENT'].includes(action)) {
        score += (k.avgRentalYield ?? 0) * 2; // e.g. 12% yield → +0.24
      }

      // AI signal boost (AI agents that recommend this action)
      for (const signal of ctx.aiSignals) {
        if (signal.recommendation === action) {
          score += signal.confidence * 0.25;
        }
      }

      // Objective modifier
      if (objective === 'MAXIMIZE_REVENUE') {
        if (['CORPORATE_MASTER_LEASE', 'SHORT_TERM_RENT', 'FRACTIONAL_INVESTMENT'].includes(action)) score += 0.10;
      }
      if (objective === 'MINIMIZE_RISK') {
        if (['LONG_TERM_RENT', 'CORPORATE_MASTER_LEASE', 'HOLD'].includes(action)) score += 0.10;
        if (['SHORT_TERM_RENT', 'AUCTION'].includes(action)) score -= 0.05;
      }
      if (objective === 'FASTEST_TRANSACTION') {
        if (['SELL', 'AUCTION', 'OFF_MARKET_DEAL'].includes(action)) score += 0.10;
      }

      // Blocked actions get 0
      if (blocked.has(action)) score = 0;

      return { action, score: Math.min(score, 1) };
    });
  }

  // ─── Private: Reasoning builders ─────────────────────────────────────────

  private buildKnowledgeReasoning(ctx: DecisionContext): DecisionReasoning[] {
    const k = ctx.knowledge;
    const reasons: DecisionReasoning[] = [];

    if (k.corporateDemandPresent) {
      reasons.push({ source: 'KNOWLEDGE_OS', signal: 'Corporate tenant demand detected in neighborhood', weight: 0.35 });
    }
    if (k.touristDemandPresent) {
      reasons.push({ source: 'KNOWLEDGE_OS', signal: 'Tourist demand present — short-stay viable', weight: 0.25 });
    }
    if (k.investorInterestLevel === 'HIGH') {
      reasons.push({ source: 'KNOWLEDGE_OS', signal: 'High investor interest — fractional or investment sale viable', weight: 0.30 });
    }
    if (k.avgRentalYield) {
      reasons.push({ source: 'KNOWLEDGE_OS', signal: `Avg rental yield: ${(k.avgRentalYield * 100).toFixed(1)}%`, weight: k.avgRentalYield });
    }
    reasons.push({ source: 'KNOWLEDGE_OS', signal: `Market trend: ${k.marketTrend}`, weight: 0.15 });

    return reasons;
  }

  private buildAIReasoning(signals: AISignal[], chosen: RecommendedAction): DecisionReasoning[] {
    return signals
      .filter(s => s.recommendation === chosen)
      .map(s => ({
        source: 'AI_OS' as const,
        signal: `${s.agentId}: ${s.signal} (confidence: ${(s.confidence * 100).toFixed(0)}%)`,
        weight: s.confidence * 0.25,
      }));
  }
}

// Singleton
export const decisionPipeline = new DecisionPipeline();
