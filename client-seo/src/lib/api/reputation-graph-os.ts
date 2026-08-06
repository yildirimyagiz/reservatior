import { apiClient } from "./client";

export interface ReputationNode {
  id: string;
  type: string;
  name: string;
  reputationScore: number;
  influenceScore: number;
  metadata?: Record<string, unknown>;
}

export interface ReputationEdge {
  id: string;
  fromId: string;
  toId: string;
  edgeType: string;
  trustWeight: number;
  riskLevel: string;
  metadata?: Record<string, unknown>;
}

export interface ReputationPath {
  path: string[];
  totalTrustScore: number;
  pathLength: number;
}

export interface Community {
  id: string;
  members: string[];
  communityScore: number;
  type: string;
}

export const reputationGraphOSApi = {
  // Build reputation graph
  buildGraph: async (entityId: string): Promise<{ nodes: ReputationNode[]; edges: ReputationEdge[] }> => {
    const response = await apiClient.post<{ nodes: ReputationNode[]; edges: ReputationEdge[] }>(
      `/api/v1/reputation-graph-os/graph/build`,
      { entityId }
    );
    return response;
  },

  // Calculate influence score
  calculateInfluence: async (entityId: string): Promise<{ score: number; factors: Record<string, number> }> => {
    const response = await apiClient.get<{ score: number; factors: Record<string, number> }>(
      `/api/v1/reputation-graph-os/influence/${entityId}`
    );
    return response;
  },

  // Calculate reputation score
  calculateReputation: async (entityId: string): Promise<{ score: number; breakdown: Record<string, number> }> => {
    const response = await apiClient.get<{ score: number; breakdown: Record<string, number> }>(
      `/api/v1/reputation-graph-os/reputation/${entityId}`
    );
    return response;
  },

  // Find trust path
  findPath: async (fromId: string, toId: string): Promise<ReputationPath> => {
    const response = await apiClient.get<ReputationPath>(
      `/api/v1/reputation-graph-os/path/${fromId}/${toId}`
    );
    return response;
  },

  // Detect communities
  detectCommunities: async (orgId?: string): Promise<Community[]> => {
    const response = await apiClient.get<Community[]>(`/api/v1/reputation-graph-os/communities`, {
      params: { orgId },
    });
    return response;
  },

  // Get reputation summary
  getSummary: async (entityId: string): Promise<any> => {
    const response = await apiClient.get(`/api/v1/reputation-graph-os/summary/${entityId}`);
    return response;
  },

  // Get dashboard
  getDashboard: async (orgId?: string): Promise<any> => {
    const response = await apiClient.get(`/api/v1/reputation-graph-os/dashboard`, {
      params: { orgId },
    });
    return response;
  },
};
