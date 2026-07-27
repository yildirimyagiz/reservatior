/**
 * VPS Event Consumer Integration
 * 
 * Integrates event consumer with existing Prisma database
 * Handles AI results from Google Cloud and updates country databases
 */

import { EventFactory, EventEnvelope } from '../events/base/event-envelope';
import { databaseRouter } from '../database/database-router';

export class EventConsumerIntegration {
  /**
   * Handle valuation completed event
   * Updates ValuationAI table in country database
   */
  async handleValuationCompleted(event: EventEnvelope) {
    const { property_id, estimated_value, confidence_score, valuation_data } = event.data;
    const { country_code } = event;
    
    console.log(`[EventConsumer] Processing valuation.completed.v1 for property: ${property_id} (${country_code})`);

    try {
      // Create valuation record in country database
      await databaseRouter.createValuation(country_code, {
        propertyProspectId: property_id,
        estimatedValue: estimated_value,
        valueRangeLow: estimated_value * 0.9,
        valueRangeHigh: estimated_value * 1.1,
        confidenceScore: confidence_score,
        marketTrend: valuation_data?.marketTrend || 'STABLE',
        locationScore: valuation_data?.locationScore || 0.5,
        conditionScore: valuation_data?.conditionScore || 0.5,
        amenitiesScore: valuation_data?.amenitiesScore || 0.5,
        modelVersion: 'v1.0',
        modelType: 'AVM',
        processingTimeMs: valuation_data?.processingTimeMs || 100,
        valuedAt: new Date()
      });

      console.log(`[EventConsumer] Valuation stored in ${country_code} database for property ${property_id}`);
      
      return { success: true, property_id, country_code };
    } catch (error) {
      console.error(`[EventConsumer] Failed to store valuation:`, error);
      return { success: false, property_id, country_code, error };
    }
  }

  /**
   * Handle opportunity scored event
   * Updates PropertyProspect table with opportunity score
   */
  async handleOpportunityScored(event: EventEnvelope) {
    const { property_id, opportunity_score, opportunity_tier, acquisition_urgency, score_breakdown } = event.data;
    const { country_code } = event;
    
    console.log(`[EventConsumer] Processing opportunity.scored.v1 for property: ${property_id} (${country_code})`);

    try {
      // Update property with AI analysis results
      await databaseRouter.updatePropertyWithAI(country_code, property_id, {
        confidenceScore: opportunity_score,
        metadata: {
          opportunity_tier,
          acquisition_urgency,
          score_breakdown,
          correlationId: event.correlation_id,
          analyzedAt: new Date()
        },
        acquisitionScore: opportunity_score,
        overallPriority: opportunity_score
      });

      console.log(`[EventConsumer] Opportunity score stored in ${country_code} database for property ${property_id}`);
      
      return { success: true, property_id, country_code, opportunity_score };
    } catch (error) {
      console.error(`[EventConsumer] Failed to store opportunity score:`, error);
      return { success: false, property_id, country_code, error };
    }
  }

  /**
   * Handle opportunity explained event from Strategic Brain
   * Updates PropertyProspect with strategic analysis
   */
  async handleOpportunityExplained(event: EventEnvelope) {
    const { property_id, final_opportunity_score, recommended_strategy, explanation, regional_strengths, target_segments, risk_factors } = event.data;
    const { country_code } = event;
    
    console.log(`[EventConsumer] Processing opportunity.explained.v1 for property: ${property_id} (${country_code})`);

    try {
      // Update property with strategic analysis
      await databaseRouter.updatePropertyWithAI(country_code, property_id, {
        confidenceScore: final_opportunity_score,
        metadata: {
          recommended_strategy,
          explanation,
          regional_strengths,
          target_segments,
          risk_factors,
          correlationId: event.correlation_id,
          analyzedAt: new Date()
        }
      });

      console.log(`[EventConsumer] Strategic analysis stored in ${country_code} database for property ${property_id}`);
      
      return { success: true, property_id, country_code, recommended_strategy };
    } catch (error) {
      console.error(`[EventConsumer] Failed to store strategic analysis:`, error);
      return { success: false, property_id, country_code, error };
    }
  }

