import { apiClient } from "./client";

export interface Lease {
  id: string;
  propertyId: string;
  tenantId: string;
  startDate: string;
  endDate: string;
  monthlyRent: string;
  currency: string;
  securityDeposit: string;
  status: "draft" | "active" | "expired" | "terminated";
  terms: string;
  autoRenew: boolean;
  renewalNoticeDays: number;
  createdAt: string;
  updatedAt: string;
}

export interface RentSchedule {
  id: string;
  leaseId: string;
  dueDate: string;
  amount: string;
  currency: string;
  status: "pending" | "paid" | "overdue" | "partial";
  paidDate?: string;
  paidAmount?: string;
  notes?: string;
}

export interface LeaseRenewal {
  id: string;
  leaseId: string;
  newEndDate: string;
  newRentAmount?: string;
  status: "pending" | "approved" | "rejected";
  requestedAt: string;
  respondedAt?: string;
}

export const leasesApi = {
  // Leases
  getLeases: (params?: { 
    propertyId?: string; 
    tenantId?: string; 
    status?: string; 
    startDate?: string; 
    endDate?: string;
  }): Promise<Lease[]> => apiClient.get<Lease[]>("/api/leases", { params }),
  getLeaseById: (id: string) => apiClient.get(`/api/leases/${id}`),
  createLease: (data: Partial<Lease>) => apiClient.post("/api/leases", data),
  updateLease: (id: string, data: Partial<Lease>) => apiClient.patch(`/api/leases/${id}`, data),
  deleteLease: (id: string) => apiClient.delete(`/api/leases/${id}`),
  
  // Status Management
  updateLeaseStatus: (id: string, status: string, notes?: string) => 
    apiClient.patch(`/api/leases/${id}/status`, { status, notes }),
  
  // Property Leases
  getPropertyLeases: (propertyId: string) => apiClient.get(`/api/properties/${propertyId}/leases`),
  
  // Tenant Leases
  getTenantLeases: (tenantId: string) => apiClient.get(`/api/tenants/${tenantId}/leases`),
  
  // Rent Schedule
  getRentSchedule: (leaseId: string) => apiClient.get(`/api/leases/${leaseId}/rent-schedule`),
  createRentPayment: (leaseId: string, data: Partial<RentSchedule>) => 
    apiClient.post(`/api/leases/${leaseId}/rent-schedule`, data),
  updateRentPayment: (leaseId: string, paymentId: string, data: Partial<RentSchedule>) => 
    apiClient.patch(`/api/leases/${leaseId}/rent-schedule/${paymentId}`, data),
  
  // Rent Collection
  getRentPayments: (params?: { 
    leaseId?: string; 
    status?: string; 
    startDate?: string; 
    endDate?: string;
  }): Promise<any[]> => apiClient.get<any[]>("/api/rent-payments", { params }),
  recordRentPayment: (leaseId: string, amount: string, paymentDate?: string) => 
    apiClient.post(`/api/leases/${leaseId}/rent-payments`, { amount, paymentDate }),
  
  // Lease Renewals
  getLeaseRenewals: (leaseId: string) => apiClient.get(`/api/leases/${leaseId}/renewals`),
  requestLeaseRenewal: (leaseId: string, data: Partial<LeaseRenewal>) => 
    apiClient.post(`/api/leases/${leaseId}/renewals`, data),
  respondToLeaseRenewal: (leaseId: string, renewalId: string, status: string, notes?: string) => 
    apiClient.patch(`/api/leases/${leaseId}/renewals/${renewalId}`, { status, notes }),
  
  // Termination
  terminateLease: (id: string, terminationDate: string, reason: string) => 
    apiClient.post(`/api/leases/${id}/terminate`, { terminationDate, reason }),
  
  // Documents
  getLeaseDocuments: (id: string) => apiClient.get(`/api/leases/${id}/documents`),
  uploadLeaseDocument: (id: string, file: File, type: string) => {
    const formData = new FormData();
    formData.append("document", file);
    formData.append("type", type);
    return apiClient.post(`/api/leases/${id}/documents`, formData);
  },
  
  // Notifications
  getLeaseNotifications: (id: string) => apiClient.get(`/api/leases/${id}/notifications`),
  sendLeaseNotification: (id: string, type: string, message: string) => 
    apiClient.post(`/api/leases/${id}/notifications`, { type, message }),
  
  // Analytics
  getLeaseAnalytics: (params?: { 
    propertyId?: string; 
    startDate?: string; 
    endDate?: string 
  }) => apiClient.get("/api/leases/analytics", { params }),
  
  // Export
  exportLeases: (params?: { 
    propertyId?: string; 
    status?: string; 
    format?: "csv" | "excel" | "pdf"
  }) => apiClient.get("/api/leases/export", { params }),
  
  // Statistics
  getLeaseStats: (params?: { 
    propertyId?: string; 
    startDate?: string; 
    endDate?: string 
  }) => apiClient.get("/api/leases/stats", { params }),
};
