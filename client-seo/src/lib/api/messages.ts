import { apiClient } from "./client";

export interface MessageThread {
  id: string;
  subject?: string;
  lastMessage?: string;
  updatedAt: string;
  participants: {
    id: string;
    name: string;
    avatar?: string;
    role: string;
  }[];
  unreadCount: number;
}

export interface Message {
  id: string;
  threadId: string;
  body: string;
  senderId: string;
  senderType: 'USER' | 'AGENT' | 'SYSTEM';
  createdAt: string;
  attachments?: any[];
}

export const messagesApi = {
  getThreads: async () => {
    return await apiClient.get("/api/v1/message/threads");
    
  },

  getMessages: async (threadId: string) => {
    return await apiClient.get(`/api/v1/message/threads/${threadId}`);
    
  },

  sendMessage: async (threadId: string, body: string, attachments?: File[]) => {
    const formData = new FormData();
    formData.append("body", body);
    if (attachments) {
      attachments.forEach((file) => formData.append("attachments", file));
    }
    return await apiClient.post(`/api/v1/message/threads/${threadId}`, formData, {
      headers: { "Content-Type": "multipart/form-data" },
    });
    
  },

  createThread: async (participantIds: string[], subject?: string) => {
    return await apiClient.post("/api/v1/message/threads", { participantIds, subject });
    
  },

  markAsRead: async (threadId: string) => {
    return await apiClient.post(`/api/v1/message/threads/${threadId}/read`);
    
  },
};
