/**
 * REOS v5 — Decision OS: Core Types
 *
 * The Decision OS is the central intelligence layer that combines:
 *   AI OS       → What is possible? (prediction)
 *   Knowledge OS → What is the context? (graph data)
 *   Policy OS   → What is allowed? (rules)
 *   Decision OS → What is the optimal action? (decision)
 *
 * No hardcoded if/else. Every decision is data-driven, auditable,
 * and overridable by the user.
 */

// --- Input Context ---

export interface DecisionContext {
  // Identity
  requestId: string;
  tenantId: string;
  actorId?: string;       // User/agent making the request

  // Property context
  propertyId?: string;
  propertyType?: 'RESIDENTIAL' | 'LUXURY' | 'COMMERCIAL' | 'LAND' | 'INVEST';
  currentUsage?: 'SHORT_STAY' | 'LONG_RENT' | 'SALE' | 'VACANT';

  // Market context (from Knowledge OS / Graph)
  knowledge: KnowledgeContext;

  // AI predictions (from AI OS)
  aiSignals: AISignal[];

  // Policy constraints (from Policy OS)
  policyConstraints: PolicyConstraint[];

  // Business objective
  objective: 'MAXIMIZE_REVENUE' | 'MINIMIZE_RISK' | 'FASTEST_TRANSACTION' | 'OWNER_PREFERENCE';

  // Locale
  countryCode: string;
  currency?: string;
}

export interface KnowledgeContext {
  neighborhoodDemandScore: number;    // 0–100
  marketTrend: 'RISING' | 'STABLE' | 'FALLING';
  corporateDemandPresent: boolean;
  touristDemandPresent: boolean;
  investorInterestLevel: 'LOW' | 'MEDIUM' | 'HIGH';
  avgRentalYield?: number;            // e.g. 0.12 = 12%
  priceHistory?: Array<{ date: string; price: number }>;
}

export interface AISignal {
  agentId: string;        // e.g. 'PricingAgent', 'MarketingAgent', 'RiskAgent'
  signal: string;         // Human-readable finding
  recommendation: RecommendedAction;
  confidence: number;     // 0–1
}

export interface PolicyConstraint {
  ruleId: string;
  ruleName: string;
  allows: boolean;
  restrictedActions?: RecommendedAction[];
  reason?: string;
}

// --- Actions ---

export type RecommendedAction =
  | 'SELL'
  | 'LONG_TERM_RENT'
  | 'SHORT_TERM_RENT'
  | 'CORPORATE_MASTER_LEASE'
  | 'FRACTIONAL_INVESTMENT'
  | 'AUCTION'
  | 'HOLD'
  | 'REDEVELOP'
  | 'OFF_MARKET_DEAL'
  | 'INSTALLMENT_SALE';

// --- Decision Output ---

export interface Decision {
  requestId: string;
  recommendedAction: RecommendedAction;
  confidence: number;                 // 0–1, aggregated from AI signals + policy weight
  reasoning: DecisionReasoning[];
  blockedActions: BlockedAction[];
  suggestedSaga?: string;             // e.g. 'CorporateLeaseSaga', 'AuctionSaga'
  suggestedAgents?: string[];         // e.g. ['KW Partner Network', 'Investor Network']
  generatedAt: string;
  overridable: boolean;
}

export interface DecisionReasoning {
  source: 'AI_OS' | 'KNOWLEDGE_OS' | 'POLICY_OS' | 'BUSINESS_OBJECTIVE';
  signal: string;
  weight: number;                     // How much this influenced the decision (0–1)
}

export interface BlockedAction {
  action: RecommendedAction;
  reason: string;
  ruleId?: string;
}

// --- User Override ---

export interface DecisionOverride {
  requestId: string;
  originalDecision: RecommendedAction;
  overrideAction: RecommendedAction;
  reason: string;
  actorId: string;
  overriddenAt: string;
}
