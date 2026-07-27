import { getLocalizationHeaders } from './localization-helper';

export const documentOSApi = {
  getDashboardStats: async (orgId: string) => {
    const res = await fetch(`/api/v1/document-os/dashboard?orgId=${orgId}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to fetch document OS dashboard stats');
    return res.json();
  },

  uploadDocument: async (data: FormData) => {
    const res = await fetch('/api/v1/document-os/upload', {
      method: 'POST',
      headers: getLocalizationHeaders(),
      body: data,
    });
    if (!res.ok) throw new Error('Failed to upload document');
    return res.json();
  },

  createFromTemplate: async (templateId: string, variables: Record<string, any>, orgId: string) => {
    const res = await fetch(`/api/v1/document-os/from-template?orgId=${orgId}`, {
      method: 'POST',
      headers: { 
        'Content-Type': 'application/json',
        ...getLocalizationHeaders(),
      },
      body: JSON.stringify({ templateId, variables }),
    });
    if (!res.ok) throw new Error('Failed to create document from template');
    return res.json();
  },

  requestSignature: async (documentId: string, signers: Array<{ email: string; name: string }>) => {
    const res = await fetch(`/api/v1/document-os/${documentId}/signature`, {
      method: 'POST',
      headers: { 
        'Content-Type': 'application/json',
        ...getLocalizationHeaders(),
      },
      body: JSON.stringify({ signers }),
    });
    if (!res.ok) throw new Error('Failed to request signature');
    return res.json();
  },

  approveDocument: async (documentId: string, approverId: string, comments?: string) => {
    const res = await fetch(`/api/v1/document-os/${documentId}/approve`, {
      method: 'POST',
      headers: { 
        'Content-Type': 'application/json',
        ...getLocalizationHeaders(),
      },
      body: JSON.stringify({ approverId, comments }),
    });
    if (!res.ok) throw new Error('Failed to approve document');
    return res.json();
  },

  createVersion: async (documentId: string, file: File) => {
    const formData = new FormData();
    formData.append('file', file);
    const res = await fetch(`/api/v1/document-os/${documentId}/version`, {
      method: 'POST',
      headers: getLocalizationHeaders(),
      body: formData,
    });
    if (!res.ok) throw new Error('Failed to create version');
    return res.json();
  },

  searchDocuments: async (query: string, filters: {
    documentType?: string;
    status?: string;
    organizationId: string;
    tags?: string[];
  }) => {
    const res = await fetch('/api/v1/document-os/search', {
      method: 'POST',
      headers: { 
        'Content-Type': 'application/json',
        ...getLocalizationHeaders(),
      },
      body: JSON.stringify({ query, filters }),
    });
    if (!res.ok) throw new Error('Failed to search documents');
    return res.json();
  },

  getDocumentTimeline: async (documentId: string) => {
    const res = await fetch(`/api/v1/document-os/${documentId}/timeline`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to fetch document timeline');
    return res.json();
  },

  archiveDocument: async (documentId: string) => {
    const res = await fetch(`/api/v1/document-os/${documentId}/archive`, {
      method: 'POST',
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to archive document');
    return res.json();
  },

  deleteDocument: async (documentId: string) => {
    const res = await fetch(`/api/v1/document-os/${documentId}`, {
      method: 'DELETE',
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to delete document');
    return res.json();
  },

  getDocumentTrends: async (orgId: string) => {
    const res = await fetch(`/api/v1/document-os/document-trends?orgId=${orgId}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to fetch document trends');
    return res.json();
  },

  getDocumentTypes: async (orgId: string) => {
    const res = await fetch(`/api/v1/document-os/document-types?orgId=${orgId}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to fetch document types');
    return res.json();
  },
};
