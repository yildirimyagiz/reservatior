import { prisma } from "../../lib/prisma";

export type MarketStateData = {
  segment: "PROPERTY" | "TOURISM" | "AGENT_SERVICE";
  demandIndex: number;
  supplyIndex: number;
  priceElasticity: number;
  liquidityScore: number;
  congestionLevel: number;
  underSupplyLevel: number;
};

/**
 * İlgili segmentin (Örn: PROPERTY) güncel piyasa durumunu getirir.
 */
export async function getMarketState(segment: string) {
  let state = await prisma.marketState.findUnique({
    where: { segment }
  });

  if (!state) {
    // Eğer yoksa (Seeder çalışmadıysa) varsayılan yarat (Self-healing)
    state = await prisma.marketState.create({
      data: {
        segment,
        demandIndex: 0.5,
        supplyIndex: 0.5,
        priceElasticity: 1.0,
        liquidityScore: 1.0,
      }
    });
  }
  return state;
}

/**
 * Arz - Talep Dengesi (Equilibrium) hesaplar.
 */
export function calculateMarketEquilibrium(state: any) {
  const imbalance = state.demandIndex - state.supplyIndex;

  // Denge bozukluğunun şiddeti (elastisite ile çarpılarak baskı hesaplanır)
  const pressure = Math.abs(imbalance) * state.priceElasticity;

  const direction = imbalance > 0 ? "UNDER_SUPPLY" : "OVER_SUPPLY";

  return {
    equilibriumGap: imbalance,
    pricingPressure: pressure,
    marketSignal: direction,
  };
}

/**
 * Dinamik Fiyatlama Düzenleyicisi (Market-aware Adjuster)
 * Piyasa sinyaline göre (Kıtlık veya Bolluk) baz krediyi değiştirir.
 */
export function adjustPricing(state: any, baseCost: number): number {
  const { pricingPressure, marketSignal } = calculateMarketEquilibrium(state);

  let multiplier = 1;

  if (marketSignal === "UNDER_SUPPLY") {
    multiplier += pricingPressure * 0.6; // Scarcity premium (Kıtlık Zammı)
  }

  if (marketSignal === "OVER_SUPPLY") {
    multiplier -= pricingPressure * 0.4; // Discount pressure (Bolluk İndirimi)
  }

  // Asla 1'in altına düşmesin
  return Math.max(1, Math.ceil(baseCost * multiplier));
}

/**
 * Self-learning market feedback loop.
 * Sistem her sorguda veya ilan eklendiğinde bu tabloyu günceller.
 */
export async function updateMarketState(segment: string, type: "SEARCH_INCREASE" | "NEW_LISTING") {
  const state = await getMarketState(segment);

  const demandDelta = type === "SEARCH_INCREASE" ? 0.01 : -0.005;
  const supplyDelta = type === "NEW_LISTING" ? 0.01 : 0;

  // 0 ile 1 arasına sınırla (Clamp)
  const clamp = (num: number, min: number, max: number) => Math.min(Math.max(num, min), max);

  const newDemand = clamp(state.demandIndex + demandDelta, 0, 1);
  const newSupply = clamp(state.supplyIndex + supplyDelta, 0, 1);
  
  // Basit likidite skoru = 1 - gap (Ne kadar yakınlarsa o kadar likit)
  const newLiquidity = 1 - Math.abs(newDemand - newSupply);

  return await prisma.marketState.update({
    where: { segment },
    data: {
      demandIndex: newDemand,
      supplyIndex: newSupply,
      liquidityScore: newLiquidity,
      lastUpdated: new Date(),
    },
  });
}
