import { apiClient } from "./client";

export interface Appointments {
  id: string;
  orgId: string;
  propertyId?: string;
  agentId?: string;
  clientId?: string;
  title: string;
  description?: string;
  type: "PROPERTY_VIEWING" | "CLIENT_MEETING" | "INSPECTION" | "APPRAISAL" | "CLOSING" | "CONSULTATION" | "MAINTENANCE" | "CUSTOM";
  status: "SCHEDULED" | "CONFIRMED" | "IN_PROGRESS" | "COMPLETED" | "CANCELLED" | "RESCHEDULED" | "NO_SHOW";
  scheduledAt: string;
  startTime?: string;
  endTime?: string;
  duration?: number;
  location?: {
    address?: string;
    latitude?: number;
    longitude?: number;
    meetingUrl?: string;
    phone?: string;
    notes?: string;
  };
  participants?: Array<{
    id: string;
    type: "AGENT" | "CLIENT" | "INSPECTOR" | "APPRAISER" | "THIRD_PARTY";
    name: string;
    email?: string;
    phone?: string;
    status: "CONFIRMED" | "PENDING" | "DECLINED";
    confirmedAt?: string;
  }>;
  reminders?: Array<{
    id: string;
    type: "EMAIL" | "SMS" | "PUSH" | "IN_APP";
    timing: string;
    sentAt?: string;
  }>;
  notes?: string;
  documents?: Array<{
    id: string;
    name: string;
    type: string;
    url: string;
    size: number;
    uploadedAt: string;
  }>;
  metadata?: Record<string, any>;
  createdAt: string;
  updatedAt: string;
  property?: {
    id: string;
    title: string;
    address: string;
  };
  agent?: {
    id: string;
    firstName: string;
    lastName: string;
    email: string;
  };
  client?: {
    id: string;
    firstName: string;
    lastName: string;
    email: string;
  };
}

