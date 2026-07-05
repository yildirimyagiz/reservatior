import { apiClient } from "./client";

// Types based on Prisma schema
export type DocumentTypeUSA = 
  | "LEASE_AGREEMENT"
  | "SALE_CONTRACT"
  | "PURCHASE_AGREEMENT"
  | "DISCLOSURE"
  | "INSPECTION_REPORT"
  | "APPRAISAL"
  | "TITLE_REPORT"
  | "DEED"
  | "MORTGAGE_DOCUMENT"
  | "INSURANCE_POLICY"
  | "PROPERTY_TAX_RECORD"
  | "HOA_DOCUMENT"
  | "PERMIT"
  | "OTHER";

export type ComplianceType = 
  | "STATE_COMPLIANCE"
  | "FEDERAL_COMPLIANCE"
  | "LOCAL_COMPLIANCE"
  | "INDUSTRY_COMPLIANCE"
  | "INTERNAL_COMPLIANCE";

export interface Document {
  id: string;
  orgId: string;
  dealId?: string;
  propertyId?: string;
  contractId?: string;
  userId?: string;
  listingId?: string;
  documentType: DocumentTypeUSA;
  title: string;
  description?: string;
  fileUrl: string;
  fileName: string;
  fileSize: number;
  mimeType: string;
  checksum: string;
  version: number;
  isRequired: boolean;
  isSigned: boolean;
  signatureRequired: boolean;
  notarizationRequired: boolean;
  recordingRequired: boolean;
  expiryDate?: string;
  complianceType?: ComplianceType;
  jurisdiction?: string;
  templateId?: string;
  tags: string[];
  analysisStatus: string;
  lastAnalyzedAt?: string;
  analysisJobId?: string;
  duplicates?: any;
  searchVector?: string;
  createdBy?: string;
  createdAt: string;
  updatedAt: string;
  deletedAt?: string;
}

export interface DocumentTemplate {
  id: string;
  orgId: string;
  name: string;
  type: string;
  category?: string;
  templateContent: string;
  variables?: any;
  isActive: boolean;
  createdBy?: string;
  createdAt: string;
  updatedAt: string;
  deletedAt?: string;
}

export interface DocumentAnalysis {
  id: string;
  documentId: string;
  jobId?: string;
  orgId?: string;
  extractedText?: string;
  metadata?: any;
  classification?: any;
  confidence?: number;
  processingTime?: number;
  createdAt: string;
  updatedAt: string;
}

export const documentsApi = {
  // Documents - matching server routes
  getDocuments: (params?: { orgId?: string; documentType?: DocumentTypeUSA; search?: string }) => 
    apiClient.get("/documents", params),
  getDocumentById: (id: string) => apiClient.get(`/documents/${id}`),
  createDocument: (data: Partial<Document>) => apiClient.post("/documents", data),
  updateDocument: (id: string, data: Partial<Document>) => apiClient.put(`/documents/${id}`, data),
  deleteDocument: (id: string) => apiClient.delete(`/documents/${id}`),
  
  // Upload - matching server route
  uploadDocument: (file: File, metadata: {
    orgId: string;
    dealId?: string;
    propertyId?: string;
    contractId?: string;
    userId?: string;
    listingId?: string;
    documentType: DocumentTypeUSA;
    title: string;
    description?: string;
    isRequired?: boolean;
    signatureRequired?: boolean;
    notarizationRequired?: boolean;
    recordingRequired?: boolean;
    expiryDate?: string;
    complianceType?: ComplianceType;
    jurisdiction?: string;
    tags?: string[];
  }) => {
    const formData = new FormData();
    formData.append("file", file);
    Object.keys(metadata).forEach(key => {
      if (metadata[key as keyof typeof metadata] !== undefined) {
        formData.append(key, String(metadata[key as keyof typeof metadata]));
      }
    });
    return apiClient.post("/documents", formData);
  },
  
  // Download
  downloadDocument: (id: string) => apiClient.get(`/documents/${id}/download`),
  
  // Templates - separate endpoints
  getDocumentTemplates: (orgId?: string) => 
    apiClient.get("/document-templates", orgId ? { orgId } : {}),
  getDocumentTemplateById: (id: string) => apiClient.get(`/document-templates/${id}`),
  createDocumentTemplate: (data: Partial<DocumentTemplate>) => apiClient.post("/document-templates", data),
  updateDocumentTemplate: (id: string, data: Partial<DocumentTemplate>) => 
    apiClient.put(`/document-templates/${id}`, data),
  deleteDocumentTemplate: (id: string) => apiClient.delete(`/document-templates/${id}`),
  
  // Generate from template
  generateDocumentFromTemplate: (templateId: string, data: any) => 
    apiClient.post(`/document-templates/${templateId}/generate`, data),
  
  // Statistics
  getDocumentStats: (params?: { orgId?: string; dateRange?: string }) => 
    apiClient.get("/documents/stats", params),
  
  // Search
  searchDocuments: (query: string, filters?: any) => 
    apiClient.post("/documents/search", { query, filters }),
  
  // Analysis
  analyzeDocument: (documentId: string) => 
    apiClient.post(`/documents/${documentId}/analyze`),
  getDocumentAnalysis: (documentId: string) => 
    apiClient.get(`/documents/${documentId}/analysis`),
  getDocumentAnalyses: (documentId: string) => apiClient.get(`/documents/${documentId}/analyses`),
  
  // ML Service OCR/Analysis integration
  analyzeDocumentWithAI: async (documentId: string): Promise<DocumentAnalysis> => {
    // This proxies to Python OCR/Classifier ML backend
    return await apiClient.post<DocumentAnalysis>(`/documents/${documentId}/analyze`);
  }
};
