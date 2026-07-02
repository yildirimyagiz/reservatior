import { apiClient } from "./client";

export interface MobileDevice {
  id: string;
  userId: string;
  deviceId: string;
  platform: string;
  model?: string;
  osVersion?: string;
  appVersion?: string;
  pushToken?: string;
  isActive: boolean;
  lastSeenAt?: string;
  createdAt: string;
  updatedAt: string;
  user?: {
    id: string;
    name: string;
    email: string;
  };
}

export interface MobileDeviceCreate {
  userId: string;
  deviceId: string;
  platform: string;
  model?: string;
  osVersion?: string;
  appVersion?: string;
  pushToken?: string;
  isActive: boolean;
}

export interface MobileDeviceUpdate {
  deviceId?: string;
  platform?: string;
  model?: string;
  osVersion?: string;
  appVersion?: string;
  pushToken?: string;
  isActive?: boolean;
  lastSeenAt?: string;
}

export interface PushNotificationData {
  title: string;
  message: string;
  data?: any;
}

export const mobileDevicesApi = {
  getAll: async (params?: {
    userId?: string;
    platform?: string;
    isActive?: boolean;
  }) => {
    return await apiClient.get("/api/v1/mobile-device", { params });
    
  },

  getById: async (id: string) => {
    return await apiClient.get(`/api/v1/mobile-device/${id}`);
    
  },

  create: async (data: MobileDeviceCreate) => {
    return await apiClient.post("/api/v1/mobile-device", data);
    
  },

  update: async (id: string, data: MobileDeviceUpdate) => {
    return await apiClient.patch(`/api/v1/mobile-device/${id}`, data);
    
  },

  delete: async (id: string) => {
    return await apiClient.delete(`/api/v1/mobile-device/${id}`, {
      data: { tags: [] },
    });
    
  },

  // Get devices for user
  getUserDevices: async (userId: string) => {
    return await apiClient.get("/api/v1/mobile-device", {
      params: { userId },
    });
    
  },

  // Send push notification to device
  sendPushNotification: async (deviceId: string, data: PushNotificationData) => {
    return await apiClient.post(`/api/v1/mobile-device/${deviceId}/push`, data);
    
  },

  // Update device last seen
  updateLastSeen: async (deviceId: string) => {
    return await apiClient.patch(`/api/v1/mobile-device/${deviceId}`, {
      lastSeenAt: new Date().toISOString(),
    });
    
  },
};
