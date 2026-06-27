import { apiClient } from "./client";

export interface Analysis {
  id: string;
  orgId: string;
  propertyId?: string;
  userId?: string;
  agentId?: string;
  type: "PROPERTY_VALUATION" | "MARKET_ANALYSIS" | "COMPARATIVE_ANALYSIS" | "INVESTMENT_ANALYSIS" | "RENTAL_ANALYSIS" | "NEIGHBORHOOD_ANALYSIS" | "RISK_ASSESSMENT" | "PERFORMANCE_ANALYSIS" | "CUSTOM";
  title: string;
  description?: string;
  status: "PENDING" | "PROCESSING" | "COMPLETED" | "FAILED" | "CANCELLED";
  parameters: {
    propertyId?: string;
    analysisType: string;
    filters?: Record<string, any>;
    options?: Record<string, any>;
    includeComparable?: boolean;
    dateRange?: {
      startDate?: string;
      endDate?: string;
    };
  };
  results: {
    summary?: {
      estimatedValue?: number;
      marketValue?: number;
      rentalValue?: number;
      pricePerSqr?: number;
      comparableCount?: number;
      confidence?: number;
    };
    details?: Array<{
      category: string;
      item: string;
      value: any;
      unit?: string;
      description?: string;
    }>;
    charts?: Array<{
      type: string;
      title: string;
      data: any[];
      config?: Record<string, any>;
    }>;
    recommendations?: Array<{
      type: string;
      priority: "HIGH" | "MEDIUM" | "LOW";
      description: string;
      impact?: string;
    }>;
    comparableProperties?: Array<{
      id: string;
      address: string;
      price: number;
      size: number;
      bedrooms: number;
      bathrooms: number;
      distance: number;
      similarity: number;
    }>;
  };
  metadata: {
    processingTime: number;
    dataSource: string;
    modelVersion: string;
    confidence: number;
    lastUpdated: string;
  };
  createdAt: string;
  updatedAt: string;
  completedAt?: string;
  property?: {
    id: string;
    title: string;
    address: string;
  };
  user?: {
    id: string;
    firstName: string;
    lastName: string;
    email: string;
  };
  agent?: {
    id: string;
    firstName: string;
    lastName: string;
    email: string;
  };
}

