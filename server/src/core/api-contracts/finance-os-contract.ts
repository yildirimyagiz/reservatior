/**
 * Finance OS API Contract
 * Defines the API interface for Finance OS operations
 */

export interface FinanceOSAPIContract {
  // Deal Operations
  createDeal(params: CreateDealParams): Promise<DealResponse>;
  getDeal(dealId: string): Promise<DealResponse>;
  updateDeal(dealId: string, params: UpdateDealParams): Promise<DealResponse>;
  closeDeal(dealId: string, params: CloseDealParams): Promise<DealResponse>;
  cancelDeal(dealId: string, reason: string): Promise<CancellationResponse>;
  
  // Commission Operations
  calculateCommission(params: CalculateCommissionParams): Promise<CommissionCalculationResponse>;
  createCommission(params: CreateCommissionParams): Promise<CommissionResponse>;
  getCommission(commissionId: string): Promise<CommissionResponse>;
  updateCommission(commissionId: string, params: UpdateCommissionParams): Promise<CommissionResponse>;
  approveCommission(commissionId: string): Promise<CommissionResponse>;
  
  // Installment Operations
  createInstallmentPlan(params: CreateInstallmentParams): Promise<InstallmentPlanResponse>;
  getInstallmentPlan(planId: string): Promise<InstallmentPlanResponse>;
  processInstallmentPayment(installmentId: string): Promise<PaymentResponse>;
  getInstallmentSchedule(planId: string): Promise<InstallmentScheduleResponse>;
  
  // Payment Operations
  processPayment(params: PaymentParams): Promise<PaymentResponse>;
  refundPayment(paymentId: string, params: RefundParams): Promise<RefundResponse>;
  getPaymentStatus(paymentId: string): Promise<PaymentStatusResponse>;
  getPaymentHistory(dealId: string): Promise<PaymentResponse[]>;
  
  // Invoice Operations
  createInvoice(params: CreateInvoiceParams): Promise<InvoiceResponse>;
  getInvoice(invoiceId: string): Promise<InvoiceResponse>;
  updateInvoice(invoiceId: string, params: UpdateInvoiceParams): Promise<InvoiceResponse>;
  sendInvoice(invoiceId: string): Promise<InvoiceResponse>;
  markInvoicePaid(invoiceId: string, params: PaymentParams): Promise<InvoiceResponse>;
  
  // Revenue Operations
  recognizeRevenue(params: RecognizeRevenueParams): Promise<RevenueResponse>;
  getRevenue(params: RevenueParams): Promise<RevenueResponse>;
  adjustRevenue(revenueId: string, params: AdjustRevenueParams): Promise<RevenueResponse>;
  
  // Expense Operations
  createExpense(params: CreateExpenseParams): Promise<ExpenseResponse>;
  getExpense(expenseId: string): Promise<ExpenseResponse>;
  updateExpense(expenseId: string, params: UpdateExpenseParams): Promise<ExpenseResponse>;
  approveExpense(expenseId: string): Promise<ExpenseResponse>;
  
  // Reporting Operations
  generateReport(params: ReportParams): Promise<ReportResponse>;
  getReport(reportId: string): Promise<ReportResponse>;
  exportReport(reportId: string, format: 'pdf' | 'excel' | 'csv'): Promise<ExportResponse>;
  
  // Analytics Operations
  getFinancialAnalytics(params: AnalyticsParams): Promise<FinancialAnalyticsResponse>;
  getCommissionAnalytics(params: CommissionAnalyticsParams): Promise<CommissionAnalyticsResponse>;
  getCashFlowAnalytics(params: CashFlowParams): Promise<CashFlowResponse>;
}

// Request/Response Types
export interface CreateDealParams {
  propertyId: string;
  agentId: string;
  buyerId: string;
  salePrice: number;
  currency: string;
  dealType: 'sale' | 'rental' | 'lease';
  expectedCloseDate: string;
  commissionModel?: 'INSTALLMENT_12' | 'HYBRID_50_6' | 'TRADITIONAL_1M';
}

export interface UpdateDealParams {
  salePrice?: number;
  expectedCloseDate?: string;
  commissionModel?: 'INSTALLMENT_12' | 'HYBRID_50_6' | 'TRADITIONAL_1M';
  status?: string;
}

export interface CloseDealParams {
  actualCloseDate: string;
  finalSalePrice: number;
  closingCosts?: number;
}

export interface DealResponse {
  id: string;
  propertyId: string;
  agentId: string;
  buyerId: string;
  salePrice: number;
  currency: string;
  dealType: string;
  status: 'pending' | 'active' | 'closed' | 'cancelled';
  expectedCloseDate: string;
  actualCloseDate?: string;
  commissionModel: string;
  createdAt: string;
  updatedAt: string;
}

export interface CancellationResponse {
  dealId: string;
  cancelledAt: string;
  reason: string;
  refundAmount?: number;
}

export interface CalculateCommissionParams {
  propertyId: string;
  agentId: string;
  salePrice: number;
  currency: string;
  baseRateBps: number;
  countryCode: string;
  stateCode?: string;
  tenantMonthlyRent?: number;
}

export interface CommissionCalculationResponse {
  traditionalModel: {
    commissionAmount: number;
    effectiveRate: number;
  };
  installment12Model: {
    commissionAmount: number;
    monthlyPayment: number;
    totalInterest: number;
    effectiveRate: number;
  };
  hybrid50_6Model: {
    upfrontAmount: number;
    monthlyPayment: number;
    totalInterest: number;
    effectiveRate: number;
  };
  recommendedModel: string;
  compliance: {
    eligible: boolean;
    restrictions: string[];
  };
}

