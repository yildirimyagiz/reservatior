import { getLocalizationHeaders } from './localization-helper';

export interface RevenueIntelligenceStats {
  totalRevenue: number;
  netOperatingIncome: number;
  yieldArbitrage: number;
  revenueAttribution: number;
  avgOccupancy: number;
  revenueGrowth: number;
  predictedRevenue: number;
  optimizationPotential: number;
}

export interface RevenueStream {
  name: string;
  value: number;
  trend: string;
  color: string;
}

export interface OptimizationOpportunity {
  name: string;
  potential: string;
  impact: string;
  effort: string;
}

export interface PredictiveInsight {
  metric: string;
  predicted: string;
  confidence: number;
  trend: string;
}

const MOCK_STATS: RevenueIntelligenceStats = {
  totalRevenue: 1450000,
  netOperatingIncome: 980000,
  yieldArbitrage: 14.8,
  revenueAttribution: 320000,
  avgOccupancy: 86.5,
  revenueGrowth: 18.2,
  predictedRevenue: 1680000,
  optimizationPotential: 125000,
};

const MOCK_STREAMS: RevenueStream[] = [
  { name: "Uzun Dönem Kira", value: 850000, trend: "+12%", color: "bg-blue-500" },
  { name: "Kısa Dönem & Airbnb", value: 380000, trend: "+24%", color: "bg-purple-500" },
  { name: "FinTek & Komisyon", value: 140000, trend: "+18%", color: "bg-blue-500" },
  { name: "Sigorta & ReosCare", value: 80000, trend: "+30%", color: "bg-orange-500" },
];

const MOCK_OPPORTUNITIES: OptimizationOpportunity[] = [
  { name: "Dinamik Sezonluk Fiyatlandırma", potential: "₺45.000 / ay", impact: "Yüksek", effort: "Düşük" },
  { name: "Taksitli Depozito Koruması Satışı", potential: "₺32.000 / ay", impact: "Orta", effort: "Düşük" },
  { name: "ROAS Reklam Arbitrajı", potential: "₺28.000 / ay", impact: "Yüksek", effort: "Orta" },
];

const MOCK_PREDICTIONS: PredictiveInsight[] = [
  { metric: "Q3 Toplam Gelir Tahmini", predicted: "₺1.68M", confidence: 94, trend: "up" },
  { metric: "Gelecek Ay Doluluk Oranı", predicted: "89.2%", confidence: 91, trend: "up" },
  { metric: "Tahmini Müşteri Yaşam Boyu Değeri (LTV)", predicted: "₺184.000", confidence: 88, trend: "up" },
];

export const revenueIntelligenceApi = {
  getStats: async (orgId: string, timeRange: string): Promise<RevenueIntelligenceStats> => {
    try {
      const res = await fetch(`/api/v1/revenue-intelligence/dashboard?orgId=${orgId}&timeRange=${timeRange}`, {
        headers: getLocalizationHeaders(),
      });
      if (res.ok) return await res.json();
    } catch (e) {
      console.warn("[RevenueIntelligence API] Fallback to mock data:", (e as Error).message);
    }
    return MOCK_STATS;
  },

  getRevenueStreams: async (orgId: string): Promise<RevenueStream[]> => {
    try {
      const res = await fetch(`/api/v1/revenue-intelligence/streams?orgId=${orgId}`, {
        headers: getLocalizationHeaders(),
      });
      if (res.ok) return await res.json();
    } catch (e) {
      console.warn("[RevenueIntelligence API] Fallback to mock streams:", (e as Error).message);
    }
    return MOCK_STREAMS;
  },

  getOptimizationOpportunities: async (orgId: string): Promise<OptimizationOpportunity[]> => {
    try {
      const res = await fetch(`/api/v1/revenue-intelligence/opportunities?orgId=${orgId}`, {
        headers: getLocalizationHeaders(),
      });
      if (res.ok) return await res.json();
    } catch (e) {
      console.warn("[RevenueIntelligence API] Fallback to mock opportunities:", (e as Error).message);
    }
    return MOCK_OPPORTUNITIES;
  },

  getPredictiveInsights: async (orgId: string): Promise<PredictiveInsight[]> => {
    try {
      const res = await fetch(`/api/v1/revenue-intelligence/predictions?orgId=${orgId}`, {
        headers: getLocalizationHeaders(),
      });
      if (res.ok) return await res.json();
    } catch (e) {
      console.warn("[RevenueIntelligence API] Fallback to mock predictions:", (e as Error).message);
    }
    return MOCK_PREDICTIONS;
  },
};
