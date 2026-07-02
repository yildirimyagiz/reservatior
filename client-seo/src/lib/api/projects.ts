import { apiClient } from "./client";

export interface Project {
  id: string;
  name: string;
  description?: string;
  projectType: string;
  propertyId?: string;
  status: string;
  startDate?: string;
  estimatedEndDate?: string;
  budget?: number;
  actualCost?: number;
  createdAt: string;
  updatedAt: string;
}

export interface ProjectAlert {
  id: string;
  projectId: string;
  type: string;
  message: string;
  severity: string;
  isResolved: boolean;
  createdAt: string;
}

export const projectsApi = {
  getProjects: (params?: any) => apiClient.get<Project[]>("/project", { params }),
  getProjectById: (id: string) => apiClient.get<Project>(`/project/${id}`),
  getPropertyProjects: (propertyId: string) => apiClient.get<Project[]>(`/project/property/${propertyId}`),
  getProjectAlerts: (projectId: string) => apiClient.get<ProjectAlert[]>(`/project/${projectId}/alerts`),
  createProject: (data: Partial<Project>) => apiClient.post<Project>("/project", data),
  updateProject: (id: string, data: Partial<Project>) => apiClient.patch<Project>(`/project/${id}`, data),
  deleteProject: (id: string) => apiClient.delete(`/project/${id}`),

  // Project Analytics API
  getProjectAnalytics: (projectId: string) => apiClient.get<ProjectAnalytics[]>(`/project-analytics`, { params: { projectId } }),
  getProjectAnalyticsById: (id: string) => apiClient.get<ProjectAnalytics>(`/project-analytics/${id}`),
  createProjectAnalytics: (data: Partial<ProjectAnalytics>) => apiClient.post<ProjectAnalytics>(`/project-analytics`, data),

  // Project Reports API
  getProjectReports: (projectId: string) => apiClient.get<ProjectReport[]>(`/project-report`, { params: { projectId } }),
  getProjectReportById: (id: string) => apiClient.get<ProjectReport>(`/project-report/${id}`),
  createProjectReport: (data: Partial<ProjectReport>) => apiClient.post<ProjectReport>(`/project-report`, data),
};

export interface ProjectAnalytics {
  id: string;
  projectId: string;
  analysisType: string;
  analysisData: any;
  insights: string[];
  recommendations: string[];
  score?: number;
  createdAt: string;
  updatedAt: string;
}

export interface ProjectReport {
  id: string;
  projectId?: string;
  reportType: string;
  title: string;
  content: string;
  data: any;
  generatedBy: string;
  createdAt: string;
  updatedAt: string;
}
