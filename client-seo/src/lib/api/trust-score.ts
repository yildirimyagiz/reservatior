import { apiClient } from "./client";

export interface UniversalTrustScore {
  id: string;
  orgId: string;
  entityType: string;
  entityId: string;
  version: number;
  overallScore: number;
  confidenceLevel: string;
  scoreBreakdown: Record<string, number>;
  tier: string;
  status: string;
  decayRate: number;
  inactivityDays: number;
  signalCount: number;
  lastSignalAt: string;
  isExplainable: boolean;
  explanationData: Record<string, any>;
  apiAccessEnabled: boolean;
  lastAccessedAt: string;
  accessCount: number;
  createdAt: string;
  updatedAt: string;
}

export interface TrustScoreEvent {
  id: string;
  scoreId: string;
  orgId: string;
  eventType: string;
  eventSource: string;
  impactScore: number;
  metadata: Record<string, any>;
  recordedAt: string;
  createdAt: string;
  updatedAt: string;
}

export interface TrustScoreVersion {
  id: string;
  scoreId: string;
  version: number;
  overallScore: number;
  scoreBreakdown: Record<string, number>;
  tier: string;
  changeReason: string;
  createdAt: string;
}

export const trustScoreApi = {
  getByEntity: (params: { entityType: string; entityId: string }) =>
    apiClient.get<{ data: UniversalTrustScore }>("/trust-score", params),

  getPublicScore: (params: { entityType: string; entityId: string }) =>
    apiClient.get<{ data: { overallScore: number; tier: string; confidenceLevel: string } }>("/trust-score/public", params),

  getHistory: (scoreId: string, params?: { page?: number; limit?: number }) =>
    apiClient.get<{ data: TrustScoreVersion[]; total: number }>(`/trust-score/${scoreId}/history`, params),

  getExplainable: (scoreId: string) =>
    apiClient.get<{ data: UniversalTrustScore }>(`/trust-score/${scoreId}/explainable`),

  recordEvent: (data: {
    orgId: string;
    entityType: string;
    entityId: string;
    eventType: string;
    eventSource: string;
    impactScore: number;
    metadata?: Record<string, any>;
  }) =>
    apiClient.post<{ data: TrustScoreEvent }>("/trust-score/events", data),

  runDecay: (params?: { orgId?: string }) =>
    apiClient.post<{ data: { decayed: number } }>("/trust-score/decay", params),

  getByOrg: (orgId: string, params?: { entityType?: string; page?: number; limit?: number }) =>
    apiClient.get<{ data: UniversalTrustScore[]; total: number }>(`/trust-score/org/${orgId}`, params),
};
