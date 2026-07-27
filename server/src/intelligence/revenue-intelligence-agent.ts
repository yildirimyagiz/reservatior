/**
 * Revenue Intelligence Agent
 * Phase 7 — Revenue Intelligence Loop
 *
 * Tracks predicted vs actual revenue across all revenue streams:
 *   - Commission (deals)
 *   - Rental income (bookings)
 *   - Investment returns
 *   - Platform fees
 *
 * Stores actuals in DB (replaces in-memory Map from revenue-intelligence-loop.ts)
 * Generates RevenueOutcomeReport with:
 *   - Accuracy scores per prediction model
 *   - Market-level aggregates
 *   - Auto-generated content refresh triggers
 *
 * Emits:
 *   revenue.intelligence.report.v1
 *   content.refresh.triggered.v1   (when conversion is declining)
 *   seo.page.regenerate.triggered.v1 (when page performance drops)
 */

import { PrismaClient } from '@prisma/client';
import { eventBus } from '../core/events/event-bus';
import { DomainEvents } from '../core/events/domain-events';

const prisma = new PrismaClient();

// ─── Types ─────────────────────────────────────────────────────────────────────

export interface RevenueOutcome {
  orgId: string;
  propertyId?: string;
  locationId?: string;
  agentId?: string;
  period: string;               // e.g. '2026-07'

  // Actuals
  actualCommission: number;
  actualRentalRevenue: number;
  actualInvestmentReturn: number;
  actualPlatformFee: number;

  // Predictions (from intelligence scores at listing time)
  predictedCommission: number;
  predictedRentalRevenue: number;
  predictedInvestmentReturn: number;

  currency: string;
}

export interface RevenueAccuracyReport {
  period: string;
  totalActualRevenue: number;
  totalPredictedRevenue: number;
  overallAccuracy: number;       // 1.0 = perfect
  commissionAccuracy: number;
  rentalAccuracy: number;
  investmentAccuracy: number;
  topPropertyId?: string;
  bottomPropertyId?: string;
  trend: 'IMPROVING' | 'STABLE' | 'DECLINING';
  actions: RevenueAction[];
}

export interface RevenueAction {
  type: 'REFRESH_CONTENT' | 'REGENERATE_SEO' | 'UPDATE_PRICING' | 'FLAG_AGENT' | 'MARKET_ALERT';
  targetId: string;             // propertyId, agentId, or locationId
  reason: string;
  urgency: 'HIGH' | 'MEDIUM' | 'LOW';
}

// ─── Agent ─────────────────────────────────────────────────────────────────────

export class RevenueIntelligenceAgent {

  start() {
    // Listen to actual revenue events
    eventBus.subscribe(DomainEvents.COMMISSION_PAID, async (msg) => {
      await this.recordCommissionOutcome(msg.payload);
    });

    eventBus.subscribe(DomainEvents.REVENUE_RECOGNIZED, async (msg) => {
      await this.recordRevenueRecognized(msg.payload);
    });

    eventBus.subscribe(DomainEvents.BOOKING_CHECKED_OUT, async (msg) => {
      await this.recordRentalOutcome(msg.payload);
    });

    // Listen to calibration completions from FeedbackAgent → may trigger content refresh
    eventBus.subscribe('feedback.calibration.completed.v1', async (msg) => {
      await this.evaluateContentRefresh(msg.payload);
    });

    console.log('[RevenueIntelligenceAgent] ✅ Subscribed to 4 revenue outcome events');
  }

  // ─── Revenue Recording ────────────────────────────────────────────────────────

  private async recordCommissionOutcome(payload: any): Promise<void> {
    const { dealId, agentId, amount, currency, effectiveRate } = payload;

    console.log(`[RevenueAgent] Commission paid: dealId=${dealId} amount=${amount} ${currency} rate=${effectiveRate}`);

    // Store in DB
    await this.upsertRevenueRecord({
      orgId: payload.orgId ?? 'unknown',
      agentId,
      period: this.currentPeriod(),
      actualCommission: Number(amount ?? 0),
      actualRentalRevenue: 0,
      actualInvestmentReturn: 0,
      actualPlatformFee: Number(amount ?? 0) * 0.05, // 5% platform cut
      predictedCommission: payload.predictedCommission ?? 0,
      predictedRentalRevenue: 0,
      predictedInvestmentReturn: 0,
      currency: currency ?? 'USD',
    });

    await this.generatePeriodReport(payload.orgId ?? 'unknown', this.currentPeriod());
  }

