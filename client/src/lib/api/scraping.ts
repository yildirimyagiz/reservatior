import { apiClient } from "./client";

export interface ScrapingJob {
  id: string;
  jobType: "sahibinden" | "emlakjet" | "hurriyetemlak" | string;
  status: "pending" | "running" | "completed" | "failed";
  startTime?: string;
  endTime?: string;
  projectsScraped: number;
  errors: string[];
  configuration: any;
  createdAt: string;
  updatedAt: string;
}

export const scrapingApi = {
  getJobs: (params?: any) => 
    apiClient.get<{ data: ScrapingJob[] }>("/scraping/jobs", { params }),
  
  getJobById: (id: string) => 
    apiClient.get<{ data: ScrapingJob }>(`/scraping/jobs/${id}`),
  
  createJob: (data: { jobType: string; configuration: any }) => 
    apiClient.post<{ data: ScrapingJob }>("/scraping/jobs", data),
  
  retryJob: (id: string) => 
    apiClient.post<{ data: ScrapingJob }>(`/scraping/jobs/${id}/retry`),
  
  deleteJob: (id: string) => 
    apiClient.delete(`/scraping/jobs/${id}`),
};
