import { apiClient } from "./client";

export interface PropertyManagement {
  id: string;
  orgId: string;
  propertyId: string;
  managerId: string;
  type: "FULL_SERVICE" | "SELF_MANAGED" | "HYBRID";
  status: "ACTIVE" | "INACTIVE" | "SUSPENDED";
  startDate: string;
  endDate?: string;
  managementFee?: number;
  feeType: "FIXED" | "PERCENTAGE" | "RENTAL_PERCENTAGE";
  responsibilities: string[];
  services: Array<{
    type: string;
    name: string;
    included: boolean;
    cost?: number;
  }>;
  notes?: string;
  documents?: Array<{
    id: string;
    name: string;
    type: string;
    url: string;
  }>;
  createdAt: string;
  updatedAt: string;
  property?: {
    id: string;
    title: string;
    address: string;
  };
  manager?: {
    id: string;
    firstName: string;
    lastName: string;
    email: string;
  };
}

export const propertyManagementApi = {
  // Get all property management records
  getAll: async (orgId: string): Promise<PropertyManagement[]> => {
    return await apiClient.get(`/organizations/${orgId}/property-management`);
    
  },

  // Get property management by ID
  getById: async (orgId: string, id: string): Promise<PropertyManagement> => {
    return await apiClient.get(`/organizations/${orgId}/property-management/${id}`);
    
  },

  // Create new property management record
  create: async (orgId: string, data: Omit<PropertyManagement, 'id' | 'createdAt' | 'updatedAt' | 'property' | 'manager'>): Promise<PropertyManagement> => {
    return await apiClient.post(`/organizations/${orgId}/property-management`, data);
    
  },

  // Update property management
  update: async (orgId: string, id: string, data: Partial<PropertyManagement>): Promise<PropertyManagement> => {
    return await apiClient.put(`/organizations/${orgId}/property-management/${id}`, data);
    
  },

  // Delete property management
  delete: async (orgId: string, id: string): Promise<void> => {
    await apiClient.delete(`/organizations/${orgId}/property-management/${id}`);
  },

  // Get management by property
  getByProperty: async (orgId: string, propertyId: string): Promise<PropertyManagement[]> => {
    return await apiClient.get(`/organizations/${orgId}/properties/${propertyId}/management`);
    
  },

  // Get management by manager
  getByManager: async (orgId: string, managerId: string): Promise<PropertyManagement[]> => {
    return await apiClient.get(`/organizations/${orgId}/managers/${managerId}/properties`);
    
  },

  // Update management status
  updateStatus: async (orgId: string, id: string, status: PropertyManagement['status']): Promise<PropertyManagement> => {
    return await apiClient.patch(`/organizations/${orgId}/property-management/${id}/status`, { status });
    
  },

  // Calculate management fees
  calculateFees: async (orgId: string, data: {
    propertyId: string;
    managementType: PropertyManagement['type'];
    services: Array<{
      type: string;
      name: string;
    }>;
    propertyValue?: number;
  expectedRevenue?: number;
  }): Promise<{
    managementFee: number;
    processingFee: number;
    totalFee: number;
    netRevenue: number;
    feeBreakdown: Array<{
      serviceName: string;
      fee: number;
      type: string;
    }>;
  }> => {
    return await apiClient.post(`/organizations/${orgId}/property-management/calculate-fees`, data);
    
  },

  // Get management statistics
  getStatistics: async (orgId: string, filters?: {
    propertyId?: string;
    managerId?: string;
    type?: PropertyManagement['type'];
    status?: PropertyManagement['status'];
    startDate?: string;
    endDate?: string;
  }): Promise<{
    total: number;
    active: number;
    inactive: number;
    suspended: number;
    byType: Record<string, number>;
    byManager: Array<{
      managerId: string;
      managerName: string;
      propertyCount: number;
      totalRevenue: number;
    }>;
    totalRevenue: number;
    averageManagementFee: number;
    monthlyGrowth: Array<{
      month: string;
      properties: number;
      revenue: number;
    }>;
  }> => {
    return await apiClient.get(`/organizations/${orgId}/property-management/statistics`, {
      params: { ...filters }
    });
    
  },

  // Assign manager to property
  assignManager: async (orgId: string, propertyId: string, managerId: string, data: {
    type: PropertyManagement['type'];
    managementFee?: number;
    feeType?: PropertyManagement['feeType'];
    responsibilities?: string[];
    services?: Array<{
      type: string;
      name: string;
      included: boolean;
      cost?: number;
    }>;
    notes?: string;
  }): Promise<PropertyManagement> => {
    return await apiClient.post(`/organizations/${orgId}/properties/${propertyId}/assign-manager`, {
      managerId,
      ...data
    });
    
  },

  // Remove manager from property
  removeManager: async (orgId: string, propertyId: string): Promise<void> => {
    await apiClient.delete(`/organizations/${orgId}/properties/${propertyId}/manager`);
  },

  // Generate management report
  generateReport: async (orgId: string, options: {
    propertyId?: string;
    managerId?: string;
    type?: PropertyManagement['type'];
    status?: PropertyManagement['status'];
    format: "PDF" | "EXCEL" | "CSV";
    includeFinancials: boolean;
    includeServices: boolean;
    startDate?: string;
    endDate?: string;
  }): Promise<Blob> => {
    return await apiClient.post(`/organizations/${orgId}/property-management/report`, options, {
      responseType: 'blob'
    });
    
  },

  // Get available managers
  getAvailableManagers: async (orgId: string): Promise<Array<{
    id: string;
    firstName: string;
    lastName: string;
    email: string;
    phone?: string;
    specializations: string[];
    currentProperties: number;
    rating: number;
  }>> => {
    return await apiClient.get(`/organizations/${orgId}/available-managers`);
    
  },

  // Update management services
  updateServices: async (orgId: string, id: string, services: Array<{
    type: string;
    name: string;
    included: boolean;
    cost?: number;
  }>): Promise<PropertyManagement> => {
    return await apiClient.patch(`/organizations/${orgId}/property-management/${id}/services`, { services });
    
  },

  // Terminate management
  terminate: async (orgId: string, id: string, data: {
    terminationDate: string;
    reason: string;
    finalSettlement?: number;
    notes?: string;
  }): Promise<PropertyManagement> => {
    return await apiClient.patch(`/organizations/${orgId}/property-management/${id}/terminate`, data);
    
  },
};
