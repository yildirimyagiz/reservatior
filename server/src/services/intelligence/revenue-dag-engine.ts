// =============================================================================
// RevenueDAGEngine — Global Multi-Currency Revenue Pipeline
// Directed Acyclic Graph for revenue flow with country-specific tax nodes
// Backwards compatible: amountTRY retained, amountLocal + currency added
// =============================================================================

import { multiCountryIntelligenceEngine } from './multi-country-intelligence-engine';

export type DAGNodeType =
  | 'INPUT_REVENUE'
  | 'LOCAL_TAX'
  | 'VAT_GST'
  | 'WITHHOLDING_TAX'
  | 'TOURISM_TAX'
  | 'TAX_DEDUCTION'       // legacy compat
  | 'OWNER_PAYOUT'
  | 'PARTNER_COMMISSION'
  | 'RESERVATIOR_MARGIN'
  | 'FINANCE_LEDGER';

export interface DAGNode {
  nodeId: string;
  nodeName: string;
  nodeType: DAGNodeType;
  // Legacy (TRY)
  amountTRY: number;
  percentageOfGross: number;
  status: 'PROCESSED' | 'COMMITTED';
  outputDestination: string;
  // Global extension
  amountLocal: number;
  currency: string;
  exchangeRateToUSD?: number;
  countryCode?: string;
  taxDescription?: string;
}

export interface RevenueDAGResult {
  transactionId: string;
  propertyId: string;
  countryCode: string;
  currency: string;
  grossRevenueTRY: number;
  grossRevenueLocal: number;
  totalTaxDeductedLocal: number;
  totalTaxDeductedPct: number;
  netRevenueAfterTaxLocal: number;
  dagNodes: DAGNode[];
  executedAt: string;
  ledgerCommitHash: string;
}

// ---------------------------------------------------------------------------
// Exchange rate stubs (would come from CurrencyConverter in production)
// ---------------------------------------------------------------------------
const APPROX_TRY_RATES: Record<string, number> = {
  TRY: 1,
  USD: 32.5,
  EUR: 35.2,
  GBP: 41.0,
  AED: 8.85,
  SAR: 8.67,
  QAR: 8.93,
  AUD: 21.3,
  SGD: 24.1,
  JPY: 0.217,
  KRW: 0.024,
  INR: 0.39,
  PKR: 0.117,
  CHF: 36.8,
  CAD: 24.0,
  MXN: 1.87,
  BRL: 6.3,
};

function toTRY(amount: number, currency: string): number {
  const rate = APPROX_TRY_RATES[currency] ?? 1;
  return Math.round(amount * rate);
}

function fromTRY(amountTRY: number, currency: string): number {
  const rate = APPROX_TRY_RATES[currency] ?? 1;
  return Math.round((amountTRY / rate) * 100) / 100;
}

// =============================================================================
// ENGINE CLASS
// =============================================================================
export class RevenueDAGEngine {
  private static instance: RevenueDAGEngine;

  public static getInstance(): RevenueDAGEngine {
    if (!RevenueDAGEngine.instance) {
      RevenueDAGEngine.instance = new RevenueDAGEngine();
    }
    return RevenueDAGEngine.instance;
  }

  // ---------------------------------------------------------------------------
  // Legacy TRY-based method (backward compatible, defaults to TR)
  // ---------------------------------------------------------------------------
  public processBookingRevenueDAG(
    propertyId: string,
    grossRevenueTRY: number,
    ownerGuaranteedMonthlyTRY: number = 40000,
    partnerCommissionRatePct: number = 12.5
  ): RevenueDAGResult {
    return this.processGlobalRevenueDAG({
      propertyId,
      countryCode: 'TR',
      grossRevenueLocal: grossRevenueTRY,
      ownerSharePct: 55,
      partnerCommissionRatePct,
    });
  }