export const appointmentsApi = {
  // Get all appointments
  getAll: async (orgId: string): Promise<Appointments[]> => {
    const response = await apiClient.get<Appointments[]>(`/organizations/${orgId}/appointments`);
    return response;
  },

  // Get appointment by ID
  getById: async (orgId: string, id: string): Promise<Appointments> => {
    const response = await apiClient.get<Appointments>(`/organizations/${orgId}/appointments/${id}`);
    return response;
  },

  // Create new appointment
  create: async (orgId: string, data: Omit<Appointments, 'id' | 'createdAt' | 'updatedAt' | 'property' | 'agent' | 'client'>): Promise<Appointments> => {
    const response = await apiClient.post<Appointments>(`/organizations/${orgId}/appointments`, data);
    return response;
  },

  // Update appointment
  update: async (orgId: string, id: string, data: Partial<Appointments>): Promise<Appointments> => {
    const response = await apiClient.put<Appointments>(`/organizations/${orgId}/appointments/${id}`, data);
    return response;
  },

  // Delete appointment
  delete: async (orgId: string, id: string): Promise<void> => {
    await apiClient.delete(`/organizations/${orgId}/appointments/${id}`);
  },

  // Get appointments by property
  getByProperty: async (orgId: string, propertyId: string): Promise<Appointments[]> => {
    const response = await apiClient.get<Appointments[]>(`/organizations/${orgId}/properties/${propertyId}/appointments`);
    return response;
  },

  // Get appointments by agent
  getByAgent: async (orgId: string, agentId: string): Promise<Appointments[]> => {
    const response = await apiClient.get<Appointments[]>(`/organizations/${orgId}/agents/${agentId}/appointments`);
    return response;
  },

  // Get appointments by client
  getByClient: async (orgId: string, clientId: string): Promise<Appointments[]> => {
    const response = await apiClient.get<Appointments[]>(`/organizations/${orgId}/clients/${clientId}/appointments`);
    return response;
  },

  // Update appointment status
  updateStatus: async (orgId: string, id: string, status: Appointments['status']): Promise<Appointments> => {
    const response = await apiClient.patch<Appointments>(`/organizations/${orgId}/appointments/${id}/status`, { status });
    return response;
  },

  // Confirm appointment
  confirm: async (orgId: string, id: string): Promise<Appointments> => {
    const response = await apiClient.patch<Appointments>(`/organizations/${orgId}/appointments/${id}/confirm`);
    return response;
  },

  // Cancel appointment
  cancel: async (orgId: string, id: string, data: {
    reason: string;
    notes?: string;
    cancelBy?: string;
  }): Promise<Appointments> => {
    const response = await apiClient.patch<Appointments>(`/organizations/${orgId}/appointments/${id}/cancel`, data);
    return response;
  },

  // Reschedule appointment
  reschedule: async (orgId: string, id: string, data: {
    newScheduledAt: string;
    reason?: string;
    notifyParticipants?: boolean;
  }): Promise<Appointments> => {
    const response = await apiClient.patch<Appointments>(`/organizations/${orgId}/appointments/${id}/reschedule`, data);
    return response;
  },

  // Get available time slots
  getAvailableTimeSlots: async (orgId: string, data: {
    propertyId?: string;
    agentId?: string;
    date: string;
    duration?: number;
    bufferTime?: number;
  }): Promise<Array<{
    startTime: string;
    endTime: string;
    available: boolean;
  }>> => {
    const response = await apiClient.post<Array<{
    startTime: string;
    endTime: string;
    available: boolean;
  }>>(`/organizations/${orgId}/appointments/available-slots`, data);
    return response;
  },

  // Add participant to appointment
  addParticipant: async (orgId: string, id: string, data: {
    participantId: string;
    type: "AGENT" | "CLIENT" | "INSPECTOR" | "APPRAISER" | "THIRD_PARTY";
    role?: string;
  }): Promise<Appointments> => {
    const response = await apiClient.post<Appointments>(`/organizations/${orgId}/appointments/${id}/participants`, data);
    return response;
  },

  // Remove participant from appointment
  removeParticipant: async (orgId: string, id: string, participantId: string): Promise<Appointments> => {
    const response = await apiClient.delete<Appointments>(`/organizations/${orgId}/appointments/${id}/participants/${participantId}`);
    return response;
  },

  // Update participant status
  updateParticipantStatus: async (orgId: string, id: string, participantId: string, status: "CONFIRMED" | "PENDING" | "DECLINED"): Promise<Appointments> => {
    const response = await apiClient.patch<Appointments>(`/organizations/${orgId}/appointments/${id}/participants/${participantId}/status`, { status });
    return response;
  },

  // Send appointment reminder
  sendReminder: async (orgId: string, id: string, data: {
    type: "EMAIL" | "SMS" | "PUSH" | "IN_APP";
    timing: string;
    customMessage?: string;
  }): Promise<void> => {
    await apiClient.post(`/organizations/${orgId}/appointments/${id}/reminders`, data);
  },

  // Get appointment statistics
  getStatistics: async (orgId: string, filters?: {
    agentId?: string;
    propertyId?: string;
    clientId?: string;
    type?: Appointments['type'];
    status?: Appointments['status'];
    startDate?: string;
    endDate?: string;
  }): Promise<{
    total: number;
    scheduled: number;
    confirmed: number;
    inProgress: number;
    completed: number;
    cancelled: number;
    noShow: number;
    rescheduled: number;
    averageDuration: number;
    showRate: number;
    byType: Record<string, number>;
    byAgent: Array<{
      agentId: string;
      agentName: string;
      totalAppointments: number;
      completedAppointments: number;
      showRate: number;
    }>;
    byProperty: Array<{
      propertyId: string;
      propertyAddress: string;
      totalAppointments: number;
      completedAppointments: number;
    }>;
  }> => {
    const response = await apiClient.get<{
    total: number;
    scheduled: number;
    confirmed: number;
    inProgress: number;
    completed: number;
    cancelled: number;
    noShow: number;
    rescheduled: number;
    averageDuration: number;
    showRate: number;
    byType: Record<string, number>;
    byAgent: Array<{
      agentId: string;
      agentName: string;
      totalAppointments: number;
      completedAppointments: number;
      showRate: number;
    }>;
    byProperty: Array<{
      propertyId: string;
      propertyAddress: string;
      totalAppointments: number;
      completedAppointments: number;
    }>;
  }>(`/organizations/${orgId}/appointments/statistics`, {
      params: { ...filters }
    });
    return response;
  },

  // Sync with calendar
  syncWithCalendar: async (orgId: string, id: string, data: {
    calendarType: "GOOGLE" | "OUTLOOK" | "APPLE" | "CUSTOM";
    calendarId?: string;
    syncDirection: "IMPORT" | "EXPORT" | "BIDIRECTIONAL";
  }): Promise<{
    success: boolean;
    syncedEvents: number;
    conflicts: Array<{
      eventId: string;
      conflictType: string;
      description: string;
    }>;
  }> => {
    const response = await apiClient.post<{
    success: boolean;
    syncedEvents: number;
    conflicts: Array<{
      eventId: string;
      conflictType: string;
      description: string;
    }>;
  }>(`/organizations/${orgId}/appointments/${id}/sync-calendar`, data);
    return response;
  },

  // Generate appointment report
  generateReport: async (orgId: string, options: {
    agentId?: string;
    propertyId?: string;
    clientId?: string;
    type?: Appointments['type'];
    status?: Appointments['status'];
    startDate?: string;
    endDate?: string;
    format: "PDF" | "EXCEL" | "CSV";
  }): Promise<Blob> => {
    const response = await apiClient.post<Blob>(`/organizations/${orgId}/appointments/report`, options, {
      responseType: 'blob'
    });
    return response;
  },
};
