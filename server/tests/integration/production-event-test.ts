/**
 * Production Event Test
 * 
 * End-to-end validation of the event flow:
 * VPS → Pub/Sub → Agents → Pub/Sub → VPS → Database
 */

import { edgeEventPublisher } from '../../src/edge/event-publisher';
import { eventConsumerIntegration } from '../../src/edge/event-consumer-integration';
import { EventFactory } from '../../src/events/base/event-envelope';
import { outcomeStore } from '../../src/learning/outcome-store-v2';

describe('Production Event Flow Test', () => {
  test('should complete full event flow for Turkey property', async () => {
    console.log('\n=== Production Event Flow Test: Turkey Property ===\n');

    // Step 1: Create property event (simulating VPS property creation)
    const propertyEvent = EventFactory.createListingIngestedEvent({
      country_code: 'TR',
      property_id: 'test_istanbul_001',
      source: 'manual',
      source_listing_id: 'mls_tr_001',
      property_data: {
        name: 'Test Property Istanbul',
        price: 18500000,
        currency: 'TRY',
        areaSqm: 120,
        city: 'Istanbul',
        country: 'Turkey',
        propertyType: 'apartment',
        listingStatus: 'AVAILABLE'
      }
    });

    console.log('Step 1: Property event created');
    console.log(`  Event ID: ${propertyEvent.event_id}`);
    console.log(`  Country: ${propertyEvent.country_code}`);
    console.log(`  Property ID: ${propertyEvent.data.property_id}`);
    console.log(`  Price: ${propertyEvent.data.property_data.price} TRY`);

    // Step 2: Publish event to Pub/Sub (simulated)
    const publishResult = await edgeEventPublisher.publish(propertyEvent);
    console.log('\nStep 2: Event published to Pub/Sub');
    console.log(`  Topic: ${publishResult.topic}`);
    console.log(`  Success: ${publishResult.success}`);

    expect(publishResult.success).toBe(true);

    // Step 3: Simulate Opportunity Engine processing
    console.log('\nStep 3: Simulating Opportunity Engine processing...');
    const opportunityScoreEvent = EventFactory.createEvent({
      event_type: 'opportunity.scored.v1',
      producer: 'opportunity-engine',
      country_code: 'TR',
      data: {
        property_id: 'test_istanbul_001',
        opportunity_score: 78,
        opportunity_tier: 'HIGH_POTENTIAL',
        acquisition_urgency: 'HIGH',
        score_breakdown: {
          yield_score: 75,
          price_gap_score: 80,
          demand_score: 85,
          vacancy_score: 70,
          risk_score: 65,
          liquidity_score: 75
        }
      }
    });

    console.log(`  Opportunity Score: ${opportunityScoreEvent.data.opportunity_score}`);
    console.log(`  Tier: ${opportunityScoreEvent.data.opportunity_tier}`);

    // Step 4: Simulate Strategic Brain processing
    console.log('\nStep 4: Simulating Strategic Brain processing...');
    const strategicAnalysisEvent = EventFactory.createEvent({
      event_type: 'opportunity.explained.v1',
      producer: 'strategic-brain',
      country_code: 'TR',
      data: {
        property_id: 'test_istanbul_001',
        final_opportunity_score: 78,
        recommended_strategy: 'NORMAL_SALE',
        why_score: 'Strong location in Istanbul with good rental yield potential',
        regional_strengths: ['Growing market', 'Tourism demand', 'Infrastructure development'],
        target_segments: ['Local investors', 'Foreign buyers'],
        recommended_sales_strategy: 'Focus on rental yield potential',
        risk_factors: ['Currency volatility', 'Earthquake risk'],
        timing_recommendations: 'Act within 3 months'
      }
    });

    console.log(`  Recommended Strategy: ${strategicAnalysisEvent.data.recommended_strategy}`);
    console.log(`  Why: ${strategicAnalysisEvent.data.why_score}`);

    // Step 5: Process events through VPS consumer
    console.log('\nStep 5: Processing events through VPS Consumer...');
    
    const opportunityScoreResult = await eventConsumerIntegration.routeEvent(opportunityScoreEvent);
    console.log(`  Opportunity Score Result: ${opportunityScoreResult.success ? 'SUCCESS' : 'FAILED'}`);

    const strategicAnalysisResult = await eventConsumerIntegration.routeEvent(strategicAnalysisEvent);
    console.log(`  Strategic Analysis Result: ${strategicAnalysisResult.success ? 'SUCCESS' : 'FAILED'}`);

    // Step 6: Record prediction for learning
    console.log('\nStep 6: Recording prediction for learning...');
    const predictionRecord = await outcomeStore.recordPrediction({
      country_code: 'TR',
      property_id: 'test_istanbul_001',
      prediction_type: 'opportunity_score',
      predicted_value: 78,
      predicted_unit: 'score',
      model_version: 'v1.0',
      model_type: 'opportunity-engine',
      confidence_score: 0.85,
      property_context: {
        location: 'Istanbul',
        price: 18500000,
        property_type: 'apartment'
      },
      market_context: {
        demand_level: 85,
        competition_level: 60
      }
    });

    console.log(`  Prediction recorded: ${predictionRecord.id}`);
    console.log(`  Status: ${predictionRecord.status}`);

    console.log('\n=== Production Event Flow Test Complete ===\n');

    expect(opportunityScoreResult.success).toBe(true);
    expect(strategicAnalysisResult.success).toBe(true);
    expect(predictionRecord.status).toBe('pending');
  });

  test('should complete full event flow for UAE property', async () => {
    console.log('\n=== Production Event Flow Test: UAE Property ===\n');

    // Create UAE property event
    const propertyEvent = EventFactory.createListingIngestedEvent({
      country_code: 'AE',
      property_id: 'test_dubai_001',
      source: 'manual',
      source_listing_id: 'mls_ae_001',
      property_data: {
        name: 'Test Property Dubai Marina',
        price: 2500000,
        currency: 'AED',
        areaSqm: 150,
        city: 'Dubai',
        country: 'UAE',
        propertyType: 'apartment',
        listingStatus: 'AVAILABLE'
      }
    });

    console.log('Step 1: Property event created');
    console.log(`  Event ID: ${propertyEvent.event_id}`);
    console.log(`  Country: ${propertyEvent.country_code}`);
    console.log(`  Property ID: ${propertyEvent.data.property_id}`);
    console.log(`  Price: ${propertyEvent.data.property_data.price} AED`);

    // Publish event
    const publishResult = await edgeEventPublisher.publish(propertyEvent);
    console.log('\nStep 2: Event published to Pub/Sub');
    console.log(`  Topic: ${publishResult.topic}`);
    console.log(`  Success: ${publishResult.success}`);

    expect(publishResult.success).toBe(true);

    // Simulate Opportunity Engine processing
    console.log('\nStep 3: Simulating Opportunity Engine processing...');
    const opportunityScoreEvent = EventFactory.createEvent({
      event_type: 'opportunity.scored.v1',
      producer: 'opportunity-engine',
      country_code: 'AE',
      data: {
        property_id: 'test_dubai_001',
        opportunity_score: 85,
        opportunity_tier: 'HIGH_POTENTIAL',
        acquisition_urgency: 'HIGH',
        score_breakdown: {
          yield_score: 90,
          price_gap_score: 85,
          demand_score: 88,
          vacancy_score: 80,
          risk_score: 75,
          liquidity_score: 85
        }
      }
    });

    console.log(`  Opportunity Score: ${opportunityScoreEvent.data.opportunity_score}`);
    console.log(`  Tier: ${opportunityScoreEvent.data.opportunity_tier}`);

    // Simulate Strategic Brain processing
    console.log('\nStep 4: Simulating Strategic Brain processing...');
    const strategicAnalysisEvent = EventFactory.createEvent({
      event_type: 'opportunity.explained.v1',
      producer: 'strategic-brain',
      country_code: 'AE',
      data: {
        property_id: 'test_dubai_001',
        final_opportunity_score: 85,
        recommended_strategy: 'LUXURY_RENTAL',
        why_score: 'Premium location in Dubai Marina with high rental yield potential',
        regional_strengths: ['Tax-free environment', 'Tourism hub', 'Luxury market'],
        target_segments: ['High-net-worth investors', 'Corporate tenants'],
        recommended_sales_strategy: 'Focus on luxury rental market',
        risk_factors: ['Market volatility', 'Supply fluctuations'],
        timing_recommendations: 'Act within 2 months'
      }
    });

    console.log(`  Recommended Strategy: ${strategicAnalysisEvent.data.recommended_strategy}`);
    console.log(`  Why: ${strategicAnalysisEvent.data.why_score}`);

    // Process events
    console.log('\nStep 5: Processing events through VPS Consumer...');
    
    const opportunityScoreResult = await eventConsumerIntegration.routeEvent(opportunityScoreEvent);
    console.log(`  Opportunity Score Result: ${opportunityScoreResult.success ? 'SUCCESS' : 'FAILED'}`);

    const strategicAnalysisResult = await eventConsumerIntegration.routeEvent(strategicAnalysisEvent);
    console.log(`  Strategic Analysis Result: ${strategicAnalysisResult.success ? 'SUCCESS' : 'FAILED'}`);

    // Record prediction
    console.log('\nStep 6: Recording prediction for learning...');
    const predictionRecord = await outcomeStore.recordPrediction({
      country_code: 'AE',
      property_id: 'test_dubai_001',
      prediction_type: 'opportunity_score',
      predicted_value: 85,
      predicted_unit: 'score',
      model_version: 'v1.0',
      model_type: 'opportunity-engine',
      confidence_score: 0.90,
      property_context: {
        location: 'Dubai Marina',
        price: 2500000,
        property_type: 'apartment'
      },
      market_context: {
        demand_level: 88,
        competition_level: 50
      }
    });

    console.log(`  Prediction recorded: ${predictionRecord.id}`);
    console.log(`  Status: ${predictionRecord.status}`);

    console.log('\n=== Production Event Flow Test Complete ===\n');

    expect(opportunityScoreResult.success).toBe(true);
    expect(strategicAnalysisResult.success).toBe(true);
    expect(predictionRecord.status).toBe('pending');
  });

  test('should verify prediction outcome for learning', async () => {
    console.log('\n=== Prediction Outcome Verification Test ===\n');

    // Create a prediction
    const predictionRecord = await outcomeStore.recordPrediction({
      country_code: 'TR',
      property_id: 'test_learning_001',
      prediction_type: 'rental_yield',
      predicted_value: 0.08,
      predicted_unit: 'percentage',
      model_version: 'v1.0',
      model_type: 'opportunity-engine',
      confidence_score: 0.80
    });

    console.log(`Prediction recorded: ${predictionRecord.id}`);
    console.log(`Predicted yield: ${predictionRecord.predicted_value} (${predictionRecord.predicted_unit})`);

    // Simulate actual outcome (e.g., property rented)
    const actualYield = 0.075; // 7.5% actual yield
    const actualDate = new Date();

    console.log(`Actual yield: ${actualYield} (percentage)`);

    // Verify prediction
    const verifiedRecord = await outcomeStore.verifyPrediction({
      outcome_id: predictionRecord.id,
      country_code: 'TR',
      actual_value: actualYield,
      actual_unit: 'percentage',
      actual_at: actualDate
    });

    console.log(`\nVerification complete:`);
    console.log(`  Error Delta: ${verifiedRecord.error_delta?.toFixed(4)}`);
    console.log(`  Accuracy: ${verifiedRecord.accuracy_percentage?.toFixed(1)}%`);
    console.log(`  Strategy Match: ${verifiedRecord.strategy_match ? 'YES' : 'NO'}`);
    console.log(`  Status: ${verifiedRecord.status}`);

    expect(verifiedRecord.status).toBe('verified');
    expect(verifiedRecord.accuracy_percentage).toBeGreaterThan(0);
    expect(verifiedRecord.error_delta).toBeDefined();

    console.log('\n=== Prediction Outcome Verification Test Complete ===\n');
  });

  test('should get learning metrics for country', async () => {
    console.log('\n=== Learning Metrics Test ===\n');

    const metrics = await outcomeStore.getLearningMetrics('TR');

    console.log(`Country: ${metrics.country_code}`);
    console.log(`Total Predictions: ${metrics.total_predictions}`);
    console.log(`Verified Outcomes: ${metrics.verified_outcomes}`);
    console.log(`Average Accuracy: ${metrics.average_accuracy.toFixed(1)}%`);
    console.log(`Last 30 Days Accuracy: ${metrics.last_30_days_accuracy.toFixed(1)}%`);
    console.log(`Last 7 Days Accuracy: ${metrics.last_7_days_accuracy.toFixed(1)}%`);

    console.log('\nModel Versions:');
    Object.entries(metrics.model_versions).forEach(([version, data]) => {
      console.log(`  ${version}: ${data.count} predictions, ${data.average_accuracy.toFixed(1)}% accuracy`);
    });

    console.log('\n=== Learning Metrics Test Complete ===\n');

    expect(metrics.country_code).toBe('TR');
    expect(metrics.total_predictions).toBeGreaterThanOrEqual(0);
    expect(metrics.verified_outcomes).toBeGreaterThanOrEqual(0);
  });

  test('should evaluate model performance for retraining', async () => {
    console.log('\n=== Model Performance Evaluation Test ===\n');

    const evaluation = await outcomeStore.evaluateModelPerformance('TR', 'v1.0');

    console.log(`Should Retrain: ${evaluation.shouldRetrain ? 'YES' : 'NO'}`);
    console.log(`Reason: ${evaluation.reason}`);
    console.log(`Current Accuracy: ${evaluation.currentAccuracy.toFixed(1)}%`);
    console.log(`Threshold: ${evaluation.threshold}%`);

    console.log('\n=== Model Performance Evaluation Test Complete ===\n');

    expect(evaluation.shouldRetrain).toBeDefined();
    expect(evaluation.currentAccuracy).toBeGreaterThanOrEqual(0);
    expect(evaluation.threshold).toBe(70);
  });
});
