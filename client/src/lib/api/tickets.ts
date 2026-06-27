import { apiClient } from "./client";

export enum TicketStatus {
  OPEN = "OPEN",
  IN_PROGRESS = "IN_PROGRESS",
  RESOLVED = "RESOLVED",
  CLOSED = "CLOSED",
}

export interface Ticket {
  id: string;
  cuid: string;
  subject: string;
  description?: string;
  status: TicketStatus;
  createdAt: string;
  updatedAt: string;
  userId: string;
  agentId?: string;
}

export const ticketsApi = {
  getTickets: async () => {
    return await apiClient.get("/api/v1/ticket");
    
  },

  getTicketById: async (id: string) => {
    return await apiClient.get(`/api/v1/ticket/${id}`);
    
  },

  createTicket: async (data: { subject: string; description: string }) => {
    return await apiClient.post("/api/v1/ticket", data);
    
  },

  updateTicket: async (id: string, data: Partial<Ticket>) => {
    return await apiClient.patch(`/api/v1/ticket/${id}`, data);
    
  },

  closeTicket: async (id: string) => {
    return await apiClient.post(`/api/v1/ticket/${id}/close`);
    
  },
};
