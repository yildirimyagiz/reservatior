export interface OperationsOSMetrics {
  totalTasks: number;
  completedTasks: number;
  pendingTasks: number;
  totalWorkflows: number;
  averageCompletionTime: number;
}

export const OperationsOSMetricDefinitions: Record<string, any> = {
  total_tasks: { name: 'Total Tasks', unit: 'count', category: 'task' },
  completed_tasks: { name: 'Completed Tasks', unit: 'count', category: 'task' },
  total_workflows: { name: 'Total Workflows', unit: 'count', category: 'workflow' },
  average_completion_time: { name: 'Average Completion Time', unit: 'minutes', category: 'performance' },
};

export class OperationsOSMetricsCollector {
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
