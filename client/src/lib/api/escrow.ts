import { apiClient } from "./client";

export interface EscrowAccount {
  id: string;
  reservationId: string;
  orgId: string;
  totalAmount: number;
  depositAmount: number;
  currency: string;
  status: "HOLDING" | "RELEASED" | "DISPUTED" | "REFUNDED";
  heldAt: string;
  releasedAt?: string;
  reservation?: {
    id: string;
    contact?: { name: string };
    listing?: { name: string };
  };
}

export const escrowApi = {
  getAccounts: (params?: { orgId?: string; status?: string }) => 
    apiClient.get<{ data: EscrowAccount[] }>("/escrow", params),
    
  getAccount: (id: string) => 
    apiClient.get<{ data: EscrowAccount }>(`/escrow/${id}`),
    
  createAccount: (data: { orgId: string; reservationId: string; totalAmount: number; depositAmount: number; currency?: string }) => 
    apiClient.post<{ data: EscrowAccount }>("/escrow", data),
    
  releaseFunds: (id: string, data: { orgId: string; triggerEvent: string; releasePercent: number; amount: number; currency?: string }) => 
    apiClient.post(`/escrow/${id}/releases`, data),
    
  openDispute: (id: string, data: { orgId: string; openedBy: string; disputeType: string; description: string; claimedAmount?: number }) => 
    apiClient.post(`/escrow/${id}/disputes`, data),
};
