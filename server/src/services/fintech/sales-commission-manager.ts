// server/src/services/fintech/sales-commission-manager.ts
// 3 komisyon modeli — ülke uyumluluğuyla birlikte
//
// Model A — INSTALLMENT_12 (%4/ay carry; %4 EV SAHİBİ + %4 KİRACI, her biri kendi payını öder)
//           Taksit izni olmayan ülkelerde → Model C'ye fallback
// Model B — HYBRID_50_6   (%50 peşin + kalan %60'ı 6 taksit + %10 servis + %2 platform)
//           Open Banking yoksa → kart taksit (Stripe/iyzico)
// Model C — TRADITIONAL_1M (1 ay kira/komisyon peşin, evrensel, her ülkede çalışır)
//
// %2 Platform & Sigorta her modelde her zaman Reservatior'a kalır.

import { ALL_COMPLIANCE_RULES } from '../../../config/rental-compliance-config';

export enum CommissionModel {
  INSTALLMENT_12  = 'INSTALLMENT_12',
  HYBRID_50_6     = 'HYBRID_50_6',
  TRADITIONAL_1M  = 'TRADITIONAL_1M',
}

const PLATFORM_INSURANCE_RATE = 0.02;  // %2 - Tüm modeller, sabit
const INSTALLMENT_CARRY_RATE  = 0.04;  // %4 - Ev sahibinden + %4 Kiracıdan
const HYBRID_SERVICE_FEE      = 0.10;  // %10 - Hibrit modelde ertelenen kısma

export interface SalesCommissionInput {
  propertyId:          string;
  agentId:             string;
  salePrice:           number;
  currency:            string;
  baseRateBps:         number;     // Örn: 350 = %3.5 (acentenin oranı)
  countryCode:         string;     // ISO: TR, US, DE, AE ...
  stateCode?:          string;
  model:               CommissionModel;
  tenantMonthlyRent?:  number;     // Model C ve Model B eşiği için
}

export interface CommissionParty {
  amount:    number;
  carryFee:  number;  // Taşıma/servis bedeli bu taraftan alınan kısım
  total:     number;  // amount + carryFee
  feeLabel?: string;  // Ücretin faturada/sözleşmede nasıl görüneceği
}

export interface CommissionBreakdown {
  model:                   CommissionModel;
  appliedModel:            CommissionModel;  // fallback sonrası gerçek model
  fallbackReason?:         string;           // Neden fallback yapıldı?
  countryCode:             string;
  complianceRule:          { maxInstallments: number; tenantCanPay: boolean; landlordCanPay: boolean; };
  loadShiftedToLandlord?:  boolean;          // Kiracı ücret ödeyemediği için ev sahibine kaydırıldı mı?

  grossCommission:         number;           // Acentenin baz komisyonu
  platformInsuranceFee:    number;           // %2 Reservatior payı (satış fiyatından)

  // Taraflara bölüşüm (carry varsa her biri kendi payını öder)
  landlordSide:            CommissionParty;
  tenantSide:              CommissionParty;

  downPayment:             number;           // Peşin toplam (tenant+landlord)
  installmentAmount?:      number;           // Aylık taksit toplamı (her iki taraf)
  numberOfInstallments?:   number;
  totalCost:               number;           // Grand total (her şey dahil)

  rentEquivalentLabel?:    string;
  schedule:                PaymentScheduleItem[];
}

export interface PaymentScheduleItem {
  installmentNo: number;
  dueDate:       Date;
  fromLandlord:  number;
  fromTenant:    number;
  total:         number;
  label:         string;
}

export class SalesCommissionManager {

  static async calculateAllModels(input: Omit<SalesCommissionInput, 'model'>): Promise<Record<CommissionModel, CommissionBreakdown>> {
    const results: Partial<Record<CommissionModel, CommissionBreakdown>> = {};
    for (const model of Object.values(CommissionModel)) {
      results[model] = await this.calculate({ ...input, model });
    }
    return results as Record<CommissionModel, CommissionBreakdown>;
  }

