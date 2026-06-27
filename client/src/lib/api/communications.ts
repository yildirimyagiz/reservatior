import { apiClient } from "./client";

export enum ChannelType {
  PUBLIC = "PUBLIC",
  PRIVATE = "PRIVATE",
  AGENCY = "AGENCY",
  SUPPORT = "SUPPORT",
}

export enum ChannelCategory {
  AGENCY = "AGENCY",
  PROPERTY = "PROPERTY",
  GENERAL = "GENERAL",
}

export interface Channel {
  id: string;
  orgId: string;
  name: string;
  type: ChannelType;
  category: ChannelCategory;
  description?: string;
  isActive: boolean;
  memberCount: number;
  createdAt: string;
  updatedAt: string;
}

export interface CommunicationLog {
  id: string;
  orgId: string;
  senderId: string;
  receiverId?: string;
  channelId?: string;
  ticketId?: string;
  type: "MESSAGE" | "EMAIL" | "NOTIFICATION" | "TICKET_REPLY" | "SYSTEM_ANNOUNCEMENT";
  content: string;
  isRead: boolean;
  priority: "LOW" | "NORMAL" | "HIGH" | "URGENT";
  status: "SENT" | "DELIVERED" | "READ" | "FAILED";
  attachments?: Array<{
    id: string;
    name: string;
    type: string;
    url: string;
    size: number;
  }>;
  metadata?: Record<string, any>;
  createdAt: string;
  readAt?: string;
  sender?: {
    id: string;
    firstName: string;
    lastName: string;
    email: string;
    avatar?: string;
  };
  receiver?: {
    id: string;
    firstName: string;
    lastName: string;
    email: string;
    avatar?: string;
  };
  channel?: {
    id: string;
    name: string;
    type: ChannelType;
  };
}

export interface SupportTicket {
  id: string;
  orgId: string;
  userId: string;
  subject: string;
  description: string;
  category: "TECHNICAL" | "BILLING" | "GENERAL" | "FEATURE_REQUEST" | "BUG_REPORT";
  priority: "LOW" | "NORMAL" | "HIGH" | "URGENT";
  status: "OPEN" | "IN_PROGRESS" | "RESOLVED" | "CLOSED" | "REOPENED";
  assignedTo?: string;
  createdAt: string;
  updatedAt: string;
  resolvedAt?: string;
  user?: {
    id: string;
    firstName: string;
    lastName: string;
    email: string;
  };
  assignedAgent?: {
    id: string;
    firstName: string;
    lastName: string;
    email: string;
  };
  messages?: CommunicationLog[];
}