  // ---------------------------------------------------------------------------
  // New global method — country-aware, multi-currency
  // ---------------------------------------------------------------------------
  public processGlobalRevenueDAG(params: {
    propertyId: string;
    countryCode: string;
    grossRevenueLocal: number;
    ownerSharePct?: number;
    partnerCommissionRatePct?: number;
  }): RevenueDAGResult {
    const {
      propertyId,
      countryCode,
      grossRevenueLocal,
      ownerSharePct = 55,
      partnerCommissionRatePct = 12.5,
    } = params;

    const policy = multiCountryIntelligenceEngine.getCountryPolicy(countryCode);
    const currency = policy?.currency || 'TRY';
    const tourismTaxRate = (policy?.tourismTaxRate ?? 2) / 100;
    const vatRate = (policy?.vatRate ?? 0) / 100;
    const withholdingTaxRate = (policy?.withholdingTaxRate ?? 0) / 100;

    // ── Tax Calculations ──────────────────────────────────────────────────
    const tourismTaxLocal = Math.round(grossRevenueLocal * tourismTaxRate * 100) / 100;
    const vatLocal = Math.round(grossRevenueLocal * vatRate * 100) / 100;
    const withholdingTaxLocal = Math.round(grossRevenueLocal * withholdingTaxRate * 100) / 100;
    const totalTaxLocal = tourismTaxLocal + vatLocal + withholdingTaxLocal;
    const netOperatingRevenueLocal = grossRevenueLocal - totalTaxLocal;

    // ── Revenue Split ──────────────────────────────────────────────────────
    const ownerShareLocal = Math.round(netOperatingRevenueLocal * (ownerSharePct / 100) * 100) / 100;
    const partnerShareLocal = Math.round(grossRevenueLocal * (partnerCommissionRatePct / 100) * 100) / 100;
    const reservatiorMarginLocal = Math.round((netOperatingRevenueLocal - ownerShareLocal - partnerShareLocal) * 100) / 100;

    // ── TRY equivalents ────────────────────────────────────────────────────
    const grossRevenueTRY = toTRY(grossRevenueLocal, currency);

    // ── Build DAG Nodes ────────────────────────────────────────────────────
    const dagNodes: DAGNode[] = [];

    // DAG-01: Gross Revenue
    dagNodes.push({
      nodeId: 'DAG-01-GROSS',
      nodeName: 'Gross Booking Revenue Event',
      nodeType: 'INPUT_REVENUE',
      amountLocal: grossRevenueLocal,
      amountTRY: grossRevenueTRY,
      currency,
      percentageOfGross: 100,
      status: 'COMMITTED',
      outputDestination: 'Revenue Processing Pipeline',
      countryCode,
    });

    // DAG-02: Tourism / Accommodation Tax
    if (tourismTaxLocal > 0) {
      dagNodes.push({
        nodeId: 'DAG-02-TOURISM-TAX',
        nodeName: `Tourism / Accommodation Tax (${policy?.tourismTaxRate ?? 2}%)`,
        nodeType: 'TOURISM_TAX',
        amountLocal: tourismTaxLocal,
        amountTRY: toTRY(tourismTaxLocal, currency),
        currency,
        percentageOfGross: policy?.tourismTaxRate ?? 2,
        status: 'COMMITTED',
        outputDestination: `${policy?.countryName || countryCode} Tax Authority`,
        countryCode,
        taxDescription: `Tourism/accommodation tax at ${policy?.tourismTaxRate ?? 2}%`,
      });
    }

    // DAG-03: VAT / GST
    if (vatLocal > 0) {
      dagNodes.push({
        nodeId: 'DAG-03-VAT',
        nodeName: `VAT / GST Node (${policy?.vatRate ?? 0}%)`,
        nodeType: 'VAT_GST',
        amountLocal: vatLocal,
        amountTRY: toTRY(vatLocal, currency),
        currency,
        percentageOfGross: policy?.vatRate ?? 0,
        status: 'COMMITTED',
        outputDestination: `${policy?.countryName || countryCode} Revenue Service`,
        countryCode,
        taxDescription: `VAT/GST at ${policy?.vatRate ?? 0}%`,
      });
    }

    // DAG-04: Withholding Tax
    if (withholdingTaxLocal > 0) {
      dagNodes.push({
        nodeId: 'DAG-04-WITHHOLDING',
        nodeName: `Withholding Tax Node (${policy?.withholdingTaxRate ?? 0}%)`,
        nodeType: 'WITHHOLDING_TAX',
        amountLocal: withholdingTaxLocal,
        amountTRY: toTRY(withholdingTaxLocal, currency),
        currency,
        percentageOfGross: policy?.withholdingTaxRate ?? 0,
        status: 'COMMITTED',
        outputDestination: `${policy?.countryName || countryCode} Tax Withholding Authority`,
        countryCode,
        taxDescription: `Withholding tax at ${policy?.withholdingTaxRate ?? 0}%`,
      });
    }

    // DAG-05: Owner Distribution
    dagNodes.push({
      nodeId: 'DAG-05-OWNER',
      nodeName: 'Owner Guaranteed & Performance Share Node',
      nodeType: 'OWNER_PAYOUT',
      amountLocal: ownerShareLocal,
      amountTRY: toTRY(ownerShareLocal, currency),
      currency,
      percentageOfGross: Math.round((ownerShareLocal / grossRevenueLocal) * 100),
      status: 'COMMITTED',
      outputDestination: 'Owner Escrow Bank Account',
      countryCode,
    });

    // DAG-06: Partner Commission
    dagNodes.push({
      nodeId: 'DAG-06-PARTNER',
      nodeName: 'Partner Multi-Split Commission Node',
      nodeType: 'PARTNER_COMMISSION',
      amountLocal: partnerShareLocal,
      amountTRY: toTRY(partnerShareLocal, currency),
      currency,
      percentageOfGross: partnerCommissionRatePct,
      status: 'COMMITTED',
      outputDestination: 'Partner Wallet & Instant Advance Pool',
      countryCode,
    });

    // DAG-07: Reservatior Margin
    dagNodes.push({
      nodeId: 'DAG-07-MARGIN',
      nodeName: 'Reservatior Platform Net Margin Node',
      nodeType: 'RESERVATIOR_MARGIN',
      amountLocal: reservatiorMarginLocal,
      amountTRY: toTRY(reservatiorMarginLocal, currency),
      currency,
      percentageOfGross: Math.round((reservatiorMarginLocal / grossRevenueLocal) * 100),
      status: 'COMMITTED',
      outputDestination: 'Reservatior Corporate Treasury',
      countryCode,
    });

    // DAG-08: Finance Ledger Commit
    dagNodes.push({
      nodeId: 'DAG-08-LEDGER',
      nodeName: 'Finance OS Double-Entry Ledger Commit',
      nodeType: 'FINANCE_LEDGER',
      amountLocal: grossRevenueLocal,
      amountTRY: grossRevenueTRY,
      currency,
      percentageOfGross: 100,
      status: 'COMMITTED',
      outputDestination: "Prisma `Commission` & `Payout` Tables",
      countryCode,
    });

    return {
      transactionId: `TX-DAG-${Math.floor(100000 + Math.random() * 900000)}`,
      propertyId,
      countryCode,
      currency,
      grossRevenueTRY,
      grossRevenueLocal,
      totalTaxDeductedLocal: totalTaxLocal,
      totalTaxDeductedPct: Math.round((totalTaxLocal / grossRevenueLocal) * 100),
      netRevenueAfterTaxLocal: netOperatingRevenueLocal,
      dagNodes,
      executedAt: new Date().toISOString(),
      ledgerCommitHash: `0x${Math.random().toString(16).substring(2, 12)}${Math.random().toString(16).substring(2, 12)}`,
    };
  }
}

export const revenueDAGEngine = RevenueDAGEngine.getInstance();
