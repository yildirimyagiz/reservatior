/**
 * Booking OS API Contract
 * Defines the API interface for Booking OS operations
 */

export interface BookingOSAPIContract {
  // Booking CRUD Operations
  createBooking(params: CreateBookingParams): Promise<BookingResponse>;
  getBooking(bookingId: string): Promise<BookingResponse>;
  updateBooking(bookingId: string, params: UpdateBookingParams): Promise<BookingResponse>;
  cancelBooking(bookingId: string, reason: string): Promise<CancellationResponse>;
  deleteBooking(bookingId: string): Promise<void>;
  
  // Booking Operations
  checkInBooking(bookingId: string, params: CheckInParams): Promise<CheckInResponse>;
  checkOutBooking(bookingId: string, params: CheckOutParams): Promise<CheckOutResponse>;
  modifyBooking(bookingId: string, params: ModifyBookingParams): Promise<BookingResponse>;
  extendBooking(bookingId: string, params: ExtendBookingParams): Promise<BookingResponse>;
  
  // Payment Operations
  processPayment(bookingId: string, params: PaymentParams): Promise<PaymentResponse>;
  refundPayment(bookingId: string, params: RefundParams): Promise<RefundResponse>;
  getPaymentStatus(bookingId: string): Promise<PaymentStatusResponse>;
  
  // Guest Operations
  addGuest(bookingId: string, guest: GuestInfo): Promise<GuestResponse>;
  updateGuest(bookingId: string, guestId: string, guest: Partial<GuestInfo>): Promise<GuestResponse>;
  removeGuest(bookingId: string, guestId: string): Promise<void>;
  getGuests(bookingId: string): Promise<GuestResponse[]>;
  
  // Review Operations
  createReview(bookingId: string, review: ReviewParams): Promise<ReviewResponse>;
  getReviews(bookingId: string): Promise<ReviewResponse[]>;
  moderateReview(reviewId: string, action: 'approve' | 'reject' | 'flag'): Promise<void>;
  
  // Dispute Operations
  createDispute(bookingId: string, dispute: DisputeParams): Promise<DisputeResponse>;
  resolveDispute(disputeId: string, resolution: DisputeResolution): Promise<DisputeResponse>;
  getDisputes(bookingId: string): Promise<DisputeResponse[]>;
  
  // Analytics Operations
  getBookingAnalytics(params: AnalyticsParams): Promise<BookingAnalyticsResponse>;
  getBookingReports(params: ReportParams): Promise<BookingReportResponse>;
  exportBookingData(params: ExportParams): Promise<ExportResponse>;
  
  // Calendar Operations
  getCalendarAvailability(propertyId: string, params: CalendarParams): Promise<CalendarResponse>;
  updateCalendarAvailability(propertyId: string, availability: AvailabilityUpdate): Promise<void>;
  
  // Pricing Operations
  getPricing(propertyId: string, params: PricingParams): Promise<PricingResponse>;
  updatePricing(propertyId: string, pricing: PricingUpdate): Promise<void>;
  getDynamicPricing(propertyId: string, params: DynamicPricingParams): Promise<DynamicPricingResponse>;
}

// Request/Response Types
export interface CreateBookingParams {
  propertyId: string;
  guestId: string;
  checkInDate: string;
  checkOutDate: string;
  guestCount: number;
  totalPrice: number;
  currency: string;
  specialRequests?: string;
  promoCode?: string;
}

export interface UpdateBookingParams {
  checkInDate?: string;
  checkOutDate?: string;
  guestCount?: number;
  specialRequests?: string;
}

export interface BookingResponse {
  id: string;
  propertyId: string;
  guestId: string;
  status: 'pending' | 'confirmed' | 'checked_in' | 'checked_out' | 'cancelled';
  checkInDate: string;
  checkOutDate: string;
  guestCount: number;
  totalPrice: number;
  currency: string;
  confirmationCode: string;
  createdAt: string;
  updatedAt: string;
}

export interface CancellationResponse {
  bookingId: string;
  cancelledAt: string;
  refundAmount: number;
  refundStatus: 'pending' | 'processed' | 'failed';
}

export interface CheckInParams {
  guestId: string;
  idVerification?: string;
  specialRequests?: string;
}

export interface CheckInResponse {
  bookingId: string;
  checkedInAt: string;
  roomNumber?: string;
  accessCodes?: string[];
}

export interface CheckOutParams {
  roomCondition?: string;
  damages?: string[];
  additionalCharges?: number;
}

export interface CheckOutResponse {
  bookingId: string;
  checkedOutAt: string;
  finalBill: number;
  depositRefund: number;
}

