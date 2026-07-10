// server/config/global-compliance-filter.ts
// Ülke ve Eyalet bazlı regülatif uygunluk denetimi
// Her işlem bu filtreden geçmeden ödeme akışı başlamaz.

import { prismaManager } from '../src/lib/prisma';

export interface ComplianceCheckResult {
  isCompliant: boolean;
  reason?: string;
  maxInstallmentsAllowed?: number;
  maxCommissionRateBps?: number;
  requiresEscrow?: boolean;
  isYieldAllowed?: boolean;
}

export class GlobalComplianceFilter {

  /**
   * Satış komisyonu taksitlendirmesi (Installment) bu ülke/bölge için uygun mu?
   */
  static async checkSalesCommissionInstallmentEligibility(
    countryIsoCode: string,
    requestedInstallments: number,
    stateCode?: string
  ): Promise<ComplianceCheckResult> {
    const db = prismaManager.getClient();

    const countryConfig = await db.countryFintechConfig.findUnique({
      where: { isoCode: countryIsoCode },
      include: { states: true }
    });

    if (!countryConfig) {
      return { isCompliant: false, reason: `Country config not found for ${countryIsoCode}` };
    }

    if (!countryConfig.allowsSalesCommissionInstallments) {
      return {
        isCompliant: false,
        reason: 'Sales commission installments are not legally permitted in this country.'
      };
    }

    if (requestedInstallments > countryConfig.maxSalesCommissionInstallments) {
      return {
        isCompliant: false,
        reason: `Requested ${requestedInstallments} installments exceeds the legal maximum of ${countryConfig.maxSalesCommissionInstallments}.`,
        maxInstallmentsAllowed: countryConfig.maxSalesCommissionInstallments
      };
    }

    return {
      isCompliant: true,
      maxInstallmentsAllowed: countryConfig.maxSalesCommissionInstallments,
      maxCommissionRateBps: countryConfig.maxSalesCommissionRateBps
    };
  }

  /**
   * Kira depozitosundan faiz (yield) elde etmek yasal mı?
   * Bazı ABD eyaletlerinde depozito faizi kiracıya ait olmak zorunda.
   */
  static async checkDepositYieldEligibility(
    countryIsoCode: string,
    stateCode?: string
  ): Promise<ComplianceCheckResult> {
    const db = prismaManager.getClient();

    const countryConfig = await db.countryFintechConfig.findUnique({
      where: { isoCode: countryIsoCode },
      include: { states: true }
    });

    if (!countryConfig) {
      return { isCompliant: false, reason: `Country config not found for ${countryIsoCode}` };
    }

    let isYieldAllowed = countryConfig.allowsDepositYield;
    let requiresEscrow = countryConfig.requiresDepositEscrow;

    // State-level overrides
    if (stateCode) {
      const stateConfig = countryConfig.states.find(s => s.stateCode === stateCode);
      if (stateConfig) {
        if (stateConfig.overridesDepositRules && stateConfig.localDepositYieldAllowed !== null) {
          isYieldAllowed = stateConfig.localDepositYieldAllowed as boolean;
        }
      }
    }

    if (!isYieldAllowed) {
      return {
        isCompliant: false,
        requiresEscrow,
        isYieldAllowed: false,
        reason: 'Generating yield from tenant deposits is not permitted in this jurisdiction. Deposit must be held in a dedicated FBO account.'
      };
    }

    return { isCompliant: true, requiresEscrow, isYieldAllowed: true };
  }

  /**
   * Komisyon oranı bu ülkedeki yasal sınırı aşıyor mu?
   */
  static async checkCommissionRateEligibility(
    countryIsoCode: string,
    proposedRateBps: number
  ): Promise<ComplianceCheckResult> {
    const db = prismaManager.getClient();

    const countryConfig = await db.countryFintechConfig.findUnique({
      where: { isoCode: countryIsoCode }
    });

    if (!countryConfig) {
      return { isCompliant: false, reason: `Country config not found for ${countryIsoCode}` };
    }

    if (proposedRateBps > countryConfig.maxSalesCommissionRateBps) {
      return {
        isCompliant: false,
        maxCommissionRateBps: countryConfig.maxSalesCommissionRateBps,
        reason: `Commission rate of ${proposedRateBps / 100}% exceeds legal cap of ${countryConfig.maxSalesCommissionRateBps / 100}% in ${countryIsoCode}.`
      };
    }

    return {
      isCompliant: true,
      maxCommissionRateBps: countryConfig.maxSalesCommissionRateBps
    };
  }
}
