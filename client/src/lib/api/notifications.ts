import { apiClient } from "./client";

export enum NotificationStatus {
  QUEUED = "QUEUED",
  SENT = "SENT",
  READ = "READ",
  FAILED = "FAILED",
}

export interface Notification {
  id: string;
  title: string;
  body: string;
  status: NotificationStatus;
  createdAt: string;
  readAt?: string;
  data?: any;
}

export const notificationsApi = {
  getNotifications: async (params?: { limit?: number }) => {
    return await apiClient.get("/api/v1/notification", params);
  },

  markAsRead: async (id: string) => {
    return await apiClient.patch(`/api/v1/notification/${id}`, { readAt: new Date().toISOString() });
  },

  markAllAsRead: async () => {
    // Backend doesn't have read-all yet, we'll need to implement or handle locally
    return await apiClient.post("/api/v1/notification/read-all");
  },

  getUnreadCount: async () => {
    // Placeholder as backend doesn't have unread-count yet
    const res = await apiClient.get("/api/v1/notification", { readAt: null });
    return { count: Array.isArray(res) ? res.length : 0 };
  },

  delete: async (id: string) => {
    return await apiClient.delete(`/api/v1/notification/${id}`);
  },
};