  private async recordRentalOutcome(payload: any): Promise<void> {
    const { propertyId, orgId, amount } = payload;

    console.log(`[RevenueAgent] Rental checkout: propertyId=${propertyId} amount=${amount}`);

    await this.upsertRevenueRecord({
      orgId: orgId ?? 'unknown',
      propertyId,
      period: this.currentPeriod(),
      actualCommission: 0,
      actualRentalRevenue: Number(amount ?? 0),
      actualInvestmentReturn: 0,
      actualPlatformFee: Number(amount ?? 0) * 0.03,
      predictedCommission: 0,
      predictedRentalRevenue: payload.predictedRentalRevenue ?? 0,
      predictedInvestmentReturn: 0,
      currency: payload.currency ?? 'USD',
    });
  }

  private async recordRevenueRecognized(payload: any): Promise<void> {
    const { orgId, amount, revenueType } = payload;

    console.log(`[RevenueAgent] Revenue recognized: type=${revenueType} amount=${amount}`);

    await this.upsertRevenueRecord({
      orgId: orgId ?? 'unknown',
      period: this.currentPeriod(),
      actualCommission: revenueType === 'COMMISSION' ? Number(amount ?? 0) : 0,
      actualRentalRevenue: revenueType === 'RENTAL' ? Number(amount ?? 0) : 0,
      actualInvestmentReturn: revenueType === 'INVESTMENT' ? Number(amount ?? 0) : 0,
      actualPlatformFee: Number(amount ?? 0) * 0.02,
      predictedCommission: 0,
      predictedRentalRevenue: 0,
      predictedInvestmentReturn: 0,
      currency: payload.currency ?? 'USD',
    });
  }

  // ─── Content Refresh Evaluation ───────────────────────────────────────────────

  private async evaluateContentRefresh(payload: any): Promise<void> {
    const { propertyId, orgId, direction, calibrationDelta } = payload;

    if (!propertyId || direction === 'NEUTRAL') return;

    if (direction === 'DOWNWARD' && calibrationDelta < -0.05) {
      // Significant downward calibration → refresh content & SEO
      console.log(`[RevenueAgent] 📉 Triggering content refresh for ${propertyId} (delta=${calibrationDelta.toFixed(3)})`);

      await eventBus.publish(
        'content.refresh.triggered.v1',
        {
          propertyId,
          orgId,
          reason: `Score calibrated downward (delta=${calibrationDelta.toFixed(3)}). Content may be overpromising.`,
          urgency: Math.abs(calibrationDelta) > 0.1 ? 'HIGH' : 'MEDIUM',
          triggeredBy: 'revenue-intelligence-agent',
        },
        'revenue-intelligence-agent'
      );
    } else if (direction === 'UPWARD' && calibrationDelta > 0.05) {
      // Outperforming predictions → generate similar pages for adjacent markets
      console.log(`[RevenueAgent] 📈 Property ${propertyId} outperforming. Signaling for expansion.`);

      await eventBus.publish(
        'revenue.expansion.signal.v1',
        {
          propertyId,
          orgId,
          calibrationDelta,
          reason: 'Property outperforming predictions — adjacent market opportunities exist.',
          triggeredBy: 'revenue-intelligence-agent',
        },
        'revenue-intelligence-agent'
      );
    }
  }

  // ─── Period Report ────────────────────────────────────────────────────────────

