import { EventEnvelope } from '../events/base/event-envelope';
import { RevenueEvents, ContractEvents, CognitiveEvents } from '../core/domain/events/event-catalog';
import { outcomeStore } from '../learning/outcome-store-v2';
import { eventBus } from '../core/events/event-bus';

/**
 * KnowledgeOS Learning Loop Event Handlers
 * 
 * Listens for real-world outcome events (deals closing, leases signing)
 * and compares them against previous predictions to improve the models.
 */
export class LearningLoopEventHandlers {
  
  /**
   * Initializes the event handlers and attaches them to the event bus
   */
  static initialize() {
    console.log('[KnowledgeOS] Initializing Learning Loop Event Handlers...');

    // Listen for closed deals (Sales)
    eventBus.subscribe(RevenueEvents.DEAL_CLOSED, async (envelope: EventEnvelope) => {
      await this.handleDealClosed(envelope);
    });

    // Listen for signed leases (Rentals)
    eventBus.subscribe(ContractEvents.LEASE_SIGNED, async (envelope: EventEnvelope) => {
      await this.handleLeaseSigned(envelope);
    });
  }

  /**
   * Handles a DEAL_CLOSED event to verify sale price predictions
   */
  private static async handleDealClosed(envelope: EventEnvelope) {
    try {
      const payload = envelope.payload;
      const propertyId = payload.property_id || payload.propertyId;
      const countryCode = payload.country_code || payload.countryCode || 'tr';
      const actualSalePrice = payload.final_price || payload.amount;
      
      if (!propertyId || !actualSalePrice) {
        console.warn('[LearningLoop] DEAL_CLOSED event missing propertyId or actual price.');
        return;
      }

      console.log(`[LearningLoop] Processing closed deal for property ${propertyId} in ${countryCode}`);

      // Get pending predictions for this country
      const pendingPredictions = await outcomeStore.getPendingPredictions(countryCode);
      
      // Filter predictions related to this property and of type 'sale_price'
      const relevantPredictions = pendingPredictions.filter(p => 
        p.property_id === propertyId && p.prediction_type === 'sale_price'
      );

      for (const prediction of relevantPredictions) {
        // Verify the prediction
        const verified = await outcomeStore.verifyPrediction({
          outcome_id: prediction.id,
          country_code: countryCode,
          actual_value: actualSalePrice,
          actual_unit: payload.currency || 'USD',
          actual_at: new Date()
        });

        // Trigger performance evaluation
        await this.evaluateModelAndTriggerUpdates(countryCode, prediction.model_version);
      }
    } catch (error) {
      console.error('[LearningLoop] Error handling DEAL_CLOSED:', error);
    }
  }

  /**
   * Handles a LEASE_SIGNED event to verify rental yield and time-to-rent predictions
   */
  private static async handleLeaseSigned(envelope: EventEnvelope) {
    try {
      const payload = envelope.payload;
      const propertyId = payload.property_id || payload.propertyId;
      const countryCode = payload.country_code || payload.countryCode || 'tr';
      const actualRent = payload.monthly_rent || payload.rent_amount;
      const propertyValue = payload.property_value; // Often needed to calculate yield
      
      if (!propertyId || !actualRent) {
        console.warn('[LearningLoop] LEASE_SIGNED event missing propertyId or actual rent.');
        return;
      }

      // Calculate actual yield if property value is available
      let actualYield: number | undefined;
      if (propertyValue) {
        actualYield = ((actualRent * 12) / propertyValue) * 100;
      }

      console.log(`[LearningLoop] Processing signed lease for property ${propertyId} in ${countryCode}`);

      const pendingPredictions = await outcomeStore.getPendingPredictions(countryCode);
      
      const relevantYieldPredictions = pendingPredictions.filter(p => 
        p.property_id === propertyId && p.prediction_type === 'rental_yield'
      );

      for (const prediction of relevantYieldPredictions) {
        if (actualYield) {
          await outcomeStore.verifyPrediction({
            outcome_id: prediction.id,
            country_code: countryCode,
            actual_value: actualYield,
            actual_unit: '%',
            actual_at: new Date()
          });

          await this.evaluateModelAndTriggerUpdates(countryCode, prediction.model_version);
        }
      }

    } catch (error) {
      console.error('[LearningLoop] Error handling LEASE_SIGNED:', error);
    }
  }

  /**
   * Evaluates the model performance and emits a learning event if retraining is needed
   */
  private static async evaluateModelAndTriggerUpdates(countryCode: string, modelVersion: string) {
    try {
      const evaluation = await outcomeStore.evaluateModelPerformance(countryCode, modelVersion);
      
      if (evaluation.shouldRetrain) {
        console.log(`[LearningLoop] Model ${modelVersion} requires retraining. Reason: ${evaluation.reason}`);
        
        // Emit a Cognitive event to trigger Knowledge Graph updates or AI retraining pipelines
        eventBus.publish(
          CognitiveEvents.LEARNING_COMPLETED,
          {
            country_code: countryCode,
            model_version: modelVersion,
            accuracy: evaluation.currentAccuracy,
            threshold: evaluation.threshold,
            reason: evaluation.reason,
            action_required: 'retrain_model'
          },
          'learning.loop'
        );
      }
    } catch (error) {
      console.error('[LearningLoop] Error during model evaluation:', error);
    }
  }
}
