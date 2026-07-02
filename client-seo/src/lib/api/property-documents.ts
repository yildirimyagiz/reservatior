import { apiClient } from "./client";

export interface PropertyDocument {
  id: string;
  orgId: string;
  propertyId: string;
  name: string;
  type: "DEED" | "TITLE_DEED" | "PROPERTY_TAX_RECORD" | "MORTGAGE_STATEMENT" | "INSURANCE_POLICY" | "UTILITY_BILL" | "HOA_DOCUMENT" | "COURT_ORDER" | "INHERITANCE_DOCUMENT" | "TRUST_DOCUMENT" | "CORPORATE_RESOLUTION" | "POWER_OF_ATTORNEY" | "OTHER";
  category: string;
  description?: string;
  fileUrl: string;
  fileName: string;
  fileSize: number;
  mimeType: string;
  status: "PENDING" | "PROCESSING" | "APPROVED" | "REJECTED" | "EXPIRED";
  uploadedBy: string;
  uploadedAt: string;
  verifiedAt?: string;
  expiresAt?: string;
  isPublic: boolean;
  isEncrypted: boolean;
  tags?: string[];
  metadata?: Record<string, any>;
  property?: {
    id: string;
    title: string;
    address: string;
  };
}

export const propertyDocumentsApi = {
  // Get all property documents
  getAll: async (orgId: string): Promise<PropertyDocument[]> => {
    return await apiClient.get(`/organizations/${orgId}/property-documents`);
    
  },

  // Get property documents by property
  getByProperty: async (orgId: string, propertyId: string): Promise<PropertyDocument[]> => {
    return await apiClient.get(`/organizations/${orgId}/properties/${propertyId}/documents`);
    
  },

  // Get property document by ID
  getById: async (orgId: string, id: string): Promise<PropertyDocument> => {
    return await apiClient.get(`/organizations/${orgId}/property-documents/${id}`);
    
  },

  // Upload property document
  upload: async (orgId: string, data: {
    propertyId: string;
    name: string;
    type: PropertyDocument['type'];
    category: string;
    description?: string;
    file: File;
    isPublic: boolean;
    isEncrypted: boolean;
    tags?: string[];
    metadata?: Record<string, any>;
  }): Promise<PropertyDocument> => {
    const formData = new FormData();
    formData.append('propertyId', data.propertyId);
    formData.append('name', data.name);
    formData.append('type', data.type);
    formData.append('category', data.category);
    if (data.description) formData.append('description', data.description);
    formData.append('file', data.file);
    formData.append('isPublic', String(data.isPublic));
    formData.append('isEncrypted', String(data.isEncrypted));
    if (data.tags) formData.append('tags', JSON.stringify(data.tags));
    if (data.metadata) formData.append('metadata', JSON.stringify(data.metadata));

    return await apiClient.post(`/organizations/${orgId}/property-documents/upload`, formData, {
      headers: {
        'Content-Type': 'multipart/form-data',
      },
    });
    
  },

  // Update property document
  update: async (orgId: string, id: string, data: Partial<PropertyDocument>): Promise<PropertyDocument> => {
    return await apiClient.put(`/organizations/${orgId}/property-documents/${id}`, data);
    
  },

  // Delete property document
  delete: async (orgId: string, id: string): Promise<void> => {
    await apiClient.delete(`/organizations/${orgId}/property-documents/${id}`);
  },

  // Update document status
  updateStatus: async (orgId: string, id: string, status: PropertyDocument['status']): Promise<PropertyDocument> => {
    return await apiClient.patch(`/organizations/${orgId}/property-documents/${id}/status`, { status });
    
  },

  // Verify document
  verify: async (orgId: string, id: string): Promise<PropertyDocument> => {
    return await apiClient.patch(`/organizations/${orgId}/property-documents/${id}/verify`);
    
  },

  // Get document by type
  getByType: async (orgId: string, propertyId: string, type: PropertyDocument['type']): Promise<PropertyDocument[]> => {
    return await apiClient.get(`/organizations/${orgId}/properties/${propertyId}/documents`, {
      params: { type }
    });
    
  },

  // Search documents
  search: async (orgId: string, query: string, filters?: {
    propertyId?: string;
    type?: PropertyDocument['type'];
    category?: string;
    status?: PropertyDocument['status'];
    uploadedBy?: string;
    startDate?: string;
    endDate?: string;
  }): Promise<PropertyDocument[]> => {
    return await apiClient.get(`/organizations/${orgId}/property-documents/search`, {
      params: { query, ...filters }
    });
    
  },

  // Get document categories
  getCategories: async (orgId: string): Promise<string[]> => {
    return await apiClient.get(`/organizations/${orgId}/property-documents/categories`);
    
  },

  // Get document statistics
  getStatistics: async (orgId: string, filters?: {
    propertyId?: string;
    type?: PropertyDocument['type'];
    status?: PropertyDocument['status'];
    startDate?: string;
    endDate?: string;
  }): Promise<{
    total: number;
    pending: number;
    processing: number;
    approved: number;
    rejected: number;
    expired: number;
    byType: Record<string, number>;
    byCategory: Record<string, number>;
    totalSize: number;
    averageSize: number;
  }> => {
    return await apiClient.get(`/organizations/${orgId}/property-documents/statistics`, {
      params: { ...filters }
    });
    
  },

  // Bulk upload documents
  bulkUpload: async (orgId: string, data: {
    propertyId: string;
    documents: Array<{
      name: string;
      type: PropertyDocument['type'];
      category: string;
      description?: string;
      file: File;
      isPublic: boolean;
      isEncrypted: boolean;
      tags?: string[];
      metadata?: Record<string, any>;
    }>;
  }): Promise<PropertyDocument[]> => {
    const formData = new FormData();
    formData.append('propertyId', data.propertyId);
    formData.append('documents', JSON.stringify(data.documents));

    data.documents.forEach((doc, index) => {
      formData.append(`files[${index}]`, doc.file);
      formData.append(`names[${index}]`, doc.name);
      formData.append(`types[${index}]`, doc.type);
      formData.append(`categories[${index}]`, doc.category);
    });

    return await apiClient.post(`/organizations/${orgId}/property-documents/bulk-upload`, formData, {
      headers: {
        'Content-Type': 'multipart/form-data',
      },
    });
    
  },

  // Download document
  download: async (orgId: string, id: string): Promise<Blob> => {
    return await apiClient.get(`/organizations/${orgId}/property-documents/${id}/download`, {
      responseType: 'blob'
    });
    
  },

  // Generate document share link
  generateShareLink: async (orgId: string, id: string, options: {
    expiresAt?: string;
    password?: string;
    downloadLimit?: number;
  }): Promise<{
    shareUrl: string;
    shareToken: string;
    expiresAt: string;
  }> => {
    return await apiClient.post(`/organizations/${orgId}/property-documents/${id}/share`, options);
    
  },

  // Revoke document access
  revokeAccess: async (orgId: string, id: string): Promise<PropertyDocument> => {
    return await apiClient.patch(`/organizations/${orgId}/property-documents/${id}/revoke`);
    
  },
};