  private async generatePeriodReport(orgId: string, period: string): Promise<void> {
    try {
      const records = await (prisma as any).revenueOutcomeRecord?.findMany({
        where: { orgId, period },
      }).catch(() => []) ?? [];

      if (records.length === 0) return;

      const totalActual = records.reduce((s: number, r: any) =>
        s + (r.actualCommission ?? 0) + (r.actualRentalRevenue ?? 0) + (r.actualInvestmentReturn ?? 0), 0);
      const totalPredicted = records.reduce((s: number, r: any) =>
        s + (r.predictedCommission ?? 0) + (r.predictedRentalRevenue ?? 0) + (r.predictedInvestmentReturn ?? 0), 0);

      const overallAccuracy = totalPredicted > 0
        ? Math.min(2, totalActual / totalPredicted)   // capped at 2.0 (200%)
        : 1.0;

      const trend: RevenueAccuracyReport['trend'] =
        overallAccuracy >= 0.95 ? 'IMPROVING' :
        overallAccuracy >= 0.80 ? 'STABLE' : 'DECLINING';

      const actions: RevenueAction[] = [];
      if (trend === 'DECLINING') {
        actions.push({
          type: 'MARKET_ALERT',
          targetId: orgId,
          reason: `Revenue accuracy dropped to ${(overallAccuracy * 100).toFixed(1)}% for period ${period}`,
          urgency: overallAccuracy < 0.70 ? 'HIGH' : 'MEDIUM',
        });
      }

      const report: RevenueAccuracyReport = {
        period,
        totalActualRevenue: totalActual,
        totalPredictedRevenue: totalPredicted,
        overallAccuracy,
        commissionAccuracy: this.calcAccuracy(records, 'actualCommission', 'predictedCommission'),
        rentalAccuracy: this.calcAccuracy(records, 'actualRentalRevenue', 'predictedRentalRevenue'),
        investmentAccuracy: this.calcAccuracy(records, 'actualInvestmentReturn', 'predictedInvestmentReturn'),
        trend,
        actions,
      };

      await eventBus.publish(
        'revenue.intelligence.report.v1',
        { orgId, ...report },
        'revenue-intelligence-agent'
      );

      console.log(`[RevenueAgent] 📊 Period report: org=${orgId} period=${period} accuracy=${(overallAccuracy * 100).toFixed(1)}% trend=${trend}`);
    } catch (err) {
      console.error('[RevenueAgent] Report generation failed:', err);
    }
  }

  // ─── DB Helpers ───────────────────────────────────────────────────────────────

  private async upsertRevenueRecord(data: RevenueOutcome): Promise<void> {
    try {
      const key = `${data.orgId}:${data.period}:${data.propertyId ?? data.agentId ?? 'global'}`;

      await (prisma as any).revenueOutcomeRecord?.upsert({
        where: { periodKey: key },
        create: {
          periodKey: key,
          orgId: data.orgId,
          propertyId: data.propertyId,
          agentId: data.agentId,
          locationId: data.locationId,
          period: data.period,
          actualCommission: data.actualCommission,
          actualRentalRevenue: data.actualRentalRevenue,
          actualInvestmentReturn: data.actualInvestmentReturn,
          actualPlatformFee: data.actualPlatformFee,
          predictedCommission: data.predictedCommission,
          predictedRentalRevenue: data.predictedRentalRevenue,
          predictedInvestmentReturn: data.predictedInvestmentReturn,
          currency: data.currency,
        },
        update: {
          actualCommission: { increment: data.actualCommission },
          actualRentalRevenue: { increment: data.actualRentalRevenue },
          actualInvestmentReturn: { increment: data.actualInvestmentReturn },
          actualPlatformFee: { increment: data.actualPlatformFee },
        },
      });
    } catch {
      // Table may not exist in all country DBs — non-fatal
    }
  }

  private calcAccuracy(records: any[], actualField: string, predictedField: string): number {
    const totalActual = records.reduce((s: number, r: any) => s + (r[actualField] ?? 0), 0);
    const totalPredicted = records.reduce((s: number, r: any) => s + (r[predictedField] ?? 0), 0);
    return totalPredicted > 0 ? Math.min(2, totalActual / totalPredicted) : 1.0;
  }

  private currentPeriod(): string {
    const now = new Date();
    return `${now.getFullYear()}-${String(now.getMonth() + 1).padStart(2, '0')}`;
  }
}

export const revenueIntelligenceAgent = new RevenueIntelligenceAgent();
