import { apiClient } from "./client";

// Market Insight Types
export type InsightType = "PRICE_TRENDS" | "DEMAND_ANALYSIS" | "INVENTORY_LEVELS" | "MARKET_HEALTH" | "INVESTMENT_OPPORTUNITIES" | "FORECAST" | "COMPETITIVE_ANALYSIS";
export type PropertyClassification = "RESIDENTIAL" | "COMMERCIAL" | "INDUSTRIAL" | "MIXED_USE" | "LAND" | "SPECIAL_PURPOSE";
export type ImpactLevel = "POSITIVE" | "NEGATIVE" | "NEUTRAL";
export type ConfidenceLevel = "LOW" | "MEDIUM" | "HIGH" | "VERY_HIGH";

export interface MarketInsight {
  id: string;
  orgId?: string;
  title: string;
  description: string;
  insightType: InsightType;
  region: string;
  propertyClassification: PropertyClassification;
  impact: ImpactLevel;
  confidence: ConfidenceLevel;
  relevanceScore: number; // 0-100
  priority: "LOW" | "NORMAL" | "HIGH" | "URGENT";
  
  // Content
  content: {
    summary: string;
    details: string;
    keyFindings: string[];
    recommendations: string[];
    dataPoints: Array<{
      label: string;
      value: number | string;
      trend?: "UP" | "DOWN" | "STABLE";
      change?: number; // percentage change
      period?: string;
    }>;
    charts?: Array<{
      type: "LINE" | "BAR" | "PIE" | "AREA" | "SCATTER";
      title: string;
      data: any[];
      xAxis: string;
      yAxis: string;
    }>;
    visualizations?: Array<{
      type: "MAP" | "HEATMAP" | "TABLE" | "TIMELINE";
      title: string;
      data: any;
      config?: any;
    }>;
  };
  
  // Temporal Data
  validFrom: string;
  validTo?: string;
  expirationDate?: string;
  lastUpdated: string;
  nextUpdate?: string;
  
  // Source & Attribution
  source: {
    primary: string;
    secondary?: string[];
    methodology?: string;
    dataQuality: "EXCELLENT" | "GOOD" | "FAIR" | "POOR";
    reliability: number; // 0-100
    lastVerified?: string;
  };
  
  // Geographic Scope
  geography: {
    region: string;
    subregions?: string[];
    cities?: string[];
    zipCodes?: string[];
    neighborhoods?: string[];
    coordinates?: {
      latitude: number;
      longitude: number;
      radius?: number; // miles/km
    };
  };
  
  // Property Scope
  propertyScope: {
    propertyTypes?: string[];
    priceRange?: {
      min: number;
      max: number;
    };
    sizeRange?: {
      min: number;
      max: number;
    };
    bedrooms?: number[];
    bathrooms?: number[];
    features?: string[];
    ageRange?: {
      min: number;
      max: number;
    };
  };
  
  // Metrics & KPIs
  metrics: {
    marketHealth: number; // 0-100
    priceGrowth: number; // percentage
    inventoryLevel: number; // percentage
    demandIndex: number; // 0-100
    averageDaysOnMarket: number;
    pricePerSqFt: number;
    inventoryTurnover: number;
    absorptionRate: number;
    vacancyRate: number;
    rentalYield?: number;
    capRate?: number;
  };
  
  // Forecast
  forecast?: {
    period: string; // "1M", "3M", "6M", "1Y", "3Y", "5Y"
    pricePrediction: number; // percentage change
    confidence: number; // 0-100
    factors: Array<{
      factor: string;
      weight: number; // 0-1
      impact: "POSITIVE" | "NEGATIVE" | "NEUTRAL";
    }>;
    scenarios?: Array<{
      name: string;
      probability: number;
      outcome: number;
      description: string;
    }>;
  };
  
  // Engagement & Distribution
  engagement: {
    views: number;
    shares: number;
    downloads: number;
    bookmarks: number;
    averageRating: number;
    totalRatings: number;
    comments: Array<{
      id: string;
      userId: string;
      userName: string;
      content: string;
      rating: number;
      createdAt: string;
    }>;
  };
  
