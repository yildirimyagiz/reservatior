import { create } from 'zustand';
import { devtools } from 'zustand/middleware';

export interface FinancialReport {
  id: string;
  title: string;
  type: string;
  period: string;
  revenue: string;
  expenses: string;
  profit: string;
  growth: string;
  createdAt: string;
}

export interface RevenueBreakdown {
  source: string;
  amount: string;
  percentage: number;
  growth: string;
}

export interface ExpenseAnalysis {
  category: string;
  amount: string;
  percentage: number;
  change: string;
}

export interface MonthlyPerformance {
  month: string;
  revenue: string;
  expenses: string;
  profit: string;
  growth: string;
}

interface FinancialReportsState {
  // State
  reports: FinancialReport[];
  revenueBreakdown: RevenueBreakdown[];
  expenseAnalysis: ExpenseAnalysis[];
  monthlyPerformance: MonthlyPerformance[];
  topProperties: any[];
  paymentMethods: any[];
  upcomingReports: any[];
  
  loading: boolean;
  error: string | null;
  
  // Actions
  fetchReports: () => Promise<void>;
  createReport: (report: Partial<FinancialReport>) => Promise<void>;
  deleteReport: (id: string) => Promise<void>;
  
  fetchRevenueBreakdown: () => Promise<void>;
  fetchExpenseAnalysis: () => Promise<void>;
  fetchMonthlyPerformance: () => Promise<void>;
  fetchTopProperties: () => Promise<void>;
  fetchPaymentMethods: () => Promise<void>;
  fetchUpcomingReports: () => Promise<void>;
  
  exportReport: (id: string, format: string) => Promise<void>;
  
  clearError: () => void;
  reset: () => void;
}

