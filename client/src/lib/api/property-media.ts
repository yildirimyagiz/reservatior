import { apiClient } from "./client";

export const propertyMediaApi = {
  // Photos
  getPhotos: (params?: { orgId?: string; propertyId?: string; isPrimary?: boolean }) =>
    apiClient.get("/property-media/photos", params),
  getPhotoById: (id: string) => apiClient.get(`/property-media/photos/${id}`),
  uploadPhoto: (propertyId: string, file: File, data?: any) => {
    const formData = new FormData();
    formData.append("file", file);
    formData.append("propertyId", propertyId);
    if (data) Object.entries(data).forEach(([k, v]) => formData.append(k, v as string));
    return apiClient.post("/property-media/photos", formData);
  },
  updatePhoto: (id: string, data: any) => apiClient.patch(`/property-media/photos/${id}`, data),
  deletePhoto: (id: string) => apiClient.delete(`/property-media/photos/${id}`),
  setPrimary: (id: string) => apiClient.patch(`/property-media/photos/${id}/primary`),
  reorderPhotos: (propertyId: string, photoIds: string[]) =>
    apiClient.patch(`/property-media/photos/reorder`, { propertyId, photoIds }),

  // Videos
  getVideos: (params?: { orgId?: string; propertyId?: string }) =>
    apiClient.get("/property-media/videos", params),
  createVideo: (data: any) => apiClient.post("/property-media/videos", data),
  updateVideo: (id: string, data: any) => apiClient.patch(`/property-media/videos/${id}`, data),
  deleteVideo: (id: string) => apiClient.delete(`/property-media/videos/${id}`),
};
