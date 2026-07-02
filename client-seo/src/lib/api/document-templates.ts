import { apiClient } from "./client";

export interface DocumentTemplates {
  id: string;
  orgId: string;
  name: string;
  description?: string;
  type: "LEASE_AGREEMENT" | "SALE_CONTRACT" | "PURCHASE_AGREEMENT" | "MANAGEMENT_CONTRACT" | "SERVICE_AGREEMENT" | "COMMISSION_AGREEMENT" | "PARTNERSHIP_AGREEMENT" | "EMPLOYMENT_CONTRACT" | "ND_AGREEMENT" | "INVOICE" | "RECEIPT" | "NOTICE" | "DISCLOSURE" | "FORM" | "LETTER" | "CUSTOM";
  category: string;
  tags?: Array<{
    id: string;
    name: string;
    color?: string;
  }>;
  content: {
    html?: string;
    text?: string;
    markdown?: string;
    variables?: Array<{
      name: string;
      type: "TEXT" | "NUMBER" | "DATE" | "BOOLEAN" | "SELECT" | "MULTI_SELECT";
      label: string;
      required: boolean;
      defaultValue?: any;
      options?: Array<{
        label: string;
        value: any;
      }>;
      validation?: {
        min?: number;
        max?: number;
        pattern?: string;
        message?: string;
      };
    }>;
    styling?: {
      fonts?: Record<string, any>;
      colors?: Record<string, any>;
      layout?: Record<string, any>;
    };
  };
  settings: {
    isPublic: boolean;
    isActive: boolean;
    requireApproval: boolean;
    allowCloning: boolean;
    allowCustomization: boolean;
    versionControl: boolean;
    autoSave: boolean;
  };
  metadata?: Record<string, any>;
  createdAt: string;
  updatedAt: string;
  usage?: {
    totalUses: number;
    uniqueUsers: number;
    lastUsed?: string;
  };
  versions?: Array<{
    id: string;
    version: string;
    name: string;
    description?: string;
    changes?: string;
    isActive: boolean;
    createdBy: string;
    createdAt: string;
  }>;
  creator?: {
    id: string;
    firstName: string;
    lastName: string;
    email: string;
  };
  updater?: {
    id: string;
    firstName: string;
    lastName: string;
    email: string;
  };
}

