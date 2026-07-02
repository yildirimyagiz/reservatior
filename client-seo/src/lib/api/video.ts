import { apiClient } from "./client";

export interface VideoContent {
  id: string;
  propertyId?: string;
  listingId?: string;
  title?: string;
  primaryLoraStyle: string;
  secondaryLoraStyle?: string;
  primaryLoraScale?: number;
  secondaryLoraScale?: number;
  pipeline: string;
  prompt: string;
  negativePrompt?: string;
  strategy?: string;
  durationSeconds?: number;
  platform: string;
  status: string;
  renderingJobId?: string;
  storageKey?: string;
  url?: string;
  thumbnailUrl?: string;
  fileSize?: number;
  mimeType?: string;
  engagementData?: Record<string, any>;
  campaignType?: string;
  createdAt: string;
  updatedAt: string;
}

export interface AIToolConfig {
  toolId: string;
  params: Record<string, any>;
}

export interface VideoProject {
  id: string;
  title: string;
  videoContentId?: string;
  pipeline: string;
  loraStyle: string;
  platform: string;
  status: string;
  progress?: number;
  aiTools: AIToolConfig[];
}

export interface PipelineStatus {
  engine: string;
  status: "online" | "offline" | "standby";
  latency?: number;
}

export const videoApi = {
  // CRUD
  getVideos: (params?: any) => apiClient.get<VideoContent[]>("/video", { params }),
  getVideoById: (id: string) => apiClient.get<VideoContent>(`/video/${id}`),
  getPropertyVideos: (propertyId: string) => apiClient.get<VideoContent[]>(`/video/property/${propertyId}`),
  generateVideo: (data: Partial<VideoContent>) => apiClient.post<VideoContent>("/video/generate", data),
  updateVideo: (id: string, data: Partial<VideoContent>) => apiClient.patch<VideoContent>(`/video/${id}`, data),
  deleteVideo: (id: string) => apiClient.delete(`/video/${id}`),

  // AI Tools
  applyAITool: (videoId: string, tool: AIToolConfig) =>
    apiClient.post(`/video/${videoId}/ai-tool`, tool),
  getAIToolStatus: (videoId: string, jobId: string) =>
    apiClient.get(`/video/${videoId}/ai-tool/${jobId}/status`),

  // Pipeline management
  getPipelineStatus: () =>
    apiClient.get<PipelineStatus[]>("/video/pipelines/status"),
  getAvailableEngine: () =>
    apiClient.get<{ engine: string }>("/video/pipelines/available"),

  // Staging & Enhancement (proxied to ml-services)
  stageImage: (data: { imagePath: string; roomType: string; style: string }) =>
    apiClient.post("/ai-video-generation/stage", data),
  enhanceImage: (data: { imagePath: string; upscaleFactor?: number }) =>
    apiClient.post("/ai-video-generation/enhance", data),
  generateVoiceover: (data: { text: string; language?: string }) =>
    apiClient.post("/ai-video-generation/voiceover", data),
  generateWalkthrough: (data: { photoCount: number; roomTypes: string[]; luxuryFlag?: boolean }) =>
    apiClient.post("/ai-video-generation/walkthrough", data),
};
