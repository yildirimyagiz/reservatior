import { apiClient } from "./client";

export interface LegalDocument {
  id: string;
  orgId: string;
  propertyId?: string;
  documentType: string;
  status?: string;
  title?: string;
  fileUrl?: string;
  createdAt: string;
}

export const legalApi = {
  // Documents
  getDocuments: (params?: { orgId?: string; propertyId?: string; documentType?: string; status?: string }) =>
    apiClient.get("/legal/documents", params),
  getDocumentById: (id: string) => apiClient.get(`/legal/documents/${id}`),
  createDocument: (data: Partial<LegalDocument>) => apiClient.post("/legal/documents", data),
  updateDocument: (id: string, data: Partial<LegalDocument>) => apiClient.patch(`/legal/documents/${id}`, data),
  deleteDocument: (id: string) => apiClient.delete(`/legal/documents/${id}`),
  uploadDocument: (file: File, metadata: any) => {
    const formData = new FormData();
    formData.append("document", file);
    Object.entries(metadata).forEach(([k, v]) => formData.append(k, v as string));
    return apiClient.post("/legal/documents/upload", formData);
  },

  // Clauses
  getClauses: (params?: { orgId?: string; clauseType?: string; isActive?: boolean }) =>
    apiClient.get("/legal/clauses", params),
  getClauseById: (id: string) => apiClient.get(`/legal/clauses/${id}`),
  createClause: (data: any) => apiClient.post("/legal/clauses", data),
  updateClause: (id: string, data: any) => apiClient.patch(`/legal/clauses/${id}`, data),
  deleteClause: (id: string) => apiClient.delete(`/legal/clauses/${id}`),
};
