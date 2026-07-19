import { apiClient } from "./client";

export interface FinancialAuditLog {
  id: string;
  orgId: string;
  action: string;
  entityType: string;
  entityId: string;
  userId: string;
  actorType: string;
  amount: number;
  currency: string;
  oldAmount: number;
  newAmount: number;
  oldStatus: string;
  newStatus: string;
  oldValues: Record<string, any>;
  newValues: Record<string, any>;
  changeDelta: number;
  reservationId: string;
  leaseId: string;
  escrowId: string;
  paymentId: string;
  ipAddress: string;
  userAgent: string;
  sessionId: string;
  requestId: string;
  idempotencyKey: string;
  checksum: string;
  previousHash: string;
  createdAt: string;
}

export const financialAuditApi = {
  create: (data: {
    orgId: string;
    action: string;
    entityType: string;
    entityId: string;
    userId?: string;
    actorType?: string;
    amount?: number;
    currency?: string;
    oldAmount?: number;
    newAmount?: number;
    oldStatus?: string;
    newStatus?: string;
    oldValues?: Record<string, any>;
    newValues?: Record<string, any>;
    reservationId?: string;
    leaseId?: string;
    escrowId?: string;
    paymentId?: string;
    idempotencyKey?: string;
  }) =>
    apiClient.post<{ data: FinancialAuditLog }>("/financial-audit-log", data),

  getEntityAudit: (params: { entityType: string; entityId: string; page?: number; limit?: number }) =>
    apiClient.get<{ data: FinancialAuditLog[]; total: number }>("/financial-audit-log", params),

  getOrgAudit: (orgId: string, params?: { action?: string; entityType?: string; startDate?: string; endDate?: string; page?: number; limit?: number }) =>
    apiClient.get<{ data: FinancialAuditLog[]; total: number }>(`/financial-audit-log/org/${orgId}`, params),

  getOrgSummary: (orgId: string, params?: { startDate?: string; endDate?: string }) =>
    apiClient.get<{ data: Record<string, any> }>(`/financial-audit-log/org/${orgId}/summary`, params),

  verifyIntegrity: (orgId: string, params?: { startDate?: string; endDate?: string }) =>
    apiClient.get<{ data: { verified: boolean; brokenLinks: string[]; totalChecked: number } }>(`/financial-audit-log/org/${orgId}/verify`, params),
};
