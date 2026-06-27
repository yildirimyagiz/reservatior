import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface AnalyticsMetrics {
  totalProperties: number;
  totalContacts: number;
  totalLeads: number;
  totalDeals: number;
  totalTasks: number;
  activeDeals: number;
  completedTasks: number;
  conversionRate: number;
  avgDealSize: number;
  totalRevenue: number;
  monthlyGrowth: number;
}

export interface ChartData {
  labels: string[];
  datasets: Array<{
    label: string;
    data: number[];
    backgroundColor?: string;
    borderColor?: string;
  }>;
}

export interface AnalyticsState {
  metrics: AnalyticsMetrics;
  loading: boolean;
  error: string | null;
  timeRange: "7days" | "30days" | "90days" | "1year";
  chartData: {
    dealsByMonth: ChartData;
    leadsBySource: ChartData;
    revenueByMonth: ChartData;
    tasksByStatus: ChartData;
    propertyTypes: ChartData;
  };
  setMetrics: (metrics: AnalyticsMetrics) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setTimeRange: (timeRange: "7days" | "30days" | "90days" | "1year") => void;
  setChartData: (chartData: Partial<AnalyticsState["chartData"]>) => void;
  refreshData: () => Promise<void>;
}

export const useAnalyticsStore = create<AnalyticsState>()(
  devtools(
    (set) => ({
      metrics: {
        totalProperties: 0,
        totalContacts: 0,
        totalLeads: 0,
        totalDeals: 0,
        totalTasks: 0,
        activeDeals: 0,
        completedTasks: 0,
        conversionRate: 0,
        avgDealSize: 0,
        totalRevenue: 0,
        monthlyGrowth: 0,
      },
      loading: false,
      error: null,
      timeRange: "30days",
      chartData: {
        dealsByMonth: { labels: [], datasets: [] },
        leadsBySource: { labels: [], datasets: [] },
        revenueByMonth: { labels: [], datasets: [] },
        tasksByStatus: { labels: [], datasets: [] },
        propertyTypes: { labels: [], datasets: [] },
      },
      setMetrics: (metrics) => set({ metrics }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setTimeRange: (timeRange) => set({ timeRange }),
      setChartData: (chartData) =>
        set((state) => ({
          chartData: { ...state.chartData, ...chartData },
        })),
      refreshData: async () => {
        set({ loading: true, error: null });
        try {
          // API calls would go here to fetch analytics data
          console.log("Refreshing analytics data...");
        } catch (error) {
          set({ error: "Failed to refresh analytics data" });
        } finally {
          set({ loading: false });
        }
      },
    }),
    { name: "analytics-store" }
  )
);
