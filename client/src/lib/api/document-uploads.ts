import { apiClient } from "./client";

/* ---------------- TYPES ---------------- */

export type DocumentCategory =
  | "CONTRACT"
  | "IDENTITY"
  | "PROPERTY"
  | "FINANCIAL"
  | "LEGAL"
  | "INSPECTION"
  | "MAINTENANCE"
  | "COMMUNICATION"
  | "OTHER";

export type DocumentPermission =
  | "VIEW"
  | "DOWNLOAD"
  | "EDIT"
  | "DELETE"
  | "SHARE";

export interface DocumentUploads {
  id: string;
  orgId: string;
  name: string;
  type: string;
  category: DocumentCategory;
  description?: string;
  url: string;
  path: string;
  size: number;
  mimeType: string;
  hash: string;
  uploadedBy: string;
  uploadedAt: string;
  documentExpiresAt?: string;
  isPublic: boolean;
  isEncrypted: boolean;
  downloadCount: number;
  lastAccessedAt?: string;
  metadata?: Record<string, any>;
}

/* ---------------- API ---------------- */

export const documentUploadsApi = {
  getAll: async (orgId: string): Promise<DocumentUploads[]> =>
    await apiClient.get(`/documents`, { orgId }),

  getById: async (orgId: string, id: string): Promise<DocumentUploads> =>
    await apiClient.get(`/documents/${id}`, { orgId }),

  upload: async (
    orgId: string,
    data: {
      name: string;
      type: string;
      category: DocumentCategory;
      description?: string;
      isPublic?: boolean;
      isEncrypted?: boolean;
      expiresAt?: string;
      file: File;
    }
  ): Promise<DocumentUploads> => {
    const formData = new FormData();

    formData.append("name", data.name);
    formData.append("type", data.type);
    formData.append("category", data.category);
    formData.append("orgId", orgId);

    if (data.description) formData.append("description", data.description);
    formData.append("isPublic", String(data.isPublic ?? false));
    formData.append("isEncrypted", String(data.isEncrypted ?? false));
    if (data.expiresAt) formData.append("expiresAt", data.expiresAt);
    formData.append("file", data.file);

    return await apiClient.post(`/documents`, formData);
  },

  update: async (
    orgId: string,
    id: string,
    data: Partial<DocumentUploads>
  ): Promise<DocumentUploads> =>
    await apiClient.put(`/documents/${id}`, { ...data, orgId }),

  delete: async (orgId: string, id: string): Promise<void> => {
    await apiClient.delete(`/documents/${id}`, { params: { orgId } });
  },

  getByCategory: async (
    orgId: string,
    category: DocumentCategory
  ): Promise<DocumentUploads[]> =>
    await apiClient.get(`/documents`, {
      params: { orgId, category },
    }),

  search: async (
    orgId: string,
    query: string
  ): Promise<DocumentUploads[]> =>
    await apiClient.get(
      `/documents`,
      { params: { orgId, search: query } }
    ),

  download: async (orgId: string, id: string): Promise<Blob> => {
    const response = await fetch(`${apiClient['baseURL']}/documents/${id}/download?orgId=${orgId}`, {
      method: 'GET',
      headers: {
        'Authorization': `Bearer ${localStorage.getItem("auth_token")}`,
      },
    });
    
    if (!response.ok) {
      throw new Error(`HTTP error! status: ${response.status}`);
    }
    
    return await response.blob();
  },

  getDownloadUrl: async (
    orgId: string,
    id: string
  ): Promise<{ url: string; expiresAt?: string }> =>
    await apiClient.get(`/documents/${id}/download-url`, { orgId }),

  share: async (
    orgId: string,
    id: string,
    data: {
      sharePermissions: DocumentPermission[];
    }
  ): Promise<{
    shareUrl: string;
    shareToken: string;
    expiresAt: string;
  }> =>
    await apiClient.post(`/documents/${id}/share`, { ...data, orgId }),

  addPermission: async (
    orgId: string,
    id: string,
    data: {
      role: string;
      permissions: DocumentPermission[];
    }
  ): Promise<DocumentUploads> =>
    await apiClient.post(`/documents/${id}/permissions`, { ...data, orgId }),

  createVersion: async (
    orgId: string,
    id: string,
    data: {
      version: string;
      file: File;
    }
  ): Promise<DocumentUploads> => {
    const formData = new FormData();

    formData.append("version", data.version);
    formData.append("orgId", orgId);
    formData.append("file", data.file);

    return await apiClient.post(`/documents/${id}/versions`, formData);
  },

  getStatistics: async (orgId: string) =>
    await apiClient.get(`/documents/stats`, { orgId }),
};