export interface CreateCommissionParams {
  dealId: string;
  agentId: string;
  amount: number;
  currency: string;
  commissionModel: 'INSTALLMENT_12' | 'HYBRID_50_6' | 'TRADITIONAL_1M';
}

export interface UpdateCommissionParams {
  amount?: number;
  status?: string;
}

export interface CommissionResponse {
  id: string;
  dealId: string;
  agentId: string;
  amount: number;
  currency: string;
  commissionModel: string;
  status: 'pending' | 'approved' | 'paid' | 'cancelled';
  createdAt: string;
  paidAt?: string;
}

export interface CreateInstallmentParams {
  commissionId: string;
  totalAmount: number;
  currency: string;
  installmentCount: number;
  monthlyPayment: number;
  startDate: string;
}

export interface InstallmentPlanResponse {
  id: string;
  commissionId: string;
  totalAmount: number;
  currency: string;
  installmentCount: number;
  monthlyPayment: number;
  status: 'active' | 'completed' | 'defaulted';
  startDate: string;
  endDate: string;
}

export interface InstallmentScheduleResponse {
  installments: Array<{
    id: string;
    dueDate: string;
    amount: number;
    status: 'pending' | 'paid' | 'overdue';
    paidDate?: string;
  }>;
}

export interface PaymentParams {
  amount: number;
  currency: string;
  paymentMethod: string;
  paymentDetails: Record<string, any>;
}

export interface PaymentResponse {
  id: string;
  status: 'pending' | 'processing' | 'completed' | 'failed';
  amount: number;
  currency: string;
  processedAt?: string;
  transactionId?: string;
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
  paymentId: string;
  status: string;
  amount: number;
  currency: string;
  createdAt: string;
  processedAt?: string;
  failureReason?: string;
}

export interface CreateInvoiceParams {
  dealId: string;
  commissionId?: string;
  invoiceType: 'commission' | 'installment' | 'expense' | 'other';
  amount: number;
  currency: string;
  dueDate: string;
  lineItems?: Array<{
    description: string;
    amount: number;
  }>;
}

export interface UpdateInvoiceParams {
  amount?: number;
  dueDate?: string;
  status?: string;
}

export interface InvoiceResponse {
  id: string;
  dealId: string;
  invoiceType: string;
  amount: number;
  currency: string;
  status: 'draft' | 'sent' | 'paid' | 'overdue' | 'cancelled';
  dueDate: string;
  createdAt: string;
  paidAt?: string;
}

export interface RecognizeRevenueParams {
  dealId: string;
  amount: number;
  currency: string;
  recognitionDate: string;
  category: string;
}

export interface RevenueResponse {
  id: string;
  dealId: string;
  amount: number;
  currency: string;
  status: 'recognized' | 'adjusted' | 'reversed';
  recognitionDate: string;
  category: string;
}

export interface AdjustRevenueParams {
  adjustmentAmount: number;
  reason: string;
}

export interface RevenueParams {
  organizationId: string;
  startDate: string;
  endDate: string;
  category?: string;
}

export interface CreateExpenseParams {
  organizationId: string;
  category: string;
  amount: number;
  currency: string;
  description: string;
  expenseDate: string;
  vendor?: string;
}

export interface UpdateExpenseParams {
  amount?: number;
  description?: string;
  status?: string;
}

export interface ExpenseResponse {
  id: string;
  organizationId: string;
  category: string;
  amount: number;
  currency: string;
  description: string;
  status: 'pending' | 'approved' | 'paid' | 'rejected';
  expenseDate: string;
  createdAt: string;
}

export interface ReportParams {
  type: 'revenue' | 'commission' | 'expense' | 'profit_loss' | 'cash_flow' | 'tax';
  startDate: string;
  endDate: string;
  organizationId?: string;
  filters?: Record<string, any>;
}

export interface ReportResponse {
  reportId: string;
  status: 'generating' | 'ready' | 'failed';
  type: string;
  startDate: string;
  endDate: string;
  downloadUrl?: string;
  expiresAt?: string;
}

export interface ExportResponse {
  exportId: string;
  status: 'processing' | 'completed' | 'failed';
  downloadUrl?: string;
  format: string;
  recordCount?: number;
}

export interface AnalyticsParams {
  organizationId: string;
  startDate: string;
  endDate: string;
  groupBy?: 'day' | 'week' | 'month' | 'quarter';
  metrics?: string[];
}

export interface FinancialAnalyticsResponse {
  totalRevenue: number;
  totalExpenses: number;
  grossProfit: number;
  netProfit: number;
  profitMargin: number;
  revenueGrowth: number;
  breakdown: Array<{
    period: string;
    revenue: number;
    expenses: number;
    profit: number;
  }>;
}

export interface CommissionAnalyticsParams {
  organizationId: string;
  agentId?: string;
  startDate: string;
  endDate: string;
}

export interface CommissionAnalyticsResponse {
  totalCommissions: number;
  averageCommission: number;
  commissionRate: number;
  installmentRate: number;
  topPerformers: Array<{
    agentId: string;
    totalCommission: number;
    dealCount: number;
  }>;
}

export interface CashFlowParams {
  organizationId: string;
  startDate: string;
  endDate: string;
}

export interface CashFlowResponse {
  openingBalance: number;
  closingBalance: number;
  cashFromOperations: number;
  cashFromInvesting: number;
  cashFromFinancing: number;
  forecast: Array<{
    period: string;
    projectedBalance: number;
  }>;
}
