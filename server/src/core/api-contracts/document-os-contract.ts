/**
 * Document OS API Contract
 * Defines the API interface for Document OS operations
 */

export interface DocumentOSAPIContract {
  // Document CRUD Operations
  createDocument(params: CreateDocumentParams): Promise<DocumentResponse>;
  getDocument(documentId: string): Promise<DocumentResponse>;
  updateDocument(documentId: string, params: UpdateDocumentParams): Promise<DocumentResponse>;
  deleteDocument(documentId: string): Promise<void>;
  
  // Document Operations
  uploadDocument(params: UploadDocumentParams): Promise<DocumentResponse>;
  downloadDocument(documentId: string): Promise<DownloadResponse>;
  archiveDocument(documentId: string): Promise<DocumentResponse>;
  restoreDocument(documentId: string): Promise<DocumentResponse>;
  
  // Signature Operations
  requestSignature(documentId: string, signers: Signer[]): Promise<SignatureRequestResponse>;
  signDocument(documentId: string, signatureData: SignatureData): Promise<DocumentResponse>;
  getSignatureStatus(documentId: string): Promise<SignatureStatusResponse>;
  
  // Version Operations
  createVersion(documentId: string): Promise<VersionResponse>;
  getVersions(documentId: string): Promise<VersionResponse[]>;
  compareVersions(documentId: string, version1: string, version2: string): Promise<ComparisonResponse>;
  restoreVersion(documentId: string, versionId: string): Promise<DocumentResponse>;
  
  // Template Operations
  createTemplate(params: CreateTemplateParams): Promise<TemplateResponse>;
  getTemplate(templateId: string): Promise<TemplateResponse>;
  updateTemplate(templateId: string, params: UpdateTemplateParams): Promise<TemplateResponse>;
  deleteTemplate(templateId: string): Promise<void>;
  useTemplate(templateId: string, params: UseTemplateParams): Promise<DocumentResponse>;
  
  // Search Operations
  searchDocuments(params: SearchParams): Promise<SearchResponse>;
  filterDocuments(params: FilterParams): Promise<SearchResponse>;
  exportDocuments(params: ExportParams): Promise<ExportResponse>;
  
  // Compliance Operations
  checkCompliance(documentId: string): Promise<ComplianceResponse>;
  getComplianceReport(params: ComplianceReportParams): Promise<ComplianceReportResponse>;
  
  // Integration Operations
  manageIntegration(integrationId: string, config: any): Promise<void>;
  manageWebhook(webhookId: string, config: any): Promise<void>;
}

// Request/Response Types
export interface CreateDocumentParams {
  name: string;
  documentType: string;
  content: string;
  organizationId: string;
  createdBy: string;
  metadata?: Record<string, any>;
}

export interface UpdateDocumentParams {
  name?: string;
  content?: string;
  metadata?: Record<string, any>;
  status?: string;
}

export interface DocumentResponse {
  id: string;
  name: string;
  documentType: string;
  status: 'draft' | 'pending' | 'approved' | 'rejected' | 'archived';
  organizationId: string;
  createdBy: string;
  createdAt: string;
  updatedAt: string;
  version: number;
  signatureStatus: 'none' | 'pending' | 'completed';
}

export interface UploadDocumentParams {
  file: File;
  documentType: string;
  organizationId: string;
  createdBy: string;
}

export interface DownloadResponse {
  documentId: string;
  downloadUrl: string;
  expiresAt: string;
  mimeType: string;
  fileSize: number;
}

export interface Signer {
  email: string;
  name: string;
  role: string;
}

export interface SignatureRequestResponse {
  requestId: string;
  documentId: string;
  signers: Signer[];
  status: 'pending' | 'completed' | 'cancelled';
  expiresAt: string;
}

export interface SignatureData {
  signature: string;
  signerId: string;
  signedAt: string;
}

export interface SignatureStatusResponse {
  documentId: string;
  status: 'none' | 'pending' | 'completed';
  signatures: Array<{
    signerId: string;
    name: string;
    status: 'pending' | 'signed';
    signedAt?: string;
  }>;
}

export interface VersionResponse {
  id: string;
  documentId: string;
  version: number;
  createdAt: string;
  createdBy: string;
  changes: string[];
}

export interface ComparisonResponse {
  documentId: string;
  version1: string;
  version2: string;
  similarity: number;
  differences: Array<{
    type: string;
    location: string;
    description: string;
  }>;
}

export interface CreateTemplateParams {
  name: string;
  documentType: string;
  content: string;
  organizationId: string;
  variables: string[];
}

export interface UpdateTemplateParams {
  name?: string;
  content?: string;
  variables?: string[];
}

export interface TemplateResponse {
  id: string;
  name: string;
  documentType: string;
  organizationId: string;
  variables: string[];
  createdAt: string;
  updatedAt: string;
}

export interface UseTemplateParams {
  variableValues: Record<string, string>;
  createdBy: string;
}

export interface SearchParams {
  query: string;
  documentType?: string;
  organizationId: string;
  limit?: number;
  offset?: number;
}

export interface FilterParams {
  filters: Record<string, any>;
  organizationId: string;
  limit?: number;
  offset?: number;
}

export interface SearchResponse {
  documents: DocumentResponse[];
  total: number;
  page: number;
  limit: number;
}

export interface ExportParams {
  documentIds: string[];
  format: 'pdf' | 'docx' | 'zip';
}

export interface ExportResponse {
  exportId: string;
  status: 'processing' | 'completed' | 'failed';
  downloadUrl?: string;
  format: string;
}

export interface ComplianceResponse {
  documentId: string;
  complianceScore: number;
  violations: Array<{
    type: string;
    severity: 'low' | 'medium' | 'high';
    description: string;
  }>;
  recommendations: string[];
}

export interface ComplianceReportParams {
  organizationId: string;
  startDate: string;
  endDate: string;
  documentType?: string;
}

export interface ComplianceReportResponse {
  reportId: string;
  organizationId: string;
  overallScore: number;
  documentCount: number;
  compliantCount: number;
  nonCompliantCount: number;
  violations: Array<{
    documentId: string;
    type: string;
    severity: string;
  }>;
  generatedAt: string;
}
