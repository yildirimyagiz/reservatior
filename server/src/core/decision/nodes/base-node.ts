import { BaseDomainEvent } from "@/core/events/catalog";


export interface DecisionNodeResult {
  decision: string;
  reason: string;
  confidence: number;
  revenueImpact?: number;
  outcomeExpected?: string;
  metadata?: any;
}

export abstract class BaseDecisionNode {
  abstract name: string;
  
  /**
   * Evaluates the event and makes a decision if applicable.
   * Returns null if this node decides not to act on the event.
   */
  abstract process(event: BaseDomainEvent): Promise<DecisionNodeResult | null>;
}
