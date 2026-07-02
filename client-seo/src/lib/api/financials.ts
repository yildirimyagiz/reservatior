import { apiClient } from "./client";

export type FinancialRecordType = "INCOME" | "EXPENSE";
export type ExpenseCategory = "MAINTENANCE" | "INSURANCE" | "UTILITIES" | "TAX" | "RENOVATION" | "OTHER" | "COMMISSION" | "MANAGEMENT_FEE" | "CLEANING" | "REPAIR" | "MARKETING";

export interface FinancialRecord {
  id: string;
  orgId: string;
  propertyId: string;
  type: FinancialRecordType;
  amount: number;
  currency: string;
  listingId?: string;
  leaseId?: string;
  bookingId?: string;
  reservationId?: string;
  recordType?: string;
  category?: string;
  description?: string;
  occurredAt: string;
  dueDate?: string;
  paymentStatus?: string;
  createdAt: string;
  updatedAt: string;
}

export interface Expense {
  id: string;
  orgId: string;
  propertyId?: string;
  category: ExpenseCategory;
  amount: number;
  currency: string;
  date: string;
  description?: string;
  receiptUrl?: string;
  paidById?: string;
  vendorId?: string;
  createdAt: string;
  updatedAt: string;
}

export interface Budget {
  id: string;
  orgId: string;
  propertyId?: string;
  year: number;
  totalAmount: number;
  spentAmount?: number;
  currency: string;
  categories?: any;
  notes?: string;
  startDate: string;
  endDate: string;
}

export interface Payout {
  id: string;
  orgId: string;
  recipientId: string;
  amount: number;
  currency: string;
  status: "PENDING" | "PROCESSING" | "PAID" | "FAILED";
  method: string;
  reference?: string;
  scheduledAt?: string;
  paidAt?: string;
  createdAt: string;
  updatedAt: string;
}

export interface CommissionRule {
  id: string;
  providerId: string;
  ruleType: "PERCENTAGE" | "FLAT" | "TIERED";
  commission: number;
  minVolume?: number;
  maxVolume?: number;
  conditions?: any;
  createdAt: string;
}

export interface Mortgage {
  id: string;
  propertyId: string;
  lender: string;
  principal: number;
  interestRate: number;
  startDate: string;
  endDate?: string;
  status: "ACTIVE" | "PAID_OFF" | "REFINANCED";
  notes?: string;
}

export interface RentIncrease {
  id: string;
  propertyId: string;
  tenantId: string;
  oldRent: number;
  newRent: number;
  effectiveDate: string;
  status: "PENDING" | "APPROVED" | "REJECTED" | "CANCELLED";
  createdAt: string;
}

export interface Discount {
  id: string;
  propertyId: string;
  name: string;
  code?: string;
  value: number;
  type: "PERCENTAGE" | "FIXED";
  startDate?: string;
  endDate?: string;
  isActive: boolean;
}

export interface PaginatedResponse<T> {
  data: T[];
  total: number;
  page: number;
  limit: number;
}

export const financialsApi = {
  // Financial Records
  getRecords: (params?: { 
    orgId?: string; 
    propertyId?: string; 
    type?: FinancialRecordType; 
    paymentStatus?: string; 
    category?: string;
    from?: string; 
    to?: string; 
    page?: number; 
    limit?: number 
  }) => apiClient.get<PaginatedResponse<FinancialRecord>>("/financial-record", params),
  
  createRecord: (data: Partial<FinancialRecord> & { orgId: string; propertyId: string; type: FinancialRecordType; amount: number; currency: string }) => 
    apiClient.post<{ data: FinancialRecord }>("/financial-record", data),

  updateRecord: (id: string, data: Partial<FinancialRecord>) => 
    apiClient.patch<{ data: FinancialRecord }>(`/financial-record/${id}`, data),

  deleteRecord: (id: string) => 
    apiClient.delete(`/financial-record/${id}`),

  // Expenses
  getExpenses: (params?: { 
    orgId?: string; 
    propertyId?: string; 
    category?: ExpenseCategory; 
    from?: string; 
    to?: string; 
    page?: number; 
    limit?: number 
  }) => apiClient.get<PaginatedResponse<Expense>>("/expense", params),
  
  createExpense: (data: Partial<Expense> & { orgId: string; category: ExpenseCategory; amount: number; date: string }) => 
    apiClient.post<{ data: Expense }>("/expense", data),

  updateExpense: (id: string, data: Partial<Expense>) => 
    apiClient.patch<{ data: Expense }>(`/expense/${id}`, data),

  deleteExpense: (id: string) => 
    apiClient.delete(`/expense/${id}`),

  // Budgets
  getBudgets: (params?: { 
    orgId?: string; 
    propertyId?: string; 
    year?: number; 
    page?: number; 
    limit?: number 
  }) => apiClient.get<PaginatedResponse<Budget>>("/budget", params),
  
  createBudget: (data: Partial<Budget> & { orgId: string; year: number; totalAmount: number; budgetType: string; period: string; startDate: string; endDate: string; name: string }) => 
    apiClient.post<{ data: Budget }>("/budget", data),
  
  updateBudget: (id: string, data: Partial<Budget>) => 
    apiClient.patch<{ data: Budget }>(`/budget/${id}`, data),

  deleteBudget: (id: string) => 
    apiClient.delete(`/budget/${id}`),

  // Payouts
  getPayouts: (params?: { 
    orgId?: string; 
    status?: string; 
    recipientId?: string; 
    page?: number; 
    limit?: number 
  }) => apiClient.get<PaginatedResponse<Payout>>("/payout", params),
  
  createPayout: (data: Partial<Payout> & { orgId: string; recipientId: string; amount: number }) => 
    apiClient.post<{ data: Payout }>("/payout", data),

  updatePayout: (id: string, data: Partial<Payout>) => 
    apiClient.patch<{ data: Payout }>(`/payout/${id}`, data),

  deletePayout: (id: string) => 
    apiClient.delete(`/payout/${id}`),

  // Commissions
  getCommissionRules: () => apiClient.get<CommissionRule[]>("/financials/commissions/rules"),
  
  // Mortgages
  getMortgages: (propertyId?: string) => apiClient.get<Mortgage[]>("/mortgages", { propertyId }),
  createMortgage: (data: any) => apiClient.post<{ data: any }>("/mortgages", data),
  
  // Rent Increases
  getRentIncreases: (propertyId?: string) => apiClient.get<RentIncrease[]>("/financials/increases", { propertyId }),
  
  // Discounts
  getDiscounts: (propertyId?: string) => apiClient.get<Discount[]>("/financials/discounts", { propertyId }),

  // Invoices (using the dedicated /invoices backend route)
  getInvoices: (params?: { 
    status?: string; 
    customerId?: string; 
    dateFrom?: string; 
    dateTo?: string; 
    page?: number; 
    limit?: number 
  }) => apiClient.get<PaginatedResponse<any>>("/invoices", params),
  
  createInvoice: (data: any) => 
    apiClient.post<{ data: any }>("/invoices", data),
};
