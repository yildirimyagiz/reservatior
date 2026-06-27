// server/config/ai-yield-optimization.ts
// AI Dynamic Yield Optimization Rules for Global Markets
// This configuration calculates the "Vacancy Cost" (Boş Kalma Maliyeti) and recommends discounts.

export enum RegionCode {
  USA = 'USA',
  CA = 'CA',
  MX = 'MX',
  UK = 'UK',
  DE = 'DE',
  FR = 'FR',
  ES = 'ES',
  IT = 'IT',
  NL = 'NL',
  TR = 'TR',
  BR = 'BR',
  AR = 'AR',
  AU = 'AU',
  NZ = 'NZ',
  JP = 'JP',
  KR = 'KR',
  CN = 'CN',
  IN = 'IN',
  SG = 'SG',
  MY = 'MY',
  TH = 'TH',
  AE = 'AE',
  SA = 'SA',
  EU = 'EU',
  GLOBAL = 'GLOBAL',
}

export interface YieldRule {
  maxPremiumOverMarket: number; // Kiralama rayicinin % kaç üstüne çıkarsa risk başlar?
  estimatedVacancyDays: number; // Bu fiyatlamada tahmini boş kalma süresi (Gün)
  recommendedDiscount: number; // Önerilen kira indirimi (%)
  loyaltyIncentiveRate: number; // Sadık kiracıya zam yapılmazsa platform komisyon indirimi (%)
}

export const GlobalYieldRules: Record<RegionCode, YieldRule> = {
  // --- NORTH AMERICA ---
  [RegionCode.USA]: { maxPremiumOverMarket: 0.10, estimatedVacancyDays: 30, recommendedDiscount: 0.05, loyaltyIncentiveRate: 0.50 },
  [RegionCode.CA]: { maxPremiumOverMarket: 0.08, estimatedVacancyDays: 25, recommendedDiscount: 0.04, loyaltyIncentiveRate: 0.60 },
  [RegionCode.MX]: { maxPremiumOverMarket: 0.12, estimatedVacancyDays: 40, recommendedDiscount: 0.08, loyaltyIncentiveRate: 0.40 },
  
  // --- EUROPE (Yüksek Regülasyon ve Koruma) ---
  [RegionCode.UK]: { maxPremiumOverMarket: 0.08, estimatedVacancyDays: 20, recommendedDiscount: 0.04, loyaltyIncentiveRate: 0.40 },
  [RegionCode.DE]: { maxPremiumOverMarket: 0.05, estimatedVacancyDays: 14, recommendedDiscount: 0.03, loyaltyIncentiveRate: 0.85 }, // Mietpreisbremse (Kira Freni)
  [RegionCode.FR]: { maxPremiumOverMarket: 0.06, estimatedVacancyDays: 20, recommendedDiscount: 0.04, loyaltyIncentiveRate: 0.80 },
  [RegionCode.ES]: { maxPremiumOverMarket: 0.10, estimatedVacancyDays: 30, recommendedDiscount: 0.06, loyaltyIncentiveRate: 0.60 },
  [RegionCode.IT]: { maxPremiumOverMarket: 0.08, estimatedVacancyDays: 35, recommendedDiscount: 0.05, loyaltyIncentiveRate: 0.70 },
  [RegionCode.NL]: { maxPremiumOverMarket: 0.05, estimatedVacancyDays: 7, recommendedDiscount: 0.03, loyaltyIncentiveRate: 0.80 },  // Middenhuur (Sıkı Kontrol)
  [RegionCode.TR]: { maxPremiumOverMarket: 0.15, estimatedVacancyDays: 60, recommendedDiscount: 0.10, loyaltyIncentiveRate: 0.75 }, // Enflasyonist Pazar
  
  // --- SOUTH AMERICA (Yüksek Enflasyon Dinamikleri) ---
  [RegionCode.BR]: { maxPremiumOverMarket: 0.12, estimatedVacancyDays: 45, recommendedDiscount: 0.08, loyaltyIncentiveRate: 0.50 },
  [RegionCode.AR]: { maxPremiumOverMarket: 0.20, estimatedVacancyDays: 60, recommendedDiscount: 0.15, loyaltyIncentiveRate: 0.90 }, // Hiper Enflasyon
  
  // --- APAC (Asya Pasifik) ---
  [RegionCode.AU]: { maxPremiumOverMarket: 0.08, estimatedVacancyDays: 14, recommendedDiscount: 0.04, loyaltyIncentiveRate: 0.50 },
  [RegionCode.NZ]: { maxPremiumOverMarket: 0.08, estimatedVacancyDays: 14, recommendedDiscount: 0.04, loyaltyIncentiveRate: 0.50 },
  [RegionCode.JP]: { maxPremiumOverMarket: 0.05, estimatedVacancyDays: 30, recommendedDiscount: 0.02, loyaltyIncentiveRate: 0.80 }, // Stabil ve Düşük Enflasyon
  [RegionCode.KR]: { maxPremiumOverMarket: 0.06, estimatedVacancyDays: 25, recommendedDiscount: 0.03, loyaltyIncentiveRate: 0.70 },
  [RegionCode.CN]: { maxPremiumOverMarket: 0.08, estimatedVacancyDays: 45, recommendedDiscount: 0.06, loyaltyIncentiveRate: 0.40 },
  [RegionCode.IN]: { maxPremiumOverMarket: 0.10, estimatedVacancyDays: 30, recommendedDiscount: 0.07, loyaltyIncentiveRate: 0.50 },
  [RegionCode.SG]: { maxPremiumOverMarket: 0.15, estimatedVacancyDays: 14, recommendedDiscount: 0.05, loyaltyIncentiveRate: 0.30 }, // Yüksek Expat Sirkülasyonu
  [RegionCode.MY]: { maxPremiumOverMarket: 0.10, estimatedVacancyDays: 40, recommendedDiscount: 0.06, loyaltyIncentiveRate: 0.50 },
  [RegionCode.TH]: { maxPremiumOverMarket: 0.12, estimatedVacancyDays: 45, recommendedDiscount: 0.08, loyaltyIncentiveRate: 0.40 },
  
  // --- MIDDLE EAST (Körfez Ülkeleri) ---
  [RegionCode.AE]: { maxPremiumOverMarket: 0.15, estimatedVacancyDays: 20, recommendedDiscount: 0.06, loyaltyIncentiveRate: 0.30 }, // Hızlı Sirkülasyon, Düşük Sadakat
  [RegionCode.SA]: { maxPremiumOverMarket: 0.12, estimatedVacancyDays: 30, recommendedDiscount: 0.05, loyaltyIncentiveRate: 0.40 },
  
  // --- GENERAL/FALLBACK ---
  [RegionCode.EU]: { maxPremiumOverMarket: 0.08, estimatedVacancyDays: 30, recommendedDiscount: 0.05, loyaltyIncentiveRate: 0.60 },
  [RegionCode.GLOBAL]: { maxPremiumOverMarket: 0.10, estimatedVacancyDays: 30, recommendedDiscount: 0.05, loyaltyIncentiveRate: 0.50 },
};

