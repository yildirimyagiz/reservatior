import { prisma } from "../../lib/prisma";
import crypto from "crypto";
import { getUserRevenueProfile } from "./ai-arpu-engine";

export type RouteType = "DB_ONLY" | "TEMPLATE_RENDER" | "LIGHT_AI" | "FULL_AI" | "PRECOMPUTED_AI" | "PREMIUM_AI";

/**
 * Maliyet Optimizasyon Katmanı (Cost Estimation)
 */
export function estimateCost(route: RouteType): number {
  const costMap: Record<RouteType, number> = {
    DB_ONLY: 0,
    TEMPLATE_RENDER: 0.0001,
    PRECOMPUTED_AI: 0.0005,
    LIGHT_AI: 0.01,
    FULL_AI: 0.05,
    PREMIUM_AI: 0.15,
  };
  return costMap[route];
}

/**
 * Niyetin (Intent) karmaşıklığını ölçer
 */
function analyzeComplexity(intent: string, filters: any) {
  if (intent === "PROPERTY_SEARCH" || intent === "GENERAL_SEARCH") return { low: true, medium: false, high: false };
  if (intent === "COMPARISON") return { low: false, medium: true, high: true };
  if (intent === "VALUATION" || intent === "TOURISM_POI") return { low: false, medium: false, high: true };
  return { low: false, medium: true, high: false }; // Default
}

/**
 * 1. Karar Ağacı: Hangi rota seçilmeli?
 */
export async function routeRequest(intent: string, filters: any): Promise<RouteType> {
  const queryHash = crypto.createHash("sha256").update(`${intent}_${JSON.stringify(filters)}`).digest("hex");
  
  // 1a. Semantic Cache Kontrolü
  const cached = await prisma.aISemanticCache.findUnique({ where: { queryHash } });
  if (cached && cached.expiresAt > new Date()) {
    await prisma.aISemanticCache.update({ where: { queryHash }, data: { hitCount: { increment: 1 } } });
    return "DB_ONLY";
  }

  const complexity = analyzeComplexity(intent, filters);

  if (complexity.low) return "TEMPLATE_RENDER";
  if (complexity.medium && intent !== "COMPARISON") return "LIGHT_AI";
  if (complexity.high && intent === "COMPARISON") return "FULL_AI";
  if (intent === "TOURISM_POI" || intent === "VALUATION") return "PREMIUM_AI";

  return "LIGHT_AI";
}

/**
 * Kullanıcının kârlılık potansiyelini tahmin eder.
 */
function predictUserValue(userProfile: any): number {
  if (!userProfile) return 0;
  return userProfile.arpuScore * (1 + userProfile.conversionRate);
}

/**
 * 2. Karar Motoru (Profit-Aware)
 * Kullanıcının değeri, tahmini maliyetin x2'sinden büyük değilse işlemi (Downgrade) düşür.
 */
export async function smartExecute(
  intent: string, 
  filters: any, 
  user: any, 
  executeCallback: (route: RouteType, isDowngraded: boolean) => Promise<any>
) {
  let route = await routeRequest(intent, filters);
  
  if (route === "DB_ONLY") {
    // Cache'ten dönülecek
    return await executeCallback(route, false);
  }

  let isDowngraded = false;
  const cost = estimateCost(route);

  // Profitability Analysis
  if (user?.id) {
    const userProfile = await getUserRevenueProfile(user.id);
    const value = predictUserValue(userProfile);
    
    const isProfitable = value > (cost * 2);

    // Eğer kârlı değilse ve pahalı bir AI seçildiyse, route'u düşür.
    if (!isProfitable && (route === "FULL_AI" || route === "PREMIUM_AI")) {
      console.log(`[Router] Downgrading request for User ${user.id} due to profitability metrics.`);
      route = "LIGHT_AI";
      isDowngraded = true;
    }
  } else {
    // Anonim kullanıcılar her zaman en ucuz yolu kullanır
    if (route !== "TEMPLATE_RENDER") {
      route = "TEMPLATE_RENDER";
      isDowngraded = true;
    }
  }

  // Execution pipeline'ı çağır
  const result = await executeCallback(route, isDowngraded);
  
  // Learning Loop
  await logOutcome(intent, route, { converted: result.properties?.length > 0, revenueGenerated: result.costCharged || 0 });

  return result;
}

/**
 * 3. System Feedback Loop (Learning Layer)
 */
export async function logOutcome(intent: string, route: RouteType, outcome: any) {
  try {
    await prisma.aICostAnalytics.create({
      data: {
        route,
        cost: estimateCost(route),
        conversion: outcome.converted,
        revenue: outcome.revenueGenerated,
        intent,
      },
    });
  } catch (e) {
    console.error("Log Outcome error:", e);
  }
}