  static async calculate(input: SalesCommissionInput): Promise<CommissionBreakdown> {
    const rule = ALL_COMPLIANCE_RULES[input.countryCode];

    // Ülke kurallarını çöz
    const maxInstallments = rule?.openBanking?.maxInstallments ?? 0;
    const landlordCanPay  = (rule?.landlordCommissionFixedPct ?? 3.5) > 0;
    let   tenantCanPay    = (rule?.tenantCommissionFixedPct ?? 3.5) > 0;

    // Fallback: Taksit yoksa TRADITIONAL_1M'e yönlendir
    let appliedModel    = input.model;
    let fallbackReason: string | undefined;

    if (input.model === CommissionModel.INSTALLMENT_12 && maxInstallments < 12) {
      appliedModel   = CommissionModel.TRADITIONAL_1M;
      fallbackReason = `${input.countryCode} max installments is ${maxInstallments}. Switched to Traditional 1-Month model.`;
    } else if (input.model === CommissionModel.HYBRID_50_6 && maxInstallments < 6) {
      appliedModel   = CommissionModel.TRADITIONAL_1M;
      fallbackReason = `${input.countryCode} does not support 6-installment plans. Switched to Traditional 1-Month model.`;
    }

    // Platform ücreti → satış fiyatının %2'si
    const platformInsuranceFee = Math.round(input.salePrice * PLATFORM_INSURANCE_RATE);

    // Her tarafın baz komisyonu ve dinamik etiketler
    let landlordRatePct = rule?.landlordCommissionFixedPct ?? input.baseRateBps / 200;
    let tenantRatePct   = rule?.tenantCommissionFixedPct   ?? input.baseRateBps / 200;
    
    let loadShiftedToLandlord = false;
    let landlordFeeLabel = "Sales Commission";
    let tenantFeeLabel = "Sales Commission";

    const allowsTenantServiceFee = rule?.allowsTenantServiceFee ?? true;

    if (tenantRatePct === 0) {
      if (allowsTenantServiceFee) {
        // İsimlendirme Değişikliği (Platform & Service Fees)
        tenantRatePct = rule?.maxTenantServiceFeePct ?? (input.baseRateBps / 200);
        tenantFeeLabel = "Platform Transaction & Concierge Fee";
        tenantCanPay = true; // Servis bedeli olarak ödeyebiliyor
      } else {
        // Yük Kaydırma (Load Shifting to Landlord)
        loadShiftedToLandlord = true;
        landlordFeeLabel = "Premium Liquidity & Guarantee Fee";
      }
    }

    const landlordBase    = Math.round(input.salePrice * landlordRatePct / 100);
    const tenantBase      = Math.round(input.salePrice * tenantRatePct   / 100);
    const grossCommission = landlordBase + tenantBase; // Toplam ajan komisyonu

    const complianceRule = { maxInstallments, tenantCanPay, landlordCanPay };

    const p: ModelParams = { 
      input, appliedModel, fallbackReason, grossCommission, 
      landlordBase, tenantBase, platformInsuranceFee, complianceRule,
      landlordFeeLabel, tenantFeeLabel, loadShiftedToLandlord
    };

    switch (appliedModel) {
      case CommissionModel.INSTALLMENT_12:
        return this._model_INSTALLMENT_12(p);
      case CommissionModel.HYBRID_50_6:
        return this._model_HYBRID_50_6(p);
      default:
        return this._model_TRADITIONAL_1M(p);
    }
  }

  // ─── MODEL A: 12 Ay / %4 EV SAHİBİ + %4 KİRACI Carry ───────────────────────
  private static _model_INSTALLMENT_12(p: ModelParams): CommissionBreakdown {
    const { input, appliedModel, fallbackReason, grossCommission, landlordBase, tenantBase, platformInsuranceFee, complianceRule } = p;

    const landlordCarry = Math.round(landlordBase * INSTALLMENT_CARRY_RATE * 12);
    const tenantCarry   = Math.round(tenantBase   * INSTALLMENT_CARRY_RATE * 12);
    const landlordTotal = landlordBase + landlordCarry;
    const tenantTotal   = tenantBase   + tenantCarry;

    const installmentLandlord = Math.round(landlordTotal / 12);
    const installmentTenant   = Math.round(tenantTotal   / 12);
    const installmentAmount   = installmentLandlord + installmentTenant;

    const totalCost = landlordTotal + tenantTotal + platformInsuranceFee;
    const schedule  = this._schedule(12, installmentLandlord, installmentTenant, 0, 'Monthly Installment (4% carry each party)');

    return {
      model: input.model, appliedModel, fallbackReason, countryCode: input.countryCode, complianceRule, loadShiftedToLandlord: p.loadShiftedToLandlord,
      grossCommission, platformInsuranceFee,
      landlordSide: { amount: landlordBase, carryFee: landlordCarry, total: landlordTotal, feeLabel: p.landlordFeeLabel },
      tenantSide:   { amount: tenantBase,   carryFee: tenantCarry,   total: tenantTotal, feeLabel: p.tenantFeeLabel },
      downPayment: 0, installmentAmount, numberOfInstallments: 12, totalCost, schedule,
    };
  }

