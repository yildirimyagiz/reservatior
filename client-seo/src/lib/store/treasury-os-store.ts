import { create } from 'zustand';
import { CashFlowForecast, LiquidityPosition, PayoutSchedule, CashFlowCategory, CashFlowStatus } from '../api/treasury-os';

interface TreasuryOSState {
  forecasts: CashFlowForecast[];
  liquidityPosition: LiquidityPosition | null;
  payoutSchedules: PayoutSchedule[];
  loading: boolean;
  error: string | null;
  forecastCashFlow: (orgId: string, period: string, category: CashFlowCategory) => Promise<void>;
  getLiquidityPosition: (orgId: string) => Promise<void>;
  createPayoutSchedule: (data: Omit<PayoutSchedule, 'status'>) => Promise<void>;
  processPayout: (payoutId: string) => Promise<void>;
  getPayoutSchedule: (orgId: string, startDate: string, endDate: string) => Promise<void>;
  getCashFlowHistory: (orgId: string, months?: number) => Promise<void>;
}

export const useTreasuryOSStore = create<TreasuryOSState>((set) => ({
  forecasts: [],
  liquidityPosition: null,
  payoutSchedules: [],
  loading: false,
  error: null,

  forecastCashFlow: async (orgId: string, period: string, category: CashFlowCategory) => {
    set({ loading: true, error: null });
    try {
      const { treasuryOSApi } = await import('../api/treasury-os');
      const forecast = await treasuryOSApi.forecastCashFlow(orgId, period, category);
      set(state => ({ forecasts: [...state.forecasts, forecast], loading: false }));
    } catch (error: any) {
      set({ error: error.message, loading: false });
    }
  },

  getLiquidityPosition: async (orgId: string) => {
    set({ loading: true, error: null });
    try {
      const { treasuryOSApi } = await import('../api/treasury-os');
      const position = await treasuryOSApi.getLiquidityPosition(orgId);
      set({ liquidityPosition: position, loading: false });
    } catch (error: any) {
      set({ error: error.message, loading: false });
    }
  },

  createPayoutSchedule: async (data) => {
    set({ loading: true, error: null });
    try {
      const { treasuryOSApi } = await import('../api/treasury-os');
      const schedule = await treasuryOSApi.createPayoutSchedule(data);
      set(state => ({ payoutSchedules: [...state.payoutSchedules, schedule], loading: false }));
    } catch (error: any) {
      set({ error: error.message, loading: false });
    }
  },

  processPayout: async (payoutId: string) => {
    set({ loading: true, error: null });
    try {
      const { treasuryOSApi } = await import('../api/treasury-os');
      await treasuryOSApi.processPayout(payoutId);
      set(state => ({
        payoutSchedules: state.payoutSchedules.map(p => 
          p.partnerId === payoutId ? { ...p, status: CashFlowStatus.COMPLETED } : p
        ),
        loading: false,
      }));
    } catch (error: any) {
      set({ error: error.message, loading: false });
    }
  },

  getPayoutSchedule: async (orgId: string, startDate: string, endDate: string) => {
    set({ loading: true, error: null });
    try {
      const { treasuryOSApi } = await import('../api/treasury-os');
      const schedules = await treasuryOSApi.getPayoutSchedule(orgId, startDate, endDate);
      set({ payoutSchedules: schedules, loading: false });
    } catch (error: any) {
      set({ error: error.message, loading: false });
    }
  },

  getCashFlowHistory: async (orgId: string, months?: number) => {
    set({ loading: true, error: null });
    try {
      const { treasuryOSApi } = await import('../api/treasury-os');
      const history = await treasuryOSApi.getCashFlowHistory(orgId, months);
      set({ forecasts: history, loading: false });
    } catch (error: any) {
      set({ error: error.message, loading: false });
    }
  },
}));
