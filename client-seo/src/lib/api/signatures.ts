import { apiClient } from "./client";

export type SignatureStatus = "PENDING" | "COMPLETED" | "DECLINED" | "EXPIRED";

export interface SignatureSigner {
  id: string;
  orgId: string;
  signatureRequestId: string;
  participantType: string;
  userId?: string;
  contactId?: string;
  fullName: string;
  email?: string;
  status: SignatureStatus;
  signedAt?: string;
  createdAt: string;
  updatedAt: string;
}

export interface SignatureRequest {
  id: string;
  orgId: string;
  contractId: string;
  provider?: string;
  status: SignatureStatus;
  signUrl?: string;
  signedDocumentUrl?: string;
  expiresAt?: string;
  createdAt: string;
  updatedAt: string;
  signers: SignatureSigner[];
}

export interface SignatureRequestsResponse {
  data: SignatureRequest[];
}

export const signaturesApi = {
  getSignatureRequests: (params?: { orgId?: string; status?: string }) => 
    apiClient.get<SignatureRequestsResponse>("/legal/signature-requests", params),
  
  createSignatureRequest: (data: Partial<SignatureRequest> & { orgId: string; contractId: string }) => 
    apiClient.post<{ data: SignatureRequest }>("/legal/signature-requests", data),
  
  updateSignatureRequest: (id: string, data: Partial<SignatureRequest>) => 
    apiClient.patch<{ data: SignatureRequest }>(`/legal/signature-requests/${id}`, data),
  
  deleteSignatureRequest: (id: string) => 
    apiClient.delete(`/legal/signature-requests/${id}`, { data: { tags: [] } }),
};
