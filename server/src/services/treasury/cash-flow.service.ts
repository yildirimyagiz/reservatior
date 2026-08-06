/**
 * Treasury Cash Flow Service
 * 
 * Manages cash flow forecasting, escrow liquidity, reserve ratios, partner payouts, and settlement timing.
 * Extends Finance OS and Rental Finance OS for advanced treasury management.
 */

import { prisma } from "../../lib/prisma";

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
  period: string; // YYYY-MM
  projectedIncome: number;
  projectedExpense: number;
  netCashFlow: number;
  category: CashFlowCategory;
  confidence: number; // 0-1
  factors: { factor: string; impact: number }[];
  createdAt: Date;
}

export interface LiquidityPosition {
  totalCash: number;
  escrowBalance: number;
  availableLiquidity: number;
  reserveRatio: number; // percentage
  liquidityRatio: number; // percentage
  lastUpdated: Date;
}

export interface PayoutSchedule {
  partnerId: string;
  amount: number;
  currency: string;
  dueDate: Date;
  status: CashFlowStatus;
  metadata?: any;
}

export class TreasuryCashFlowService {
  /**
   * Forecast cash flow for a period
   */
  async forecastCashFlow(
    orgId: string,
    period: string,
    category: CashFlowCategory
  ): Promise<CashFlowForecast> {
    const properties = await prisma.property.findMany({
      where: { orgId },
      take: 50,
    });

    const projectedIncome = properties.reduce((sum: number, p: any) => {
      return sum + (p.aiOpportunityScore || 50) * 0.1; // Simplified calculation
    }, 0);

    const projectedExpense = projectedIncome * 0.3; // 30% expense ratio
    const netCashFlow = projectedIncome - projectedExpense;

    const factors: { factor: string; impact: number }[] = [
      { factor: "Property Count", impact: properties.length * 0.05 },
      { factor: "Market Conditions", impact: Math.random() * 0.1 - 0.05 },
      { factor: "Seasonality", impact: Math.random() * 0.08 - 0.04 },
    ];

    const confidence = 0.7 + Math.random() * 0.2;

    return {
      id: `forecast-${Date.now()}`,
      orgId,
      period,
      projectedIncome: Math.round(projectedIncome),
      projectedExpense: Math.round(projectedExpense),
      netCashFlow: Math.round(netCashFlow),
      category,
      confidence,
      factors,
      createdAt: new Date(),
    };
  }

  /**
   * Get current liquidity position
   */
  async getLiquidityPosition(orgId: string): Promise<LiquidityPosition> {
    // In production, calculate from actual financial data
    const totalCash = 1000000 + Math.random() * 500000;
    const escrowBalance = totalCash * 0.2;
    const availableLiquidity = totalCash - escrowBalance;
    const reserveRatio = 0.15; // 15% reserve requirement
    const liquidityRatio = availableLiquidity / totalCash;

    return {
      totalCash: Math.round(totalCash),
      escrowBalance: Math.round(escrowBalance),
      availableLiquidity: Math.round(availableLiquidity),
      reserveRatio: Math.round(reserveRatio * 100) / 100,
      liquidityRatio: Math.round(liquidityRatio * 100) / 100,
      lastUpdated: new Date(),
    };
  }

  /**
   * Check escrow liquidity
   */
  async checkEscrowLiquidity(orgId: string): Promise<boolean> {
    const liquidity = await this.getLiquidityPosition(orgId);
    const minLiquidityRatio = 0.3; // 30% minimum liquidity ratio

    return liquidity.liquidityRatio >= minLiquidityRatio;
  }

  /**
   * Calculate reserve ratio
   */
  async calculateReserveRatio(orgId: string): Promise<number> {
    const liquidity = await this.getLiquidityPosition(orgId);
    const requiredReserve = liquidity.totalCash * 0.15; // 15% requirement
    const actualReserve = liquidity.escrowBalance * 0.5; // 50% of escrow as reserve

    return actualReserve / requiredReserve;
  }

  /**
   * Create payout schedule
   */
  async createPayoutSchedule(
    partnerId: string,
    amount: number,
    dueDate: Date,
    metadata?: any
  ): Promise<PayoutSchedule> {
    return {
      partnerId,
      amount,
      currency: "USD",
      dueDate,
      status: CashFlowStatus.PENDING,
      metadata,
    };
  }

