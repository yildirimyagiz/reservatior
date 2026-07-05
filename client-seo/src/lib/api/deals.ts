import { apiClient } from "./client";

export interface Deal {
  id: string;
  orgId: string;
  title: string;
  dealType: string;
  status: string;
  propertyId?: string;
  buyerId?: string;
  sellerId?: string;
  agentId?: string;
  listingPrice?: number;
  salePrice?: number;
  commissionRate?: number;
  commissionAmount?: number;
  closingDate?: string;
  startDate: string;
  endDate?: string;
  description?: string;
  address?: string;
  city?: string;
  state?: string;
  zipCode?: string;
  country?: string;
  tags?: string[];
  documents?: string[];
  activities?: Array<{
    id: string;
    type: string;
    description: string;
    date: string;
    userId: string;
  }>;
  milestones?: Array<{
    id: string;
    title: string;
    dueDate: string;
    completed: boolean;
    completedAt?: string;
  }>;
  financials?: {
    depositAmount?: number;
    loanAmount?: number;
    appraisalValue?: number;
    inspectionCost?: number;
    closingCost?: number;
  };
  createdAt: string;
  updatedAt: string;
}

export interface DealCreate {
  orgId: string;
  title: string;
  dealType: string;
  status: string;
  propertyId?: string;
  buyerId?: string;
  sellerId?: string;
  agentId?: string;
  listingPrice?: number;
  salePrice?: number;
  commissionRate?: number;
  closingDate?: string;
  startDate: string;
  description?: string;
  address?: string;
  city?: string;
  state?: string;
  zipCode?: string;
  country?: string;
  tags?: string[];
  milestones?: Array<{
    id: string;
    title: string;
    dueDate: string;
    completed: boolean;
  }>;
  financials?: {
    depositAmount?: number;
    loanAmount?: number;
    appraisalValue?: number;
    inspectionCost?: number;
    closingCost?: number;
  };
}

export interface DealUpdate {
  title?: string;
  dealType?: string;
  status?: string;
  propertyId?: string;
  buyerId?: string;
  sellerId?: string;
  agentId?: string;
  listingPrice?: number;
  salePrice?: number;
  commissionRate?: number;
  commissionAmount?: number;
  closingDate?: string;
  endDate?: string;
  description?: string;
  address?: string;
  city?: string;
  state?: string;
  zipCode?: string;
  country?: string;
  tags?: string[];
  documents?: string[];
  milestones?: Array<{
    id: string;
    title: string;
    dueDate: string;
    completed: boolean;
    completedAt?: string;
  }>;
  financials?: {
    depositAmount?: number;
    loanAmount?: number;
    appraisalValue?: number;
    inspectionCost?: number;
    closingCost?: number;
  };
}

export const dealsApi = {
  getAll: async (params?: {
    page?: number;
    limit?: number;
    search?: string;
    orgId?: string;
    status?: string;
    dealType?: string;
    agentId?: string;
    propertyId?: string;
  }) => {
    return await apiClient.get("/api/deals", { params });
  },

  getById: async (id: string) => {
    return await apiClient.get(`/api/deals/${id}`);
  },

  create: async (data: DealCreate) => {
    return await apiClient.post("/api/deals", data);
  },

  update: async (id: string, data: DealUpdate) => {
    return await apiClient.patch(`/api/deals/${id}`, data);
  },

  delete: async (id: string) => {
    return await apiClient.delete(`/api/deals/${id}`, { data: { tags: [] } });
  },

  // Get deals for organization
  getOrgDeals: async (orgId: string) => {
    return await apiClient.get("/api/deals", {
      params: { orgId }
    });
  },

  // Search deals
  searchDeals: async (query: string, filters?: any) => {
    return await apiClient.get(`/api/deals/search`, {
      params: { q: query, ...filters }
    });
  },

  // Get deal analytics
  getDealAnalytics: async (orgId: string) => {
    return await apiClient.get(`/api/deals/analytics`, {
      params: { orgId }
    });
  },

  // Update deal status
  updateStatus: async (id: string, status: string) => {
    return await apiClient.patch(`/api/deals/${id}/status`, {
      status,
    });
  },

  // Add activity
  addActivity: async (
    id: string,
    activity: {
      type: string;
      description: string;
      date: string;
    }
  ) => {
    return await apiClient.post(`/api/deals/${id}/activities`, activity);
  },

  // Get activities
  getActivities: async (id: string) => {
    return await apiClient.get(`/api/deals/${id}/activities`);
  },

  // Update milestone
  updateMilestone: async (
    id: string,
    milestoneId: string,
    completed: boolean
  ) => {
    return await apiClient.patch(
      `/api/deals/${id}/milestones/${milestoneId}`,
      { completed }
    );
  },

  // Upload documents
  uploadDocuments: async (id: string, files: File[]) => {
    const formData = new FormData();
    files.forEach((file) => formData.append("documents", file));

    return await apiClient.post(`/api/deals/${id}/documents`, formData);
  },

  // Calculate commission
  calculateCommission: async (id: string) => {
    return await apiClient.post(`/api/deals/${id}/calculate-commission`);
  },

  // Get pipeline data
  getPipeline: async (orgId: string) => {
    return await apiClient.get("/api/deals/pipeline", {
      params: { orgId },
    });
  },

  // Export deals
  exportDeals: async (format: "csv" | "xlsx" | "json") => {
    const response = await fetch(`${apiClient['baseURL']}/api/deals/export?format=${format}`, {
      method: 'GET',
      headers: {
        'Authorization': `Bearer ${typeof window !== "undefined" ? localStorage.getItem("auth_token") : ""}`,
      },
    });
    
    if (!response.ok) {
      throw new Error(`HTTP error! status: ${response.status}`);
    }
    
    return await response.blob();
  },
};
