import { apiClient } from "./client";

export enum TicketStatus {
  OPEN = "OPEN",
  IN_PROGRESS = "IN_PROGRESS",
  RESOLVED = "RESOLVED",
  CLOSED = "CLOSED",
}

export enum TicketPriority {
  LOW = "LOW",
  MEDIUM = "MEDIUM",
  HIGH = "HIGH",
  URGENT = "URGENT",
}

export interface Ticket {
  id: string;
  cuid: string;
  subject: string;
  description?: string;
  status: TicketStatus;
  priority?: TicketPriority;
  createdAt: string;
  updatedAt: string;
  closedAt?: string;
  userId: string;
  agentId?: string;
  CommunicationLogs?: CommunicationLog[];
  Agent?: any;
  User?: any;
}

export interface CommunicationLog {
  id: string;
  ticketId: string;
  message: string;
  senderId: string;
  senderRole: "USER" | "AGENT" | "AI";
  attachments?: string[];
  createdAt: string;
  isInternal?: boolean;
}

export const ticketsApi = {
  getTickets: async () => {
    return await apiClient.get("/api/v1/ticket");
  },

  getTicketById: async (id: string) => {
    return await apiClient.get(`/api/v1/ticket/${id}`);
  },

  createTicket: async (data: { subject: string; description: string; priority?: TicketPriority }) => {
    return await apiClient.post("/api/v1/ticket", data);
  },

  updateTicket: async (id: string, data: Partial<Ticket>) => {
    return await apiClient.patch(`/api/v1/ticket/${id}`, data);
  },

  closeTicket: async (id: string) => {
    return await apiClient.post(`/api/v1/ticket/${id}/close`);
  },

  // Communication Logs
  getCommunicationLogs: async (ticketId: string) => {
    return await apiClient.get(`/api/v1/ticket/${ticketId}/logs`);
  },

  addCommunicationLog: async (ticketId: string, data: { message: string; attachments?: string[]; isInternal?: boolean }) => {
    return await apiClient.post(`/api/v1/ticket/${ticketId}/logs`, data);
  },

  // File Upload
  uploadAttachment: async (file: File) => {
    const formData = new FormData();
    formData.append("file", file);
    return await apiClient.post("/api/v1/ticket/upload", formData, {
      headers: { "Content-Type": "multipart/form-data" },
    });
  },

  // AI Support
  getAISuggestion: async (message: string) => {
    return await apiClient.post("/api/v1/ticket/ai-suggest", { message });
  },

  // Agent Management
  assignAgent: async (ticketId: string, agentId: string) => {
    return await apiClient.post(`/api/v1/ticket/${ticketId}/assign`, { agentId });
  },

  // Agency Dashboard
  getAgencyTickets: async (agencyId: string) => {
    return await apiClient.get(`/api/v1/agency/${agencyId}/tickets`);
  },

  getAgentTickets: async (agentId: string) => {
    return await apiClient.get(`/api/v1/agent/${agentId}/tickets`);
  },
};
