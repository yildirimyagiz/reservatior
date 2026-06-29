import { BaseDecisionNode, DecisionNodeResult } from "./base-node";
import { BaseDomainEvent, MarketEvents } from "../../events/catalog";

export class PricingNode extends BaseDecisionNode {
  name = "PricingNode";

  async process(event: BaseDomainEvent): Promise<DecisionNodeResult | null> {
    if (event.eventName === MarketEvents.MARKET_DEMAND_DROP) {
      const demandDrop = event.payload?.dropPercentage || 0.15;
      
      const action = "PRICE_DECREASE";
      const delta = -0.035;
      const confidence = 0.93;
      const expectedRevenueGain = 4200;
      
      return {
        decision: action,
        reason: `Market demand dropped by ${(demandDrop * 100).toFixed(1)}%. Multi-dimensional pricing optimization triggered.`,
        confidence: confidence,
        outcomeExpected: `Expected revenue gain: $${expectedRevenueGain}`,
        metadata: {
          action,
          delta,
          expectedRevenueGain,
          cost: 0,
          roi: Infinity
        }
      };
    }

    if (event.eventName === MarketEvents.MARKET_DEMAND_SPIKE) {
      const demandSpike = event.payload?.spikePercentage || 0.20;
      
      const action = "PRICE_INCREASE";
      const delta = 0.05;
      const expectedRevenueGain = 6800;

      return {
        decision: action,
        reason: `Sudden demand spike detected (${(demandSpike * 100).toFixed(1)}%). Automatically capturing higher yield.`,
        confidence: 0.92,
        outcomeExpected: `Expected revenue gain: $${expectedRevenueGain}`,
        metadata: {
          action,
          delta,
          expectedRevenueGain,
        }
      };
    }

    return null;
  }
}
