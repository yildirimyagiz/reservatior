import { BaseDecisionNode, DecisionNodeResult } from "./base-node";
import { BaseDomainEvent, ListingEvents, TourEvents, OfferEvents } from "../../events/catalog";

export class ConversionNode extends BaseDecisionNode {
  name = "ConversionNode";

  async process(event: BaseDomainEvent): Promise<DecisionNodeResult | null> {
    const funnelEvents = [
      ListingEvents.LISTING_VIEWED,
      TourEvents.TOUR_REQUESTED,
      OfferEvents.OFFER_CREATED,
    ];

    if (funnelEvents.includes(event.eventName as any)) {
      // Base probabilities (Prior)
      let prior = 0.01; 
      let evidence = 1.0;

      if (event.eventName === ListingEvents.LISTING_VIEWED) {
        evidence = 1.2;
      } else if (event.eventName === TourEvents.TOUR_REQUESTED) {
        evidence = 4.5;
        prior = 0.05; // Assumed prior for users who reach this stage
      } else if (event.eventName === OfferEvents.OFFER_CREATED) {
        evidence = 15.0;
        prior = 0.15;
      }

      // Simple Bayesian Update
      let posterior = Math.min(prior * evidence, 0.99);

      return {
        decision: "UPDATED_CONVERSION_PROBABILITY",
        reason: `Bayesian update due to ${event.eventName}. Prior: ${prior}, Evidence Multiplier: ${evidence}`,
        confidence: 0.95,
        outcomeExpected: `New conversion probability: ${(posterior * 100).toFixed(1)}%`,
        metadata: { conversionProbability: posterior }
      };
    }

    return null;
  }
}
