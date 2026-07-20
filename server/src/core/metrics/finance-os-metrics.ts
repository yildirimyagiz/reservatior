/**
 * Finance OS Metrics Collection
 * Defines key performance indicators and metrics for financial operations
 */

export interface FinanceOSMetrics {
  // Revenue Metrics
  totalRevenue: number;
  revenueGrowthRate: number;
  revenuePerDeal: number;
  recurringRevenue: number;
  
  // Commission Metrics
  totalCommissions: number;
  commissionRate: number;
  commissionGrowthRate: number;
  averageCommissionAmount: number;
  
  // Deal Metrics
  totalDeals: number;
  dealConversionRate: number;
  averageDealValue: number;
  dealCycleTime: number;
  
  // Payment Metrics
  paymentSuccessRate: number;
  averagePaymentTime: number;
  paymentVolume: number;
  refundRate: number;
  
  // Installment Metrics
  activeInstallments: number;
  installmentCompletionRate: number;
  averageInstallmentAmount: number;
  installmentDelinquencyRate: number;
  
  // Expense Metrics
  totalExpenses: number;
  expenseGrowthRate: number;
  expenseRatio: number;
  operatingMargin: number;
  
  // Cash Flow Metrics
  currentCashPosition: number;
  cashFlowFromOperations: number;
  cashFlowFromInvesting: number;
  cashFlowFromFinancing: number;
  
  // Profitability Metrics
  grossProfit: number;
  grossProfitMargin: number;
  netProfit: number;
  netProfitMargin: number;
  
  // Efficiency Metrics
  revenuePerEmployee: number;
  expensePerDeal: number;
  collectionPeriod: number;
  paymentCycleTime: number;
}

export interface FinanceOSMetricConfig {
  name: string;
  description: string;
  unit: string;
  category: 'revenue' | 'commission' | 'deal' | 'payment' | 'installment' | 'expense' | 'cashflow' | 'profitability' | 'efficiency';
  aggregation: 'sum' | 'average' | 'rate' | 'count';
  dimensions: string[];
}