  // ─── MODEL B: %50 Peşin + %60'ı 6 Taksit ────────────────────────────────────
  private static _model_HYBRID_50_6(p: ModelParams): CommissionBreakdown {
    const { input, appliedModel, fallbackReason, grossCommission, landlordBase, tenantBase, platformInsuranceFee, complianceRule } = p;

    const landlordDown    = Math.round(landlordBase * 0.5);
    const tenantDown      = Math.round(tenantBase   * 0.5);
    const landlordDeferred = Math.round((landlordBase - landlordDown) * (1 + HYBRID_SERVICE_FEE));
    const tenantDeferred   = Math.round((tenantBase   - tenantDown)   * (1 + HYBRID_SERVICE_FEE));

    const installmentLandlord = Math.round(landlordDeferred / 6);
    const installmentTenant   = Math.round(tenantDeferred   / 6);
    const installmentAmount   = installmentLandlord + installmentTenant;

    const downPayment = landlordDown + tenantDown + platformInsuranceFee;
    const totalCost   = downPayment + landlordDeferred + tenantDeferred;

    const rentEquivalentLabel = input.tenantMonthlyRent
      ? `Down payment ≈ ${(downPayment / input.tenantMonthlyRent).toFixed(1)}x Monthly Rent`
      : '≈ 1 Month Rent Transition Threshold';

    const schedule: PaymentScheduleItem[] = [
      { installmentNo: 0, dueDate: new Date(), fromLandlord: landlordDown + platformInsuranceFee, fromTenant: tenantDown, total: downPayment, label: '50% Down + Platform/Insurance Fee' },
      ...this._schedule(6, installmentLandlord, installmentTenant, 1, 'Installment (+10% service fee on deferred portion)'),
    ];

    return {
      model: input.model, appliedModel, fallbackReason, countryCode: input.countryCode, complianceRule, loadShiftedToLandlord: p.loadShiftedToLandlord,
      grossCommission, platformInsuranceFee,
      landlordSide: { amount: landlordBase, carryFee: Math.round(landlordDeferred - (landlordBase * 0.5)), total: landlordDown + landlordDeferred, feeLabel: p.landlordFeeLabel },
      tenantSide:   { amount: tenantBase,   carryFee: Math.round(tenantDeferred   - (tenantBase   * 0.5)), total: tenantDown   + tenantDeferred, feeLabel: p.tenantFeeLabel },
      downPayment, installmentAmount, numberOfInstallments: 6, totalCost, rentEquivalentLabel, schedule,
    };
  }

  // ─── MODEL C: Geleneksel, Evrensel Fallback ───────────────────────────────────
  private static _model_TRADITIONAL_1M(p: ModelParams): CommissionBreakdown {
    const { input, appliedModel, fallbackReason, grossCommission, landlordBase, tenantBase, platformInsuranceFee, complianceRule } = p;

    const baseAmount  = input.tenantMonthlyRent ?? grossCommission;
    const downPayment = baseAmount + platformInsuranceFee;
    const totalCost   = downPayment;

    return {
      model: input.model, appliedModel, fallbackReason, countryCode: input.countryCode, complianceRule, loadShiftedToLandlord: p.loadShiftedToLandlord,
      grossCommission, platformInsuranceFee,
      landlordSide: { amount: landlordBase, carryFee: 0, total: landlordBase, feeLabel: p.landlordFeeLabel },
      tenantSide:   { amount: tenantBase,   carryFee: 0, total: tenantBase, feeLabel: p.tenantFeeLabel },
      downPayment, totalCost,
      rentEquivalentLabel: input.tenantMonthlyRent ? '1 Month Rent + Platform Guarantee' : undefined,
      schedule: [
        { installmentNo: 1, dueDate: new Date(), fromLandlord: landlordBase, fromTenant: tenantBase, total: baseAmount, label: 'Full Commission (Traditional)' },
        { installmentNo: 2, dueDate: new Date(), fromLandlord: platformInsuranceFee, fromTenant: 0, total: platformInsuranceFee, label: 'Platform & Insurance Fee (2%)' },
      ],
    };
  }

  private static _schedule(count: number, landlordAmt: number, tenantAmt: number, startMonth: number, label: string): PaymentScheduleItem[] {
    return Array.from({ length: count }, (_, i) => {
      const d = new Date();
      d.setMonth(d.getMonth() + startMonth + i);
      return { installmentNo: startMonth + i, dueDate: d, fromLandlord: landlordAmt, fromTenant: tenantAmt, total: landlordAmt + tenantAmt, label };
    });
  }
}

// Helper type
interface ModelParams {
  input:                SalesCommissionInput;
  appliedModel:         CommissionModel;
  fallbackReason?:      string;
  grossCommission:      number;
  landlordBase:         number;
  tenantBase:           number;
  platformInsuranceFee: number;
  complianceRule:       { maxInstallments: number; tenantCanPay: boolean; landlordCanPay: boolean; };
  landlordFeeLabel:     string;
  tenantFeeLabel:       string;
  loadShiftedToLandlord: boolean;
}
