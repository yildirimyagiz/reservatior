import { prisma } from "../../lib/prisma";

/**
 * Kullanıcının gelir (Revenue) profilini getirir veya oluşturur.
 */
export async function getUserRevenueProfile(userId: string) {
  return await prisma.userRevenueProfile.upsert({
    where: { userId },
    create: {
      userId,
      arpuScore: 0,
      intentValueMap: {},
      conversionRate: 0,
      upsellProbability: 0,
    },
    update: {},
  });
}

/**
 * Belirli bir Intent'in (Niyetin) ekonomik değerini hesaplar.
 * POI (Turizm) ve Değerleme en çok kazandıran işlemlerdir.
 */
export function calculateIntentValue(intent: string, cost: number): number {
  const baseMap: Record<string, number> = {
    PROPERTY_SEARCH: 1.0,
    COMPARISON: 1.3,
    VALUATION: 1.6,
    TOURISM_POI: 2.2,
    AGENT_ASSIST: 1.8,
    GENERAL_SEARCH: 0.5,
  };

  return (baseMap[intent] ?? 1.0) * cost;
}

/**
 * UPSELL (Çapraz Satış) Karar Motoru.
 * Eğer intent'in değeri yüksekse ve kullanıcının dönüşüm oranı yüksekse, 
 * AI cevap vermek yerine doğrudan premium rapor satmayı dener.
 */
export function shouldUpsell(userProfile: any, intent: string) {
  const intentMap = userProfile.intentValueMap as Record<string, number> || {};
  const intentWeight = intentMap[intent] ?? 1;

  // Skor algoritması: ARPU ağırlığı + Intent ağırlığı + Conversion ağırlığı
  const score =
    (userProfile.arpuScore * 0.4) +
    (intentWeight * 0.4) +
    (userProfile.conversionRate * 0.2);

  return {
    shouldUpsell: score > 1.5,
    confidence: score,
  };
}

/**
 * Dinamik Fiyatlama (Dynamic Credit Pricing).
 * Kullanıcının upsell ve ARPU potansiyeli yüksekse, maliyet (kredi) dinamik olarak artar.
 */
export function dynamicCreditPrice(userProfile: any, baseCost: number): number {
  const multiplier =
    1 +
    (userProfile.upsellProbability * 0.5) +
    (userProfile.arpuScore * 0.3);

  return Math.ceil(baseCost * multiplier);
}

/**
 * AI işlemi bittikten sonra kullanıcının ARPU (Average Revenue Per User) profilini günceller.
 * Öğrenen (Self-learning) mekanizma burasıdır.
 */
export async function updateARPUModel(userId: string, intent: string, cost: number, result: any) {
  const profile = await getUserRevenueProfile(userId);
  const value = calculateIntentValue(intent, cost);

  const newARPU = (profile.arpuScore + value) / 2;
  const intentMap = profile.intentValueMap as Record<string, number> || {};

  await prisma.userRevenueProfile.update({
    where: { userId },
    data: {
      arpuScore: newARPU,
      intentValueMap: {
        ...intentMap,
        [intent]: value,
      },
      // Eğer kullanıcı sonuca tıkladıysa (converted) oran artar (Şimdilik mock)
      conversionRate: result?.properties?.length > 0 ? Math.min(1.0, profile.conversionRate + 0.01) : profile.conversionRate,
      upsellProbability: newARPU > 1.0 ? Math.min(1.0, profile.upsellProbability + 0.05) : profile.upsellProbability,
    },
  });
}
