import { getLocalizationHeaders } from './localization-helper';

export interface AILearningStats {
  totalIterations: number;
  accuracyImprovement: number;
  modelVersion: number;
  lastRetrained: string;
  predictionAccuracy: number;
  learningRate: number;
}

export interface LearningLoop {
  id: string;
  name: string;
  status: string;
  accuracy: number;
  iterations: number;
  lastUpdate: string;
}

export interface LearningMetric {
  metric: string;
  current: number;
  target: number;
  progress: number;
  trend: string;
}

export interface RecentImprovement {
  loop: string;
  improvement: string;
  metric: string;
  date: string;
}

export const aiLearningApi = {
  getStats: async (orgId: string, loop: string): Promise<AILearningStats> => {
    const res = await fetch(`/api/v1/ai-learning/dashboard?orgId=${orgId}&loop=${loop}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to fetch AI learning stats');
    return res.json();
  },

  getLoops: async (orgId: string): Promise<LearningLoop[]> => {
    const res = await fetch(`/api/v1/ai-learning/loops?orgId=${orgId}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to fetch learning loops');
    return res.json();
  },

  getMetrics: async (orgId: string): Promise<LearningMetric[]> => {
    const res = await fetch(`/api/v1/ai-learning/metrics?orgId=${orgId}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to fetch learning metrics');
    return res.json();
  },

  getImprovements: async (orgId: string): Promise<RecentImprovement[]> => {
    const res = await fetch(`/api/v1/ai-learning/improvements?orgId=${orgId}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to fetch recent improvements');
    return res.json();
  },

  retrainModels: async (orgId: string): Promise<{ success: boolean; message: string }> => {
    const res = await fetch(`/api/v1/ai-learning/retrain?orgId=${orgId}`, {
      method: 'POST',
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to retrain models');
    return res.json();
  },
};
