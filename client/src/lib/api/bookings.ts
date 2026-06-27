import { apiClient } from "./client";

export type BookingStatus = "DRAFT" | "PENDING" | "CONFIRMED" | "CANCELLED" | "COMPLETED";
export type PaymentStatus = "UNPAID" | "PARTIALLY_PAID" | "PAID" | "REFUNDED";
export type SecurityScreeningStatus = "PENDING" | "PASSED" | "FAILED" | "REVIEW_REQUIRED";
export type SecurityRiskLevel = "LOW" | "MEDIUM" | "HIGH" | "CRITICAL";
export type OwnershipVerificationStatus = "PENDING" | "VERIFIED" | "REJECTED" | "EXPIRED";
export type VerificationMethod = "MANUAL" | "API" | "BLOCKCHAIN" | "AI";

export interface Booking {
  id: string;
  orgId: string;
  listingId: string;
  contactId?: string;
  reservationId?: string;
  propertyId?: string;
  ownershipVerificationId?: string;
  status: BookingStatus;
  startDate: string;
  endDate: string;
  adults?: number;
  children?: number;
  priceTotal?: number;
  currency?: string;
  paymentStatus: PaymentStatus;
  notes?: string;
  ownershipVerified: boolean;
  verificationRequired: boolean;
  verificationStatus?: string;
  verifiedAt?: string;
  verificationExpiresAt?: string;
  riskScore?: number;
  fraudFlags?: any;
  createdBy?: string;
  createdAt: string;
  updatedAt: string;
  deletedAt?: string;
  
  // Relations
  contact?: {
    id: string;
    name: string;
    email: string;
    phone: string;
  };
  listing?: {
    id: string;
    title: string;
    property?: {
      id: string;
      name: string;
      address: string;
    };
  };
  property?: {
    id: string;
    name: string;
    address: string;
    type: string;
  };
  org?: {
    id: string;
    name: string;
  };
  ownershipVerification?: PropertyOwnershipVerification;
  securityScreenings?: BookingSecurityScreening[];
}

export interface BookingSecurityScreening {
  id: string;
  bookingId?: string;
  reservationId?: string;
  contactId: string;
  propertyId: string;
  orgId: string;
  vacationRentalId?: string;
  screeningStatus: SecurityScreeningStatus;
  riskLevel?: SecurityRiskLevel;
  riskScore?: number;
  confidenceScore?: number;
  screeningResults?: any;
  fraudIndicators?: any;
  identityVerification?: any;
  backgroundCheckResults?: any;
  paymentRiskAssessment?: any;
  behavioralAnalysis?: any;
  deviceFingerprint?: string;
  ipGeolocation?: any;
  verificationMethods?: any;
  manualReviewRequired: boolean;
  manualReviewBy?: string;
  manualReviewNotes?: string;
  reviewedAt?: string;
  expiresAt?: string;
  screeningMetadata?: any;
  createdAt: string;
  updatedAt: string;
  
  // Relations
  reviewer?: {
    id: string;
    name: string;
    email: string;
  };
  contact?: {
    id: string;
    name: string;
    email: string;
  };
  property?: {
    id: string;
    name: string;
    address: string;
  };
}

export interface PropertyOwnershipVerification {
  id: string;
  propertyId: string;
  orgId: string;
  currentOwnerId?: string;
  verificationStatus: OwnershipVerificationStatus;
  verificationMethod: VerificationMethod;
  verifiedAt?: string;
  verifiedBy?: string;
  expiresAt?: string;
  rejectionReason?: string;
  governmentTransactionId?: string;
  aiConfidenceScore?: number;
  manualReviewRequired: boolean;
  priorityVerification: boolean;
  verificationNotes?: string;
  supportingDocuments?: any;
  ownershipHistory?: any;
  legalDescription?: string;
  parcelNumber?: string;
  jurisdiction?: string;
  recordingDate?: string;
  chainOfCustody?: any;
  verificationMetadata?: any;
  createdAt: string;
  updatedAt: string;
  
  // Relations
  property?: {
    id: string;
    name: string;
    address: string;
  };
  organization?: {
    id: string;
    name: string;
  };
  currentOwner?: {
    id: string;
    name: string;
    email: string;
  };
  verifier?: {
    id: string;
    name: string;
    email: string;
  };
  documents?: OwnershipVerificationDocument[];
}

export interface OwnershipVerificationDocument {
  id: string;
  verificationId: string;
  type: string;
  url: string;
  status: string;
  uploadedAt: string;
  createdAt: string;
  updatedAt: string;
}

export interface BookingsResponse {
  data: Booking[];
  total: number;
  page: number;
  limit: number;
}

export interface BookingSecurityStatus {
  bookingId: string;
  ownershipVerified: boolean;
  verificationStatus: string;
  verificationExpiresAt?: string;
  riskScore: number;
  fraudFlags?: any;
  ownershipVerification?: PropertyOwnershipVerification;
  securityScreenings?: BookingSecurityScreening[];
  overallRisk: {
    level: SecurityRiskLevel;
    score: number;
    requiresAction: boolean;
  };
}

export interface BookingAnalytics {
  totalBookings: number;
  statusBreakdown: Record<BookingStatus, number>;
  paymentStatusBreakdown: Record<PaymentStatus, number>;
  verificationStatusBreakdown: Record<string, number>;
  riskDistribution: {
    low: number;
    medium: number;
    high: number;
  };
  avgRiskScore: number;
  ownershipVerificationRate: number;
}

