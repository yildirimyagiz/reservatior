import apiClient from "./client";



// Types
export interface OwnershipVerification {
  id: string;
  propertyId: string;
  orgId: string;
  currentOwnerId?: string;
  verificationStatus: 'PENDING' | 'VERIFIED' | 'REJECTED' | 'EXPIRED' | 'SUSPENDED';
  verificationMethod: 'DOCUMENT_UPLOAD' | 'BLOCKCHAIN_VERIFICATION' | 'GOVERNMENT_API' | 'THIRD_PARTY_SERVICE' | 'MANUAL_REVIEW' | 'AI_VERIFICATION';
  verifiedAt?: string;
  verifiedBy?: string;
  expiresAt?: string;
  rejectionReason?: string;
  governmentTransactionId?: string;
  aiConfidenceScore?: number;
  manualReviewRequired: boolean;
  priorityVerification: boolean;
  verificationNotes?: string;
  supportingDocuments?: any;
  ownershipHistory?: any;
  legalDescription?: string;
  parcelNumber?: string;
  jurisdiction?: string;
  createdAt: string;
  updatedAt: string;
  
  // Relations
  property?: {
    id: string;
    name: string;
    addressLine1: string;
    city: string;
    state: string;
    zip: string;
  };
  currentOwner?: {
    id: string;
    name: string;
    email: string;
  };
  verifier?: {
    id: string;
    name: string;
    email: string;
  };
  documents?: OwnershipVerificationDocument[];
  organization?: {
    id: string;
    name: string;
    type: string;
  };
}

export interface OwnershipVerificationDocument {
  id: string;
  verificationId: string;
  documentType: 'DEED' | 'TITLE_DEED' | 'PROPERTY_TAX_RECORD' | 'MORTGAGE_STATEMENT' | 'INSURANCE_POLICY' | 'UTILITY_BILL' | 'HOA_DOCUMENT' | 'COURT_ORDER' | 'INHERITANCE_DOCUMENT' | 'TRUST_DOCUMENT' | 'CORPORATE_RESOLUTION' | 'POWER_OF_ATTORNEY' | 'OTHER';
  fileName: string;
  filePath: string;
  fileSize: number;
  mimeType: string;
  checksum: string;
  uploadMethod: 'direct' | 'api' | 'import';
  extractedText?: string;
  extractedMetadata?: any;
  validationStatus: 'valid' | 'invalid' | 'pending';
  validationErrors?: any;
  aiAnalysisResults?: any;
  reviewedAt?: string;
  reviewedBy?: string;
  reviewNotes?: string;
  isPublic: boolean;
  accessLevel: 'private' | 'organization' | 'public';
  retentionUntil?: string;
  deletedAt?: string;
  createdAt: string;
  updatedAt: string;
  
  // Relations
  verification?: {
    id: string;
    verificationStatus: string;
    property: {
      id: string;
      name: string;
      addressLine1: string;
    };
  };
  reviewer?: {
    id: string;
    name: string;
    email: string;
  };
}

export interface PropertyOwnershipTransfer {
  id: string;
  propertyId: string;
  orgId: string;
  fromOwnerId?: string;
  toOwnerId?: string;
  transferType: 'sale' | 'inheritance' | 'gift' | 'foreclosure';
  transferStatus: 'pending' | 'completed' | 'cancelled';
  transferDate?: string;
  recordingDate?: string;
  considerationAmount?: number;
  transferDocuments?: any;
  legalDescription?: string;
  blockchainTransactionId?: string;
  governmentReference?: string;
  transferNotes?: string;
  createdAt: string;
  updatedAt: string;
  
  // Relations
  property?: {
    id: string;
    name: string;
    addressLine1: string;
  };
  organization?: {
    id: string;
    name: string;
  };
  fromOwner?: {
    id: string;
    name: string;
    email: string;
  };
  toOwner?: {
    id: string;
    name: string;
    email: string;
  };
}

export interface OwnershipVerificationAnalytics {
  summary: {
    total: number;
    verified: number;
    pending: number;
    rejected: number;
    expired: number;
    verificationRate: string;
    averageConfidence: string;
  };
  byMethod: Array<{
    verificationMethod: string;
    _count: number;
  }>;
  recent: OwnershipVerification[];
}

