import { apiClient } from "./client";

export interface Event {
  id: string;
  title: string;
  description: string;
  type: string;
  status: "scheduled" | "ongoing" | "completed" | "cancelled";
  startDate: string;
  endDate: string;
  location?: string;
  organizerId: string;
  maxAttendees?: number;
  attendeeCount: number;
  createdAt: string;
  updatedAt: string;
}

export interface EventAttendee {
  id: string;
  eventId: string;
  userId: string;
  status: "registered" | "confirmed" | "declined" | "attended";
  registeredAt: string;
}

export interface CalendarEvent {
  id: string;
  title: string;
  description: string;
  startDate: string;
  endDate: string;
  type: "meeting" | "viewing" | "deadline" | "reminder";
  priority: "low" | "medium" | "high";
  attendees?: string[];
  location?: string;
  isRecurring: boolean;
  recurrencePattern?: string;
}

export const eventsApi = {
  // Events
  getEvents: (params?: { type?: string; status?: string; startDate?: string; endDate?: string }) => 
    apiClient.get("/events", params),
  getEventById: (id: string) => apiClient.get(`/events/${id}`),
  createEvent: (data: Partial<Event>) => apiClient.post("/events", data),
  updateEvent: (id: string, data: Partial<Event>) => apiClient.patch(`/events/${id}`, data),
  deleteEvent: (id: string) => apiClient.delete(`/events/${id}`, { data: { tags: [] } }),
  
  // Attendees
  getEventAttendees: (eventId: string) => apiClient.get(`/events/${eventId}/attendees`),
  registerForEvent: (eventId: string, userId: string) => 
    apiClient.post(`/events/${eventId}/attendees`, { userId }),
  updateAttendeeStatus: (eventId: string, attendeeId: string, status: string) => 
    apiClient.patch(`/events/${eventId}/attendees/${attendeeId}`, { status }),
  removeAttendee: (eventId: string, attendeeId: string) => 
    apiClient.delete(`/events/${eventId}/attendees/${attendeeId}`, { data: { tags: [] } }),
  
  // Calendar Events
  getCalendarEvents: (params?: { startDate?: string; endDate?: string; type?: string }) => 
    apiClient.get("/events/calendar", params),
  getCalendarEventById: (id: string) => apiClient.get(`/events/calendar/${id}`),
  createCalendarEvent: (data: Partial<CalendarEvent>) => apiClient.post("/events/calendar", data),
  updateCalendarEvent: (id: string, data: Partial<CalendarEvent>) => 
    apiClient.patch(`/events/calendar/${id}`, data),
  deleteCalendarEvent: (id: string) => apiClient.delete(`/events/calendar/${id}`, { data: { tags: [] } }),
  
  // My Events
  getMyEvents: () => apiClient.get("/events/my"),
  getMyCalendarEvents: (params?: { startDate?: string; endDate?: string }) => 
    apiClient.get("/events/my/calendar", params),
  
  // Event Types
  getEventTypes: () => apiClient.get("/events/types"),
  
  // Statistics
  getEventStats: () => apiClient.get("/events/stats"),
};