export interface ModifyBookingParams {
  newCheckInDate?: string;
  newCheckOutDate?: string;
  newGuestCount?: number;
  reason?: string;
}

export interface ExtendBookingParams {
  additionalNights: number;
  additionalPrice: number;
}

export interface PaymentParams {
  amount: number;
  currency: string;
  paymentMethod: string;
  paymentDetails: Record<string, any>;
}

export interface PaymentResponse {
  paymentId: string;
  status: 'pending' | 'processing' | 'completed' | 'failed';
  amount: number;
  currency: string;
  processedAt?: string;
}

export interface RefundParams {
  amount: number;
  reason: string;
  refundMethod?: string;
}

export interface RefundResponse {
  refundId: string;
  status: 'pending' | 'processing' | 'completed' | 'failed';
  amount: number;
  currency: string;
  estimatedCompletion?: string;
}

export interface PaymentStatusResponse {
  bookingId: string;
  payments: PaymentResponse[];
  totalPaid: number;
  totalRefunded: number;
  balanceDue: number;
}

export interface GuestInfo {
  id: string;
  name: string;
  email: string;
  phone: string;
  dateOfBirth?: string;
  nationality?: string;
  idNumber?: string;
}

export interface GuestResponse {
  id: string;
  bookingId: string;
  name: string;
  email: string;
  phone: string;
  isPrimary: boolean;
  checkedInAt?: string;
}

export interface ReviewParams {
  rating: number;
  comment: string;
  categories?: {
    cleanliness: number;
    location: number;
    communication: number;
    checkIn: number;
    value: number;
  };
}

export interface ReviewResponse {
  id: string;
  bookingId: string;
  guestId: string;
  rating: number;
  comment: string;
  status: 'pending' | 'approved' | 'rejected';
  createdAt: string;
}

export interface DisputeParams {
  type: string;
  description: string;
  evidence?: string[];
  requestedAmount?: number;
}

export interface DisputeResponse {
  id: string;
  bookingId: string;
  type: string;
  status: 'open' | 'investigating' | 'resolved' | 'closed';
  createdAt: string;
  resolvedAt?: string;
}

export interface DisputeResolution {
  resolution: string;
  compensation?: number;
  actionRequired?: string;
}

export interface AnalyticsParams {
  propertyId?: string;
  startDate: string;
  endDate: string;
  groupBy?: 'day' | 'week' | 'month';
  metrics?: string[];
}

export interface BookingAnalyticsResponse {
  totalBookings: number;
  totalRevenue: number;
  averageBookingValue: number;
  occupancyRate: number;
  cancellationRate: number;
  breakdown: Array<{
    period: string;
    bookings: number;
    revenue: number;
  }>;
}

export interface ReportParams {
  type: 'revenue' | 'occupancy' | 'cancellations' | 'guest_satisfaction';
  startDate: string;
  endDate: string;
  propertyId?: string;
  format?: 'pdf' | 'excel' | 'csv';
}

export interface BookingReportResponse {
  reportId: string;
  status: 'generating' | 'ready' | 'failed';
  downloadUrl?: string;
  expiresAt?: string;
}

export interface ExportParams {
  startDate: string;
  endDate: string;
  format: 'csv' | 'json' | 'excel';
  filters?: Record<string, any>;
}

export interface ExportResponse {
  exportId: string;
  status: 'processing' | 'completed' | 'failed';
  downloadUrl?: string;
  recordCount?: number;
}

export interface CalendarParams {
  startDate: string;
  endDate: string;
}

export interface CalendarResponse {
  propertyId: string;
  availability: Array<{
    date: string;
    available: boolean;
    price?: number;
    minimumStay?: number;
  }>;
}

export interface AvailabilityUpdate {
  dates: Array<{
    date: string;
    available: boolean;
    price?: number;
  }>;
}

export interface PricingParams {
  checkInDate: string;
  checkOutDate: string;
  guestCount: number;
}

export interface PricingResponse {
  basePrice: number;
  totalPrice: number;
  currency: string;
  breakdown: Array<{
    type: string;
    amount: number;
  }>;
}

export interface PricingUpdate {
  basePrice: number;
  currency: string;
  weekendSurcharge?: number;
  seasonalAdjustments?: Array<{
    startDate: string;
    endDate: string;
    adjustment: number;
  }>;
}

export interface DynamicPricingParams {
  demandLevel?: number;
  competitorPrices?: number[];
  leadTime?: number;
}

export interface DynamicPricingResponse {
  recommendedPrice: number;
  confidence: number;
  factors: {
    demand: number;
    competition: number;
    seasonality: number;
    urgency: number;
  };
}
