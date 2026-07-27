/**
 * Content Intelligence Event Handlers
 * Handles content intelligence events and integrates with the event bus
 */

import { contentIntelligenceAgent } from './content-intelligence-agent';
import { DomainEvents } from '../core/events/domain-events';

export class ContentIntelligenceEventHandlers {
  /**
   * Handle property digital twin generated event
   * Triggers content brief generation for the property
   */
  async handlePropertyDigitalTwinGenerated(event: any): Promise<void> {
    console.log(`[ContentIntelligenceEventHandlers] Property digital twin generated for ${event.propertyId}`);
    
    try {
      await contentIntelligenceAgent.onDigitalTwinGenerated(event);
    } catch (error) {
      console.error(`[ContentIntelligenceEventHandlers] Failed to handle property digital twin generated:`, error);
      throw error;
    }
  }

  /**
   * Handle market intelligence generated event
   * Triggers neighborhood guide refresh
   */
  async handleMarketIntelligenceGenerated(event: any): Promise<void> {
    console.log(`[ContentIntelligenceEventHandlers] Market intelligence generated for ${event.locationId}`);
    
    try {
      await contentIntelligenceAgent.onMarketIntelligenceGenerated(event);
    } catch (error) {
      console.error(`[ContentIntelligenceEventHandlers] Failed to handle market intelligence generated:`, error);
      throw error;
    }
  }

  /**
   * Handle property score updated event
   * Triggers content refresh if score change is significant
   */
  async handlePropertyScoreUpdated(event: any): Promise<void> {
    console.log(`[ContentIntelligenceEventHandlers] Property score updated for ${event.propertyId}`);
    
    try {
      await contentIntelligenceAgent.onPropertyScoreUpdated(event);
    } catch (error) {
      console.error(`[ContentIntelligenceEventHandlers] Failed to handle property score updated:`, error);
      throw error;
    }
  }
}

// Singleton instance
export const contentIntelligenceEventHandlers = new ContentIntelligenceEventHandlers();

/**
 * Event Bus Integration
 * Registers content intelligence event handlers
 */
export function registerContentIntelligenceEventHandlers(eventBus: any): void {
  eventBus.subscribe(DomainEvents.PROPERTY_DIGITAL_TWIN_GENERATED, (event: any) => {
    contentIntelligenceEventHandlers.handlePropertyDigitalTwinGenerated(event);
  });

  eventBus.subscribe(DomainEvents.MARKET_INTELLIGENCE_CREATED, (event: any) => {
    contentIntelligenceEventHandlers.handleMarketIntelligenceGenerated(event);
  });

  eventBus.subscribe(DomainEvents.PROPERTY_SCORE_CALCULATED, (event: any) => {
    contentIntelligenceEventHandlers.handlePropertyScoreUpdated(event);
  });

  console.log('[ContentIntelligenceEventHandlers] Registered all content intelligence event handlers');
}