  /**
   * Handle acquisition approved event
   * Updates property ownership status
   */
  async handleAcquisitionApproved(event: EventEnvelope) {
    const { property_id, approved_by, approval_notes } = event.data;
    const { country_code } = event;
    
    console.log(`[EventConsumer] Processing acquisition.approved.v1 for property: ${property_id} (${country_code})`);

    try {
      // Update property ownership status
      await databaseRouter.updateProperty(country_code, property_id, {
        ownershipStatus: 'ACTIVE_LISTING',
        metadata: {
          approved_by,
          approval_notes,
          approvedAt: new Date(),
          correlationId: event.correlation_id
        }
      });

      console.log(`[EventConsumer] Acquisition approval stored in ${country_code} database for property ${property_id}`);
      
      return { success: true, property_id, country_code };
    } catch (error) {
      console.error(`[EventConsumer] Failed to store acquisition approval:`, error);
      return { success: false, property_id, country_code, error };
    }
  }

  /**
   * Handle property claimed event
   * Updates property ownership
   */
  async handlePropertyClaimed(event: EventEnvelope) {
    const { property_id, owner_id, claim_data } = event.data;
    const { country_code } = event;
    
    console.log(`[EventConsumer] Processing property.claimed.v1 for property: ${property_id} (${country_code})`);

    try {
      // Update property ownership
      await databaseRouter.updateProperty(country_code, property_id, {
        ownerId: owner_id,
        ownershipStatus: 'CLAIMED',
        metadata: {
          claim_data,
          claimedAt: new Date(),
          correlationId: event.correlation_id
        }
      });

      console.log(`[EventConsumer] Property claim stored in ${country_code} database for property ${property_id}`);
      
      return { success: true, property_id, country_code, owner_id };
    } catch (error) {
      console.error(`[EventConsumer] Failed to store property claim:`, error);
      return { success: false, property_id, country_code, error };
    }
  }

  /**
   * Handle campaign created event
   * Creates campaign record in country database
   */
  async handleCampaignCreated(event: EventEnvelope) {
    const { campaign_id, campaign_data } = event.data;
    const { country_code } = event;
    
    console.log(`[EventConsumer] Processing campaign.created.v1 for campaign: ${campaign_id} (${country_code})`);

    try {
      // Create campaign in country database
      await databaseRouter.executeQuery(country_code, async (prisma) => {
        const Model = (prisma as any).acquisitionCampaign || (prisma as any).AcquisitionCampaign;
        
        if (!Model) {
          console.warn(`[EventConsumer] Campaign model not found for country: ${country_code}`);
          return null;
        }

        return await Model.create({
          data: {
            id: campaign_id,
            ...campaign_data,
            createdAt: new Date()
          }
        });
      });

      console.log(`[EventConsumer] Campaign created in ${country_code} database: ${campaign_id}`);
      
      return { success: true, campaign_id, country_code };
    } catch (error) {
      console.error(`[EventConsumer] Failed to create campaign:`, error);
      return { success: false, campaign_id, country_code, error };
    }
  }

  /**
   * Handle transaction completed event
   * Creates transaction record in country database
   */
  async handleTransactionCompleted(event: EventEnvelope) {
    const { transaction_id, transaction_data } = event.data;
    const { country_code } = event;
    
    console.log(`[EventConsumer] Processing transaction.completed.v1 for transaction: ${transaction_id} (${country_code})`);

    try {
      // Create transaction in country database
      await databaseRouter.executeQuery(country_code, async (prisma) => {
        const Model = (prisma as any).transaction || (prisma as any).Transaction;
        
        if (!Model) {
          console.warn(`[EventConsumer] Transaction model not found for country: ${country_code}`);
          return null;
        }

        return await Model.create({
          data: {
            id: transaction_id,
            ...transaction_data,
            completedAt: new Date()
          }
        });
      });

      console.log(`[EventConsumer] Transaction created in ${country_code} database: ${transaction_id}`);
      
      return { success: true, transaction_id, country_code };
    } catch (error) {
      console.error(`[EventConsumer] Failed to create transaction:`, error);
      return { success: false, transaction_id, country_code, error };
    }
  }

