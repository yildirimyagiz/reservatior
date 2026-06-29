/**
 * Domain Event Catalog
 * 
 * V1: Core Domain Events for the Decision Graph.
 * Target: 500+ events spanning all system activities for robust AI learning.
 */

export namespace ListingEvents {
  export const LISTING_VIEWED = "LISTING_VIEWED";
  export const LISTING_SHARED = "LISTING_SHARED";
  export const LISTING_FAVORITED = "LISTING_FAVORITED";
  export const LISTING_AI_IMPROVED = "LISTING_AI_IMPROVED";
  export const LISTING_PRICE_REDUCED = "LISTING_PRICE_REDUCED";
  export const LISTING_PRICE_INCREASED = "LISTING_PRICE_INCREASED";
  export const LISTING_HIDDEN = "LISTING_HIDDEN";
}

export namespace TourEvents {
  export const TOUR_REQUESTED = "TOUR_REQUESTED";
  export const TOUR_CANCELLED = "TOUR_CANCELLED";
  export const TOUR_COMPLETED = "TOUR_COMPLETED";
}

export namespace OfferEvents {
  export const OFFER_CREATED = "OFFER_CREATED";
  export const OFFER_ACCEPTED = "OFFER_ACCEPTED";
  export const OFFER_REJECTED = "OFFER_REJECTED";
  export const OFFER_COUNTERED = "OFFER_COUNTERED";
}

export namespace ContractEvents {
  export const CONTRACT_CREATED = "CONTRACT_CREATED";
  export const CONTRACT_SIGNED = "CONTRACT_SIGNED";
  export const CONTRACT_MUTATED = "CONTRACT_MUTATED";
  export const MARKET_SUPPLY_DROPPED = "MARKET_SUPPLY_DROPPED";
  export const MARKET_PRICE_DROPPED = "MARKET_PRICE_DROPPED";
}

export namespace PaymentEvents {
  export const PAYMENT_AUTHORIZED = "PAYMENT_AUTHORIZED";
  export const PAYMENT_CAPTURED = "PAYMENT_CAPTURED";
  export const PAYMENT_FAILED = "PAYMENT_FAILED";
}

export namespace AIEvents {
  export const AI_REQUEST_STARTED = "AI_REQUEST_STARTED";
  export const AI_REQUEST_COMPLETED = "AI_REQUEST_COMPLETED";
  export const AI_RESPONSE_ACCEPTED = "AI_RESPONSE_ACCEPTED";
  export const POI_ANALYSIS_STARTED = "POI_ANALYSIS_STARTED";
  export const POI_ANALYSIS_COMPLETED = "POI_ANALYSIS_COMPLETED";
}

export namespace AgentEvents {
  export const AGENT_ASSIGNED = "AGENT_ASSIGNED";
  export const AGENT_PERFORMANCE_UPDATED = "AGENT_PERFORMANCE_UPDATED";
  export const AGENT_LICENSE_VERIFIED = "AGENT_LICENSE_VERIFIED";
}

export namespace MarketEvents {
  export const MARKET_DEMAND_SPIKE = "MARKET_DEMAND_SPIKE";
  export const MARKET_DEMAND_DROP = "MARKET_DEMAND_DROP";
  export const INTEREST_RATE_CHANGED = "INTEREST_RATE_CHANGED";
}

export type DomainEventName = 
  | typeof ListingEvents[keyof typeof ListingEvents]
  | typeof TourEvents[keyof typeof TourEvents]
  | typeof OfferEvents[keyof typeof OfferEvents]
  | typeof ContractEvents[keyof typeof ContractEvents]
  | typeof PaymentEvents[keyof typeof PaymentEvents]
  | typeof AIEvents[keyof typeof AIEvents]
  | typeof AgentEvents[keyof typeof AgentEvents]
  | typeof MarketEvents[keyof typeof MarketEvents];

export interface BaseDomainEvent<T = any> {
  id: string; // uuid
  eventName: DomainEventName;
  timestamp: Date;
  source: string; // e.g. "MOBILE_APP", "AGENT_OS", "BACKGROUND_JOB"
  payload: T;
  entityId: string; // e.g. propertyId
  entityType: string; // e.g. "PROPERTY"
  orgId?: string;
  userId?: string;
}