export const documentTemplatesApi = {
  // Get all document templates
  getAll: async (orgId: string): Promise<DocumentTemplates[]> => {
    return await apiClient.get(`/document-templates`, { params: { orgId } });
  },

  // Get document template by ID
  getById: async (orgId: string, id: string): Promise<DocumentTemplates> => {
    return await apiClient.get(`/document-templates/${id}`, { params: { orgId } });
  },

  // Create new document template
  create: async (orgId: string, data: Omit<DocumentTemplates, 'id' | 'createdAt' | 'updatedAt' | 'usage' | 'versions' | 'creator' | 'updater'>): Promise<DocumentTemplates> => {
    return await apiClient.post(`/document-templates`, { ...data, orgId });
  },

  // Update document template
  update: async (orgId: string, id: string, data: Partial<DocumentTemplates>): Promise<DocumentTemplates> => {
    return await apiClient.put(`/document-templates/${id}`, { ...data, orgId });
  },

  // Delete document template
  delete: async (orgId: string, id: string): Promise<void> => {
    await apiClient.delete(`/document-templates/${id}`, { params: { orgId } });
  },

  // Get document templates by type
  getByType: async (orgId: string, type: DocumentTemplates['type']): Promise<DocumentTemplates[]> => {
    return await apiClient.get(`/document-templates`, {
      params: { orgId, type }
    });
  },

  // Get document templates by category
  getByCategory: async (orgId: string, category: string): Promise<DocumentTemplates[]> => {
    return await apiClient.get(`/document-templates`, {
      params: { orgId, category }
    });
  },

  // Search document templates
  search: async (orgId: string, query: string, filters?: {
    type?: DocumentTemplates['type'];
    category?: string;
    isActive?: boolean;
    isPublic?: boolean;
    tags?: string[];
    createdBy?: string;
    startDate?: string;
    endDate?: string;
  }): Promise<DocumentTemplates[]> => {
    return await apiClient.get(`/document-templates`, {
      params: { orgId, query, ...filters }
    });
  },

  // Preview document template
  preview: async (orgId: string, id: string, data?: {
    variables?: Record<string, any>;
    format?: "HTML" | "PDF" | "DOC";
    locale?: string;
  }): Promise<{
    content: string;
    format: string;
    renderedAt: string;
  }> => {
    return await apiClient.post(`/document-templates/${id}/preview`, { ...data, orgId });
  },

  // Generate document from template
  generate: async (orgId: string, id: string, data: {
    variables: Record<string, any>;
    format?: "HTML" | "PDF" | "DOC" | "DOCX";
    options?: {
      watermark?: boolean;
      branding?: boolean;
      signatures?: boolean;
      saveAs?: {
        name: string;
        description?: string;
        category?: string;
        tags?: string[];
      };
    };
  }): Promise<{
    document: {
      id: string;
      name: string;
      url: string;
      size: number;
      format: string;
    };
    variables?: Record<string, any>;
    generatedAt: string;
  }> => {
    return await apiClient.post(`/document-templates/${id}/generate`, { ...data, orgId });
  },

  // Clone document template
  clone: async (orgId: string, id: string, data: {
    name: string;
    description?: string;
    copyVariables?: boolean;
    copyContent?: boolean;
    copySettings?: boolean;
    copyStyling?: boolean;
  }): Promise<DocumentTemplates> => {
    return await apiClient.post(`/document-templates/${id}/clone`, { ...data, orgId });
  },

  // Update template status
  updateStatus: async (orgId: string, id: string, data: {
    isActive: boolean;
    isPublic?: boolean;
  }): Promise<DocumentTemplates> => {
    return await apiClient.patch(`/document-templates/${id}/status`, { ...data, orgId });
  },

  // Submit for approval
  submitForApproval: async (orgId: string, id: string, data?: {
    notes?: string;
    priority?: "LOW" | "NORMAL" | "HIGH";
  }): Promise<DocumentTemplates> => {
    return await apiClient.post(`/document-templates/${id}/submit-approval`, { ...data, orgId });
  },

  // Approve document template
  approve: async (orgId: string, id: string, data?: {
    notes?: string;
    approvedBy?: string;
  }): Promise<DocumentTemplates> => {
    return await apiClient.post(`/document-templates/${id}/approve`, { ...data, orgId });
  },

  // Reject document template
  reject: async (orgId: string, id: string, data: {
    reason: string;
    notes?: string;
    rejectedBy?: string;
  }): Promise<DocumentTemplates> => {
    return await apiClient.post(`/document-templates/${id}/reject`, { ...data, orgId });
  },

  // Get template versions
  getVersions: async (orgId: string, id: string): Promise<DocumentTemplates['versions']> => {
    return await apiClient.get(`/document-templates/${id}/versions`, { params: { orgId } });
  },

  // Create template version
  createVersion: async (orgId: string, id: string, data: {
    version: string;
    name: string;
    description?: string;
    changes?: string;
    makeActive?: boolean;
  }): Promise<DocumentTemplates> => {
    return await apiClient.post(`/document-templates/${id}/versions`, { ...data, orgId });
  },

  // Restore template version
  restoreVersion: async (orgId: string, id: string, versionId: string): Promise<DocumentTemplates> => {
    return await apiClient.post(`/document-templates/${id}/versions/${versionId}/restore`, { orgId });
  },

  // Get template usage statistics
  getUsageStatistics: async (orgId: string, id: string, filters?: {
    startDate?: string;
    endDate?: string;
    userId?: string;
    teamId?: string;
  }): Promise<{
    totalUses: number;
    uniqueUsers: number;
    averageCompletionTime: number;
    byUser: Array<{
      userId: string;
      userName: string;
      usageCount: number;
      averageTime: number;
      lastUsed: string;
    }>;
    byPeriod: Array<{
      period: string;
      usageCount: number;
      uniqueUsers: number;
      averageTime: number;
    }>;
    byFormat: Record<string, number>;
    topVariables: Array<{
      name: string;
      usageCount: number;
      type: string;
    }>;
  }> => {
    return await apiClient.get(`/document-templates/${id}/usage-statistics`, {
      params: { orgId, ...filters }
    });
  },

  // Export document templates
  export: async (orgId: string, options: {
    type?: DocumentTemplates['type'];
    category?: string;
    isActive?: boolean;
    isPublic?: boolean;
    format: "JSON" | "CSV" | "EXCEL";
    includeContent?: boolean;
    includeVariables?: boolean;
    includeSettings?: boolean;
    includeUsage?: boolean;
  }): Promise<Blob> => {
    const response = await fetch(`${apiClient['baseURL']}/document-templates/export?orgId=${orgId}`, {
      method: 'POST',
      headers: {
        'Authorization': `Bearer ${localStorage.getItem("auth_token")}`,
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(options)
    });
    
    if (!response.ok) {
      throw new Error(`HTTP error! status: ${response.status}`);
    }
    
    return await response.blob();
  },

  // Import document templates
  import: async (orgId: string, data: {
    format: "JSON" | "CSV" | "EXCEL" | "DOCX";
    file?: File;
    url?: string;
    mapping?: Record<string, string>;
    mergeStrategy: "REPLACE" | "MERGE" | "SKIP_CONFLICTS";
    validateOnly?: boolean;
  }): Promise<{
    imported: number;
    updated: number;
    conflicts: Array<{
      row: number;
      field: string;
      value: string;
      conflict: string;
    }>;
    errors: Array<{
      row: number;
      field: string;
      message: string;
      value: any;
    }>;
  }> => {
    const formData = new FormData();
    formData.append('format', data.format);
    formData.append('orgId', orgId);
    if (data.file) {
      formData.append('file', data.file);
    }
    if (data.url) {
      formData.append('url', data.url);
    }
    if (data.mapping) {
      formData.append('mapping', JSON.stringify(data.mapping));
    }
    formData.append('mergeStrategy', data.mergeStrategy);
    formData.append('validateOnly', String(data.validateOnly || false));

    return await apiClient.post(`/document-templates/import`, formData, {
      headers: {
        'Content-Type': 'multipart/form-data',
      },
    });
  },

  // Get public templates
  getPublic: async (filters?: {
    type?: DocumentTemplates['type'];
    category?: string;
    tags?: string[];
    limit?: number;
    offset?: number;
  }): Promise<{
    templates: Array<{
      id: string;
      name: string;
      description?: string;
      type: DocumentTemplates['type'];
      category: string;
      tags: Array<{
        id: string;
        name: string;
        color?: string;
      }>;
      usageCount: number;
      rating: number;
      createdBy: {
        id: string;
        name: string;
        isVerified: boolean;
      };
      createdAt: string;
    }>;
    total: number;
    hasMore: boolean;
  }> => {
    return await apiClient.get(`/document-templates/public`, {
      params: { ...filters }
    });
  },

  // Rate public template
  ratePublicTemplate: async (templateId: string, data: {
    rating: number;
    review?: string;
  }): Promise<void> => {
    await apiClient.post(`/document-templates/public/${templateId}/rate`, data);
  },
};
