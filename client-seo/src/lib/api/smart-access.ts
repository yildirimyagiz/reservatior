import { apiClient } from "./client";

export interface SmartLock {
  id: string;
  propertyId: string;
  lockName: string;
  lockType: "AUGUST_SMART" | "SCHLAGE_ENCODE" | "YALE_ASSURE" | "GENERIC_ZIGBEE";
  status: "ONLINE" | "OFFLINE" | "LOW_BATTERY" | "LOCKED" | "UNLOCKED";
  batteryLevel?: number;
  lastSyncAt?: string;
  metadata?: any;
  createdAt: string;
  updatedAt: string;
}

export interface AccessCode {
  id: string;
  lockId: string;
  reservationId?: string;
  userId?: string;
  code: string;
  status: "ACTIVE" | "EXPIRED" | "REVOKED" | "PENDING";
  expiresAt?: string;
  label?: string; // 'Guest Code', 'Cleaning Service', 'Maintenance'
}

export interface AccessLog {
  id: string;
  lockId: string;
  codeId?: string;
  action: "LOCK" | "UNLOCK" | "TAMPER" | "LOW_BATTERY";
  timestamp: string;
  status: "SUCCESS" | "FAILED";
  userId?: string;
}

export const smartAccessApi = {
  // Lock Management
  getLocks: (propertyId?: string) => 
    apiClient.get<SmartLock[]>("/smart-lock", { propertyId }),
  getLockById: (id: string) => 
    apiClient.get<SmartLock>(`/smart-lock/${id}`),
  updateLock: (id: string, data: Partial<SmartLock>) =>
    apiClient.patch<SmartLock>(`/smart-lock/${id}`, data),
  lockProperty: (id: string) => 
    apiClient.post(`/smart-lock/${id}/lock`),
  unlockProperty: (id: string) => 
    apiClient.post(`/smart-lock/${id}/unlock`),

  // Access Codes
  getAccessCodes: (lockId: string) => 
    apiClient.get<AccessCode[]>("/smart-access/codes", { lockId }),
  generateCode: (lockId: string, data: Partial<AccessCode>) =>
    apiClient.post<AccessCode>("/smart-access/codes", { lockId, ...data }),
  revokeCode: (id: string) => 
    apiClient.delete(`/smart-access/codes/${id}`),

  // Audit Trail
  getAccessLogs: (lockId?: string, propertyId?: string) => 
    apiClient.get<AccessLog[]>("/smart-access/logs", { lockId, propertyId }),
  getRecentActivity: (limit: number = 20) => 
    apiClient.get<AccessLog[]>("/smart-access/logs/recent", { limit }),
};
