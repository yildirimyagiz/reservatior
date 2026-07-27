/**
 * Outcome Store - BigQuery Learning Loop
 * 
 * Stores actual field results vs AI predictions for continuous learning:
 * - Predicted opportunity score vs actual conversion
 * - Predicted strategy vs actual outcome
 * - Model error delta calculation
 * - Feedback loop for model improvement
 */

export interface OutcomeRecord {
  outcomeId: string;
  propertyId: string;
  
  // Predictions
  predictedOpportunityScore: number;
  predictedBestStrategy: string;
  predictedAcquisitionUrgency: string;
  predictedConfidence: number;
  modelVersion: string;
  
  // Actual Field Results
  actualOwnerResponded: boolean;
  actualDaysToClose: number | null;
  actualRealizedRevenue: number | null;
  actualConversionStatus: 'SUCCESS' | 'REJECTED' | 'EXPIRED' | 'WITHDRAWN';
  actualStrategyUsed: string | null;
  actualRevenueDate: Date | null;
  
  // Model Performance
  modelErrorDelta: number; // Predicted vs Actual sapma skoru
  predictionAccuracy: number; // 0-100
  strategyMatch: boolean;
  
  // Metadata
  timestamp: Date;
  evaluationDate: Date | null;
  feedbackNotes: string | null;
}

export interface LearningMetrics {
  totalOutcomes: number;
  averageModelError: number;
  averagePredictionAccuracy: number;
  strategyMatchRate: number;
  conversionRate: number;
  revenueRealizationRate: number;
  modelPerformanceByStrategy: Record<string, {
    count: number;
    averageAccuracy: number;
    averageRevenue: number;
  }>;
  timeToCloseAverage: number;
}

export class OutcomeStore {
  private projectId: string;
  private datasetId: string;
  private tableId: string;

  constructor() {
    this.projectId = process.env.GCP_PROJECT_ID || 'reservatior-prod';
    this.datasetId = process.env.BIGQUERY_DATASET || 'analytics';
    this.tableId = 'property_outcomes_v1';
  }

  /**
   * Record outcome for learning
   */
  async recordOutcome(data: {
    propertyId: string;
    predictedOpportunityScore: number;
    predictedBestStrategy: string;
    predictedAcquisitionUrgency: string;
    predictedConfidence: number;
    modelVersion: string;
    actualOwnerResponded: boolean;
    actualDaysToClose: number | null;
    actualRealizedRevenue: number | null;
    actualConversionStatus: 'SUCCESS' | 'REJECTED' | 'EXPIRED' | 'WITHDRAWN';
    actualStrategyUsed: string | null;
    actualRevenueDate: Date | null;
    feedbackNotes?: string;
  }): Promise<void> {
    const outcomeId = this.generateOutcomeId();
    
    // Calculate model error delta
    const modelErrorDelta = this.calculateModelErrorDelta(
      data.predictedOpportunityScore,
      data.actualConversionStatus
    );
    
    // Calculate prediction accuracy
    const predictionAccuracy = this.calculatePredictionAccuracy(
      data.predictedOpportunityScore,
      data.actualConversionStatus,
      data.actualOwnerResponded
    );
    
    // Check strategy match
    const strategyMatch = data.predictedBestStrategy === data.actualStrategyUsed;

    const record: OutcomeRecord = {
      outcomeId,
      propertyId: data.propertyId,
      predictedOpportunityScore: data.predictedOpportunityScore,
      predictedBestStrategy: data.predictedBestStrategy,
      predictedAcquisitionUrgency: data.predictedAcquisitionUrgency,
      predictedConfidence: data.predictedConfidence,
      modelVersion: data.modelVersion,
      actualOwnerResponded: data.actualOwnerResponded,
      actualDaysToClose: data.actualDaysToClose,
      actualRealizedRevenue: data.actualRealizedRevenue,
      actualConversionStatus: data.actualConversionStatus,
      actualStrategyUsed: data.actualStrategyUsed,
      actualRevenueDate: data.actualRevenueDate,
      modelErrorDelta,
      predictionAccuracy,
      strategyMatch,
      timestamp: new Date(),
      evaluationDate: null,
      feedbackNotes: data.feedbackNotes || null
    };

    // TODO: Insert into BigQuery
    // const { BigQuery } = require('@google-cloud/bigquery');
    // const bigquery = new BigQuery({ projectId: this.projectId });
    // const dataset = bigquery.dataset(this.datasetId);
    // const table = dataset.table(this.tableId);
    // await table.insert(record);

    console.log(`[OutcomeStore] Recorded outcome for property: ${data.propertyId}`);
    console.log(`[OutcomeStore] Model error delta: ${modelErrorDelta}, Prediction accuracy: ${predictionAccuracy}%`);
  }

