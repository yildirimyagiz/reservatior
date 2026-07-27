/**
 * Outcome Store v2 - Country-Aware Learning Loop
 * 
 * Tracks predicted vs actual outcomes for continuous model improvement
 * Country-specific learning for better scoring accuracy
 */

import { databaseRouter } from '../database/database-router';

export interface OutcomeRecord {
  id: string;
  country_code: string;
  property_id: string;
  prediction_type: 'opportunity_score' | 'rental_yield' | 'time_to_rent' | 'sale_price';
  
  // Predicted values
  predicted_value: number;
  predicted_unit: string;
  predicted_at: Date;
  model_version: string;
  model_type: string;
  
  // Actual values
  actual_value?: number;
  actual_unit?: string;
  actual_at?: Date;
  
  // Metadata
  confidence_score?: number;
  property_context?: Record<string, any>;
  market_context?: Record<string, any>;
  
  // Learning metrics
  error_delta?: number;
  accuracy_percentage?: number;
  strategy_match?: boolean;
  
  // Status
  status: 'pending' | 'verified' | 'analyzed';
  created_at: Date;
  updated_at: Date;
}

export interface LearningMetrics {
  country_code: string;
  prediction_type: string;
  
  // Model performance
  total_predictions: number;
  verified_outcomes: number;
  average_error_delta: number;
  average_accuracy: number;
  
  // Time-based metrics
  last_30_days_accuracy: number;
  last_7_days_accuracy: number;
  
  // Model comparison
  model_versions: Record<string, {
    count: number;
    average_accuracy: number;
  }>;
  
  // Country-specific insights
  country_insights: {
    best_performing_regions: string[];
    worst_performing_regions: string[];
    seasonal_patterns: Record<string, number>;
  };
}

export class OutcomeStore {
  /**
   * Record a prediction outcome
   */
  async recordPrediction(params: {
    country_code: string;
    property_id: string;
    prediction_type: OutcomeRecord['prediction_type'];
    predicted_value: number;
    predicted_unit: string;
    model_version: string;
    model_type: string;
    confidence_score?: number;
    property_context?: Record<string, any>;
    market_context?: Record<string, any>;
  }): Promise<OutcomeRecord> {
    const record: OutcomeRecord = {
      id: `outcome_${Date.now()}_${Math.random().toString(36).substr(2, 9)}`,
      country_code: params.country_code,
      property_id: params.property_id,
      prediction_type: params.prediction_type,
      predicted_value: params.predicted_value,
      predicted_unit: params.predicted_unit,
      predicted_at: new Date(),
      model_version: params.model_version,
      model_type: params.model_type,
      confidence_score: params.confidence_score,
      property_context: params.property_context,
      market_context: params.market_context,
      status: 'pending',
      created_at: new Date(),
      updated_at: new Date()
    };

    // Store in country-specific database via Database Router
    try {
      await databaseRouter.executeQuery(params.country_code, async (prisma) => {
        const Model = (prisma as any).outcomeRecord || (prisma as any).OutcomeRecord;
        
        if (!Model) {
          console.warn(`[OutcomeStore] OutcomeRecord model not found for country: ${params.country_code}`);
          return null;
        }

        return await Model.create({
          data: record
        });
      });

      console.log(`[OutcomeStore] Recorded prediction for ${params.property_id} (${params.country_code})`);
    } catch (error) {
      console.error(`[OutcomeStore] Failed to record prediction:`, error);
    }

    return record;
  }

  /**
   * Verify a prediction with actual outcome
   */
  async verifyPrediction(params: {
    outcome_id: string;
    country_code: string;
    actual_value: number;
    actual_unit: string;
    actual_at: Date;
  }): Promise<OutcomeRecord> {
    // Calculate learning metrics
    const record = await this.getOutcomeRecord(params.outcome_id, params.country_code);
    
    if (!record) {
      throw new Error('Outcome record not found');
    }

    // Calculate error delta
    const error_delta = Math.abs(record.predicted_value - params.actual_value);
    
    // Calculate accuracy percentage
    const accuracy_percentage = this.calculateAccuracy(
      record.predicted_value,
      params.actual_value,
      record.prediction_type
    );

    // Determine strategy match
    const strategy_match = this.determineStrategyMatch(record, params.actual_value);

    // Update record
    const updatedRecord: OutcomeRecord = {
      ...record,
      actual_value: params.actual_value,
      actual_unit: params.actual_unit,
      actual_at: params.actual_at,
      error_delta,
      accuracy_percentage,
      strategy_match,
      status: 'verified',
      updated_at: new Date()
    };

    // Update in database
    try {
      await databaseRouter.executeQuery(params.country_code, async (prisma) => {
        const Model = (prisma as any).outcomeRecord || (prisma as any).OutcomeRecord;
        
        if (!Model) {
          return null;
        }

        return await Model.update({
          where: { id: params.outcome_id },
          data: updatedRecord
        });
      });

      console.log(`[OutcomeStore] Verified prediction ${params.outcome_id} with accuracy: ${accuracy_percentage.toFixed(1)}%`);
    } catch (error) {
      console.error(`[OutcomeStore] Failed to verify prediction:`, error);
    }

    return updatedRecord;
  }

