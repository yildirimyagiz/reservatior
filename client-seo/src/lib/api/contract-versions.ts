import { apiClient } from "./client";

export interface ContractVersions {
  id: string;
  orgId: string;
  contractId: string;
  version: string;
  status: "DRAFT" | "ACTIVE" | "ARCHIVED" | "SUPERSEDED";
  changes: Array<{
    id: string;
    field: string;
    oldValue: any;
    newValue: any;
    changeType: "CREATE" | "UPDATE" | "DELETE";
    changedBy: string;
    changedAt: string;
    reason?: string;
  }>;
  notes?: string;
  effectiveDate?: string;
  expirationDate?: string;
  isCurrentVersion: boolean;
  createdBy: string;
  approvedBy?: string;
  approvedAt?: string;
  createdAt: string;
  updatedAt: string;
  contract?: {
    id: string;
    title: string;
    type: string;
    status: string;
  };
  creator?: {
    id: string;
    firstName: string;
    lastName: string;
    email: string;
  };
  approver?: {
    id: string;
    firstName: string;
    lastName: string;
    email: string;
  };
}

export const contractVersionsApi = {
  // Get all contract versions
  getAll: async (orgId: string): Promise<ContractVersions[]> => {
    const response = await apiClient.get<ContractVersions[]>(`/organizations/${orgId}/contract-versions`);
    return response;
  },

  // Get contract versions by contract
  getByContract: async (orgId: string, contractId: string): Promise<ContractVersions[]> => {
    const response = await apiClient.get<ContractVersions[]>(`/organizations/${orgId}/contracts/${contractId}/versions`);
    return response;
  },

  // Get contract version by ID
  getById: async (orgId: string, id: string): Promise<ContractVersions> => {
    const response = await apiClient.get<ContractVersions>(`/organizations/${orgId}/contract-versions/${id}`);
    return response;
  },

  // Create new contract version
  create: async (orgId: string, data: Omit<ContractVersions, 'id' | 'createdAt' | 'updatedAt' | 'contract' | 'creator' | 'approver'>): Promise<ContractVersions> => {
    const response = await apiClient.post<ContractVersions>(`/organizations/${orgId}/contract-versions`, data);
    return response;
  },

  // Update contract version
  update: async (orgId: string, id: string, data: Partial<ContractVersions>): Promise<ContractVersions> => {
    const response = await apiClient.put<ContractVersions>(`/organizations/${orgId}/contract-versions/${id}`, data);
    return response;
  },

  // Delete contract version
  delete: async (orgId: string, id: string): Promise<void> => {
    await apiClient.delete(`/organizations/${orgId}/contract-versions/${id}`);
  },

  // Get current version
  getCurrent: async (orgId: string, contractId: string): Promise<ContractVersions> => {
    const response = await apiClient.get<ContractVersions>(`/organizations/${orgId}/contracts/${contractId}/versions/current`);
    return response;
  },

  // Set as current version
  setCurrent: async (orgId: string, id: string, data?: {
    effectiveDate?: string;
    notes?: string;
    notifyParties?: boolean;
  }): Promise<ContractVersions> => {
    const response = await apiClient.post<ContractVersions>(`/organizations/${orgId}/contract-versions/${id}/set-current`, data);
    return response;
  },

  // Get version history
  getHistory: async (orgId: string, id: string): Promise<ContractVersions['changes']> => {
    const response = await apiClient.get<ContractVersions['changes']>(`/organizations/${orgId}/contract-versions/${id}/history`);
    return response;
  },

  // Add change record
  addChange: async (orgId: string, id: string, data: {
    field: string;
    oldValue: any;
    newValue: any;
    changeType: "CREATE" | "UPDATE" | "DELETE";
    reason?: string;
  }): Promise<ContractVersions> => {
    const response = await apiClient.post<ContractVersions>(`/organizations/${orgId}/contract-versions/${id}/changes`, data);
    return response;
  },

  // Compare versions
  compare: async (orgId: string, data: {
    version1Id: string;
    version2Id: string;
    contractId?: string;
  }): Promise<{
    version1: ContractVersions;
    version2: ContractVersions;
    differences: Array<{
      field: string;
      oldValue: any;
      newValue: any;
      changeType: "CREATE" | "UPDATE" | "DELETE";
    }>;
    summary: {
      totalChanges: number;
      additions: number;
      modifications: number;
      deletions: number;
    };
  }> => {
    const response = await apiClient.post<{
    version1: ContractVersions;
    version2: ContractVersions;
    differences: Array<{
      field: string;
      oldValue: any;
      newValue: any;
      changeType: "CREATE" | "UPDATE" | "DELETE";
    }>;
    summary: {
      totalChanges: number;
      additions: number;
      modifications: number;
      deletions: number;
    };
  }>(`/organizations/${orgId}/contract-versions/compare`, data);
    return response;
  },

  // Update version status
  updateStatus: async (orgId: string, id: string, data: {
    status: "DRAFT" | "ACTIVE" | "ARCHIVED" | "SUPERSEDED";
    notes?: string;
    approvedBy?: string;
    approvedAt?: string;
  }): Promise<ContractVersions> => {
    const response = await apiClient.patch<ContractVersions>(`/organizations/${orgId}/contract-versions/${id}/status`, data);
    return response;
  },

  // Approve version
  approve: async (orgId: string, id: string, data?: {
    notes?: string;
    effectiveDate?: string;
  }): Promise<ContractVersions> => {
    const response = await apiClient.post<ContractVersions>(`/organizations/${orgId}/contract-versions/${id}/approve`, data);
    return response;
  },

  // Reject version
  reject: async (orgId: string, id: string, data: {
    reason: string;
    notes?: string;
  }): Promise<ContractVersions> => {
    const response = await apiClient.post<ContractVersions>(`/organizations/${orgId}/contract-versions/${id}/reject`, data);
    return response;
  },

  // Archive version
  archive: async (orgId: string, id: string): Promise<ContractVersions> => {
    const response = await apiClient.post<ContractVersions>(`/organizations/${orgId}/contract-versions/${id}/archive`);
    return response;
  },

  // Restore version
  restore: async (orgId: string, id: string): Promise<ContractVersions> => {
    const response = await apiClient.post<ContractVersions>(`/organizations/${orgId}/contract-versions/${id}/restore`);
    return response;
  },

  // Get version statistics
  getStatistics: async (orgId: string, filters?: {
    contractId?: string;
    status?: "DRAFT" | "ACTIVE" | "ARCHIVED" | "SUPERSEDED";
    createdBy?: string;
    approvedBy?: string;
    startDate?: string;
    endDate?: string;
  }): Promise<{
    total: number;
    byStatus: Record<string, number>;
    byContract: Array<{
      contractId: string;
      contractTitle: string;
      versionCount: number;
      currentVersion: string;
    }>;
    byCreator: Array<{
      creatorId: string;
      creatorName: string;
      versionCount: number;
      lastVersionDate: string;
    }>;
    averageChangesPerVersion: number;
    totalChanges: number;
    recentActivity: Array<{
      date: string;
      action: string;
      version: string;
      user: string;
    }>;
  }> => {
    const response = await apiClient.get<{
    total: number;
    byStatus: Record<string, number>;
    byContract: Array<{
      contractId: string;
      contractTitle: string;
      versionCount: number;
      currentVersion: string;
    }>;
    byCreator: Array<{
      creatorId: string;
      creatorName: string;
      versionCount: number;
      lastVersionDate: string;
    }>;
    averageChangesPerVersion: number;
    totalChanges: number;
    recentActivity: Array<{
      date: string;
      action: string;
      version: string;
      user: string;
    }>;
  }>(`/organizations/${orgId}/contract-versions/statistics`, {
      params: { ...filters }
    });
    return response;
  },

  // Export versions
  export: async (orgId: string, options: {
    contractId?: string;
    format: "PDF" | "DOC" | "HTML" | "JSON";
    includeChanges?: boolean;
    includeNotes?: boolean;
    includeApprovals?: boolean;
    status?: "DRAFT" | "ACTIVE" | "ARCHIVED" | "SUPERSEDED";
    startDate?: string;
    endDate?: string;
  }): Promise<Blob> => {
    const response = await apiClient.post<Blob>(`/organizations/${orgId}/contract-versions/export`, options, {
      responseType: 'blob'
    });
    return response;
  },

  // Import version from template
  importFromTemplate: async (orgId: string, data: {
    templateId: string;
    contractId: string;
    version: string;
    effectiveDate?: string;
    notes?: string;
  }): Promise<ContractVersions> => {
    const response = await apiClient.post<ContractVersions>(`/organizations/${orgId}/contract-versions/import-template`, data);
    return response;
  },

  // Get version templates
  getTemplates: async (): Promise<Array<{
    id: string;
    name: string;
    description?: string;
    contractType?: string;
    template: {
      fields: Array<{
        name: string;
        type: string;
        required: boolean;
        defaultValue?: any;
        description?: string;
      }>;
      clauses: Array<{
        title: string;
        content: string;
        optional: boolean;
      }>;
    };
    usageCount: number;
    isPublic: boolean;
    createdBy: string;
    createdAt: string;
  }>> => {
    const response = await apiClient.get<Array<{
    id: string;
    name: string;
    description?: string;
    contractType?: string;
    template: {
      fields: Array<{
        name: string;
        type: string;
        required: boolean;
        defaultValue?: any;
        description?: string;
      }>;
      clauses: Array<{
        title: string;
        content: string;
        optional: boolean;
      }>;
    };
    usageCount: number;
    isPublic: boolean;
    createdBy: string;
    createdAt: string;
  }>>(`/organizations/current/contract-versions/templates`);
    return response;
  },
};
