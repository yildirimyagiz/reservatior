const API_BASE_URL = 'http://localhost:3000/api/v1';

// Simple fetch-based API client
export const propertiesApi = {
  // Get all properties
  getAll: async (query?: any) => {
    try {
      const queryString = query ? new URLSearchParams(query).toString() : '';
      const response = await fetch(`${API_BASE_URL}/property${queryString ? `?${queryString}` : ''}`);
      
      if (!response.ok) {
        throw new Error(`HTTP error! status: ${response.status}`);
      }
      
      const data = await response.json();
      return data;
    } catch (error) {
      console.error('API Error:', error);
      throw error;
    }
  },

  // Get property by ID
  getById: async (id: string) => {
    try {
      const response = await fetch(`${API_BASE_URL}/property/${id}`);
      
      if (!response.ok) {
        throw new Error(`HTTP error! status: ${response.status}`);
      }
      
      const data = await response.json();
      return data;
    } catch (error) {
      console.error('API Error:', error);
      throw error;
    }
  },

  // Create new property
  create: async (propertyData: any) => {
    try {
      const response = await fetch(`${API_BASE_URL}/property`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(propertyData),
      });
      
      if (!response.ok) {
        throw new Error(`HTTP error! status: ${response.status}`);
      }
      
      const data = await response.json();
      return data;
    } catch (error) {
      console.error('API Error:', error);
      throw error;
    }
  },

  // Update property
  update: async (id: string, propertyData: any) => {
    try {
      const response = await fetch(`${API_BASE_URL}/property/${id}`, {
        method: 'PATCH',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(propertyData),
      });
      
      if (!response.ok) {
        throw new Error(`HTTP error! status: ${response.status}`);
      }
      
      const data = await response.json();
      return data;
    } catch (error) {
      console.error('API Error:', error);
      throw error;
    }
  },

  // Delete property
  delete: async (id: string) => {
    try {
      const response = await fetch(`${API_BASE_URL}/property/${id}`, {
        method: 'DELETE',
      });
      
      if (!response.ok) {
        throw new Error(`HTTP error! status: ${response.status}`);
      }
      
      const data = await response.json();
      return data;
    } catch (error) {
      console.error('API Error:', error);
      throw error;
    }
  },

  // Get properties for organization
  getOrgProperties: async (orgId: string) => {
    try {
      const response = await fetch(`${API_BASE_URL}/property?orgId=${orgId}`);
      
      if (!response.ok) {
        throw new Error(`HTTP error! status: ${response.status}`);
      }
      
      const data = await response.json();
      return data;
    } catch (error) {
      console.error('API Error:', error);
      throw error;
    }
  },

  // Search properties
  search: async (searchParams: any) => {
    try {
      const queryString = new URLSearchParams(searchParams).toString();
      const response = await fetch(`${API_BASE_URL}/property?${queryString}`);
      
      if (!response.ok) {
        throw new Error(`HTTP error! status: ${response.status}`);
      }
      
      const data = await response.json();
      return data;
    } catch (error) {
      console.error('API Error:', error);
      throw error;
    }
  },

  // Other methods would be implemented when backend routes are available
  // For now, these are placeholders for future Eden integration
  getPhotos: async (propertyId: string) => {
    try {
      const response = await fetch(`${API_BASE_URL}/property/${propertyId}/photos`);
      
      if (!response.ok) {
        throw new Error(`HTTP error! status: ${response.status}`);
      }
      
      const data = await response.json();
      return data;
    } catch (error) {
      console.error('API Error:', error);
      throw error;
    }
  },

  uploadPhoto: async (_propertyId: string, _photoData: any) => {
    // TODO: Implement photo upload
    console.log('Photo upload not yet implemented');
    return { data: null };
  },

  getDocuments: async (propertyId: string) => {
    try {
      const response = await fetch(`${API_BASE_URL}/property/${propertyId}/documents`);
      
      if (!response.ok) {
        throw new Error(`HTTP error! status: ${response.status}`);
      }
      
      const data = await response.json();
      return data;
    } catch (error) {
      console.error('API Error:', error);
      throw error;
    }
  },

  uploadDocument: async (_propertyId: string, _documentData: any) => {
    // TODO: Implement document upload
    console.log('Document upload not yet implemented');
    return { data: null };
  },

  getValuations: async (propertyId: string) => {
    try {
      const response = await fetch(`${API_BASE_URL}/property/${propertyId}/valuations`);
      
      if (!response.ok) {
        throw new Error(`HTTP error! status: ${response.status}`);
      }
      
      const data = await response.json();
      return data;
    } catch (error) {
      console.error('API Error:', error);
      throw error;
    }
  },

  createValuation: async (_propertyId: string, _valuationData: any) => {
    // TODO: Implement valuation creation
    console.log('Valuation creation not yet implemented');
    return { data: null };
  },

  getVideos: async (propertyId: string) => {
    try {
      const response = await fetch(`${API_BASE_URL}/property/${propertyId}/videos`);
      
      if (!response.ok) {
        throw new Error(`HTTP error! status: ${response.status}`);
      }
      
      const data = await response.json();
      return data;
    } catch (error) {
      console.error('API Error:', error);
      throw error;
    }
  },

  getOffers: async (propertyId: string) => {
    try {
      const response = await fetch(`${API_BASE_URL}/property/${propertyId}/offers`);
      
      if (!response.ok) {
        throw new Error(`HTTP error! status: ${response.status}`);
      }
      
      const data = await response.json();
      return data;
    } catch (error) {
      console.error('API Error:', error);
      throw error;
    }
  },

  createOffer: async (_propertyId: string, _offerData: any) => {
    // TODO: Implement offer creation
    console.log('Offer creation not yet implemented');
    return { data: null };
  },

  getViewings: async (propertyId: string) => {
    try {
      const response = await fetch(`${API_BASE_URL}/property/${propertyId}/viewings`);
      
      if (!response.ok) {
        throw new Error(`HTTP error! status: ${response.status}`);
      }
      
      const data = await response.json();
      return data;
    } catch (error) {
      console.error('API Error:', error);
      throw error;
    }
  },

  scheduleViewing: async (_propertyId: string, _viewingData: any) => {
    // TODO: Implement viewing scheduling
    console.log('Viewing scheduling not yet implemented');
    return { data: null };
  },
};

// Export the fetch client for direct use if needed
export { API_BASE_URL };