  /**
   * Handle commission generated event
   * Creates commission record in country database
   */
  async handleCommissionGenerated(event: EventEnvelope) {
    const { commission_id, commission_data } = event.data;
    const { country_code } = event;
    
    console.log(`[EventConsumer] Processing commission.generated.v1 for commission: ${commission_id} (${country_code})`);

    try {
      // Create commission in country database
      await databaseRouter.executeQuery(country_code, async (prisma) => {
        const Model = (prisma as any).commission || (prisma as any).Commission;
        
        if (!Model) {
          console.warn(`[EventConsumer] Commission model not found for country: ${country_code}`);
          return null;
        }

        return await Model.create({
          data: {
            id: commission_id,
            ...commission_data,
            generatedAt: new Date()
          }
        });
      });

      console.log(`[EventConsumer] Commission created in ${country_code} database: ${commission_id}`);
      
      return { success: true, commission_id, country_code };
    } catch (error) {
      console.error(`[EventConsumer] Failed to create commission:`, error);
      return { success: false, commission_id, country_code, error };
    }
  }

  /**
   * Route event to appropriate handler based on event type
   */
  async routeEvent(event: EventEnvelope) {
    const { event_type } = event;
    
    console.log(`[EventConsumer] Routing event: ${event_type} (${event.country_code})`);

    switch (event_type) {
      case 'valuation.completed.v1':
        return await this.handleValuationCompleted(event);
      
      case 'opportunity.scored.v1':
        return await this.handleOpportunityScored(event);
      
      case 'opportunity.explained.v1':
        return await this.handleOpportunityExplained(event);
      
      case 'acquisition.approved.v1':
        return await this.handleAcquisitionApproved(event);
      
      case 'property.claimed.v1':
        return await this.handlePropertyClaimed(event);
      
      case 'campaign.created.v1':
        return await this.handleCampaignCreated(event);
      
      case 'transaction.completed.v1':
        return await this.handleTransactionCompleted(event);
      
      case 'commission.generated.v1':
        return await this.handleCommissionGenerated(event);
      
      default:
        console.warn(`[EventConsumer] Unknown event type: ${event_type}`);
        return { success: false, error: 'Unknown event type', event_type };
    }
  }

  /**
   * Process event from Pub/Sub message
   */
  async processEvent(message: string) {
    try {
      // Parse event
      const event = EventFactory.parseEvent(message);
      
      // Validate event
      const validation = EventFactory.validateEvent(event);
      if (!validation.valid) {
        console.error(`[EventConsumer] Invalid event:`, validation.errors);
        return { success: false, errors: validation.errors };
      }
      
      // Route to appropriate handler
      return await this.routeEvent(event);
    } catch (error) {
      console.error(`[EventConsumer] Failed to process event:`, error);
      return { success: false, error };
    }
  }

  /**
   * Get integration status
   */
  getStatus() {
    return {
      status: 'active',
      handlers: [
        'valuation.completed.v1',
        'opportunity.scored.v1',
        'opportunity.explained.v1',
        'acquisition.approved.v1',
        'property.claimed.v1',
        'campaign.created.v1',
        'transaction.completed.v1',
        'commission.generated.v1'
      ],
      databaseRouter: databaseRouter.getConfiguredCountries()
    };
  }
}

export const eventConsumerIntegration = new EventConsumerIntegration();
