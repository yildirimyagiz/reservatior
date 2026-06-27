import { apiClient } from "./client";

export enum ReportStatus {
  ACTIVE = "ACTIVE",
  PAUSED = "PAUSED",
  DRAFT = "DRAFT",
}

export enum ReportExecutionStatus {
  SUCCESS = "SUCCESS",
  FAILED = "FAILED",
  RUNNING = "RUNNING",
  PENDING = "PENDING",
}

export interface Report {
  id: string;
  orgId: string;
  userId: string;
  name: string;
  description: string;
  reportType: string;
  schedule?: string;
  lastRunAt?: string;
  nextRunAt?: string;
  status: ReportStatus;
  lastRunStatus?: ReportExecutionStatus;
  createdAt: string;
  updatedAt: string;
  executions?: ReportExecution[];
  user?: {
    id: string;
    name: string;
    email: string;
  };
}

export interface ReportExecution {
  id: string;
  orgId: string;
  reportId: string;
  status: ReportExecutionStatus;
  startedAt: string;
  completedAt?: string;
  errorMessage?: string;
  fileUrl?: string;
  recordCount?: number;
  createdAt: string;
}

export const reportsApi = {
  getReports: (params?: any) => apiClient.get<Report[]>("/reports", params),
  getReportById: (id: string, params?: any) => apiClient.get<Report>(`/reports/${id}`, params),
  createReport: (data: Partial<Report>) => apiClient.post<Report>("/reports", data),
  updateReport: (id: string, data: Partial<Report>) => apiClient.patch<Report>(`/reports/${id}`, data),
  deleteReport: (id: string) => apiClient.delete(`/reports/${id}`),
  runReport: (id: string) => apiClient.post(`/reports/${id}/run`),
  downloadReport: (id: string) => apiClient.get(`/reports/${id}/download`)
};
