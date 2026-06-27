import { apiClient } from "./client";

export interface PropertyAmenity {
  id: string;
  orgId: string;
  propertyId: string;
  amenityId: string;
  quantity?: number;
  notes?: string;
  createdAt: string;
  updatedAt: string;
  amenity?: {
    id: string;
    name: string;
    category: string;
    icon?: string;
    description?: string;
  };
  property?: {
    id: string;
    title: string;
    address: string;
  };
}

export const propertyAmenitiesApi = {
  // Get all property amenities
  getAll: async (orgId: string): Promise<PropertyAmenity[]> => {
    return await apiClient.get(`/organizations/${orgId}/property-amenities`);
    
  },

  // Get property amenities by property
  getByProperty: async (orgId: string, propertyId: string): Promise<PropertyAmenity[]> => {
    return await apiClient.get(`/organizations/${orgId}/properties/${propertyId}/amenities`);
    
  },

  // Get property amenity by ID
  getById: async (orgId: string, id: string): Promise<PropertyAmenity> => {
    return await apiClient.get(`/organizations/${orgId}/property-amenities/${id}`);
    
  },

  // Create new property amenity
  create: async (orgId: string, data: Omit<PropertyAmenity, 'id' | 'createdAt' | 'updatedAt' | 'amenity' | 'property'>): Promise<PropertyAmenity> => {
    return await apiClient.post(`/organizations/${orgId}/property-amenities`, data);
    
  },

  // Update property amenity
  update: async (orgId: string, id: string, data: Partial<PropertyAmenity>): Promise<PropertyAmenity> => {
    return await apiClient.put(`/organizations/${orgId}/property-amenities/${id}`, data);
    
  },

  // Delete property amenity
  delete: async (orgId: string, id: string): Promise<void> => {
    await apiClient.delete(`/organizations/${orgId}/property-amenities/${id}`);
  },

  // Bulk add amenities to property
  bulkAdd: async (orgId: string, propertyId: string, amenityIds: string[]): Promise<PropertyAmenity[]> => {
    return await apiClient.post(`/organizations/${orgId}/properties/${propertyId}/amenities/bulk`, { amenityIds });
    
  },

  // Remove amenity from property
  removeFromProperty: async (orgId: string, propertyId: string, amenityId: string): Promise<void> => {
    await apiClient.delete(`/organizations/${orgId}/properties/${propertyId}/amenities/${amenityId}`);
  },

  // Get available amenities
  getAvailable: async (orgId: string): Promise<Array<{
    id: string;
    name: string;
    category: string;
    icon?: string;
    description?: string;
  }>> => {
    return await apiClient.get(`/organizations/${orgId}/amenities`);
    
  },

  // Search amenities
  search: async (orgId: string, query: string, category?: string): Promise<Array<{
    id: string;
    name: string;
    category: string;
    icon?: string;
    description?: string;
  }>> => {
    return await apiClient.get(`/organizations/${orgId}/amenities/search`, {
      params: { query, category }
    });
    
  },

  // Get amenity categories
  getCategories: async (orgId: string): Promise<string[]> => {
    return await apiClient.get(`/organizations/${orgId}/amenities/categories`);
    
  },

  // Create new amenity
  createAmenity: async (orgId: string, data: {
    name: string;
    category: string;
    icon?: string;
    description?: string;
  }): Promise<{
    id: string;
    name: string;
    category: string;
    icon?: string;
    description?: string;
  }> => {
    return await apiClient.post(`/organizations/${orgId}/amenities`, data);
    
  },

  // Update amenity
  updateAmenity: async (orgId: string, amenityId: string, data: {
    name?: string;
    category?: string;
    icon?: string;
    description?: string;
  }): Promise<{
    id: string;
    name: string;
    category: string;
    icon?: string;
    description?: string;
  }> => {
    return await apiClient.put(`/organizations/${orgId}/amenities/${amenityId}`, data);
    
  },

  // Delete amenity
  deleteAmenity: async (orgId: string, amenityId: string): Promise<void> => {
    await apiClient.delete(`/organizations/${orgId}/amenities/${amenityId}`);
  },
};
