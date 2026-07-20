export interface AIOSMetrics {
  totalModels: number;
  activeModels: number;
  predictionsMade: number;
  modelAccuracy: number;
  trainingTime: number;
  insightCount: number;
}

export const AIOSMetricDefinitions: Record<string, any> = {
  total_models: { name: 'Total Models', unit: 'count', category: 'model' },
  active_models: { name: 'Active Models', unit: 'count', category: 'model' },
  predictions_made: { name: 'Predictions Made', unit: 'count', category: 'prediction' },
  model_accuracy: { name: 'Model Accuracy', unit: 'percentage', category: 'model' },
};

export class AIOSMetricsCollector {
  private metrics = new Map<string, number>();
  
  recordMetric(name: string, value: number): void {
    this.metrics.set(name, value);
  }
  
  getMetric(name: string): number | undefined {
    return this.metrics.get(name);
  }
  
  getAllMetrics(): Record<string, number> {
    return Object.fromEntries(this.metrics);
  }
}
