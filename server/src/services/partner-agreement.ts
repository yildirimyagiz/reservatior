import { prisma } from "../lib/prisma";
import { BaseService } from "./base";
import * as crypto from "crypto";

// AES-256-GCM Encryption Setup
const ALGORITHM = "aes-256-gcm";
const ENCRYPTION_KEY = process.env.ENCRYPTION_KEY 
  ? crypto.scryptSync(process.env.ENCRYPTION_KEY, "salt", 32)
  : crypto.randomBytes(32); // Fallback for development if not in env

export interface CommissionSchedule {
  initial_move_in_cost_subsidy: number;
  monthly_commission_schedule: Array<{
    month: number;
    rate: number;
  }>;
  loyalty_yield_multipliers: Array<{
    month: number;
    multiplier: number;
  }>;
}

export interface RevenueDAGParams {
  exposureScore: number;         // 0.0 to 1.0 (Listing visibility score)
  engagementRate: number;        // 0.0 to 1.0 (Interaction rate)
  conversionProbability: number; // 0.0 to 1.0 (Lead to Booking probability)
  timeDecay: number;             // Decay multiplier (e.g. 0.95 per month)
  tenantBehaviorScore: number;   // 0.0 to 1.5 (Multiplier based on reliability/loyalty)
}

export class PartnerAgreementService extends BaseService<any, any, any> {
  constructor() {
    super((prisma as any).partnerAgreement, "partnerAgreement");
  }

  /**
   * Encrypts terms object to AES-256-GCM hex string
   */
  encryptTerms(terms: any): string {
    const iv = crypto.randomBytes(12);
    const cipher = crypto.createCipheriv(ALGORITHM, ENCRYPTION_KEY, iv);
    let encrypted = cipher.update(JSON.stringify(terms), "utf8", "hex");
    encrypted += cipher.final("hex");
    const authTag = cipher.getAuthTag().toString("hex");
    return `${iv.toString("hex")}:${authTag}:${encrypted}`;
  }

  /**
   * Decrypts AES-256-GCM terms string back to object
   */
  decryptTerms(encryptedBlob: string): any {
    try {
      const [ivHex, authTagHex, encryptedHex] = encryptedBlob.split(":");
      if (!ivHex || !authTagHex || !encryptedHex) {
        throw new Error("Invalid encrypted blob format");
      }
      const iv = Buffer.from(ivHex, "hex");
      const authTag = Buffer.from(authTagHex, "hex");
      const decipher = crypto.createDecipheriv(ALGORITHM, ENCRYPTION_KEY, iv);
      decipher.setAuthTag(authTag);
      let decrypted = decipher.update(encryptedHex, "hex", "utf8");
      decrypted += decipher.final("utf8");
      return JSON.parse(decrypted);
    } catch (e) {
      console.error("Decryption failed:", e);
      return null;
    }
  }

  /**
   * Computes monthly commission using the dynamic schedule and loyalty multipliers
   */
  computeMonthlyCommission(
    agreement: CommissionSchedule,
    baseRevenue: number,
    monthIndex: number
  ): number {
    const schedule = agreement.monthly_commission_schedule || [];
    const multipliers = agreement.loyalty_yield_multipliers || [];

    const rate = schedule.find(m => m.month === monthIndex)?.rate 
      ?? schedule[schedule.length - 1]?.rate 
      ?? 0;

    const loyalty = multipliers.find(m => m.month === monthIndex)?.multiplier 
      ?? 1;

    return baseRevenue * rate * loyalty;
  }

  /**
   * Revenue DAG (Deterministic Financial Flow) Formula
   * Revenue = f(exposure, engagement, conversion, time_decay, contract_rules, tenant_behavior)
   */
  computeMonthlyRevenueDAG(
    baseEstimate: number,
    params: RevenueDAGParams,
    agreement: CommissionSchedule,
    monthIndex: number
  ): {
    grossRevenue: number;
    commissionSplit: number;
    netPayout: number;
  } {
    const { exposureScore, engagementRate, conversionProbability, timeDecay, tenantBehaviorScore } = params;

    // Apply revenue formula factors
    const exposureFactor = exposureScore > 0 ? exposureScore : 1.0;
    const engagementFactor = engagementRate > 0 ? engagementRate : 1.0;
    const conversionFactor = conversionProbability > 0 ? conversionProbability : 1.0;
    const decayFactor = Math.pow(timeDecay || 0.95, monthIndex);
    const behaviorFactor = tenantBehaviorScore > 0 ? tenantBehaviorScore : 1.0;

    const grossRevenue = baseEstimate * exposureFactor * engagementFactor * conversionFactor * decayFactor * behaviorFactor;

    // Calculate commission and payout splits
    const commissionSplit = this.computeMonthlyCommission(agreement, grossRevenue, monthIndex);
    const netPayout = grossRevenue - commissionSplit;

    return {
      grossRevenue: Math.round(grossRevenue * 100) / 100,
      commissionSplit: Math.round(commissionSplit * 100) / 100,
      netPayout: Math.round(netPayout * 100) / 100
    };
  }

  /**
   * Transitions agreement state validating allowed transitions
   */
  async transitionState(agreementId: string, nextState: string, tenantId: string) {
    const agreement = await this.getById(agreementId);
    if (!agreement) throw new Error("Agreement not found");
    if (agreement.tenantId !== tenantId) throw new Error("Unauthorized tenant access");

    const validTransitions: Record<string, string[]> = {
      CREATED: ["PENDING"],
      PENDING: ["ACTIVE", "ARCHIVED"],
      ACTIVE: ["SUSPENDED", "MODIFIED", "ESCALATED", "ARCHIVED"],
      SUSPENDED: ["ACTIVE", "RE_EXECUTED", "ARCHIVED"],
      MODIFIED: ["ACTIVE", "RE_EXECUTED"],
      ESCALATED: ["ACTIVE", "SUSPENDED", "RE_EXECUTED"],
      RE_EXECUTED: ["SETTLED"],
      SETTLED: ["ARCHIVED"],
      ARCHIVED: []
    };

    const allowed = validTransitions[agreement.status] || [];
    if (!allowed.includes(nextState)) {
      throw new Error(`Invalid state transition from ${agreement.status} to ${nextState}`);
    }

    return this.update(agreementId, { status: nextState });
  }
}

export const partnerAgreementService = new PartnerAgreementService();