  /**
   * Calculate accuracy based on prediction type
   */
  private calculateAccuracy(
    predicted: number,
    actual: number,
    predictionType: OutcomeRecord['prediction_type']
  ): number {
    switch (predictionType) {
      case 'opportunity_score':
        // For scores (0-100), calculate percentage difference
        const scoreDiff = Math.abs(predicted - actual);
        return Math.max(0, 100 - scoreDiff);
      
      case 'rental_yield':
        // For yield percentages, calculate percentage difference
        const yieldDiff = Math.abs(predicted - actual);
        return Math.max(0, 100 - (yieldDiff * 100));
      
      case 'time_to_rent':
        // For time periods, calculate percentage difference
        const timeDiff = Math.abs(predicted - actual) / actual;
        return Math.max(0, 100 - (timeDiff * 100));
      
      case 'sale_price':
        // For prices, calculate percentage difference
        const priceDiff = Math.abs(predicted - actual) / actual;
        return Math.max(0, 100 - (priceDiff * 100));
      
      default:
        return 0;
    }
  }

  /**
   * Determine if strategy matched the outcome
   */
  private determineStrategyMatch(record: OutcomeRecord, actualValue: number): boolean {
    // Simple heuristic: if accuracy > 70%, strategy matched
    const accuracy = this.calculateAccuracy(
      record.predicted_value,
      actualValue,
      record.prediction_type
    );
    
    return accuracy >= 70;
  }

  /**
   * Get outcome record
   */
  async getOutcomeRecord(outcomeId: string, countryCode: string): Promise<OutcomeRecord | null> {
    try {
      const result = await databaseRouter.executeQuery(countryCode, async (prisma) => {
        const Model = (prisma as any).outcomeRecord || (prisma as any).OutcomeRecord;
        
        if (!Model) {
          return null;
        }

        return await Model.findUnique({
          where: { id: outcomeId }
        });
      });

      return result as OutcomeRecord;
    } catch (error) {
      console.error(`[OutcomeStore] Failed to get outcome record:`, error);
      return null;
    }
  }

  /**
   * Get learning metrics for a country
   */
  async getLearningMetrics(countryCode: string, predictionType?: string): Promise<LearningMetrics> {
    try {
      const results = await databaseRouter.executeQuery(countryCode, async (prisma) => {
        const Model = (prisma as any).outcomeRecord || (prisma as any).OutcomeRecord;
        
        if (!Model) {
          return null;
        }

        const where = predictionType ? { prediction_type: predictionType } : {};
        
        const records = await Model.findMany({
          where,
          orderBy: { created_at: 'desc' }
        });

        return records;
      });

      if (!results || results.length === 0) {
        return this.createEmptyMetrics(countryCode, predictionType);
      }

      // Calculate metrics
      const verifiedRecords = results.filter((r: any) => r.status === 'verified');
      const totalPredictions = results.length;
      const verifiedCount = verifiedRecords.length;

      const errorDeltas = verifiedRecords.map((r: any) => r.error_delta).filter((d: any) => d !== undefined);
      const accuracies = verifiedRecords.map((r: any) => r.accuracy_percentage).filter((a: any) => a !== undefined);

      const averageErrorDelta = errorDeltas.length > 0 
        ? errorDeltas.reduce((sum: number, delta: number) => sum + delta, 0) / errorDeltas.length 
        : 0;

      const averageAccuracy = accuracies.length > 0 
        ? accuracies.reduce((sum: number, acc: number) => sum + acc, 0) / accuracies.length 
        : 0;

      // Time-based metrics
      const now = new Date();
      const thirtyDaysAgo = new Date(now.getTime() - 30 * 24 * 60 * 60 * 1000);
      const sevenDaysAgo = new Date(now.getTime() - 7 * 24 * 60 * 60 * 1000);

      const recent30Days = verifiedRecords.filter((r: any) => new Date(r.actual_at) >= thirtyDaysAgo);
      const recent7Days = verifiedRecords.filter((r: any) => new Date(r.actual_at) >= sevenDaysAgo);

      const last30DaysAccuracy = recent30Days.length > 0
        ? recent30Days.reduce((sum: number, r: any) => sum + r.accuracy_percentage, 0) / recent30Days.length
        : 0;

      const last7DaysAccuracy = recent7Days.length > 0
        ? recent7Days.reduce((sum: number, r: any) => sum + r.accuracy_percentage, 0) / recent7Days.length
        : 0;

      // Model version comparison
      const model_versions: Record<string, { count: number; average_accuracy: number }> = {};
      verifiedRecords.forEach((r: any) => {
        const version = r.model_version;
        if (!model_versions[version]) {
          model_versions[version] = { count: 0, average_accuracy: 0 };
        }
        model_versions[version].count++;
        model_versions[version].average_accuracy += r.accuracy_percentage;
      });

      Object.keys(model_versions).forEach(version => {
        model_versions[version].average_accuracy /= model_versions[version].count;
      });

      return {
        country_code: countryCode,
        prediction_type: predictionType || 'all',
        total_predictions: totalPredictions,
        verified_outcomes: verifiedCount,
        average_error_delta: averageErrorDelta,
        average_accuracy: averageAccuracy,
        last_30_days_accuracy: last30DaysAccuracy,
        last_7_days_accuracy: last7DaysAccuracy,
        model_versions,
        country_insights: {
          best_performing_regions: [],
          worst_performing_regions: [],
          seasonal_patterns: {}
        }
      };
    } catch (error) {
      console.error(`[OutcomeStore] Failed to get learning metrics:`, error);
      return this.createEmptyMetrics(countryCode, predictionType);
    }
  }

