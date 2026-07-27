/**
 * Decision Explanation Engine
 * Phase 5 — Human-Readable Explanations for All Decisions
 *
 * Converts raw DecisionOutput into clear, trustworthy natural language
 * that users and agents can understand and act on.
 */

import { DecisionOutput, DecisionType, DecisionConfidence } from './decision-engine';

export class DecisionExplanationEngine {
  /**
   * Generate a full human-readable explanation for a decision output
   */
  async explain(output: DecisionOutput): Promise<string> {
    const parts: string[] = [];

    // Decision type header
    parts.push(this.decisionTypeLabel(output.decisionType));

    // Confidence statement
    parts.push(this.confidenceStatement(output.confidence, output.reasoning.length));

    // Primary recommendation
    parts.push(output.primaryRecommendation);

    // Key reasoning (top 3)
    if (output.reasoning.length > 0) {
      parts.push('\n**Why this recommendation:**');
      output.reasoning.slice(0, 4).forEach((r) => parts.push(`• ${r}`));
    }

    // Candidate summary
    if (output.candidates.length > 0) {
      parts.push(`\n**Top ${output.candidates.length} match(es) identified:**`);
      output.candidates.slice(0, 3).forEach((c, i) => {
        const yieldStr = c.expectedYield != null ? ` | Expected Yield: ${c.expectedYield}%` : '';
        const agentStr = c.agentId ? ` | Agent Score: ${c.agentScore?.toFixed(0) ?? 'N/A'}` : '';
        parts.push(`${i + 1}. Score: ${c.score.toFixed(1)}/100 | Risk: ${c.riskLevel}${yieldStr}${agentStr}`);
      });
    }

    // Alternative actions
    if (output.alternativeActions.length > 0) {
      parts.push('\n**Alternative actions:**');
      output.alternativeActions.slice(0, 3).forEach((a) => parts.push(`→ ${a}`));
    }

    // Expiry note
    const daysUntilExpiry = Math.round((output.expiresAt.getTime() - Date.now()) / (1000 * 60 * 60 * 24));
    if (daysUntilExpiry > 0) {
      parts.push(`\n*This recommendation is valid for ${daysUntilExpiry} day(s). Market conditions may change.*`);
    }

    return parts.join('\n');
  }

  private decisionTypeLabel(type: DecisionType): string {
    const labels: Record<DecisionType, string> = {
      BUY_PROPERTY: '🏠 **Decision: BUY PROPERTY**',
      INVEST_PROPERTY: '📈 **Decision: INVEST IN PROPERTY**',
      RENT_PROPERTY: '🔑 **Decision: RENT PROPERTY**',
      HOLD_AND_WAIT: '⏳ **Decision: HOLD & WAIT**',
      PRICE_ADJUST: '💰 **Decision: PRICE ADJUSTMENT**',
      AGENT_MATCH: '🤝 **Decision: SMART MATCH**',
      PORTFOLIO_REBALANCE: '📊 **Decision: PORTFOLIO REBALANCE**',
      MARKET_ENTRY: '🌍 **Decision: MARKET ENTRY**',
      MARKET_EXIT: '🚪 **Decision: MARKET EXIT**',
      OPPORTUNITY_ALERT: '🚨 **Decision: OPPORTUNITY ALERT**',
    };
    return labels[type] ?? `**Decision: ${type}**`;
  }

  private confidenceStatement(confidence: DecisionConfidence, reasoningCount: number): string {
    const base: Record<DecisionConfidence, string> = {
      VERY_HIGH: 'Very high confidence — supported by comprehensive data across all intelligence layers.',
      HIGH: 'High confidence — based on strong market and property intelligence signals.',
      MEDIUM: 'Medium confidence — some data gaps exist; human review recommended before committing.',
      LOW: 'Low confidence — limited data available. Treat as directional guidance only.',
    };
    return `*Confidence: ${confidence}* — ${base[confidence]}`;
  }
}