  /**
   * Process payout
   */
  async processPayout(payoutId: string): Promise<boolean> {
    // In production, integrate with payment processor
    console.log(`[Treasury] Processing payout: ${payoutId}`);
    return true;
  }

  /**
   * Get payout schedule for period
   */
  async getPayoutSchedule(orgId: string, startDate: Date, endDate: Date): Promise<PayoutSchedule[]> {
    // In production, fetch from database
    return [];
  }

  /**
   * Optimize settlement timing
   */
  async optimizeSettlementTiming(orgId: string): Promise<Date> {
    const liquidity = await this.getLiquidityPosition(orgId);
    
    // If liquidity is high, settle sooner
    if (liquidity.liquidityRatio > 0.5) {
      return new Date(Date.now() + 7 * 24 * 60 * 60 * 1000); // 7 days
    }
    
    // If liquidity is low, delay settlement
    return new Date(Date.now() + 30 * 24 * 60 * 60 * 1000); // 30 days
  }

  /**
   * Get treasury dashboard data
   */
  async getTreasuryDashboard(orgId: string): Promise<any> {
    const liquidity = await this.getLiquidityPosition(orgId);
    const reserveRatio = await this.calculateReserveRatio(orgId);
    const escrowLiquidity = await this.checkEscrowLiquidity(orgId);

    const forecast = await this.forecastCashFlow(
      orgId,
      new Date().toISOString().slice(0, 7),
      CashFlowCategory.RENTAL_INCOME
    );

    return {
      liquidity,
      reserveRatio: Math.round(reserveRatio * 100) / 100,
      escrowLiquidity,
      forecast,
      alerts: [
        ...liquidity.liquidityRatio < 0.3
          ? [{ type: "error" as const, title: "Low liquidity", message: "Liquidity ratio below 30%" }]
          : [],
        ...reserveRatio < 1.0
          ? [{ type: "warning" as const, title: "Reserve ratio below requirement", message: "Increase reserves" }]
          : [],
        ...!escrowLiquidity
          ? [{ type: "warning" as const, title: "Escrow liquidity low", message: "Review escrow balance" }]
          : [],
      ],
    };
  }

  /**
   * Get cash flow history
   */
  async getCashFlowHistory(orgId: string, months: number = 12): Promise<CashFlowForecast[]> {
    const forecasts: CashFlowForecast[] = [];
    
    for (let i = 0; i < months; i++) {
      const date = new Date();
      date.setMonth(date.getMonth() - i);
      const period = date.toISOString().slice(0, 7);
      
      try {
        const forecast = await this.forecastCashFlow(
          orgId,
          period,
          CashFlowCategory.RENTAL_INCOME
        );
        forecasts.push(forecast);
      } catch (error) {
        // Skip failed forecasts
      }
    }

    return forecasts;
  }

  /**
   * Analyze cash flow trends
   */
  async analyzeCashFlowTrends(orgId: string): Promise<any> {
    const history = await this.getCashFlowHistory(orgId, 12);

    if (history.length === 0) {
      return { trend: "INSUFFICIENT_DATA", average: 0, growth: 0 };
    }

    const netCashFlows = history.map(f => f.netCashFlow);
    const average = netCashFlows.reduce((sum, val) => sum + val, 0) / netCashFlows.length;
    
    const firstHalf = netCashFlows.slice(0, Math.floor(netCashFlows.length / 2));
    const secondHalf = netCashFlows.slice(Math.floor(netCashFlows.length / 2));
    
    const firstAvg = firstHalf.reduce((sum, val) => sum + val, 0) / firstHalf.length;
    const secondAvg = secondHalf.reduce((sum, val) => sum + val, 0) / secondHalf.length;
    
    const growth = ((secondAvg - firstAvg) / firstAvg) * 100;

    let trend: string;
    if (growth > 10) trend = "GROWING";
    else if (growth > -10) trend = "STABLE";
    else trend = "DECLINING";

    return {
      trend,
      average: Math.round(average),
      growth: Math.round(growth * 100) / 100,
      monthlyAverages: history.map(f => ({
        period: f.period,
        netCashFlow: f.netCashFlow,
      })),
    };
  }
}

export const treasuryCashFlowService = new TreasuryCashFlowService();
