const API_BASE_URL = typeof window !== 'undefined' ? '/api/v1' : 'http://localhost:3001/api/v1';

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

  uploadPhoto: async (propertyId: string, photoData: any) => {
    try {
      const response = await fetch(`${API_BASE_URL}/property/${propertyId}/photos`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(photoData)
      });
      if (!response.ok) throw new Error(`HTTP error! status: ${response.status}`);
      return await response.json();
    } catch (error) {
      console.error('API Error:', error);
      throw error;
    }
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

  uploadDocument: async (propertyId: string, documentData: any) => {
    try {
      const response = await fetch(`${API_BASE_URL}/property/${propertyId}/documents`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(documentData)
      });
      if (!response.ok) throw new Error(`HTTP error! status: ${response.status}`);
      return await response.json();
    } catch (error) {
      console.error('API Error:', error);
      throw error;
    }
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

  createValuation: async (propertyId: string, valuationData: any) => {
    try {
      const response = await fetch(`${API_BASE_URL}/property/${propertyId}/valuations`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(valuationData)
      });
      if (!response.ok) throw new Error(`HTTP error! status: ${response.status}`);
      return await response.json();
    } catch (error) {
      console.error('API Error:', error);
      throw error;
    }
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

  createOffer: async (propertyId: string, offerData: any) => {
    try {
      const response = await fetch(`${API_BASE_URL}/property/${propertyId}/offers`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(offerData)
      });
      if (!response.ok) throw new Error(`HTTP error! status: ${response.status}`);
      return await response.json();
    } catch (error) {
      console.error('API Error:', error);
      throw error;
    }
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

  scheduleViewing: async (propertyId: string, viewingData: any) => {
    try {
      const response = await fetch(`${API_BASE_URL}/property/${propertyId}/viewings`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(viewingData)
      });
      if (!response.ok) throw new Error(`HTTP error! status: ${response.status}`);
      return await response.json();
    } catch (error) {
      console.error('API Error:', error);
      throw error;
    }
  },
};

// Export the fetch client for direct use if needed
export { API_BASE_URL };