  /**
   * Create empty metrics
   */
  private createEmptyMetrics(countryCode: string, predictionType?: string): LearningMetrics {
    return {
      country_code: countryCode,
      prediction_type: predictionType || 'all',
      total_predictions: 0,
      verified_outcomes: 0,
      average_error_delta: 0,
      average_accuracy: 0,
      last_30_days_accuracy: 0,
      last_7_days_accuracy: 0,
      model_versions: {},
      country_insights: {
        best_performing_regions: [],
        worst_performing_regions: [],
        seasonal_patterns: {}
      }
    };
  }

  /**
   * Batch record predictions
   */
  async batchRecordPredictions(predictions: Array<{
    country_code: string;
    property_id: string;
    prediction_type: OutcomeRecord['prediction_type'];
    predicted_value: number;
    predicted_unit: string;
    model_version: string;
    model_type: string;
    confidence_score?: number;
    property_context?: Record<string, any>;
    market_context?: Record<string, any>;
  }>): Promise<OutcomeRecord[]> {
    const results = await Promise.all(
      predictions.map(p => this.recordPrediction(p))
    );
    return results;
  }

  /**
   * Get pending predictions (awaiting verification)
   */
  async getPendingPredictions(countryCode: string, limit: number = 100): Promise<OutcomeRecord[]> {
    try {
      const results = await databaseRouter.executeQuery(countryCode, async (prisma) => {
        const Model = (prisma as any).outcomeRecord || (prisma as any).OutcomeRecord;
        
        if (!Model) {
          return [];
        }

        return await Model.findMany({
          where: { status: 'pending' },
          orderBy: { predicted_at: 'desc' },
          take: limit
        });
      });

      return results as OutcomeRecord[];
    } catch (error) {
      console.error(`[OutcomeStore] Failed to get pending predictions:`, error);
      return [];
    }
  }

  /**
   * Evaluate model performance for retraining
   */
  async evaluateModelPerformance(countryCode: string, modelVersion: string): Promise<{
    shouldRetrain: boolean;
    reason: string;
    currentAccuracy: number;
    threshold: number;
  }> {
    const metrics = await this.getLearningMetrics(countryCode);
    
    const modelMetrics = metrics.model_versions[modelVersion];
    
    if (!modelMetrics || modelMetrics.count < 10) {
      return {
        shouldRetrain: false,
        reason: 'Insufficient data for evaluation',
        currentAccuracy: modelMetrics?.average_accuracy || 0,
        threshold: 70
      };
    }

    const threshold = 70; // 70% accuracy threshold
    const shouldRetrain = modelMetrics.average_accuracy < threshold;

    return {
      shouldRetrain,
      reason: shouldRetrain 
        ? `Model accuracy (${modelMetrics.average_accuracy.toFixed(1)}%) below threshold (${threshold}%)`
        : `Model accuracy (${modelMetrics.average_accuracy.toFixed(1)}%) above threshold (${threshold}%)`,
      currentAccuracy: modelMetrics.average_accuracy,
      threshold
    };
  }

  /**
   * Get country-specific learning insights
   */
  async getCountryInsights(countryCode: string): Promise<{
    bestPerformingPredictionTypes: string[];
    worstPerformingPredictionTypes: string[];
    recommendedModelUpdates: string[];
  }> {
    const predictionTypes: OutcomeRecord['prediction_type'][] = [
      'opportunity_score',
      'rental_yield',
      'time_to_rent',
      'sale_price'
    ];

    const metrics = await Promise.all(
      predictionTypes.map(type => this.getLearningMetrics(countryCode, type))
    );

    const sortedByAccuracy = metrics
      .filter(m => m.total_predictions > 0)
      .sort((a, b) => b.average_accuracy - a.average_accuracy);

    const bestPerforming = sortedByAccuracy.slice(0, 2).map(m => m.prediction_type);
    const worstPerforming = sortedByAccuracy.slice(-2).map(m => m.prediction_type);

    const recommendedUpdates = worstPerforming
      .filter(type => {
        const metric = metrics.find(m => m.prediction_type === type);
        return metric && metric.average_accuracy < 70;
      })
      .map(type => `Retrain ${type} model - current accuracy: ${metrics.find(m => m.prediction_type === type)?.average_accuracy.toFixed(1)}%`);

    return {
      bestPerformingPredictionTypes: bestPerforming,
      worstPerformingPredictionTypes: worstPerforming,
      recommendedModelUpdates: recommendedUpdates
    };
  }
}

export const outcomeStore = new OutcomeStore();
