import { apiClient } from "./client";

export interface Calendar {
  id: string;
  orgId: string;
  userId?: string;
  agentId?: string;
  propertyId?: string;
  name: string;
  description?: string;
  type: "PERSONAL" | "SHARED" | "PROPERTY" | "TEAM" | "PUBLIC" | "INTEGRATION";
  provider: "GOOGLE" | "OUTLOOK" | "APPLE" | "CALDAV" | "CUSTOM";
  externalId?: string;
  color?: string;
  timezone?: string;
  isDefault: boolean;
  isActive: boolean;
  syncSettings: {
    enabled: boolean;
    syncDirection: "IMPORT" | "EXPORT" | "BIDIRECTIONAL";
    syncInterval: number;
    lastSyncAt?: string;
    syncStatus: "SUCCESS" | "ERROR" | "IN_PROGRESS" | "DISABLED";
    errorMessage?: string;
  };
  sharing: {
    isPublic: boolean;
    shareWith: Array<{
      userId?: string;
      agentId?: string;
      teamId?: string;
      permissions: ("VIEW" | "EDIT" | "DELETE" | "SHARE")[];
    }>;
    shareUrl?: string;
    expiresAt?: string;
  };
  events?: Array<{
    id: string;
    title: string;
    description?: string;
    startTime: string;
    endTime: string;
    allDay: boolean;
    location?: {
      address?: string;
      latitude?: number;
      longitude?: number;
      meetingUrl?: string;
    };
    attendees?: Array<{
      id: string;
      name: string;
      email?: string;
      status: "ACCEPTED" | "DECLINED" | "TENTATIVE" | "NEEDS_ACTION";
      isOrganizer: boolean;
    }>;
    recurrence?: {
      rule: string;
      frequency: "DAILY" | "WEEKLY" | "MONTHLY" | "YEARLY";
      endDate?: string;
      occurrences?: number;
    };
    reminders?: Array<{
      type: "EMAIL" | "SMS" | "PUSH" | "POPUP";
      timing: string;
      sentAt?: string;
    }>;
    attachments?: Array<{
      id: string;
      name: string;
      type: string;
      url: string;
      size: number;
    }>;
    visibility: "PUBLIC" | "PRIVATE" | "CONFIDENTIAL";
    priority: "LOW" | "NORMAL" | "HIGH" | "URGENT";
    status: "CONFIRMED" | "TENTATIVE" | "CANCELLED";
    createdAt: string;
    updatedAt: string;
  }>;
  createdAt: string;
  updatedAt: string;
  user?: {
    id: string;
    firstName: string;
    lastName: string;
    email: string;
  };
  agent?: {
    id: string;
    firstName: string;
    lastName: string;
    email: string;
  };
}

// Define a type for calendar events to avoid array access issues
type CalendarEvent = NonNullable<Calendar['events']>[0];

