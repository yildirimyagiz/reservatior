/**
 * REOS v5 — AI OS: Agent Runtime
 *
 * Concrete AI agent implementations for Decision OS input signals.
 * Each agent calls the AIModelRouter and returns a typed AISignal.
 *
 * Agents:
 *   PricingAgent     → ROI, yield, market positioning
 *   RiskAgent        → Vacancy risk, tenant quality, legal exposure
 *   MarketingAgent   → Demand analysis, content recommendation
 *   ComplianceAgent  → Policy flags, regulatory red flags
 *   InvestorAgent    → Fractional, ROI packaging, investor fit
 */

import { aiRouter } from './ai-model-router';
import type { ModelProvider } from './ai-model-router';
import type { AISignal, RecommendedAction } from '../decision/decision-types';
import { eventBus } from '../events/event-bus';
import { CognitiveEvents } from '../domain/events/event-catalog';

export interface AgentInput {
  propertyId: string;
  propertyType: string;
  countryCode: string;
  marketData: {
    avgRentalYield: number;
    neighborhoodDemandScore: number;
    marketTrend: string;
    corporateDemandPresent: boolean;
    touristDemandPresent: boolean;
    investorInterestLevel: string;
  };
  currentUsage?: string;
  listingTitle?: string;
  provider?: ModelProvider;
}

const AGENT_OUTPUT_SCHEMA = `{
  "recommendation": "<one of: SELL | LONG_TERM_RENT | SHORT_TERM_RENT | CORPORATE_MASTER_LEASE | FRACTIONAL_INVESTMENT | AUCTION | HOLD | OFF_MARKET_DEAL | INSTALLMENT_SALE>",
  "confidence": <number 0.0-1.0>,
  "signal": "<1-2 sentence analysis>"
}`;

// ─── Base Agent ───────────────────────────────────────────────────────────────

abstract class BaseAgent {
  abstract readonly agentId: string;
  abstract readonly systemPrompt: string;

  async run(input: AgentInput): Promise<AISignal> {
    const userPrompt = this.buildUserPrompt(input);
    const response = await aiRouter.infer({
      systemPrompt: this.systemPrompt,
      userPrompt,
      outputSchema: AGENT_OUTPUT_SCHEMA,
      provider: input.provider ?? 'AUTO',
      temperature: 0.2,
      maxTokens: 512,
    });

    const parsed = response.parsed;
    const signal: AISignal = {
      agentId: this.agentId,
      signal: String(parsed.signal ?? 'No signal'),
      recommendation: (parsed.recommendation ?? 'HOLD') as RecommendedAction,
      confidence: typeof parsed.confidence === 'number' ? parsed.confidence : 0.5,
    };

    console.log(`  [${this.agentId}] via ${response.model} (${response.latencyMs}ms): ${signal.recommendation} @ ${(signal.confidence * 100).toFixed(0)}%`);

    eventBus.publish(CognitiveEvents.PREDICTION_COMPLETED, {
      agentId: this.agentId,
      propertyId: input.propertyId,
      recommendation: signal.recommendation,
      confidence: signal.confidence,
      provider: response.provider,
    }, 'AgentRuntime');

    return signal;
  }

  protected buildUserPrompt(input: AgentInput): string {
    return `
Property Analysis Request:
- Property ID: ${input.propertyId}
- Type: ${input.propertyType}
- Country: ${input.countryCode}
- Current Usage: ${input.currentUsage ?? 'VACANT'}
- Listing: ${input.listingTitle ?? 'N/A'}

Market Data:
- Avg Rental Yield: ${(input.marketData.avgRentalYield * 100).toFixed(1)}%
- Neighborhood Demand Score: ${input.marketData.neighborhoodDemandScore}/100
- Market Trend: ${input.marketData.marketTrend}
- Corporate Demand: ${input.marketData.corporateDemandPresent ? 'YES' : 'NO'}
- Tourist Demand: ${input.marketData.touristDemandPresent ? 'YES' : 'NO'}
- Investor Interest: ${input.marketData.investorInterestLevel}
    `.trim();
  }
}

