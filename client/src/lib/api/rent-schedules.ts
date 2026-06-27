import { apiClient } from "./client";

export interface RentSchedule {
  id: string;
  leaseId: string;
  dueDate: string;
  amount: number;
  currency: string;
  status: "pending" | "paid" | "overdue" | "partial";
  paidDate?: string;
  paidAmount?: number;
  notes?: string;
  createdAt: string;
}

export const rentSchedulesApi = {
  getAll: (params?: { leaseId?: string; status?: string; fromDate?: string; toDate?: string; page?: number; limit?: number }) =>
    apiClient.get("/rent-schedules", params),
  getById: (id: string) => apiClient.get(`/rent-schedules/${id}`),
  create: (data: Partial<RentSchedule>) => apiClient.post("/rent-schedules", data),
  update: (id: string, data: Partial<RentSchedule>) => apiClient.patch(`/rent-schedules/${id}`, data),
  delete: (id: string) => apiClient.delete(`/rent-schedules/${id}`),
  markAsPaid: (id: string, paidAmount: number, paidDate?: string) =>
    apiClient.patch(`/rent-schedules/${id}/pay`, { paidAmount, paidDate }),
  getByLease: (leaseId: string, params?: any) =>
    apiClient.get(`/rent-schedules/lease/${leaseId}`, params),
  getOverdue: (params?: { orgId?: string }) =>
    apiClient.get("/rent-schedules/overdue", params),
};
