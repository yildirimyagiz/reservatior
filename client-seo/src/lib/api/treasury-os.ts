import { apiClient } from "./client";

export enum CashFlowCategory {
  RENTAL_INCOME = "RENTAL_INCOME",
  SECURITY_DEPOSIT = "SECURITY_DEPOSIT",
  MAINTENANCE_COST = "MAINTENANCE_COST",
  PROPERTY_PURCHASE = "PROPERTY_PURCHASE",
  PARTNER_PAYOUT = "PARTNER_PAYOUT",
  ESCROW_RELEASE = "ESCROW_RELEASE",
  OPERATIONAL_EXPENSE = "OPERATIONAL_EXPENSE",
  INVESTMENT_RETURN = "INVESTMENT_RETURN",
}

export enum CashFlowStatus {
  PENDING = "PENDING",
  CONFIRMED = "CONFIRMED",
  PROCESSING = "PROCESSING",
  COMPLETED = "COMPLETED",
  FAILED = "FAILED",
}

export interface CashFlowForecast {
  id: string;
  orgId: string;
  period: string;
  projectedIncome: number;
  projectedExpense: number;
  netCashFlow: number;
  category: CashFlowCategory;
  confidence: number;
  factors: Array<{ factor: string; impact: number }>;
  createdAt: string;
}

export interface LiquidityPosition {
  totalCash: number;
  escrowBalance: number;
  availableLiquidity: number;
  reserveRatio: number;
  liquidityRatio: number;
  lastUpdated: string;
}

export interface PayoutSchedule {
  partnerId: string;
  amount: number;
  currency: string;
  dueDate: string;
  status: CashFlowStatus;
  metadata?: Record<string, unknown>;
}

export const treasuryOSApi = {
  // Forecast cash flow
  forecastCashFlow: async (orgId: string, period: string, category: CashFlowCategory): Promise<CashFlowForecast> => {
    const response = await apiClient.get<CashFlowForecast>(
      `/api/v1/treasury-os/forecast/${orgId}/${period}`,
      { params: { category } }
    );
    return response;
  },

  // Get liquidity position
  getLiquidityPosition: async (orgId: string): Promise<LiquidityPosition> => {
    const response = await apiClient.get<LiquidityPosition>(`/api/v1/treasury-os/liquidity/${orgId}`);
    return response;
  },

  // Check escrow liquidity
  checkEscrowLiquidity: async (orgId: string): Promise<{ liquidity: boolean }> => {
    const response = await apiClient.get<{ liquidity: boolean }>(`/api/v1/treasury-os/escrow-liquidity/${orgId}`);
    return response;
  },

  // Calculate reserve ratio
  calculateReserveRatio: async (orgId: string): Promise<{ ratio: number }> => {
    const response = await apiClient.get<{ ratio: number }>(`/api/v1/treasury-os/reserve-ratio/${orgId}`);
    return response;
  },

  // Create payout schedule
  createPayoutSchedule: async (data: Omit<PayoutSchedule, 'status'>): Promise<PayoutSchedule> => {
    const response = await apiClient.post<PayoutSchedule>(`/api/v1/treasury-os/payout`, data);
    return response;
  },

  // Process payout
  processPayout: async (payoutId: string): Promise<{ processed: boolean }> => {
    const response = await apiClient.post<{ processed: boolean }>(`/api/v1/treasury-os/payout/${payoutId}/process`);
    return response;
  },

  // Get payout schedule
  getPayoutSchedule: async (orgId: string, startDate: string, endDate: string): Promise<PayoutSchedule[]> => {
    const response = await apiClient.get<PayoutSchedule[]>(`/api/v1/treasury-os/payouts/${orgId}`, {
      params: { startDate, endDate },
    });
    return response;
  },

  // Optimize settlement timing
  optimizeSettlementTiming: async (orgId: string): Promise<{ timing: string }> => {
    const response = await apiClient.get<{ timing: string }>(`/api/v1/treasury-os/settlement-timing/${orgId}`);
    return response;
  },

  // Get treasury dashboard
  getDashboard: async (orgId: string): Promise<any> => {
    const response = await apiClient.get(`/api/v1/treasury-os/dashboard/${orgId}`);
    return response;
  },

  // Get cash flow history
  getCashFlowHistory: async (orgId: string, months?: number): Promise<CashFlowForecast[]> => {
    const response = await apiClient.get<CashFlowForecast[]>(`/api/v1/treasury-os/history/${orgId}`, {
      params: { months },
    });
    return response;
  },

  // Analyze cash flow trends
  analyzeCashFlowTrends: async (orgId: string): Promise<any> => {
    const response = await apiClient.get(`/api/v1/treasury-os/trends/${orgId}`);
    return response;
  },
};