export const calendarApi = {
  // Get all calendars
  getAll: async (orgId: string): Promise<Calendar[]> => {
    const response = await apiClient.get<Calendar[]>(`/organizations/${orgId}/calendar`);
    return response;
  },

  // Get calendar by ID
  getById: async (orgId: string, id: string): Promise<Calendar> => {
    const response = await apiClient.get<Calendar>(`/organizations/${orgId}/calendar/${id}`);
    return response;
  },

  // Create new calendar
  create: async (orgId: string, data: Omit<Calendar, 'id' | 'createdAt' | 'updatedAt' | 'events' | 'user' | 'agent'>): Promise<Calendar> => {
    const response = await apiClient.post<Calendar>(`/organizations/${orgId}/calendar`, data);
    return response;
  },

  // Update calendar
  update: async (orgId: string, id: string, data: Partial<Calendar>): Promise<Calendar> => {
    const response = await apiClient.put<Calendar>(`/organizations/${orgId}/calendar/${id}`, data);
    return response;
  },

  // Delete calendar
  delete: async (orgId: string, id: string): Promise<void> => {
    await apiClient.delete(`/organizations/${orgId}/calendar/${id}`);
  },

  // Get calendars by user
  getByUser: async (orgId: string, userId: string): Promise<Calendar[]> => {
    const response = await apiClient.get<Calendar[]>(`/organizations/${orgId}/users/${userId}/calendar`);
    return response;
  },

  // Get calendars by agent
  getByAgent: async (orgId: string, agentId: string): Promise<Calendar[]> => {
    const response = await apiClient.get<Calendar[]>(`/organizations/${orgId}/agents/${agentId}/calendar`);
    return response;
  },

  // Get calendars by property
  getByProperty: async (orgId: string, propertyId: string): Promise<Calendar[]> => {
    const response = await apiClient.get<Calendar[]>(`/organizations/${orgId}/properties/${propertyId}/calendar`);
    return response;
  },

  // Sync calendar with external provider
  sync: async (orgId: string, id: string): Promise<{
    success: boolean;
    syncedEvents: number;
    conflicts: Array<{
      eventId: string;
      conflictType: string;
      description: string;
    }>;
    lastSyncAt: string;
  }> => {
    const response = await apiClient.post<{
    success: boolean;
    syncedEvents: number;
    conflicts: Array<{
      eventId: string;
      conflictType: string;
      description: string;
    }>;
    lastSyncAt: string;
  }>(`/organizations/${orgId}/calendar/${id}/sync`);
    return response;
  },

  // Get calendar events
  getEvents: async (orgId: string, id: string, filters?: {
    startDate?: string;
    endDate?: string;
    status?: "CONFIRMED" | "TENTATIVE" | "CANCELLED";
    visibility?: "PUBLIC" | "PRIVATE" | "CONFIDENTIAL";
    priority?: "LOW" | "NORMAL" | "HIGH" | "URGENT";
  }): Promise<Calendar['events']> => {
    const response = await apiClient.get<Calendar['events']>(`/organizations/${orgId}/calendar/${id}/events`, {
      params: { ...filters }
    });
    return response;
  },

  // Create calendar event
  createEvent: async (orgId: string, calendarId: string, data: Omit<CalendarEvent, 'id' | 'createdAt' | 'updatedAt' | 'attendees'>): Promise<CalendarEvent> => {
    const response = await apiClient.post<CalendarEvent>(`/organizations/${orgId}/calendar/${calendarId}/events`, data);
    return response;
  },

  // Update calendar event
  updateEvent: async (orgId: string, calendarId: string, eventId: string, data: Partial<CalendarEvent>): Promise<CalendarEvent> => {
    const response = await apiClient.put<CalendarEvent>(`/organizations/${orgId}/calendar/${calendarId}/events/${eventId}`, data);
    return response;
  },

  // Delete calendar event
  deleteEvent: async (orgId: string, calendarId: string, eventId: string): Promise<void> => {
    await apiClient.delete(`/organizations/${orgId}/calendar/${calendarId}/events/${eventId}`);
  },

  // Get calendar statistics
  getStatistics: async (orgId: string, id: string, filters?: {
    startDate?: string;
    endDate?: string;
  }): Promise<{
    totalEvents: number;
    byStatus: Record<string, number>;
    byPriority: Record<string, number>;
    byVisibility: Record<string, number>;
    averageDuration: number;
    upcomingEvents: number;
    pastEvents: number;
    recurringEvents: number;
    attendees: {
      total: number;
      unique: number;
      averagePerEvent: number;
    };
  }> => {
    const response = await apiClient.get<{
    totalEvents: number;
    byStatus: Record<string, number>;
    byPriority: Record<string, number>;
    byVisibility: Record<string, number>;
    averageDuration: number;
    upcomingEvents: number;
    pastEvents: number;
    recurringEvents: number;
    attendees: {
      total: number;
      unique: number;
      averagePerEvent: number;
    };
  }>(`/organizations/${orgId}/calendar/${id}/statistics`, {
      params: { ...filters }
    });
    return response;
  },

  // Share calendar
  share: async (orgId: string, id: string, data: {
    shareWith: Array<{
      userId?: string;
      agentId?: string;
      teamId?: string;
      permissions: ("VIEW" | "EDIT" | "DELETE" | "SHARE")[];
    }>;
    expiresAt?: string;
    message?: string;
  }): Promise<{
    shareUrl: string;
    shareToken: string;
    expiresAt: string;
  }> => {
    const response = await apiClient.post<{
    shareUrl: string;
    shareToken: string;
    expiresAt: string;
  }>(`/organizations/${orgId}/calendar/${id}/share`, data);
    return response;
  },

  // Get shared calendars
  getShared: async (orgId: string): Promise<Array<{
    id: string;
    name: string;
    sharedBy: {
      id: string;
      name: string;
    };
    sharedAt: string;
    permissions: ("VIEW" | "EDIT" | "DELETE" | "SHARE")[];
    expiresAt?: string;
  }>> => {
    const response = await apiClient.get<Array<{
    id: string;
    name: string;
    sharedBy: {
      id: string;
      name: string;
    };
    sharedAt: string;
    permissions: ("VIEW" | "EDIT" | "DELETE" | "SHARE")[];
    expiresAt?: string;
  }>>(`/organizations/${orgId}/calendar/shared`);
    return response;
  },

  // Update sharing settings
  updateSharing: async (orgId: string, id: string, data: {
    isPublic: boolean;
    shareWith: Array<{
      userId?: string;
      agentId?: string;
      teamId?: string;
      permissions: ("VIEW" | "EDIT" | "DELETE" | "SHARE")[];
    }>;
    expiresAt?: string;
  }): Promise<Calendar> => {
    const response = await apiClient.patch<Calendar>(`/organizations/${orgId}/calendar/${id}/sharing`, data);
    return response;
  },

  // Import calendar events
  importEvents: async (orgId: string, id: string, data: {
    format: "ICAL" | "CSV" | "JSON" | "GOOGLE_CALENDAR" | "OUTLOOK";
    file?: File;
    url?: string;
    mergeStrategy: "REPLACE" | "MERGE" | "SKIP_CONFLICTS";
    timezone?: string;
  }): Promise<{
    importedEvents: number;
    conflicts: Array<{
      eventTitle: string;
      conflictType: string;
      description: string;
    }>;
    errors: Array<{
      line?: number;
      message: string;
      data?: any;
    }>;
  }> => {
    const formData = new FormData();
    if (data.file) {
      formData.append('file', data.file);
    }
    if (data.url) {
      formData.append('url', data.url);
    }
    formData.append('format', data.format);
    formData.append('mergeStrategy', data.mergeStrategy);
    if (data.timezone) formData.append('timezone', data.timezone);

    const response = await apiClient.post<{
    importedEvents: number;
    conflicts: Array<{
      eventTitle: string;
      conflictType: string;
      description: string;
    }>;
    errors: Array<{
      line?: number;
      message: string;
      data?: any;
    }>;
  }>(`/organizations/${orgId}/calendar/${id}/import`, formData, {
      headers: {
        'Content-Type': 'multipart/form-data',
      },
    });
    return response;
  },

  // Export calendar events
  exportEvents: async (orgId: string, id: string, options: {
    format: "ICAL" | "CSV" | "JSON" | "PDF";
    startDate?: string;
    endDate?: string;
    includeAttachments?: boolean;
    includeAttendees?: boolean;
  }): Promise<Blob> => {
    const response = await apiClient.post<Blob>(`/organizations/${orgId}/calendar/${id}/export`, options, {
      responseType: 'blob'
    });
    return response;
  },

  // Get calendar integrations
  getIntegrations: async (orgId: string, id: string): Promise<Array<{
    provider: Calendar['provider'];
    enabled: boolean;
    lastSyncAt?: string;
    syncStatus: string;
    settings: Record<string, any>;
  }>> => {
    const response = await apiClient.get<Array<{
    provider: Calendar['provider'];
    enabled: boolean;
    lastSyncAt?: string;
    syncStatus: string;
    settings: Record<string, any>;
  }>>(`/organizations/${orgId}/calendar/${id}/integrations`);
    return response;
  },

  // Configure calendar integration
  configureIntegration: async (orgId: string, id: string, data: {
    provider: Calendar['provider'];
    enabled: boolean;
    settings: Record<string, any>;
  }): Promise<void> => {
    await apiClient.post(`/organizations/${orgId}/calendar/${id}/integrations`, data);
  },
};