  // AI Analysis
  aiAnalysis: {
    sentiment: "POSITIVE" | "NEGATIVE" | "NEUTRAL";
    keyTopics: string[];
    entities: Array<{
      name: string;
      type: "PERSON" | "ORGANIZATION" | "LOCATION" | "EVENT" | "CONCEPT";
      confidence: number;
    }>;
    summary: string;
    insights: string[];
    riskFactors: Array<{
      factor: string;
      level: "LOW" | "MEDIUM" | "HIGH";
      description: string;
    }>;
  };
  
  // Tags & Categorization
  tags: string[];
  categories: string[];
  keywords: string[];
  
  // Status & Lifecycle
  status: "DRAFT" | "PENDING_REVIEW" | "APPROVED" | "PUBLISHED" | "ARCHIVED" | "EXPIRED";
  isActive: boolean;
  isPublic: boolean;
  isPremium: boolean;
  
  // Permissions
  permissions: {
    canView: string[];
    canEdit: string[];
    canShare: string[];
    canExport: string[];
  };
  
  // Metadata
  metadata?: Record<string, any>;
  createdAt: string;
  updatedAt: string;
  
  // Relations
  organization?: {
    id: string;
    name: string;
    type: string;
  };
  author?: {
    id: string;
    name: string;
    email: string;
    role: string;
  };
  relatedInsights?: Array<{
    id: string;
    title: string;
    insightType: InsightType;
    relevanceScore: number;
  }>;
}