// API Client
export const ownershipVerificationApi = {
  // Get all ownership verifications
  getVerifications: async (params?: {
    page?: number;
    limit?: number;
    propertyId?: string;
    orgId?: string;
    verificationStatus?: string;
    verificationMethod?: string;
  }): Promise<{
    verifications: OwnershipVerification[];
    pagination: {
      page: number;
      limit: number;
      total: number;
      totalPages: number;
    };
  }> => {
    const queryParams = new URLSearchParams();
    if (params) {
      Object.entries(params).forEach(([key, value]) => {
        if (value !== undefined) {
          queryParams.append(key, value.toString());
        }
      });
    }
    
    return await apiClient.get(`/property-ownership-verification?${queryParams.toString()}`);
  },

  // Get single ownership verification
  getVerificationById: async (id: string): Promise<{ data: OwnershipVerification }> => {
    return await apiClient.get(`/property-ownership-verification/${id}`);
  },

  // Create ownership verification
  createVerification: async (data: {
    propertyId: string;
    orgId: string;
    currentOwnerId?: string;
    verificationMethod: 'DOCUMENT_UPLOAD' | 'BLOCKCHAIN_VERIFICATION' | 'GOVERNMENT_API' | 'THIRD_PARTY_SERVICE' | 'MANUAL_REVIEW' | 'AI_VERIFICATION';
    verificationNotes?: string;
    supportingDocuments?: any;
    legalDescription?: string;
    parcelNumber?: string;
    jurisdiction?: string;
  }): Promise<{ data: OwnershipVerification }> => {
    return await apiClient.post('/property-ownership-verification', data);
  },

  // Update verification status
  updateVerificationStatus: async (id: string, data: {
    verificationStatus: 'PENDING' | 'VERIFIED' | 'REJECTED' | 'EXPIRED' | 'SUSPENDED';
    rejectionReason?: string;
    aiConfidenceScore?: number;
  }): Promise<{ data: OwnershipVerification }> => {
    return await apiClient.put(`/property-ownership-verification/${id}/status`, data);
  },

  // Upload verification document
  uploadDocument: async (verificationId: string, data: {
    documentType: 'DEED' | 'TITLE_DEED' | 'PROPERTY_TAX_RECORD' | 'MORTGAGE_STATEMENT' | 'INSURANCE_POLICY' | 'UTILITY_BILL' | 'HOA_DOCUMENT' | 'COURT_ORDER' | 'INHERITANCE_DOCUMENT' | 'TRUST_DOCUMENT' | 'CORPORATE_RESOLUTION' | 'POWER_OF_ATTORNEY' | 'OTHER';
    fileName: string;
    filePath: string;
    fileSize: number;
    mimeType: string;
    checksum: string;
    uploadMethod: 'direct' | 'api' | 'import';
    extractedText?: string;
    extractedMetadata?: any;
    accessLevel?: 'private' | 'organization' | 'public';
    retentionUntil?: string;
  }): Promise<{ data: OwnershipVerificationDocument }> => {
    return await apiClient.post(`/property-ownership-verification/${verificationId}/documents`, data);
  },

  // Review document
  reviewDocument: async (documentId: string, data: {
    validationStatus: 'valid' | 'invalid' | 'pending';
    validationErrors?: any;
    reviewNotes?: string;
  }): Promise<{ data: OwnershipVerificationDocument }> => {
    return await apiClient.put(`/property-ownership-verification/documents/${documentId}/review`, data);
  },

  // Get verification transfers
  getTransfers: async (propertyId: string): Promise<{ data: PropertyOwnershipTransfer[] }> => {
    return await apiClient.get(`/property-ownership-verification/${propertyId}/transfers`);
  },

  // Create ownership transfer
  createTransfer: async (propertyId: string, data: {
    orgId: string;
    fromOwnerId?: string;
    toOwnerId?: string;
    transferType: 'sale' | 'inheritance' | 'gift' | 'foreclosure';
    transferDate?: string;
    considerationAmount?: number;
    transferDocuments?: any;
    legalDescription?: string;
    blockchainTransactionId?: string;
    governmentReference?: string;
    transferNotes?: string;
  }): Promise<{ data: PropertyOwnershipTransfer }> => {
    return await apiClient.post(`/property-ownership-verification/${propertyId}/transfers`, data);
  },

  // Get verification analytics
  getAnalytics: async (params?: {
    orgId?: string;
    startDate?: string;
    endDate?: string;
  }): Promise<OwnershipVerificationAnalytics> => {
    const queryParams = new URLSearchParams();
    if (params) {
      Object.entries(params).forEach(([key, value]) => {
        if (value !== undefined) {
          queryParams.append(key, value.toString());
        }
      });
    }
    
    return await apiClient.get(`/property-ownership-verification/analytics/summary?${queryParams.toString()}`);
  },

  // Helper method to upload file with checksum
  uploadFileWithChecksum: async (
    verificationId: string,
    file: File,
    documentType: OwnershipVerificationDocument['documentType'],
    options?: {
      extractedText?: string;
      extractedMetadata?: any;
      accessLevel?: 'private' | 'organization' | 'public';
      retentionUntil?: string;
    }
  ): Promise<{ data: OwnershipVerificationDocument }> => {
    // Generate checksum
    const buffer = await file.arrayBuffer();
    const checksum = await crypto.subtle.digest('SHA-256', buffer);
    const checksumHex = Array.from(new Uint8Array(checksum))
      .map(b => b.toString(16).padStart(2, '0'))
      .join('');

    // Upload file (this would typically go through a file upload endpoint first)
    // For now, we'll assume the file is uploaded and we have the path
    const filePath = `/uploads/ownership-documents/${file.name}`;
    
    return await ownershipVerificationApi.uploadDocument(verificationId, {
      documentType,
      fileName: file.name,
      filePath,
      fileSize: file.size,
      mimeType: file.type,
      checksum: checksumHex,
      uploadMethod: 'direct',
      extractedText: options?.extractedText,
      extractedMetadata: options?.extractedMetadata,
      accessLevel: options?.accessLevel,
      retentionUntil: options?.retentionUntil
    });
  }
};

export default ownershipVerificationApi;