export const useFinancialReportsStore = create<FinancialReportsState>()(
  devtools(
    (set) => ({
      // Initial State
      reports: [],
      revenueBreakdown: [],
      expenseAnalysis: [],
      monthlyPerformance: [],
      topProperties: [],
      paymentMethods: [],
      upcomingReports: [],
      loading: false,
      error: null,
      
      // Actions
      fetchReports: async () => {
        set({ loading: true, error: null });
        try {
          // Mock API call
          const mockReports: FinancialReport[] = [
            {
              id: "1",
              title: "Monthly Financial Report",
              type: "monthly",
              period: "2024-01",
              revenue: "$456,789",
              expenses: "$89,234",
              profit: "$367,555",
              growth: "+15.2%",
              createdAt: new Date().toISOString(),
            }
          ];
          
          set({ reports: mockReports, loading: false });
        } catch (error) {
          set({ 
            error: error instanceof Error ? error.message : 'Failed to fetch reports',
            loading: false 
          });
        }
      },
      
      createReport: async (report: Partial<FinancialReport>) => {
        set({ loading: true, error: null });
        try {
          // Mock API call
          const newReport: FinancialReport = {
            id: Math.random().toString(36).substr(2, 9),
            title: report.title || '',
            type: report.type || '',
            period: report.period || '',
            revenue: report.revenue || '',
            expenses: report.expenses || '',
            profit: report.profit || '',
            growth: report.growth || '',
            createdAt: new Date().toISOString(),
          };
          
          set(state => ({
            reports: [...state.reports, newReport],
            loading: false,
          }));
        } catch (error) {
          set({ 
            error: error instanceof Error ? error.message : 'Failed to create report',
            loading: false 
          });
        }
      },
      
      deleteReport: async (id: string) => {
        set({ loading: true, error: null });
        try {
          // Mock API call
          set(state => ({
            reports: state.reports.filter(r => r.id !== id),
            loading: false,
          }));
        } catch (error) {
          set({ 
            error: error instanceof Error ? error.message : 'Failed to delete report',
            loading: false 
          });
        }
      },
      
      fetchRevenueBreakdown: async () => {
        set({ loading: true, error: null });
        try {
          // Mock API call
          const mockRevenueBreakdown: RevenueBreakdown[] = [
            {
              source: "Rental Income",
              amount: "$234,567",
              percentage: 51.4,
              growth: "+12.3%",
            },
            {
              source: "Property Management Fees",
              amount: "$89,234",
              percentage: 19.5,
              growth: "+8.7%",
            }
          ];
          
          set({ revenueBreakdown: mockRevenueBreakdown, loading: false });
        } catch (error) {
          set({ 
            error: error instanceof Error ? error.message : 'Failed to fetch revenue breakdown',
            loading: false 
          });
        }
      },
      
      fetchExpenseAnalysis: async () => {
        set({ loading: true, error: null });
        try {
          // Mock API call
          const mockExpenseAnalysis: ExpenseAnalysis[] = [
            {
              category: "Property Maintenance",
              amount: "$45,678",
              percentage: 35.2,
              change: "-5.2%",
            },
            {
              category: "Staff Salaries",
              amount: "$34,567",
              percentage: 26.7,
              change: "+2.1%",
            }
          ];
          
          set({ expenseAnalysis: mockExpenseAnalysis, loading: false });
        } catch (error) {
          set({ 
            error: error instanceof Error ? error.message : 'Failed to fetch expense analysis',
            loading: false 
          });
        }
      },
      
      fetchMonthlyPerformance: async () => {
        set({ loading: true, error: null });
        try {
          // Mock API call
          const mockMonthlyPerformance: MonthlyPerformance[] = [
            {
              month: "January",
              revenue: "$45,678",
              expenses: "$23,456",
              profit: "$22,222",
              growth: "+12.3%",
            },
            {
              month: "February",
              revenue: "$48,234",
              expenses: "$24,567",
              profit: "$23,667",
              growth: "+5.6%",
            }
          ];
          
          set({ monthlyPerformance: mockMonthlyPerformance, loading: false });
        } catch (error) {
          set({ 
            error: error instanceof Error ? error.message : 'Failed to fetch monthly performance',
            loading: false 
          });
        }
      },
      
      fetchTopProperties: async () => {
        set({ loading: true, error: null });
        try {
          // Mock API call
          const mockTopProperties = [
            {
              property: "Sunset Apartments - Unit 4B",
              revenue: "$34,567",
              roi: "22.3%",
            },
            {
              property: "Ocean View - Unit 2A",
              revenue: "$28,945",
              roi: "19.8%",
            }
          ];
          
          set({ topProperties: mockTopProperties, loading: false });
        } catch (error) {
          set({ 
            error: error instanceof Error ? error.message : 'Failed to fetch top properties',
            loading: false 
          });
        }
      },
      
      fetchPaymentMethods: async () => {
        set({ loading: true, error: null });
        try {
          // Mock API call
          const mockPaymentMethods = [
            {
              method: "Bank Transfer",
              count: 234,
              amount: "$234,567",
              percentage: 51.4,
            },
            {
              method: "Credit Card",
              count: 156,
              amount: "$123,456",
              percentage: 27.0,
            }
          ];
          
          set({ paymentMethods: mockPaymentMethods, loading: false });
        } catch (error) {
          set({ 
            error: error instanceof Error ? error.message : 'Failed to fetch payment methods',
            loading: false 
          });
        }
      },
      
      fetchUpcomingReports: async () => {
        set({ loading: true, error: null });
        try {
          // Mock API call
          const mockUpcomingReports = [
            {
              report: "Q1 Financial Summary",
              dueDate: "2024-04-05",
              status: "scheduled",
            },
            {
              report: "Tax Preparation Report",
              dueDate: "2024-03-15",
              status: "in-progress",
            }
          ];
          
          set({ upcomingReports: mockUpcomingReports, loading: false });
        } catch (error) {
          set({ 
            error: error instanceof Error ? error.message : 'Failed to fetch upcoming reports',
            loading: false 
          });
        }
      },
      
      exportReport: async (id: string, format: string) => {
        try {
          // Mock export - in real app, this would trigger file download
          console.log(`Exporting report ${id} as ${format}`);
        } catch (error) {
          console.error('Failed to export report:', error);
        }
      },
      
      clearError: () => set({ error: null }),
      
      reset: () => set({
        reports: [],
        revenueBreakdown: [],
        expenseAnalysis: [],
        monthlyPerformance: [],
        topProperties: [],
        paymentMethods: [],
        upcomingReports: [],
        loading: false,
        error: null,
      }),
    }),
    {
      name: 'financial-reports-store',
    }
  )
);
