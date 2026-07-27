/**
 * Global Event Envelope Standard
 * 
 * Country-independent event system for multi-country architecture
 * Agents never know about country-specific schemas, only events
 */

export interface EventEnvelope {
  spec_version: string;
  event_id: string;
  event_type: string;
  schema_version: string;
  timestamp: Date;
  producer: string;
  correlation_id: string;
  country_code: string;
  data: Record<string, any>;
}

export interface CountryContext {
  country_code: string;
  currency: string;
  timezone: string;
  legal_framework: Record<string, any>;
  taxation_rules: Record<string, any>;
  rental_rules: Record<string, any>;
  market_specifics: Record<string, any>;
}

export class EventFactory {
  /**
   * Create standardized event envelope
   */
  static createEvent(params: {
    event_type: string;
    producer: string;
    country_code: string;
    data: Record<string, any>;
    correlation_id?: string;
  }): EventEnvelope {
    return {
      spec_version: "1.0",
      event_id: `evt_${Date.now()}_${Math.random().toString(36).substr(2, 9)}`,
      event_type: params.event_type,
      schema_version: "v1",
      timestamp: new Date(),
      producer: params.producer,
      correlation_id: params.correlation_id || `corr_${Date.now()}_${Math.random().toString(36).substr(2, 9)}`,
      country_code: params.country_code,
      data: params.data
    };
  }

  /**
   * Create property listing ingested event
   */
  static createListingIngestedEvent(params: {
    country_code: string;
    property_id: string;
    source: string;
    source_listing_id: string;
    property_data: Record<string, any>;
  }): EventEnvelope {
    return this.createEvent({
      event_type: "listing.ingested.v1",
      producer: "reservatior-edge",
      country_code: params.country_code,
      data: {
        property_id: params.property_id,
        source: params.source,
        source_listing_id: params.source_listing_id,
        property_data: params.property_data
      }
    });
  }

  /**
   * Create valuation completed event
   */
  static createValuationCompletedEvent(params: {
    country_code: string;
    property_id: string;
    estimated_value: number;
    confidence_score: number;
    valuation_data: Record<string, any>;
  }): EventEnvelope {
    return this.createEvent({
      event_type: "valuation.completed.v1",
      producer: "valuation-agent",
      country_code: params.country_code,
      data: {
        property_id: params.property_id,
        estimated_value: params.estimated_value,
        confidence_score: params.confidence_score,
        valuation_data: params.valuation_data
      }
    });
  }

  /**
   * Create opportunity scored event
   */
  static createOpportunityScoredEvent(params: {
    country_code: string;
    property_id: string;
    opportunity_score: number;
    opportunity_tier: string;
    acquisition_urgency: string;
    score_breakdown: Record<string, any>;
  }): EventEnvelope {
    return this.createEvent({
      event_type: "opportunity.scored.v1",
      producer: "opportunity-engine",
      country_code: params.country_code,
      data: {
        property_id: params.property_id,
        opportunity_score: params.opportunity_score,
        opportunity_tier: params.opportunity_tier,
        acquisition_urgency: params.acquisition_urgency,
        score_breakdown: params.score_breakdown
      }
    });
  }

  /**
   * Parse event from Pub/Sub message
   */
  static parseEvent(message: string): EventEnvelope {
    try {
      const parsed = JSON.parse(message);
      
      // Validate required fields
      if (!parsed.event_id || !parsed.event_type || !parsed.country_code) {
        throw new Error('Invalid event format: missing required fields');
      }
      
      return parsed as EventEnvelope;
    } catch (error) {
      throw new Error(`Failed to parse event: ${error}`);
    }
  }

  /**
   * Validate event envelope
   */
  static validateEvent(event: EventEnvelope): { valid: boolean; errors: string[] } {
    const errors: string[] = [];
    
    if (!event.spec_version) errors.push('Missing spec_version');
    if (!event.event_id) errors.push('Missing event_id');
    if (!event.event_type) errors.push('Missing event_type');
    if (!event.schema_version) errors.push('Missing schema_version');
    if (!event.timestamp) errors.push('Missing timestamp');
    if (!event.producer) errors.push('Missing producer');
    if (!event.correlation_id) errors.push('Missing correlation_id');
    if (!event.country_code) errors.push('Missing country_code');
    if (!event.data) errors.push('Missing data');
    
    // Validate event_type format: domain.action.version
    const eventTypePattern = /^[a-z]+\.[a-z]+\.[a-z0-9]+$/;
    if (!eventTypePattern.test(event.event_type)) {
      errors.push(`Invalid event_type format: ${event.event_type}. Expected: domain.action.version`);
    }
    
    // Validate country_code (ISO 3166-1 alpha-2)
    const countryCodePattern = /^[A-Z]{2}$/;
    if (!countryCodePattern.test(event.country_code)) {
      errors.push(`Invalid country_code: ${event.country_code}. Expected: ISO 3166-1 alpha-2 (e.g., TR, US, AE)`);
    }
    
    return {
      valid: errors.length === 0,
      errors
    };
  }
}

export const eventFactory = new EventFactory();