export const FinanceOSMetricDefinitions: Record<string, FinanceOSMetricConfig> = {
  // Revenue Metrics
  total_revenue: {
    name: 'Total Revenue',
    description: 'Total revenue generated from all sources',
    unit: 'currency',
    category: 'revenue',
    aggregation: 'sum',
    dimensions: ['organization_id', 'time_period', 'currency', 'revenue_type'],
  },
  revenue_growth_rate: {
    name: 'Revenue Growth Rate',
    description: 'Percentage growth in revenue over time',
    unit: 'percentage',
    category: 'revenue',
    aggregation: 'rate',
    dimensions: ['organization_id', 'time_period', 'currency'],
  },
  revenue_per_deal: {
    name: 'Revenue Per Deal',
    description: 'Average revenue generated per deal',
    unit: 'currency',
    category: 'revenue',
    aggregation: 'average',
    dimensions: ['organization_id', 'deal_type', 'time_period'],
  },
  
  // Commission Metrics
  total_commissions: {
    name: 'Total Commissions',
    description: 'Total commissions paid to agents',
    unit: 'currency',
    category: 'commission',
    aggregation: 'sum',
    dimensions: ['organization_id', 'agent_id', 'time_period', 'commission_model'],
  },
  commission_rate: {
    name: 'Commission Rate',
    description: 'Average commission rate as percentage of deal value',
    unit: 'percentage',
    category: 'commission',
    aggregation: 'average',
    dimensions: ['organization_id', 'commission_model', 'time_period'],
  },
  average_commission_amount: {
    name: 'Average Commission Amount',
    description: 'Average commission amount per payment',
    unit: 'currency',
    category: 'commission',
    aggregation: 'average',
    dimensions: ['organization_id', 'agent_id', 'time_period'],
  },
  
  // Deal Metrics
  total_deals: {
    name: 'Total Deals',
    description: 'Total number of deals closed',
    unit: 'count',
    category: 'deal',
    aggregation: 'count',
    dimensions: ['organization_id', 'deal_type', 'status', 'time_period'],
  },
  deal_conversion_rate: {
    name: 'Deal Conversion Rate',
    description: 'Percentage of leads that convert to deals',
    unit: 'percentage',
    category: 'deal',
    aggregation: 'rate',
    dimensions: ['organization_id', 'lead_source', 'time_period'],
  },
  average_deal_value: {
    name: 'Average Deal Value',
    description: 'Average value of closed deals',
    unit: 'currency',
    category: 'deal',
    aggregation: 'average',
    dimensions: ['organization_id', 'deal_type', 'property_type', 'time_period'],
  },
  
  // Payment Metrics
  payment_success_rate: {
    name: 'Payment Success Rate',
    description: 'Percentage of successful payment transactions',
    unit: 'percentage',
    category: 'payment',
    aggregation: 'rate',
    dimensions: ['organization_id', 'payment_method', 'time_period'],
  },
  average_payment_time: {
    name: 'Average Payment Time',
    description: 'Average time to process payments',
    unit: 'days',
    category: 'payment',
    aggregation: 'average',
    dimensions: ['organization_id', 'payment_type', 'time_period'],
  },
  refund_rate: {
    name: 'Refund Rate',
    description: 'Percentage of payments that are refunded',
    unit: 'percentage',
    category: 'payment',
    aggregation: 'rate',
    dimensions: ['organization_id', 'refund_reason', 'time_period'],
  },
  
  // Installment Metrics
  active_installments: {
    name: 'Active Installments',
    description: 'Number of active installment plans',
    unit: 'count',
    category: 'installment',
    aggregation: 'count',
    dimensions: ['organization_id', 'installment_model', 'time_period'],
  },
  installment_completion_rate: {
    name: 'Installment Completion Rate',
    description: 'Percentage of installment plans completed',
    unit: 'percentage',
    category: 'installment',
    aggregation: 'rate',
    dimensions: ['organization_id', 'installment_model', 'time_period'],
  },
  installment_delinquency_rate: {
    name: 'Installment Delinquency Rate',
    description: 'Percentage of installment payments overdue',
    unit: 'percentage',
    category: 'installment',
    aggregation: 'rate',
    dimensions: ['organization_id', 'time_period'],
  },
  
  // Expense Metrics
  total_expenses: {
    name: 'Total Expenses',
    description: 'Total operating expenses',
    unit: 'currency',
    category: 'expense',
    aggregation: 'sum',
    dimensions: ['organization_id', 'expense_category', 'time_period'],
  },
  expense_ratio: {
    name: 'Expense Ratio',
    description: 'Expenses as percentage of revenue',
    unit: 'percentage',
    category: 'expense',
    aggregation: 'rate',
    dimensions: ['organization_id', 'expense_category', 'time_period'],
  },
  operating_margin: {
    name: 'Operating Margin',
    description: 'Operating income as percentage of revenue',
    unit: 'percentage',
    category: 'expense',
    aggregation: 'rate',
    dimensions: ['organization_id', 'time_period'],
  },
  
  // Cash Flow Metrics
  current_cash_position: {
    name: 'Current Cash Position',
    description: 'Current cash and cash equivalents',
    unit: 'currency',
    category: 'cashflow',
    aggregation: 'sum',
    dimensions: ['organization_id', 'currency'],
  },
  cash_flow_from_operations: {
    name: 'Cash Flow from Operations',
    description: 'Cash generated from core business operations',
    unit: 'currency',
    category: 'cashflow',
    aggregation: 'sum',
    dimensions: ['organization_id', 'time_period'],
  },
  
  // Profitability Metrics
  gross_profit: {
    name: 'Gross Profit',
    description: 'Revenue minus cost of goods sold',
    unit: 'currency',
    category: 'profitability',
    aggregation: 'sum',
    dimensions: ['organization_id', 'time_period'],
  },
  gross_profit_margin: {
    name: 'Gross Profit Margin',
    description: 'Gross profit as percentage of revenue',
    unit: 'percentage',
    category: 'profitability',
    aggregation: 'rate',
    dimensions: ['organization_id', 'time_period'],
  },
  net_profit: {
    name: 'Net Profit',
    description: 'Revenue minus all expenses',
    unit: 'currency',
    category: 'profitability',
    aggregation: 'sum',
    dimensions: ['organization_id', 'time_period'],
  },
  net_profit_margin: {
    name: 'Net Profit Margin',
    description: 'Net profit as percentage of revenue',
    unit: 'percentage',
    category: 'profitability',
    aggregation: 'rate',
    dimensions: ['organization_id', 'time_period'],
  },
  
  // Efficiency Metrics
  revenue_per_employee: {
    name: 'Revenue Per Employee',
    description: 'Revenue generated per employee',
    unit: 'currency',
    category: 'efficiency',
    aggregation: 'average',
    dimensions: ['organization_id', 'department', 'time_period'],
  },
  collection_period: {
    name: 'Collection Period',
    description: 'Average days to collect payments',
    unit: 'days',
    category: 'efficiency',
    aggregation: 'average',
    dimensions: ['organization_id', 'payment_type', 'time_period'],
  },
};

/**
 * Metric collection helper
 */
export class FinanceOSMetricsCollector {
  private metrics: Map<string, number> = new Map();
  private dimensions: Map<string, Map<string, string>> = new Map();

  recordMetric(metricName: string, value: number, dimensions?: Record<string, string>): void {
    this.metrics.set(metricName, value);
    if (dimensions) {
      const metricDimensions = this.dimensions.get(metricName) || new Map();
      Object.entries(dimensions).forEach(([key, val]) => {
        metricDimensions.set(key, val);
      });
      this.dimensions.set(metricName, metricDimensions);
    }
  }

  getMetric(metricName: string): number | undefined {
    return this.metrics.get(metricName);
  }

  getMetricDimensions(metricName: string): Map<string, string> | undefined {
    return this.dimensions.get(metricName);
  }

  getAllMetrics(): Record<string, number> {
    return Object.fromEntries(this.metrics);
  }

  aggregateMetrics(metricNames: string[], aggregation: 'sum' | 'average' | 'rate'): number {
    const values = metricNames
      .map(name => this.metrics.get(name))
      .filter((val): val is number => val !== undefined);

    if (values.length === 0) return 0;

    switch (aggregation) {
      case 'sum':
        return values.reduce((a, b) => a + b, 0);
      case 'average':
        return values.reduce((a, b) => a + b, 0) / values.length;
      case 'rate':
        const total = values.reduce((a, b) => a + b, 0);
        return total / values.length;
      default:
        return 0;
    }
  }

  calculateProfitMargin(revenue: number, expenses: number): number {
    if (revenue === 0) return 0;
    return ((revenue - expenses) / revenue) * 100;
  }

  calculateCommissionRate(totalRevenue: number, totalCommissions: number): number {
    if (totalRevenue === 0) return 0;
    return (totalCommissions / totalRevenue) * 100;
  }

  reset(): void {
    this.metrics.clear();
    this.dimensions.clear();
  }
}