export const marketInsightsApi = {
  // Basic CRUD
  getAll: async (params?: { 
    page?: number; 
    limit?: number; 
    region?: string; 
    propertyType?: PropertyClassification; 
    insightType?: InsightType; 
    impact?: ImpactLevel;
    confidence?: ConfidenceLevel;
    priority?: string;
    status?: string;
    isActive?: boolean;
    startDate?: string;
    endDate?: string;
    orgId?: string;
    search?: string;
  }) => {
    return await apiClient.get("/market-insights", { params });
  },
  
  getById: async (id: string): Promise<MarketInsight> => {
    return await apiClient.get(`/market-insights/${id}`);
  },
  
  create: async (data: Partial<MarketInsight>): Promise<MarketInsight> => {
    return await apiClient.post("/market-insights", data);
  },
  
  update: async (id: string, data: Partial<MarketInsight>): Promise<MarketInsight> => {
    return await apiClient.put(`/market-insights/${id}`, data);
  },
  
  delete: async (id: string): Promise<void> => {
    await apiClient.delete(`/market-insights/${id}`);
  },

  // Geographic & Regional
  getByRegion: async (region: string, params?: {
    subregions?: string[];
    propertyType?: PropertyClassification;
    insightType?: InsightType;
    startDate?: string;
    endDate?: string;
  }): Promise<{
    insights: MarketInsight[];
    region: {
      name: string;
      totalInsights: number;
      averageRelevance: number;
      topInsightTypes: Array<{
        type: InsightType;
        count: number;
      }>;
    };
  }> => {
    return await apiClient.get(`/market-insights/regions/${region}`, { params });
  },
  
  getByType: async (insightType: InsightType, params?: {
    region?: string;
    propertyType?: PropertyClassification;
    impact?: ImpactLevel;
    confidence?: ConfidenceLevel;
    page?: number;
    limit?: number;
  }): Promise<{
    insights: MarketInsight[];
    type: {
      name: InsightType;
      totalInsights: number;
      averageConfidence: number;
      impactDistribution: Record<ImpactLevel, number>;
    };
  }> => {
    return await apiClient.get(`/market-insights/types/${insightType}`, { params });
  },

  // Summary & Aggregations
  getSummary: async (params?: {
    region?: string;
    propertyType?: PropertyClassification;
    dateRange?: {
      start: string;
      end: string;
    };
    orgId?: string;
  }): Promise<{
    totalInsights: number;
    activeInsights: number;
    averageRelevance: number;
    topRegions: Array<{
      region: string;
      insightCount: number;
      avgRelevance: number;
    }>;
    topInsightTypes: Array<{
      type: InsightType;
      count: number;
      avgConfidence: number;
    }>;
    impactDistribution: Record<ImpactLevel, number>;
    recentTrends: Array<{
      date: string;
      insightCount: number;
      avgRelevance: number;
    }>;
    marketHealth: {
      overall: number;
      trend: "IMPROVING" | "DECLINING" | "STABLE";
      keyMetrics: Record<string, number>;
    };
  }> => {
    return await apiClient.get("/market-insights/summary", { params });
  },
  
  getTrending: async (params?: {
    region?: string;
    propertyType?: PropertyClassification;
    period?: "DAILY" | "WEEKLY" | "MONTHLY";
    limit?: number;
  }): Promise<{
    insights: MarketInsight[];
    trends: Array<{
      topic: string;
      momentum: number;
      mentions: number;
      sentiment: "POSITIVE" | "NEGATIVE" | "NEUTRAL";
    }>;
    keywords: Array<{
      term: string;
      frequency: number;
      growth: number;
    }>;
  }> => {
    return await apiClient.get("/market-insights/trending", { params });
  },

  // Relevance & Ranking
  boost: async (id: string, data: {
    reason: string;
    boostAmount?: number;
    duration?: string;
  }): Promise<MarketInsight> => {
    return await apiClient.post(`/market-insights/${id}/boost`, data);
  },
  
  archive: async (id: string, reason?: string): Promise<MarketInsight> => {
    return await apiClient.post(`/market-insights/${id}/archive`, { reason });
  },
  
  getRelevanceFactors: async (id: string): Promise<{
    factors: Array<{
      factor: string;
      weight: number;
      value: number;
      description: string;
    }>;
    overallScore: number;
    recommendations: string[];
  }> => {
    return await apiClient.get(`/market-insights/${id}/relevance`);
  },

  // Search & Discovery
  search: async (query: string, filters?: {
    region?: string;
    propertyType?: PropertyClassification;
    insightType?: InsightType;
    impact?: ImpactLevel;
    confidence?: ConfidenceLevel;
    dateRange?: {
      start: string;
      end: string;
    };
    tags?: string[];
  }): Promise<{
    insights: MarketInsight[];
    total: number;
    suggestions?: string[];
    filters: {
      applied: Record<string, any>;
      available: Record<string, any[]>;
    };
  }> => {
    return await apiClient.get("/market-insights/search", { 
      params: { query, ...filters } 
    });
  },
  
  getRecommendations: async (params?: {
    userId?: string;
    orgId?: string;
    region?: string;
    propertyType?: PropertyClassification;
    interests?: string[];
    limit?: number;
  }): Promise<{
    insights: MarketInsight[];
    reasoning: Array<{
      insightId: string;
      reasons: string[];
      confidence: number;
    }>;
  }> => {
    return await apiClient.get("/market-insights/recommendations", { params });
  },

  // Data & Analytics
  getAnalytics: async (params?: {
    region?: string;
    propertyType?: PropertyClassification;
    insightType?: InsightType;
    dateRange?: {
      start: string;
      end: string;
    };
    granularity?: "DAILY" | "WEEKLY" | "MONTHLY" | "QUARTERLY";
  }): Promise<{
    insights: {
      total: number;
      byType: Record<InsightType, number>;
      byImpact: Record<ImpactLevel, number>;
      byConfidence: Record<ConfidenceLevel, number>;
    };
    trends: Array<{
      date: string;
      count: number;
      avgRelevance: number;
      avgConfidence: number;
    }>;
    performance: {
      averageRelevance: number;
      averageConfidence: number;
      engagementRate: number;
      shareRate: number;
    };
    geography: Array<{
      region: string;
      count: number;
      avgRelevance: number;
    }>;
  }> => {
    return await apiClient.get("/market-insights/analytics", { params });
  },
  
  getMetrics: async (id: string): Promise<{
    views: number;
    shares: number;
    downloads: number;
    bookmarks: number;
    averageRating: number;
    totalRatings: number;
    engagement: {
      rate: number;
      trend: "UP" | "DOWN" | "STABLE";
    };
    performance: {
      relevanceScore: number;
      confidenceScore: number;
      accuracy: number;
    };
  }> => {
    return await apiClient.get(`/market-insights/${id}/metrics`);
  },

  // Export & Sharing
  export: async (params: {
    format: "CSV" | "EXCEL" | "PDF" | "JSON";
    filters?: {
      region?: string;
      propertyType?: PropertyClassification;
      insightType?: InsightType;
      startDate?: string;
      endDate?: string;
    };
    fields?: string[];
    includeCharts?: boolean;
    includeVisualizations?: boolean;
  }): Promise<Blob> => {
    const response = await fetch(`${apiClient['baseURL']}/market-insights/export`, {
      method: 'POST',
      headers: {
        'Authorization': `Bearer ${localStorage.getItem("auth_token")}`,
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(params)
    });
    
    if (!response.ok) {
      throw new Error(`HTTP error! status: ${response.status}`);
    }
    
    return await response.blob();
  },
  
  share: async (id: string, data: {
    method: "EMAIL" | "LINK" | "SOCIAL";
    recipients?: string[];
    message?: string;
    expiresIn?: string;
    permissions?: {
      canView: boolean;
      canDownload: boolean;
      canShare: boolean;
    };
  }): Promise<{
    shareId: string;
    shareUrl?: string;
    expiresAt?: string;
    message?: string;
  }> => {
    return await apiClient.post(`/market-insights/${id}/share`, data);
  },
  
  getSharedInsight: async (shareId: string): Promise<{
    insight: Partial<MarketInsight>;
    permissions: {
      canView: boolean;
      canDownload: boolean;
      canShare: boolean;
    };
    expiresAt?: string;
  }> => {
    return await apiClient.get(`/market-insights/shared/${shareId}`);
  },

  // Subscriptions & Notifications
  subscribe: async (data: {
    region?: string;
    propertyType?: PropertyClassification;
    insightTypes?: InsightType[];
    impact?: ImpactLevel;
    confidence?: ConfidenceLevel;
    frequency: "REAL_TIME" | "DAILY" | "WEEKLY" | "MONTHLY";
    deliveryMethod: "EMAIL" | "PUSH" | "WEBHOOK";
    webhookUrl?: string;
  }): Promise<any> => {
    return await apiClient.post("/market-insights/subscribe", data);
  },
  
  unsubscribe: async (subscriptionId: string): Promise<void> => {
    await apiClient.delete(`/market-insights/subscribe/${subscriptionId}`);
  },
  
  getSubscriptions: async (params?: { status?: string }): Promise<any[]> => {
    return await apiClient.get("/market-insights/subscriptions", { params });
  },

  // AI & Automation
  generateInsight: async (data: {
    region: string;
    propertyType?: PropertyClassification;
    insightType?: InsightType;
    dataSources?: string[];
    parameters?: Record<string, any>;
  }): Promise<{
    insight: Partial<MarketInsight>;
    confidence: number;
    processingTime: number;
    dataPoints: number;
  }> => {
    return await apiClient.post("/market-insights/generate", data);
  },
  
  validateInsight: async (id: string): Promise<{
    isValid: boolean;
    issues: Array<{
      type: "ERROR" | "WARNING" | "INFO";
      message: string;
      field?: string;
    }>;
    recommendations: string[];
  }> => {
    return await apiClient.post(`/market-insights/${id}/validate`);
  },
  
  getInsightExplainability: async (id: string): Promise<{
    explanation: string;
    factors: Array<{
      factor: string;
      importance: number;
      contribution: string;
    }>;
    methodology: string;
    limitations: string[];
  }> => {
    return await apiClient.get(`/market-insights/${id}/explain`);
  },
};
