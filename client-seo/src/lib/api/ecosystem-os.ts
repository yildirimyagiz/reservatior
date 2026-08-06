import { apiClient } from "./client";

export enum IntegrationStatus {
  DRAFT = "DRAFT",
  PENDING_REVIEW = "PENDING_REVIEW",
  APPROVED = "APPROVED",
  REJECTED = "REJECTED",
  SUSPENDED = "SUSPENDED",
  DEPRECATED = "DEPRECATED",
}

export enum APIAccessLevel {
  READ_ONLY = "READ_ONLY",
  READ_WRITE = "READ_WRITE",
  ADMIN = "ADMIN",
}

export interface Developer {
  id: string;
  userId: string;
  organizationName: string;
  email: string;
  status: IntegrationStatus;
  apiKeys: APIKey[];
  integrations: Integration[];
  createdAt: string;
  lastActive: string;
}

export interface APIKey {
  id: string;
  key: string;
  name: string;
  accessLevel: APIAccessLevel;
  scopes: string[];
  rateLimit: number;
  expiresAt?: string;
  lastUsed?: string;
  isActive: boolean;
  createdAt: string;
}

export interface Integration {
  id: string;
  developerId: string;
  name: string;
  description: string;
  category: string;
  status: IntegrationStatus;
  version: string;
  documentationUrl?: string;
  pricingModel: string;
  monthlyCalls: number;
  totalCalls: number;
  avgResponseTime: number;
  uptime: number;
  rating: number;
  reviews: number;
  createdAt: string;
  updatedAt: string;
}

export const ecosystemOSApi = {
  // Register developer
  registerDeveloper: async (data: {
    userId: string;
    organizationName: string;
    email: string;
  }): Promise<Developer> => {
    const response = await apiClient.post<Developer>(`/api/v1/ecosystem-os/developer/register`, data);
    return response;
  },

  // Create API key
  createAPIKey: async (data: {
    developerId: string;
    name: string;
    accessLevel: APIAccessLevel;
    scopes: string[];
    rateLimit: number;
  }): Promise<APIKey> => {
    const response = await apiClient.post<APIKey>(`/api/v1/ecosystem-os/api-key`, data);
    return response;
  },

  // Validate API key
  validateAPIKey: async (key: string): Promise<{ valid: boolean }> => {
    const response = await apiClient.get<{ valid: boolean }>(`/api/v1/ecosystem-os/api-key/validate/${key}`);
    return response;
  },

  // Revoke API key
  revokeAPIKey: async (keyId: string): Promise<{ revoked: boolean }> => {
    const response = await apiClient.delete<{ revoked: boolean }>(`/api/v1/ecosystem-os/api-key/${keyId}`);
    return response;
  },

  // Create integration
  createIntegration: async (data: {
    developerId: string;
    name: string;
    description: string;
    category: string;
    pricingModel: string;
  }): Promise<Integration> => {
    const response = await apiClient.post<Integration>(`/api/v1/ecosystem-os/integration`, data);
    return response;
  },

  // Submit integration for review
  submitIntegrationForReview: async (integrationId: string): Promise<Integration> => {
    const response = await apiClient.post<Integration>(`/api/v1/ecosystem-os/integration/${integrationId}/submit`);
    return response;
  },

  // Approve integration
  approveIntegration: async (integrationId: string): Promise<Integration> => {
    const response = await apiClient.post<Integration>(`/api/v1/ecosystem-os/integration/${integrationId}/approve`);
    return response;
  },

  // Get integration marketplace
  getIntegrationMarketplace: async (category?: string): Promise<Integration[]> => {
    const response = await apiClient.get<Integration[]>(`/api/v1/ecosystem-os/marketplace`, {
      params: { category },
    });
    return response;
  },

  // Record API usage
  recordAPIUsage: async (data: {
    integrationId: string;
    endpoint: string;
    method: string;
    responseTime: number;
    statusCode: number;
    success: boolean;
  }): Promise<void> => {
    await apiClient.post(`/api/v1/ecosystem-os/usage`, data);
  },

  // Get API analytics
  getAPIAnalytics: async (integrationId: string, period?: string): Promise<any> => {
    const response = await apiClient.get(`/api/v1/ecosystem-os/analytics/${integrationId}`, {
      params: { period },
    });
    return response;
  },

  // Get developer dashboard
  getDeveloperDashboard: async (developerId: string): Promise<any> => {
    const response = await apiClient.get(`/api/v1/ecosystem-os/dashboard/${developerId}`);
    return response;
  },

  // Get ecosystem overview
  getEcosystemOverview: async (): Promise<any> => {
    const response = await apiClient.get(`/api/v1/ecosystem-os/overview`);
    return response;
  },
};