  /**
   * Calculate model error delta
   */
  private calculateModelErrorDelta(
    predictedScore: number,
    actualStatus: 'SUCCESS' | 'REJECTED' | 'EXPIRED' | 'WITHDRAWN'
  ): number {
    // Convert actual status to numeric score
    const actualScore = this.statusToScore(actualStatus);
    
    // Calculate absolute difference
    const errorDelta = Math.abs(predictedScore - actualScore);
    
    return Math.round(errorDelta * 100) / 100;
  }

  /**
   * Convert status to numeric score
   */
  private statusToScore(status: 'SUCCESS' | 'REJECTED' | 'EXPIRED' | 'WITHDRAWN'): number {
    const statusScores = {
      'SUCCESS': 100,
      'REJECTED': 0,
      'EXPIRED': 20,
      'WITHDRAWN': 30
    };
    
    return statusScores[status] || 50;
  }

  /**
   * Calculate prediction accuracy
   */
  private calculatePredictionAccuracy(
    predictedScore: number,
    actualStatus: 'SUCCESS' | 'REJECTED' | 'EXPIRED' | 'WITHDRAWN',
    ownerResponded: boolean
  ): number {
    const actualScore = this.statusToScore(actualStatus);
    
    // Base accuracy from score difference
    const scoreAccuracy = Math.max(0, 100 - Math.abs(predictedScore - actualScore));
    
    // Boost accuracy if owner responded (indicates good targeting)
    const responseBonus = ownerResponded ? 10 : 0;
    
    // Final accuracy
    const accuracy = Math.min(100, scoreAccuracy + responseBonus);
    
    return Math.round(accuracy);
  }

  /**
   * Get learning metrics
   */
  async getLearningMetrics(filters?: {
    startDate?: Date;
    endDate?: Date;
    modelVersion?: string;
    strategy?: string;
  }): Promise<LearningMetrics> {
    // TODO: Query BigQuery for actual metrics
    // For now, return mock data
    
    return {
      totalOutcomes: 0,
      averageModelError: 0,
      averagePredictionAccuracy: 0,
      strategyMatchRate: 0,
      conversionRate: 0,
      revenueRealizationRate: 0,
      modelPerformanceByStrategy: {},
      timeToCloseAverage: 0
    };
  }

  /**
   * Get model performance by version
   */
  async getModelPerformance(modelVersion: string): Promise<any> {
    // TODO: Query BigQuery for model-specific performance
    return {
      modelVersion,
      totalPredictions: 0,
      averageAccuracy: 0,
      averageError: 0,
      strategyMatchRate: 0,
      revenuePerPrediction: 0
    };
  }

  /**
   * Get strategy performance comparison
   */
  async getStrategyPerformance(): Promise<Record<string, any>> {
    // TODO: Query BigQuery for strategy comparison
    return {
      'NORMAL_SALE': {
        count: 0,
        averageAccuracy: 0,
        averageRevenue: 0,
        conversionRate: 0
      },
      'LUXURY_RENTAL': {
        count: 0,
        averageAccuracy: 0,
        averageRevenue: 0,
        conversionRate: 0
      },
      'CORPORATE_TENANT': {
        count: 0,
        averageAccuracy: 0,
        averageRevenue: 0,
        conversionRate: 0
      }
    };
  }

