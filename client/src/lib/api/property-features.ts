import { apiClient } from "./client";

export interface PropertyFeature {
  id: string;
  orgId: string;
  propertyId: string;
  name: string;
  type: "INTERIOR" | "EXTERIOR" | "AMENITY" | "UTILITY" | "SAFETY" | "TECHNOLOGY" | "OUTDOOR_SPACE" | "PARKING" | "OTHER";
  category: string;
  description?: string;
  value?: string;
  quantity?: number;
  unit?: string;
  isAvailable: boolean;
  isPremium: boolean;
  icon?: string;
  images?: string[];
  specifications?: Record<string, any>;
  createdAt: string;
  updatedAt: string;
  property?: {
    id: string;
    title: string;
    address: string;
  };
}

export const propertyFeaturesApi = {
  // Get all property features
  getAll: async (orgId: string): Promise<PropertyFeature[]> => {
    return await apiClient.get(`/organizations/${orgId}/property-features`);
    
  },

  // Get property features by property
  getByProperty: async (orgId: string, propertyId: string): Promise<PropertyFeature[]> => {
    return await apiClient.get(`/organizations/${orgId}/properties/${propertyId}/features`);
    
  },

  // Get property feature by ID
  getById: async (orgId: string, id: string): Promise<PropertyFeature> => {
    return await apiClient.get(`/organizations/${orgId}/property-features/${id}`);
    
  },

  // Create new property feature
  create: async (orgId: string, data: Omit<PropertyFeature, 'id' | 'createdAt' | 'updatedAt' | 'property'>): Promise<PropertyFeature> => {
    return await apiClient.post(`/organizations/${orgId}/property-features`, data);
    
  },

  // Update property feature
  update: async (orgId: string, id: string, data: Partial<PropertyFeature>): Promise<PropertyFeature> => {
    return await apiClient.put(`/organizations/${orgId}/property-features/${id}`, data);
    
  },

  // Delete property feature
  delete: async (orgId: string, id: string): Promise<void> => {
    await apiClient.delete(`/organizations/${orgId}/property-features/${id}`);
  },

  // Update feature availability
  updateAvailability: async (orgId: string, id: string, isAvailable: boolean): Promise<PropertyFeature> => {
    return await apiClient.patch(`/organizations/${orgId}/property-features/${id}/availability`, { isAvailable });
    
  },

  // Get features by type
  getByType: async (orgId: string, type: PropertyFeature['type']): Promise<PropertyFeature[]> => {
    return await apiClient.get(`/organizations/${orgId}/property-features`, {
      params: { type }
    });
    
  },

  // Get features by category
  getByCategory: async (orgId: string, category: string): Promise<PropertyFeature[]> => {
    return await apiClient.get(`/organizations/${orgId}/property-features`, {
      params: { category }
    });
    
  },

  // Search features
  search: async (orgId: string, query: string, filters?: {
    propertyId?: string;
    type?: PropertyFeature['type'];
    category?: string;
    isAvailable?: boolean;
    isPremium?: boolean;
  }): Promise<PropertyFeature[]> => {
    return await apiClient.get(`/organizations/${orgId}/property-features/search`, {
      params: { query, ...filters }
    });
    
  },

  // Get feature categories
  getCategories: async (orgId: string): Promise<string[]> => {
    return await apiClient.get(`/organizations/${orgId}/property-features/categories`);
    
  },

  // Get feature types
  getTypes: async (orgId: string): Promise<PropertyFeature['type'][]> => {
    return await apiClient.get(`/organizations/${orgId}/property-features/types`);
    
  },

  // Bulk add features to property
  bulkAdd: async (orgId: string, propertyId: string, featureIds: string[]): Promise<PropertyFeature[]> => {
    return await apiClient.post(`/organizations/${orgId}/properties/${propertyId}/features/bulk`, { featureIds });
    
  },

  // Remove feature from property
  removeFromProperty: async (orgId: string, propertyId: string, featureId: string): Promise<void> => {
    await apiClient.delete(`/organizations/${orgId}/properties/${propertyId}/features/${featureId}`);
  },

  // Get feature statistics
  getStatistics: async (orgId: string, filters?: {
    propertyId?: string;
    type?: PropertyFeature['type'];
    category?: string;
    isAvailable?: boolean;
    isPremium?: boolean;
  }): Promise<{
    total: number;
    available: number;
    unavailable: number;
    premium: number;
    standard: number;
    byType: Record<string, number>;
    byCategory: Record<string, number>;
    mostCommonFeatures: Array<{
      name: string;
      count: number;
      percentage: number;
    }>;
  }> => {
    return await apiClient.get(`/organizations/${orgId}/property-features/statistics`, {
      params: { ...filters }
    });
    
  },

  // Generate feature report
  generateReport: async (orgId: string, options: {
    propertyId?: string;
    type?: PropertyFeature['type'];
    category?: string;
    format: "PDF" | "EXCEL" | "CSV";
    includeAvailability: boolean;
    includeSpecifications: boolean;
  }): Promise<Blob> => {
    return await apiClient.post(`/organizations/${orgId}/property-features/report`, options, {
      responseType: 'blob'
    });
    
  },

  // Import features from template
  importFromTemplate: async (orgId: string, data: {
    templateId: string;
    propertyId: string;
    features: Array<{
      name: string;
      type: PropertyFeature['type'];
      category: string;
      description?: string;
      value?: string;
      quantity?: number;
      unit?: string;
    }>;
  }): Promise<PropertyFeature[]> => {
    return await apiClient.post(`/organizations/${orgId}/property-features/import`, data);
    
  },

  // Create feature template
  createTemplate: async (orgId: string, data: {
    name: string;
    description?: string;
    propertyType?: string;
    features: Array<{
      name: string;
      type: PropertyFeature['type'];
      category: string;
      description?: string;
      defaultValue?: string;
      isRequired: boolean;
    }>;
  }): Promise<{
    id: string;
    name: string;
    description?: string;
    propertyType?: string;
    createdAt: string;
  }> => {
    return await apiClient.post(`/organizations/${orgId}/property-features/templates`, data);
    
  },
};
