import { apiClient } from "./client";

export interface Attachments {
  id: string;
  orgId: string;
  name: string;
  type: "IMAGE" | "DOCUMENT" | "VIDEO" | "AUDIO" | "OTHER";
  mimeType: string;
  size: number;
  url: string;
  path: string;
  description?: string;
  category: string;
  tags?: string[];
  metadata?: Record<string, any>;
  uploadedBy: string;
  uploadedAt: string;
  isPublic: boolean;
  isEncrypted: boolean;
  expiresAt?: string;
  downloadCount: number;
  lastAccessedAt?: string;
  parentType?: "PROPERTY" | "APPOINTMENT" | "TICKET" | "MESSAGE" | "CONTRACT" | "USER" | "AGENT" | "CUSTOM";
  parentId?: string;
  thumbnailUrl?: string;
  previewUrl?: string;
  versions?: Array<{
    id: string;
    version: string;
    uploadedAt: string;
    uploadedBy: string;
    size: number;
    changes?: string;
  }>;
}

export const attachmentsApi = {
  // Get all attachments
  getAll: async (orgId: string): Promise<Attachments[]> => {
    const response = await apiClient.get<Attachments[]>(`/organizations/${orgId}/attachments`);
    return response;
  },

  // Get attachment by ID
  getById: async (orgId: string, id: string): Promise<Attachments> => {
    const response = await apiClient.get<Attachments>(`/organizations/${orgId}/attachments/${id}`);
    return response;
  },

  // Upload attachment
  upload: async (orgId: string, data: {
    file: File;
    name: string;
    type: Attachments['type'];
    category: string;
    description?: string;
    tags?: string[];
    isPublic?: boolean;
    isEncrypted?: boolean;
    expiresAt?: string;
    parentType?: Attachments['parentType'];
    parentId?: string;
    metadata?: Record<string, any>;
  }): Promise<Attachments> => {
    const formData = new FormData();
    formData.append('file', data.file);
    formData.append('name', data.name);
    formData.append('type', data.type);
    formData.append('category', data.category);
    if (data.description) formData.append('description', data.description);
    if (data.tags) formData.append('tags', JSON.stringify(data.tags));
    formData.append('isPublic', String(data.isPublic || false));
    formData.append('isEncrypted', String(data.isEncrypted || false));
    if (data.expiresAt) formData.append('expiresAt', data.expiresAt);
    if (data.parentType) formData.append('parentType', data.parentType);
    if (data.parentId) formData.append('parentId', data.parentId);
    if (data.metadata) formData.append('metadata', JSON.stringify(data.metadata));

    const response = await apiClient.post<Attachments>(`/organizations/${orgId}/attachments`, formData, {
      headers: {
        'Content-Type': 'multipart/form-data',
      },
    });
    return response;
  },

  // Update attachment
  update: async (orgId: string, id: string, data: Partial<Attachments>): Promise<Attachments> => {
    const response = await apiClient.put<Attachments>(`/organizations/${orgId}/attachments/${id}`, data);
    return response;
  },

  // Delete attachment
  delete: async (orgId: string, id: string): Promise<void> => {
    await apiClient.delete(`/organizations/${orgId}/attachments/${id}`);
  },

  // Get attachments by parent
  getByParent: async (orgId: string, parentType: Attachments['parentType'], parentId: string): Promise<Attachments[]> => {
    const response = await apiClient.get<Attachments[]>(`/organizations/${orgId}/attachments`, {
      params: { parentType, parentId }
    });
    return response;
  },

  // Get attachments by type
  getByType: async (orgId: string, type: Attachments['type']): Promise<Attachments[]> => {
    const response = await apiClient.get<Attachments[]>(`/organizations/${orgId}/attachments`, {
      params: { type }
    });
    return response;
  },

  // Get attachments by category
  getByCategory: async (orgId: string, category: string): Promise<Attachments[]> => {
    const response = await apiClient.get<Attachments[]>(`/organizations/${orgId}/attachments`, {
      params: { category }
    });
    return response;
  },

  // Search attachments
  search: async (orgId: string, query: string, filters?: {
    type?: Attachments['type'];
    category?: string;
    tags?: string[];
    uploadedBy?: string;
    startDate?: string;
    endDate?: string;
    isPublic?: boolean;
    parentType?: Attachments['parentType'];
    parentId?: string;
  }): Promise<Attachments[]> => {
    const response = await apiClient.get<Attachments[]>(`/organizations/${orgId}/attachments/search`, {
      params: { query, ...filters }
    });
    return response;
  },

  // Download attachment
  download: async (orgId: string, id: string): Promise<Blob> => {
    const response = await apiClient.get<Blob>(`/organizations/${orgId}/attachments/${id}/download`, {
      responseType: 'blob'
    });
    return response;
  },

  // Get download URL
  getDownloadUrl: async (orgId: string, id: string, options?: {
    expiresIn?: number;
    singleUse?: boolean;
  }): Promise<{
    url: string;
    expiresAt?: string;
  }> => {
    const response = await apiClient.get<{
    url: string;
    expiresAt?: string;
  }>(`/organizations/${orgId}/attachments/${id}/download-url`, {
      params: { ...options }
    });
    return response;
  },

  // Update attachment visibility
  updateVisibility: async (orgId: string, id: string, isPublic: boolean): Promise<Attachments> => {
    const response = await apiClient.patch<Attachments>(`/organizations/${orgId}/attachments/${id}/visibility`, { isPublic });
    return response;
  },

  // Add attachment version
  addVersion: async (orgId: string, id: string, data: {
    file: File;
    changes?: string;
    description?: string;
  }): Promise<Attachments> => {
    const formData = new FormData();
    formData.append('file', data.file);
    if (data.changes) formData.append('changes', data.changes);
    if (data.description) formData.append('description', data.description);

    const response = await apiClient.post<Attachments>(`/organizations/${orgId}/attachments/${id}/versions`, formData, {
      headers: {
        'Content-Type': 'multipart/form-data',
      },
    });
    return response;
  },

  // Get attachment versions
  getVersions: async (orgId: string, id: string): Promise<Attachments['versions']> => {
    const response = await apiClient.get<Attachments['versions']>(`/organizations/${orgId}/attachments/${id}/versions`);
    return response;
  },

  // Restore attachment version
  restoreVersion: async (orgId: string, id: string, versionId: string): Promise<Attachments> => {
    const response = await apiClient.post<Attachments>(`/organizations/${orgId}/attachments/${id}/versions/${versionId}/restore`);
    return response;
  },

  // Delete attachment version
  deleteVersion: async (orgId: string, id: string, versionId: string): Promise<void> => {
    await apiClient.delete(`/organizations/${orgId}/attachments/${id}/versions/${versionId}`);
  },

  // Get attachment statistics
  getStatistics: async (orgId: string, filters?: {
    type?: Attachments['type'];
    category?: string;
    uploadedBy?: string;
    startDate?: string;
    endDate?: string;
  }): Promise<{
    total: number;
    totalSize: number;
    byType: Record<string, number>;
    byCategory: Record<string, number>;
    byUploader: Array<{
      uploadedBy: string;
      count: number;
      totalSize: number;
    }>;
    averageSize: number;
    uploadTrend: Array<{
      date: string;
      count: number;
      totalSize: number;
    }>;
  }> => {
    const response = await apiClient.get<{
    total: number;
    totalSize: number;
    byType: Record<string, number>;
    byCategory: Record<string, number>;
    byUploader: Array<{
      uploadedBy: string;
      count: number;
      totalSize: number;
    }>;
    averageSize: number;
    uploadTrend: Array<{
      date: string;
      count: number;
      totalSize: number;
    }>;
  }>(`/organizations/${orgId}/attachments/statistics`, {
      params: { ...filters }
    });
    return response;
  },

  // Bulk upload attachments
  bulkUpload: async (orgId: string, data: {
    files: Array<{
      file: File;
      name: string;
      type: Attachments['type'];
      category: string;
      description?: string;
      tags?: string[];
      parentType?: Attachments['parentType'];
      parentId?: string;
      metadata?: Record<string, any>;
    }>;
  }): Promise<Attachments[]> => {
    const formData = new FormData();
    
    data.files.forEach((fileData, index) => {
      formData.append(`files[${index}].file`, fileData.file);
      formData.append(`files[${index}].name`, fileData.name);
      formData.append(`files[${index}].type`, fileData.type);
      formData.append(`files[${index}].category`, fileData.category);
      if (fileData.description) formData.append(`files[${index}].description`, fileData.description);
      if (fileData.tags) formData.append(`files[${index}].tags`, JSON.stringify(fileData.tags));
      if (fileData.parentType) formData.append(`files[${index}].parentType`, fileData.parentType);
      if (fileData.parentId) formData.append(`files[${index}].parentId`, fileData.parentId);
      if (fileData.metadata) formData.append(`files[${index}].metadata`, JSON.stringify(fileData.metadata));
    });

    const response = await apiClient.post<Attachments[]>(`/organizations/${orgId}/attachments/bulk`, formData, {
      headers: {
        'Content-Type': 'multipart/form-data',
      },
    });
    return response;
  },

  // Generate attachment report
  generateReport: async (orgId: string, options: {
    type?: Attachments['type'];
    category?: string;
    uploadedBy?: string;
    startDate?: string;
    endDate?: string;
    format: "PDF" | "EXCEL" | "CSV";
    includeDetails?: boolean;
  }): Promise<Blob> => {
    const response = await apiClient.post<Blob>(`/organizations/${orgId}/attachments/report`, options, {
      responseType: 'blob'
    });
    return response;
  },
};