export const bookingsApi = {
  // Bookings
  getBookings: (params?: { 
    orgId?: string;
    listingId?: string; 
    contactId?: string; 
    status?: string; 
    ownershipVerified?: boolean;
    verificationStatus?: string;
    startDate?: string; 
    endDate?: string;
    page?: number;
    limit?: number;
  }) => apiClient.get<BookingsResponse>("/booking", params),

  getBookingById: (id: string) => 
    apiClient.get<{ data: Booking }>(`/booking/${id}`),

  createBooking: (data: Partial<Booking> & { 
    orgId: string; 
    listingId: string; 
    startDate: string; 
    endDate: string;
    contactId?: string;
    adults?: number;
    children?: number;
    notes?: string;
  }) => apiClient.post<{ data: Booking }>("/booking", data),

  updateBooking: (id: string, data: Partial<Booking>) => 
    apiClient.patch<{ data: Booking }>(`/booking/${id}`, data),

  deleteBooking: (id: string) => 
    apiClient.delete(`/booking/${id}`),

  // Status Management
  updateBookingStatus: (id: string, status: BookingStatus, notes?: string) => 
    apiClient.patch<{ data: Booking }>(`/booking/${id}/status`, { status, notes }),

  // Ownership Verification
  verifyOwnership: (id: string, data: {
    propertyId: string;
    verificationMethod?: VerificationMethod;
    documents?: any[];
    notes?: string;
  }) => apiClient.post<{ 
    data: PropertyOwnershipVerification;
    message: string;
  }>(`/booking/${id}/verify-ownership`, data),

  getOwnershipVerification: (id: string) => 
    apiClient.get<{ data: PropertyOwnershipVerification }>(`/booking/${id}/ownership-verification`),

  // Security Screening
  createSecurityScreening: (id: string, data: {
    riskLevel?: SecurityRiskLevel;
    riskScore?: number;
    manualReviewRequired?: boolean;
    screeningMetadata?: any;
    notes?: string;
  }) => apiClient.post<{ 
    data: BookingSecurityScreening;
    message: string;
  }>(`/booking/${id}/security-screening`, data),

  getSecurityScreenings: (id: string) => 
    apiClient.get<{ data: BookingSecurityScreening[] }>(`/booking/${id}/security-screenings`),

  updateSecurityScreening: (id: string, screeningId: string, data: {
    screeningStatus?: SecurityScreeningStatus;
    riskScore?: number;
    manualReviewNotes?: string;
  }) => apiClient.patch<{ 
    data: BookingSecurityScreening;
  }>(`/booking/${id}/security-screenings/${screeningId}`, data),

  // Security Status
  getSecurityStatus: (id: string) => 
    apiClient.get<BookingSecurityStatus>(`/booking/${id}/security-status`),

  // Guest Review
  createGuestReview: (id: string, data: {
    rating: number;
    comment: string;
    aspects?: {
      cleanliness: number;
      communication: number;
      checkIn: number;
      accuracy: number;
      location: number;
      value: number;
    };
  }) => apiClient.post<{ data: any }>(`/booking/${id}/guest-review`, data),

  // Analytics
  getBookingAnalytics: (params?: {
    orgId?: string;
    propertyId?: string;
    dateFrom?: string;
    dateTo?: string;
  }) => apiClient.get<BookingAnalytics>("/booking/analytics", params),

  // Risk Assessment
  getHighRiskBookings: (params?: {
    orgId?: string;
    riskThreshold?: number;
    limit?: number;
  }) => apiClient.get<{ data: Booking[] }>("/booking/high-risk", params),

  // Bulk Operations
  bulkUpdateStatus: (ids: string[], status: BookingStatus, notes?: string) => 
    apiClient.patch<{ data: Booking[] }>("/booking/bulk-status", { ids, status, notes }),

  bulkVerifyOwnership: (ids: string[], data: {
    propertyId: string;
    verificationMethod: VerificationMethod;
    notes?: string;
  }) => apiClient.post<{ data: PropertyOwnershipVerification[] }>("/booking/bulk-verify-ownership", { ids, ...data }),

  // Reports
  exportBookings: (params?: {
    format?: 'csv' | 'excel' | 'pdf';
    orgId?: string;
    status?: BookingStatus;
    dateFrom?: string;
    dateTo?: string;
    includeSecurityScreening?: boolean;
  }) => apiClient.get<Blob>("/booking/export", params),

  // Search and Filter
  searchBookings: (query: string, filters?: {
    orgId?: string;
    status?: BookingStatus;
    propertyId?: string;
    contactId?: string;
    dateFrom?: string;
    dateTo?: string;
    riskLevel?: SecurityRiskLevel;
    verificationStatus?: OwnershipVerificationStatus;
  }) => apiClient.get<BookingsResponse>("/booking/search", { query, ...filters }),

  // Calendar View
  getBookingCalendar: (params?: { 
    propertyId?: string; 
    month?: string; 
    year?: string;
    includeSecurityStatus?: boolean;
  }) => apiClient.get<any>("/booking/calendar", params),

  // Availability & Pricing
  checkPropertyAvailability: (propertyId: string, startDate: string, endDate: string) => 
    apiClient.get<any>(`/properties/${propertyId}/availability`, { startDate, endDate }),

  getBookingPrice: (propertyId: string, startDate: string, endDate: string, adults: number, children: number) => 
    apiClient.get<any>(`/properties/${propertyId}/pricing`, { startDate, endDate, adults, children }),
};