/**
 * Calculates the financial loss of a vacancy vs offering a discount.
 * @param monthlyRent Requested monthly rent
 * @param region Region code
 * @returns Calculation result object
 */
export function calculateVacancyCost(monthlyRent: number, region: RegionCode = RegionCode.GLOBAL) {
  const rule = GlobalYieldRules[region] || GlobalYieldRules.GLOBAL;
  
  // 1. Boş kalma maliyeti (Vacancy Loss)
  const dailyRent = monthlyRent / 30;
  const vacancyLoss = dailyRent * rule.estimatedVacancyDays;
  
  // 2. İndirimli Senaryo (Discounted Rent)
  const discountedRent = monthlyRent * (1 - rule.recommendedDiscount);
  const annualLossDueToDiscount = (monthlyRent - discountedRent) * 12;
  
  // 3. Karar (Decision)
  const isDiscountBetter = vacancyLoss > annualLossDueToDiscount;
  const netAdvantage = Math.abs(vacancyLoss - annualLossDueToDiscount);

  return {
    vacancyLoss,
    discountedRent,
    annualLossDueToDiscount,
    isDiscountBetter,
    netAdvantage,
    recommendedDiscountPercent: rule.recommendedDiscount * 100,
    estimatedVacancyDays: rule.estimatedVacancyDays,
    message: isDiscountBetter 
      ? `Warning: Keeping the price at ${monthlyRent} could cost you ${vacancyLoss} in vacancy. Lowering rent to ${discountedRent} yields ${netAdvantage} more annually.`
      : `Your current pricing is optimal.`
  };
}