export const communicationsApi = {
  // Get all channels
  getChannels: async (filters?: {
    type?: ChannelType;
    category?: ChannelCategory;
    isActive?: boolean;
  }): Promise<Channel[]> => {
    const response = await apiClient.get<Channel[]>(`/api/v1/channel`, {
      params: { ...filters }
    });
    return response;
  },

  // Get channel by ID
  getChannelById: async (channelId: string): Promise<Channel> => {
    const response = await apiClient.get<Channel>(`/api/v1/channel/${channelId}`);
    return response;
  },

  // Create new channel
  createChannel: async (data: Omit<Channel, 'id' | 'createdAt' | 'updatedAt' | 'memberCount'>): Promise<Channel> => {
    const response = await apiClient.post<Channel>(`/api/v1/channel`, data);
    return response;
  },

  // Update channel
  updateChannel: async (channelId: string, data: Partial<Channel>): Promise<Channel> => {
    const response = await apiClient.put<Channel>(`/api/v1/channel/${channelId}`, data);
    return response;
  },

  // Delete channel
  deleteChannel: async (channelId: string): Promise<void> => {
    await apiClient.delete(`/api/v1/channel/${channelId}`);
  },

  // Get channel messages
  getChannelMessages: async (channelId: string, filters?: {
    limit?: number;
    before?: string;
    after?: string;
    type?: "MESSAGE" | "EMAIL" | "NOTIFICATION" | "TICKET_REPLY" | "SYSTEM_ANNOUNCEMENT";
  }): Promise<CommunicationLog[]> => {
    const response = await apiClient.get<CommunicationLog[]>(`/api/v1/channel/${channelId}/messages`, {
      params: { ...filters }
    });
    return response;
  },

  // Send message
  sendMessage: async (data: {
    channelId?: string;
    ticketId?: string;
    receiverId?: string;
    content: string;
    type?: "MESSAGE" | "EMAIL" | "NOTIFICATION" | "TICKET_REPLY" | "SYSTEM_ANNOUNCEMENT";
    priority?: "LOW" | "NORMAL" | "HIGH" | "URGENT";
    attachments?: Array<{
      name: string;
      file: File;
    }>;
    metadata?: Record<string, any>;
  }): Promise<CommunicationLog> => {
    const formData = new FormData();
    if (data.channelId) formData.append('channelId', data.channelId);
    if (data.ticketId) formData.append('ticketId', data.ticketId);
    if (data.receiverId) formData.append('receiverId', data.receiverId);
    formData.append('content', data.content);
    if (data.type) formData.append('type', data.type);
    if (data.priority) formData.append('priority', data.priority);
    if (data.metadata) formData.append('metadata', JSON.stringify(data.metadata));
    
    if (data.attachments) {
      data.attachments.forEach((attachment, index) => {
        formData.append(`attachments[${index}].name`, attachment.name);
        formData.append(`attachments[${index}].file`, attachment.file);
      });
    }

    const response = await apiClient.post<CommunicationLog>(`/organizations/current/messages`, formData, {
      headers: {
        'Content-Type': 'multipart/form-data',
      },
    });
    return response;
  },

  // Get all messages
  getAllMessages: async (filters?: {
    channelId?: string;
    userId?: string;
    type?: "MESSAGE" | "EMAIL" | "NOTIFICATION" | "TICKET_REPLY" | "SYSTEM_ANNOUNCEMENT";
    status?: "SENT" | "DELIVERED" | "READ" | "FAILED";
    isRead?: boolean;
    startDate?: string;
    endDate?: string;
    limit?: number;
  }): Promise<CommunicationLog[]> => {
    const response = await apiClient.get<CommunicationLog[]>(`/organizations/current/messages`, {
      params: { ...filters }
    });
    return response;
  },

  // Mark messages as read
  markAsRead: async (messageIds: string[]): Promise<void> => {
    await apiClient.patch(`/organizations/current/messages/mark-read`, { messageIds });
  },

  // Get unread count
  getUnreadCount: async (): Promise<{
    total: number;
    byChannel: Record<string, number>;
    byType: Record<string, number>;
  }> => {
    const response = await apiClient.get<{
    total: number;
    byChannel: Record<string, number>;
    byType: Record<string, number>;
  }>(`/organizations/current/messages/unread-count`);
    return response;
  },

  // Get support tickets
  getTickets: async (filters?: {
    userId?: string;
    category?: "TECHNICAL" | "BILLING" | "GENERAL" | "FEATURE_REQUEST" | "BUG_REPORT";
    priority?: "LOW" | "NORMAL" | "HIGH" | "URGENT";
    status?: "OPEN" | "IN_PROGRESS" | "RESOLVED" | "CLOSED" | "REOPENED";
    assignedTo?: string;
    startDate?: string;
    endDate?: string;
  }): Promise<SupportTicket[]> => {
    const response = await apiClient.get<SupportTicket[]>(`/organizations/current/tickets`, {
      params: { ...filters }
    });
    return response;
  },

  // Get ticket by ID
  getTicketById: async (ticketId: string): Promise<SupportTicket> => {
    const response = await apiClient.get<SupportTicket>(`/organizations/current/tickets/${ticketId}`);
    return response;
  },

  // Create support ticket
  createTicket: async (data: Omit<SupportTicket, 'id' | 'createdAt' | 'updatedAt' | 'resolvedAt' | 'user' | 'assignedAgent' | 'messages'>): Promise<SupportTicket> => {
    const response = await apiClient.post<SupportTicket>(`/organizations/current/tickets`, data);
    return response;
  },

  // Update ticket
  updateTicket: async (ticketId: string, data: Partial<SupportTicket>): Promise<SupportTicket> => {
    const response = await apiClient.put<SupportTicket>(`/organizations/current/tickets/${ticketId}`, data);
    return response;
  },

  // Assign ticket to agent
  assignTicket: async (ticketId: string, agentId: string): Promise<SupportTicket> => {
    const response = await apiClient.patch<SupportTicket>(`/organizations/current/tickets/${ticketId}/assign`, { agentId });
    return response;
  },

  // Resolve ticket
  resolveTicket: async (ticketId: string, data: {
    resolution: string;
    satisfactionRating?: number;
    feedback?: string;
  }): Promise<SupportTicket> => {
    const response = await apiClient.patch<SupportTicket>(`/organizations/current/tickets/${ticketId}/resolve`, data);
    return response;
  },

  // Reopen ticket
  reopenTicket: async (ticketId: string, data: {
    reason: string;
  }): Promise<SupportTicket> => {
    const response = await apiClient.patch<SupportTicket>(`/organizations/current/tickets/${ticketId}/reopen`, data);
    return response;
  },

  // Get ticket statistics
  getTicketStatistics: async (filters?: {
    startDate?: string;
    endDate?: string;
    assignedTo?: string;
  }): Promise<{
    total: number;
    open: number;
    inProgress: number;
    resolved: number;
    closed: number;
    reopened: number;
    averageResolutionTime: number;
    byCategory: Record<string, number>;
    byPriority: Record<string, number>;
    byAgent: Array<{
      agentId: string;
      agentName: string;
      totalTickets: number;
      resolvedTickets: number;
      averageResolutionTime: number;
    }>;
  }> => {
    const response = await apiClient.get<{
    total: number;
    open: number;
    inProgress: number;
    resolved: number;
    closed: number;
    reopened: number;
    averageResolutionTime: number;
    byCategory: Record<string, number>;
    byPriority: Record<string, number>;
    byAgent: Array<{
      agentId: string;
      agentName: string;
      totalTickets: number;
      resolvedTickets: number;
      averageResolutionTime: number;
    }>;
  }>(`/organizations/current/tickets/statistics`, {
      params: { ...filters }
    });
    return response;
  },

  // Generate communication report
  generateReport: async (options: {
    type: "MESSAGES" | "TICKETS" | "CHANNELS";
    startDate?: string;
    endDate?: string;
    channelId?: string;
    userId?: string;
    category?: "TECHNICAL" | "BILLING" | "GENERAL" | "FEATURE_REQUEST" | "BUG_REPORT";
    format: "PDF" | "EXCEL" | "CSV";
  }): Promise<Blob> => {
    const response = await apiClient.post<Blob>(`/organizations/current/communications/report`, options, {
      responseType: 'blob'
    });
    return response;
  },
};
