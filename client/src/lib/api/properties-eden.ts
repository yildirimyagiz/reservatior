import { edenClient } from "../eden-client";

// Now using Eden Treaty with proper backend structure!
export const propertiesApi = {
  // Get all properties - using Eden Treaty
  getAll: async (query?: any) => {
    try {
      const response = await (edenClient as any).api.v1.property.get({ query });
      return response;
    } catch (error) {
      console.error('API Error:', error);
      throw error;
    }
  },

  // Get property by ID
  getById: async (id: string) => {
    try {
      const response = await (edenClient as any).api.v1.property[id].get();
      return response;
    } catch (error) {
      console.error('API Error:', error);
      throw error;
    }
  },

  // Create new property
  create: async (propertyData: any) => {
    try {
      const response = await (edenClient as any).api.v1.property.post(propertyData);
      return response;
    } catch (error) {
      console.error('API Error:', error);
      throw error;
    }
  },

  // Update property
  update: async (id: string, propertyData: any) => {
    try {
      const response = await (edenClient as any).api.v1.property[id].patch(propertyData);
      return response;
    } catch (error) {
      console.error('API Error:', error);
      throw error;
    }
  },

  // Delete property
  delete: async (id: string) => {
    try {
      const response = await (edenClient as any).api.v1.property[id].delete();
      return response;
    } catch (error) {
      console.error('API Error:', error);
      throw error;
    }
  },

  // Get properties for organization
  getOrgProperties: async (orgId: string) => {
    try {
      const response = await (edenClient as any).api.v1.property.get({ query: { orgId } });
      return response;
    } catch (error) {
      console.error('API Error:', error);
      throw error;
    }
  },

  // Search properties
  search: async (searchParams: any) => {
    try {
      const response = await (edenClient as any).api.v1.property.get({ query: searchParams });
      return response;
    } catch (error) {
      console.error('API Error:', error);
      throw error;
    }
  },

  // Other methods would be implemented when backend routes are available
  // For now, these are placeholders for future Eden integration
  getPhotos: (_propertyId: string) => Promise.resolve({ data: [] }), // Placeholder

  uploadPhoto: (_propertyId: string, _photoData: any) =>
    Promise.resolve({ data: null }), // Placeholder

  getDocuments: (_propertyId: string) => Promise.resolve({ data: [] }), // Placeholder

  uploadDocument: (_propertyId: string, _documentData: any) =>
    Promise.resolve({ data: null }), // Placeholder

  getValuations: (_propertyId: string) => Promise.resolve({ data: [] }), // Placeholder

  createValuation: (_propertyId: string, _valuationData: any) =>
    Promise.resolve({ data: null }), // Placeholder

  getOffers: (_propertyId: string) => Promise.resolve({ data: [] }), // Placeholder

  createOffer: (_propertyId: string, _offerData: any) =>
    Promise.resolve({ data: null }), // Placeholder

  getViewings: (_propertyId: string) => Promise.resolve({ data: [] }), // Placeholder

  scheduleViewing: (_propertyId: string, _viewingData: any) =>
    Promise.resolve({ data: null }), // Placeholder
};

// Export the Eden client for direct use if needed
export { edenClient };
