import { apiClient } from "./client";

export interface MigrationBenefit {
  title: string;
  description: string;
  value: string;
  free: boolean;
  icon: string;
}

export interface DriveSyncResult {
  propertyId: string;
  projectId: string;
  folderName: string;
  filesFound: number;
  files: Array<{ name: string; url: string; type?: string }>;
}

export const aiMigrationApi = {
  getBenefits: () => apiClient.get<{ benefits: MigrationBenefit[], totalValue: string }>("/ai-migration/benefits"),
  analyze: (url: string, userId: string) => 
    apiClient.post<any>("/ai-migration/analyze", { url, userId }),
  execute: (url: string, userId: string, preferences: any) => 
    apiClient.post<any>("/ai-migration/execute", { url, userId, preferences }),
  getSyncStatus: (propertyId: string) => 
    apiClient.get<any>(`/ai-migration/status/${propertyId}`),
  driveSync: (folderUrl: string, orgId: string, userId: string) => 
    apiClient.post<{ success: boolean; data: DriveSyncResult; message: string }>("/ai-migration/drive-sync", { folderUrl, orgId, userId }),
};