  /**
   * Evaluate model for retraining
   */
  async evaluateModelForRetraining(modelVersion: string): Promise<{
    needsRetraining: boolean;
    reasons: string[];
    recommendedActions: string[];
  }> {
    const metrics = await this.getModelPerformance(modelVersion);
    
    const reasons: string[] = [];
    const recommendedActions: string[] = [];
    
    // Check if accuracy is below threshold
    if (metrics.averageAccuracy < 70) {
      reasons.push(`Low prediction accuracy: ${metrics.averageAccuracy}%`);
      recommendedActions.push('Increase training data quality');
      recommendedActions.push('Review feature engineering');
    }
    
    // Check if error rate is high
    if (metrics.averageError > 30) {
      reasons.push(`High model error: ${metrics.averageError}`);
      recommendedActions.push('Adjust model hyperparameters');
      recommendedActions.push('Consider ensemble methods');
    }
    
    // Check if strategy match rate is low
    if (metrics.strategyMatchRate < 60) {
      reasons.push(`Low strategy match rate: ${metrics.strategyMatchRate}%`);
      recommendedActions.push('Improve strategic analysis');
      recommendedActions.push('Update strategy recommendation logic');
    }
    
    const needsRetraining = reasons.length > 0;
    
    return {
      needsRetraining,
      reasons,
      recommendedActions
    };
  }

  /**
   * Generate outcome ID
   */
  private generateOutcomeId(): string {
    return `outcome_${Date.now()}_${Math.random().toString(36).substr(2, 9)}`;
  }

  /**
   * Batch record outcomes
   */
  async batchRecordOutcomes(outcomes: Array<any>): Promise<void> {
    console.log(`[OutcomeStore] Batch recording ${outcomes.length} outcomes`);
    
    for (const outcome of outcomes) {
      await this.recordOutcome(outcome);
    }
    
    console.log('[OutcomeStore] Batch recording completed');
  }

  /**
   * Get outcome by property ID
   */
  async getOutcomeByProperty(propertyId: string): Promise<OutcomeRecord | null> {
    // TODO: Query BigQuery for specific property outcome
    return null;
  }

  /**
   * Get recent outcomes
   */
  async getRecentOutcomes(limit: number = 100): Promise<OutcomeRecord[]> {
    // TODO: Query BigQuery for recent outcomes
    return [];
  }

  /**
   * Get outcome statistics
   */
  async getOutcomeStatistics(): Promise<any> {
    const metrics = await this.getLearningMetrics();
    
    return {
      ...metrics,
      projectId: this.projectId,
      datasetId: this.datasetId,
      tableId: this.tableId,
      lastUpdated: new Date()
    };
  }

  /**
   * Create BigQuery table if not exists
   */
  async ensureTableExists(): Promise<void> {
    // TODO: Create BigQuery table with proper schema
    const schema = [
      { name: 'outcomeId', type: 'STRING' },
      { name: 'propertyId', type: 'STRING' },
      { name: 'predictedOpportunityScore', type: 'FLOAT64' },
      { name: 'predictedBestStrategy', type: 'STRING' },
      { name: 'predictedAcquisitionUrgency', type: 'STRING' },
      { name: 'predictedConfidence', type: 'FLOAT64' },
      { name: 'modelVersion', type: 'STRING' },
      { name: 'actualOwnerResponded', type: 'BOOLEAN' },
      { name: 'actualDaysToClose', type: 'INT64' },
      { name: 'actualRealizedRevenue', type: 'FLOAT64' },
      { name: 'actualConversionStatus', type: 'STRING' },
      { name: 'actualStrategyUsed', type: 'STRING' },
      { name: 'actualRevenueDate', type: 'TIMESTAMP' },
      { name: 'modelErrorDelta', type: 'FLOAT64' },
      { name: 'predictionAccuracy', type: 'FLOAT64' },
      { name: 'strategyMatch', type: 'BOOLEAN' },
      { name: 'timestamp', type: 'TIMESTAMP' },
      { name: 'evaluationDate', type: 'TIMESTAMP' },
      { name: 'feedbackNotes', type: 'STRING' }
    ];

    console.log(`[OutcomeStore] Table schema defined for ${this.tableId}`);
  }

  /**
   * Get table information
   */
  getTableInfo() {
    return {
      projectId: this.projectId,
      datasetId: this.datasetId,
      tableId: this.tableId,
      fullTableName: `${this.projectId}.${this.datasetId}.${this.tableId}`
    };
  }
}

export const outcomeStore = new OutcomeStore();
