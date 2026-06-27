import { create } from 'zustand';
import { devtools } from 'zustand/middleware';

export interface AIModel {
  id: string;
  name: string;
  type: string;
  status: "active" | "training" | "inactive";
  accuracy: string;
  lastTrained: string;
  predictions: string;
  createdAt: string;
  updatedAt: string;
}

export interface AIInsight {
  id: string;
  insight: string;
  confidence: string;
  category: string;
  createdAt: string;
}

export interface AIMetric {
  metric: string;
  current: string;
  target: string;
  status: "excellent" | "good" | "warning" | "critical";
}

interface AIDashboardState {
  // State
  models: AIModel[];
  insights: AIInsight[];
  metrics: AIMetric[];
  loading: boolean;
  error: string | null;
  
  // Dashboard Stats
  totalModels: number;
  totalPredictions: number;
  averageAccuracy: string;
  averageProcessingTime: string;
  
  // Actions
  fetchDashboard: () => Promise<void>;
  fetchModels: () => Promise<void>;
  fetchInsights: () => Promise<void>;
  fetchMetrics: () => Promise<void>;
  trainModel: (modelId: string) => Promise<void>;
  updateModelStatus: (modelId: string, status: string) => void;
  clearError: () => void;
  reset: () => void;
}

export const useAIDashboardStore = create<AIDashboardState>()(
  devtools(
    (set) => ({
      // Initial State
      models: [],
      insights: [],
      metrics: [],
      loading: false,
      error: null,
      totalModels: 0,
      totalPredictions: 0,
      averageAccuracy: "0%",
      averageProcessingTime: "0s",
      
      // Actions
      fetchDashboard: async () => {
        set({ loading: true, error: null });
        try {
          // Mock API call - replace with actual API
          const mockData = {
            models: [
              {
                id: "1",
                name: "Property Valuation Model",
                type: "Regression",
                status: "active" as const,
                accuracy: "97.2%",
                lastTrained: "2 days ago",
                predictions: "12,543",
                createdAt: new Date().toISOString(),
                updatedAt: new Date().toISOString(),
              }
            ],
            insights: [
              {
                id: "1",
                insight: "Property prices expected to increase 8% in Q3",
                confidence: "92%",
                category: "market",
                createdAt: new Date().toISOString(),
              }
            ],
            metrics: [
              {
                metric: "Response Time",
                current: "2.3s",
                target: "2.0s",
                status: "good" as const,
              }
            ],
            totalModels: 12,
            totalPredictions: 8543,
            averageAccuracy: "94.2%",
            averageProcessingTime: "2.3s",
          };
          
          set({
            ...mockData,
            loading: false,
          });
        } catch (error) {
          set({ 
            error: error instanceof Error ? error.message : 'Failed to fetch dashboard',
            loading: false 
          });
        }
      },
      
      fetchModels: async () => {
        set({ loading: true, error: null });
        try {
          // Mock API call
          const mockModels: AIModel[] = [
            {
              id: "1",
              name: "Property Valuation Model",
              type: "Regression",
              status: "active",
              accuracy: "97.2%",
              lastTrained: "2 days ago",
              predictions: "12,543",
              createdAt: new Date().toISOString(),
              updatedAt: new Date().toISOString(),
            }
          ];
          
          set({ models: mockModels, loading: false });
        } catch (error) {
          set({ 
            error: error instanceof Error ? error.message : 'Failed to fetch models',
            loading: false 
          });
        }
      },
      
      fetchInsights: async () => {
        set({ loading: true, error: null });
        try {
          // Mock API call
          const mockInsights: AIInsight[] = [
            {
              id: "1",
              insight: "Property prices expected to increase 8% in Q3",
              confidence: "92%",
              category: "market",
              createdAt: new Date().toISOString(),
            }
          ];
          
          set({ insights: mockInsights, loading: false });
        } catch (error) {
          set({ 
            error: error instanceof Error ? error.message : 'Failed to fetch insights',
            loading: false 
          });
        }
      },
      
      fetchMetrics: async () => {
        set({ loading: true, error: null });
        try {
          // Mock API call
          const mockMetrics: AIMetric[] = [
            {
              metric: "Response Time",
              current: "2.3s",
              target: "2.0s",
              status: "good",
            }
          ];
          
          set({ metrics: mockMetrics, loading: false });
        } catch (error) {
          set({ 
            error: error instanceof Error ? error.message : 'Failed to fetch metrics',
            loading: false 
          });
        }
      },
      
      trainModel: async (modelId: string) => {
        set({ loading: true, error: null });
        try {
          // Mock API call
          await new Promise(resolve => setTimeout(resolve, 2000));
          
          // Update model status to training
          set(state => ({
            models: state.models.map(model =>
              model.id === modelId 
                ? { ...model, status: "training" as const }
                : model
            ),
            loading: false,
          }));
        } catch (error) {
          set({ 
            error: error instanceof Error ? error.message : 'Failed to train model',
            loading: false 
          });
        }
      },
      
      updateModelStatus: (modelId: string, status: string) => {
        set(state => ({
          models: state.models.map(model =>
            model.id === modelId 
              ? { ...model, status: status as any }
              : model
          ),
        }));
      },
      
      clearError: () => set({ error: null }),
      
      reset: () => set({
        models: [],
        insights: [],
        metrics: [],
        loading: false,
        error: null,
        totalModels: 0,
        totalPredictions: 0,
        averageAccuracy: "0%",
        averageProcessingTime: "0s",
      }),
    }),
    {
      name: 'ai-dashboard-store',
    }
  )
);
