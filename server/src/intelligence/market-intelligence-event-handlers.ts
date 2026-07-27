/**
 * Market Intelligence Event Handlers
 * Handles market intelligence events and integrates with the event bus
 */

import { marketIntelligenceAgent } from './market-intelligence-agent';
import { DomainEvents } from '../core/events/domain-events';

export class MarketIntelligenceEventHandlers {
  /**
   * Handle market intelligence created event
   * Logs the completion of market intelligence profile creation
   */
  async handleMarketIntelligenceCreated(event: any): Promise<void> {
    console.log(`[MarketIntelligenceEventHandlers] Market intelligence created for ${event.locationId}`);
    // In production, this would:
    // - Update the market intelligence profile
    // - Trigger SEO page generation
    // - Notify relevant agents
  }

  /**
   * Handle market score calculated event
   * Logs the completion of market opportunity score calculation
   */
  async handleMarketScoreCalculated(event: any): Promise<void> {
    console.log(`[MarketIntelligenceEventHandlers] Market score calculated for ${event.locationId}: ${event.overallScore}`);
    // In production, this would:
    // - Update the market opportunity score
    // - Trigger ranking updates
    // - Notify investors
  }

  /**
   * Handle market trend detected event
   * Logs the detection of a market trend
   */
  async handleMarketTrendDetected(event: any): Promise<void> {
    console.log(`[MarketIntelligenceEventHandlers] Market trend detected for ${event.locationId}: ${event.metric} - ${event.trendDirection}`);
    // In production, this would:
    // - Update the market trend
    // - Trigger alert notifications
    // - Update market phase
  }

  /**
   * Handle market opportunity detected event
   * Logs the detection of a market opportunity
   */
  async handleMarketOpportunityDetected(event: any): Promise<void> {
    console.log(`[MarketIntelligenceEventHandlers] Market opportunity detected for ${event.locationId}: ${event.recommendation}`);
    // In production, this would:
    // - Update the market opportunity score
    // - Trigger investment notifications
    // - Update SEO content
  }

  /**
   * Handle market forecast generated event
   * Logs the generation of market forecast
   */
  async handleMarketForecastGenerated(event: any): Promise<void> {
    console.log(`[MarketIntelligenceEventHandlers] Market forecast generated for ${event.locationId}`);
    // In production, this would:
    // - Update the market digital twin
    // - Trigger investment analysis
    // - Enable scenario planning
  }

  /**
   * Handle property intelligence created event
   * Triggers market intelligence analysis for the property's location
   */
  async handlePropertyIntelligenceCreated(event: any): Promise<void> {
    console.log(`[MarketIntelligenceEventHandlers] Property intelligence created for ${event.propertyId}, triggering market analysis`);
    
    try {
      await marketIntelligenceAgent.handlePropertyIntelligenceCreated(event);
    } catch (error) {
      console.error(`[MarketIntelligenceEventHandlers] Failed to handle property intelligence created:`, error);
      throw error;
    }
  }
}

// Singleton instance
export const marketIntelligenceEventHandlers = new MarketIntelligenceEventHandlers();

/**
 * Event Bus Integration
 * Registers market intelligence event handlers
 */
export function registerMarketIntelligenceEventHandlers(eventBus: any): void {
  eventBus.subscribe(DomainEvents.MARKET_INTELLIGENCE_CREATED, (event: any) => {
    marketIntelligenceEventHandlers.handleMarketIntelligenceCreated(event);
  });

  eventBus.subscribe(DomainEvents.MARKET_SCORE_CALCULATED, (event: any) => {
    marketIntelligenceEventHandlers.handleMarketScoreCalculated(event);
  });

  eventBus.subscribe(DomainEvents.MARKET_TREND_DETECTED, (event: any) => {
    marketIntelligenceEventHandlers.handleMarketTrendDetected(event);
  });

  eventBus.subscribe(DomainEvents.MARKET_OPPORTUNITY_DETECTED, (event: any) => {
    marketIntelligenceEventHandlers.handleMarketOpportunityDetected(event);
  });

  eventBus.subscribe(DomainEvents.MARKET_FORECAST_GENERATED, (event: any) => {
    marketIntelligenceEventHandlers.handleMarketForecastGenerated(event);
  });

  // Subscribe to property intelligence created to trigger market analysis
  eventBus.subscribe(DomainEvents.PROPERTY_INTELLIGENCE_CREATED, (event: any) => {
    marketIntelligenceEventHandlers.handlePropertyIntelligenceCreated(event);
  });

  console.log('[MarketIntelligenceEventHandlers] Registered all market intelligence event handlers');
}
