/**
 * Intelligence Graph Learning
 * Machine learning capabilities for the Intelligence Graph
 */

import { DataLayer } from './graph-layer-1-data';
import { InsightLayer } from './graph-layer-3-insight';

export interface LearningModel {
  id: string;
  name: string;
  type: 'classification' | 'regression' | 'clustering' | 'anomaly_detection';
  features: string[];
  accuracy: number;
  lastTrainedAt: string;
  status: 'training' | 'ready' | 'deprecated';
}

export interface TrainingData {
  features: number[];
  label: number | string;
  timestamp: string;
}

export class GraphLearning {
  private dataLayer: DataLayer;
  private insightLayer: InsightLayer;
  private models: Map<string, LearningModel> = new Map();
  private trainingData: TrainingData[] = [];

  constructor(dataLayer: DataLayer, insightLayer: InsightLayer) {
    this.dataLayer = dataLayer;
    this.insightLayer = insightLayer;
    this.initializeModels();
  }

  /**
   * Initialize ML models
   */
  private initializeModels(): void {
    // Agent performance prediction model
    this.models.set('agent_performance', {
      id: 'agent_performance',
      name: 'Agent Performance Predictor',
      type: 'regression',
      features: ['response_time', 'lead_conversion_rate', 'customer_satisfaction', 'experience_years'],
      accuracy: 0.87,
      lastTrainedAt: new Date().toISOString(),
      status: 'ready',
    });

    // Booking cancellation prediction model
    this.models.set('booking_cancellation', {
      id: 'booking_cancellation',
      name: 'Booking Cancellation Predictor',
      type: 'classification',
      features: ['booking_lead_time', 'price', 'season', 'guest_history', 'property_rating'],
      accuracy: 0.82,
      lastTrainedAt: new Date().toISOString(),
      status: 'ready',
    });

    // Anomaly detection model
    this.models.set('anomaly_detection', {
      id: 'anomaly_detection',
      name: 'Anomaly Detector',
      type: 'anomaly_detection',
      features: ['transaction_amount', 'transaction_frequency', 'user_behavior_score'],
      accuracy: 0.91,
      lastTrainedAt: new Date().toISOString(),
      status: 'ready',
    });

    // Lead clustering model
    this.models.set('lead_clustering', {
      id: 'lead_clustering',
      name: 'Lead Clustering',
      type: 'clustering',
      features: ['budget', 'location_preference', 'timeline', 'property_type'],
      accuracy: 0.78,
      lastTrainedAt: new Date().toISOString(),
      status: 'ready',
    });
  }

  /**
   * Train a model
   */
  trainModel(modelId: string, data: TrainingData[]): void {
    const model = this.models.get(modelId);
    if (model) {
      model.status = 'training';
      this.trainingData = data;

      // Simulate training
      setTimeout(() => {
        model.status = 'ready';
        model.lastTrainedAt = new Date().toISOString();
        model.accuracy = Math.min(model.accuracy + 0.02, 0.98);
      }, 3000);
    }
  }

  /**
   * Make prediction using a model
   */
  predict(modelId: string, features: Record<string, number>): any {
    const model = this.models.get(modelId);
    if (!model || model.status !== 'ready') {
      return null;
    }

    // Simulate prediction based on model type
    switch (model.type) {
      case 'regression':
        return {
          prediction: this.calculateRegressionPrediction(features),
          confidence: model.accuracy,
        };
      case 'classification':
        return {
          prediction: this.calculateClassificationPrediction(features),
          confidence: model.accuracy,
        };
      case 'anomaly_detection':
        return {
          isAnomaly: this.detectAnomaly(features),
          confidence: model.accuracy,
        };
      case 'clustering':
        return {
          cluster: this.assignCluster(features),
          confidence: model.accuracy,
        };
      default:
        return null;
    }
  }

  private calculateRegressionPrediction(features: Record<string, number>): number {
    // Simplified regression simulation
    const values = Object.values(features);
    return values.reduce((a, b) => a + b, 0) / values.length;
  }

  private calculateClassificationPrediction(features: Record<string, number>): number {
    // Simplified classification simulation
    const sum = Object.values(features).reduce((a, b) => a + b, 0);
    return sum > 50 ? 1 : 0;
  }

  private detectAnomaly(features: Record<string, number>): boolean {
    // Simplified anomaly detection
    const values = Object.values(features);
    const mean = values.reduce((a, b) => a + b, 0) / values.length;
    const variance = values.reduce((a, b) => a + Math.pow(b - mean, 2), 0) / values.length;
    return variance > 100;
  }

  private assignCluster(features: Record<string, number>): number {
    // Simplified clustering
    const sum = Object.values(features).reduce((a, b) => a + b, 0);
    return Math.floor(sum / 25) % 5;
  }

  /**
   * Get model by ID
   */
  getModel(modelId: string): LearningModel | undefined {
    return this.models.get(modelId);
  }

  /**
   * Get all models
   */
  getAllModels(): LearningModel[] {
    return Array.from(this.models.values());
  }

  /**
   * Retrain all models with latest data
   */
  retrainAllModels(): void {
    this.models.forEach((model, id) => {
      this.trainModel(id, this.trainingData);
    });
  }

  /**
   * Get model performance metrics
   */
  getModelMetrics(modelId: string): Record<string, number> | null {
    const model = this.models.get(modelId);
    if (!model) return null;

    return {
      accuracy: model.accuracy,
      lastTrainedDaysAgo: Math.floor((Date.now() - new Date(model.lastTrainedAt).getTime()) / (1000 * 60 * 60 * 24)),
      featureCount: model.features.length,
    };
  }
}
