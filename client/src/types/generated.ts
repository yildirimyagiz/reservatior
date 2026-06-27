// @ts-nocheck
// ============================================================================
// PRISMA CLIENT TYPES - Automatic & Always in Sync
// ============================================================================

export * from '@prisma/client'

// ============================================================================
// CLIENT-SIDE ADDITIONAL TYPES
// ============================================================================

export interface ApiResponse<T> {
  data: T;
  success?: boolean;
  message?: string;
}

export interface PaginatedResponse<T> {
  data: T[];
  total: number;
  page: number;
  limit: number;
  totalPages: number;
}

export interface ErrorResponse {
  error: string;
  message?: string;
  details?: any;
}

export interface DateRange {
  startDate?: string;
  endDate?: string;
}

export interface PaginationQuery {
  page?: string;
  limit?: string;
  sortBy?: string;
  sortOrder?: 'asc' | 'desc';
}

export interface AchievementFilters extends PaginationQuery, DateRange {
  userId?: string;
  goalType?: any;
  isCompleted?: boolean;
  organizationId?: string;
}

export interface PropertyFilters extends PaginationQuery, DateRange {
  orgId?: string;
  type?: any;
  status?: string;
  city?: string;
  state?: string;
}

export interface BookingFilters extends PaginationQuery, DateRange {
  orgId?: string;
  listingId?: string;
  contactId?: string;
  status?: any;
  paymentStatus?: any;
}

export interface AuthUser {
  id: string;
  email: string;
  name?: string;
  role?: string;
  organizationId?: string;
}

export interface LoginRequest {
  email: string;
  password: string;
}

export interface RegisterRequest {
  email: string;
  password: string;
  name: string;
  phone?: string;
}

export interface AuthResponse {
  user: AuthUser;
  token: string;
  refreshToken?: string;
}

export type Optional<T, K extends keyof T> = Omit<T, K> & Partial<Pick<T, K>>;
export type RequiredFields<T, K extends keyof T> = T & Required<Pick<T, K>>;
export type ID = string;
export type Timestamp = Date;