export const analysisApi = {
  // Get all analyses
  getAll: async (orgId: string): Promise<Analysis[]> => {
    const response = await apiClient.get<Analysis[]>(`/organizations/${orgId}/analysis`);
    return response;
  },

  // Get analysis by ID
  getById: async (orgId: string, id: string): Promise<Analysis> => {
    const response = await apiClient.get<Analysis>(`/organizations/${orgId}/analysis/${id}`);
    return response;
  },

  // Create new analysis
  create: async (orgId: string, data: Omit<Analysis, 'id' | 'createdAt' | 'updatedAt' | 'results' | 'metadata' | 'completedAt' | 'property' | 'user' | 'agent'>): Promise<Analysis> => {
    const response = await apiClient.post<Analysis>(`/organizations/${orgId}/analysis`, data);
    return response;
  },

  // Update analysis
  update: async (orgId: string, id: string, data: Partial<Analysis>): Promise<Analysis> => {
    const response = await apiClient.put<Analysis>(`/organizations/${orgId}/analysis/${id}`, data);
    return response;
  },

  // Delete analysis
  delete: async (orgId: string, id: string): Promise<void> => {
    await apiClient.delete(`/organizations/${orgId}/analysis/${id}`);
  },

  // Get analyses by property
  getByProperty: async (orgId: string, propertyId: string): Promise<Analysis[]> => {
    const response = await apiClient.get<Analysis[]>(`/organizations/${orgId}/properties/${propertyId}/analysis`);
    return response;
  },

  // Get analyses by user
  getByUser: async (orgId: string, userId: string): Promise<Analysis[]> => {
    const response = await apiClient.get<Analysis[]>(`/organizations/${orgId}/users/${userId}/analysis`);
    return response;
  },

  // Get analyses by agent
  getByAgent: async (orgId: string, agentId: string): Promise<Analysis[]> => {
    const response = await apiClient.get<Analysis[]>(`/organizations/${orgId}/agents/${agentId}/analysis`);
    return response;
  },

  // Update analysis status
  updateStatus: async (orgId: string, id: string, status: Analysis['status']): Promise<Analysis> => {
    const response = await apiClient.patch<Analysis>(`/organizations/${orgId}/analysis/${id}/status`, { status });
    return response;
  },

  // Start analysis processing
  startProcessing: async (orgId: string, id: string): Promise<Analysis> => {
    const response = await apiClient.post<Analysis>(`/organizations/${orgId}/analysis/${id}/start`);
    return response;
  },

  // Cancel analysis
  cancel: async (orgId: string, id: string, data: {
    reason: string;
    notes?: string;
  }): Promise<Analysis> => {
    const response = await apiClient.patch<Analysis>(`/organizations/${orgId}/analysis/${id}/cancel`, data);
    return response;
  },

  // Get analysis results
  getResults: async (orgId: string, id: string): Promise<Analysis['results']> => {
    const response = await apiClient.get<Analysis['results']>(`/organizations/${orgId}/analysis/${id}/results`);
    return response;
  },

  // Generate analysis report
  generateReport: async (orgId: string, id: string, options: {
    format: "PDF" | "EXCEL" | "CSV" | "JSON";
    includeCharts?: boolean;
    includeRecommendations?: boolean;
    includeComparables?: boolean;
    includeDetails?: boolean;
  }): Promise<Blob> => {
    const response = await apiClient.post<Blob>(`/organizations/${orgId}/analysis/${id}/report`, options, {
      responseType: 'blob'
    });
    return response;
  },

  // Get analysis templates
  getTemplates: async (orgId: string): Promise<Array<{
    id: string;
    name: string;
    description: string;
    type: Analysis['type'];
    parameters: Analysis['parameters'];
    isPublic: boolean;
    usageCount: number;
  }>> => {
    const response = await apiClient.get<Array<{
    id: string;
    name: string;
    description: string;
    type: Analysis['type'];
    parameters: Analysis['parameters'];
    isPublic: boolean;
    usageCount: number;
  }>>(`/organizations/${orgId}/analysis/templates`);
    return response;
  },

  // Create analysis from template
  createFromTemplate: async (orgId: string, templateId: string, data: {
    name: string;
    description?: string;
    propertyId?: string;
    userId?: string;
    agentId?: string;
    overrideParameters?: Record<string, any>;
  }): Promise<Analysis> => {
    const response = await apiClient.post<Analysis>(`/organizations/${orgId}/analysis/from-template`, { templateId, ...data });
    return response;
  },

  // Get analysis statistics
  getStatistics: async (orgId: string): Promise<{
    total: number;
    pending: number;
    processing: number;
    completed: number;
    failed: number;
    cancelled: number;
    averageProcessingTime: number;
    byType: Record<string, number>;
    byUser: Array<{
      userId?: string;
      agentId?: string;
      name: string;
      analysisCount: number;
      successRate: number;
    }>;
    byProperty: Array<{
      propertyId: string;
      address: string;
      analysisCount: number;
      averageValue: number;
    }>;
  }> => {
    const response = await apiClient.get<{
    total: number;
    pending: number;
    processing: number;
    completed: number;
    failed: number;
    cancelled: number;
    averageProcessingTime: number;
    byType: Record<string, number>;
    byUser: Array<{
      userId?: string;
      agentId?: string;
      name: string;
      analysisCount: number;
      successRate: number;
    }>;
    byProperty: Array<{
      propertyId: string;
      address: string;
      analysisCount: number;
      averageValue: number;
    }>;
  }>(`/organizations/${orgId}/analysis/statistics`);
    return response;
  },

  // Batch analysis
  batchAnalyze: async (orgId: string, data: {
    propertyIds: string[];
    analysisType: Analysis['type'];
    options?: Record<string, any>;
    priority?: "NORMAL" | "HIGH" | "LOW";
  }): Promise<Analysis[]> => {
    const response = await apiClient.post<Analysis[]>(`/organizations/${orgId}/analysis/batch`, data);
    return response;
  },

  // Get supported analysis types
  getSupportedTypes: async (): Promise<Array<{
    type: string;
    name: string;
    description: string;
    parameters: Array<{
      name: string;
      type: string;
      required: boolean;
      description: string;
      defaultValue?: any;
    }>;
    pricing?: {
      cost: number;
      unit: string;
    };
  }>> => {
    const response = await apiClient.get<Array<{
    type: string;
    name: string;
    description: string;
    parameters: Array<{
      name: string;
      type: string;
      required: boolean;
      description: string;
      defaultValue?: any;
    }>;
    pricing?: {
      cost: number;
      unit: string;
    };
  }>>(`/organizations/current/analysis/supported-types`);
    return response;
  },
};