// ─── Pricing Agent ────────────────────────────────────────────────────────────

export class PricingAgent extends BaseAgent {
  readonly agentId = 'PricingAgent';
  readonly systemPrompt = `You are an expert real estate pricing analyst for REOS, a global PropTech OS.
Your job is to analyze property data and recommend the optimal monetization strategy to MAXIMIZE REVENUE.
Focus on: rental yield, ROI, market positioning, and demand-supply dynamics.
Be concise, data-driven, and avoid vague statements.
Always respond with valid JSON.`;
}

// ─── Risk Agent ───────────────────────────────────────────────────────────────

export class RiskAgent extends BaseAgent {
  readonly agentId = 'RiskAgent';
  readonly systemPrompt = `You are a real estate risk analyst for REOS, a global PropTech OS.
Your job is to assess risk factors (vacancy, legal, tenant quality, market volatility) and recommend strategies that MINIMIZE RISK.
Be conservative, flag regulatory concerns, and avoid recommending high-volatility options without justification.
Always respond with valid JSON.`;
}

// ─── Marketing Agent ──────────────────────────────────────────────────────────

export class MarketingAgent extends BaseAgent {
  readonly agentId = 'MarketingAgent';
  readonly systemPrompt = `You are a real estate marketing strategist for REOS, a global PropTech OS.
Your job is to analyze demand signals and recommend the best positioning strategy to attract buyers, renters, or investors.
Consider: corporate vs. tourist demand, investor appetite, and brand positioning.
Always respond with valid JSON.`;
}

// ─── Compliance Agent ─────────────────────────────────────────────────────────

export class ComplianceAgent extends BaseAgent {
  readonly agentId = 'ComplianceAgent';
  readonly systemPrompt = `You are a real estate compliance officer for REOS, a global PropTech OS.
Your job is to flag legal and regulatory risks for property transactions in different countries.
Focus on: short-term rental laws, foreign ownership restrictions, KYC requirements, tax obligations.
Be conservative and flag any potential compliance issue. Always respond with valid JSON.`;
}

// ─── Investor Agent ───────────────────────────────────────────────────────────

export class InvestorAgent extends BaseAgent {
  readonly agentId = 'InvestorAgent';
  readonly systemPrompt = `You are a real estate investment analyst for REOS, a global PropTech OS.
Your job is to identify investment packaging opportunities (fractional ownership, installment sales, off-market deals).
Focus on: IRR, cap rate, investor appetite, exit strategies.
Always respond with valid JSON.`;
}

// ─── Agent Runtime ────────────────────────────────────────────────────────────

/**
 * AgentRuntime orchestrates all AI agents and returns a set of AISignals
 * to be consumed by the Decision OS pipeline.
 *
 * Agents run in parallel to minimize latency.
 */
export class AgentRuntime {
  private readonly agents: BaseAgent[];

  constructor(agentSelection: ('pricing' | 'risk' | 'marketing' | 'compliance' | 'investor')[] = ['pricing', 'risk', 'marketing']) {
    this.agents = agentSelection.map(a => {
      switch (a) {
        case 'pricing':    return new PricingAgent();
        case 'risk':       return new RiskAgent();
        case 'marketing':  return new MarketingAgent();
        case 'compliance': return new ComplianceAgent();
        case 'investor':   return new InvestorAgent();
      }
    });
  }

  /**
   * Run all configured agents in parallel and collect their signals.
   */
  async gatherSignals(input: AgentInput): Promise<AISignal[]> {
    console.log(`\n[AgentRuntime] Running ${this.agents.length} agents in parallel...`);
    const results = await Promise.allSettled(this.agents.map(a => a.run(input)));

    return results
      .filter((r): r is PromiseFulfilledResult<AISignal> => r.status === 'fulfilled')
      .map(r => r.value);
  }
}

export const agentRuntime = new AgentRuntime(['pricing', 'risk', 'marketing', 'compliance', 'investor']);
