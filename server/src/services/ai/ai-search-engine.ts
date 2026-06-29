import { GoogleGenerativeAI } from "@google/generative-ai";
import { prisma } from "../../lib/prisma";
import crypto from "crypto";
import { enforceAICredits, deductAICredits, estimateAICost, checkAnonymousLimit, ensureCreditAccount } from "./ai-credit-service";
import { getUserRevenueProfile, dynamicCreditPrice, shouldUpsell, updateARPUModel } from "./ai-arpu-engine";
import { getMarketState, adjustPricing, updateMarketState, calculateMarketEquilibrium } from "./market-orchestrator";
import { smartExecute, RouteType, estimateCost as routerCost } from "./ai-router-engine";

const genAI = new GoogleGenerativeAI(process.env.GEMINI_API_KEY || "");

export class AISearchEngine {
  static async processSearch(query: string, user: any = null, clientIp: string = "unknown") {
    try {
      // 1. INTENT ANALYSIS
      const intentResponse = await genAI.getGenerativeModel({ model: "gemini-2.5-flash" }).generateContent({
        contents: [{ role: "user", parts: [{ text: `
          You are a highly intelligent assistant for "Reservatior", a premium real estate platform.
          The user asking is: ${user ? "LOGGED IN" : "ANONYMOUS"}
          
          User query: "${query}"

          RETURN ONLY a valid JSON object.
          {
            "location": "city or neighborhood name (string or null)",
            "maxPrice": (number or null),
            "beds": (number or null),
            "baths": (number or null),
            "isCompare": (boolean),
            "includePOI": (boolean),
            "isValuation": (boolean),
            "guestCount": (number or null),
            "smoking": (boolean or null),
            "bbq": (boolean or null),
            "guestDetails": (string or null)
          }`}]}]
      });

      const cleanJson = (intentResponse.response.text() || "{}").replace(/```json/g, '').replace(/```/g, '').trim();
      let filters: any = {};
      try { filters = JSON.parse(cleanJson); } catch (e) {}

      let intentCategory = "PROPERTY_SEARCH";
      let segment = "PROPERTY";

      if (filters.isCompare) intentCategory = "COMPARISON";
      if (filters.includePOI) { intentCategory = "TOURISM_POI"; segment = "TOURISM"; }
      if (filters.isValuation) intentCategory = "VALUATION";

      const queryHash = crypto.createHash("sha256").update(`${intentCategory}_${JSON.stringify(filters)}`).digest("hex");

      // 2. ROUTER ENGINE & PROFIT-AWARE EXECUTION
      return await smartExecute(intentCategory, filters, user, async (route: RouteType, isDowngraded: boolean) => {
        
        // --- ROUTE: DB_ONLY (CACHE) ---
        if (route === "DB_ONLY") {
          const cached = await prisma.aISemanticCache.findUnique({ where: { queryHash } });
          if (cached) return { ...cached.response as any, costCharged: 0, cached: true };
        }

        // Base Cost & Market adjustments
        const baseCost = routerCost(route);
        const marketState = await getMarketState(segment);
        const marketAdjustedCost = adjustPricing(marketState, baseCost);
        const equilibrium = calculateMarketEquilibrium(marketState);

        let finalCost = marketAdjustedCost;

        // Upsell Check
        if (user?.id) {
          const userProfile = await getUserRevenueProfile(user.id);
          finalCost = dynamicCreditPrice(userProfile, marketAdjustedCost);
          const upsellData = shouldUpsell(userProfile, intentCategory);

          if (upsellData.shouldUpsell && !isDowngraded) {
            return {
              text: "It looks like you're doing a detailed research in this area. Would you like to upgrade to our premium package for a 'Comprehensive Regional & Tourism Analysis Report'?",
              filters, properties: [], creditsRemaining: 0, requiresTopUp: false, isUpsellTriggered: true, marketContext: { signal: equilibrium.marketSignal }
            };
          }
        }

        // Credit Enforcement
        const isPaidRoute = route === "LIGHT_AI" || route === "FULL_AI" || route === "PREMIUM_AI";
        if (isPaidRoute) {
          if (user?.id) {
            await ensureCreditAccount(user.id);
            try { await enforceAICredits(user.id, finalCost); } 
            catch (e: any) { if (e.message === "INSUFFICIENT_CREDITS") return { text: "You don't have enough credits for this detailed analysis. Cost: " + finalCost + " credits.", properties: [], requiresTopUp: true }; throw e; }
          } else {
            if (!checkAnonymousLimit(clientIp)) return { text: "Your daily detailed analysis limit has been reached. Please sign up.", properties: [], requiresSignup: true };
          }
        }

        // Database Search
        const whereClause: any = { status: "PUBLISHED" };
        if (filters.location) whereClause.city = { contains: filters.location, mode: "insensitive" };
        if (filters.maxPrice) whereClause.listingPrice = { lte: filters.maxPrice };
        if (filters.beds) whereClause.bedrooms = { gte: filters.beds };
        
        let properties = await prisma.property.findMany({ 
          where: whereClause, take: 5, 
          select: { id: true, name: true, city: true, listingPrice: true, aiSummary: true, aiProsCons: true, aiNeighborhoodScore: true } 
        });
        
        let alternativeSearch = false;
        if (properties.length === 0) {
          alternativeSearch = true;
          const relaxedClause: any = { status: "PUBLISHED" };
          if (filters.location) relaxedClause.city = { contains: filters.location, mode: "insensitive" };
          properties = await prisma.property.findMany({ where: relaxedClause, take: 3, select: { id: true, name: true, city: true, listingPrice: true, aiSummary: true, aiProsCons: true, aiNeighborhoodScore: true } });
        }

        // --- EXECUTION PIPELINE ---
        let responseText = "";

        if (route === "TEMPLATE_RENDER" || route === "PRECOMPUTED_AI") {
          responseText = `I found ${properties.length} listings for you. ${alternativeSearch ? "Even though they don't perfectly match your criteria, I brought similar ones in the location." : ""} `;
          if (properties.length > 0) {
            responseText += "Highlights:\n";
            properties.forEach(p => { if (p.aiSummary) responseText += `- ${p.name}: ${p.aiSummary}\n`; });
          }
        } else if (route === "LIGHT_AI") {
           const chatResponse = await genAI.getGenerativeModel({ model: "gemini-2.5-flash" }).generateContent({
             contents: [{ role: "user", parts: [{ text: `Query: "${query}". User Preferences: ${JSON.stringify(filters)}. There are ${properties.length} properties in the database. Give a short and friendly response acknowledging their specific needs (like guest count, smoking, bbq, etc) if mentioned.` }] }]
           });
           responseText = chatResponse.response.text() || "Detailed analysis completed.";
        } else if (route === "FULL_AI" || route === "PREMIUM_AI") {
           const chatResponse = await genAI.getGenerativeModel({ model: "gemini-2.5-pro" }).generateContent({
             contents: [{ role: "user", parts: [{ text: `Comprehensive Analysis Request: "${query}". User Preferences: ${JSON.stringify(filters)}. Properties: ${JSON.stringify(properties)}. Compare these properties, perform an investment analysis, evaluate POIs, and factor in their specific needs (like guest count, smoking, bbq, etc).` }] }]
           });
           responseText = chatResponse.response.text() || "Comprehensive market and investment analysis completed.";
        }

        let creditsRemaining: number | undefined;

        // Deduct only if paid route
        if (isPaidRoute && user?.id) {
          const result = await deductAICredits(user.id, finalCost, "AI_SEARCH", { query, filters });
          creditsRemaining = result.remaining;
          await updateARPUModel(user.id, intentCategory, finalCost, { properties });
        }
        
        await updateMarketState(segment, "SEARCH_INCREASE");

        const finalResponse = {
          text: responseText,
          filters,
          properties: properties.map(p => ({
            id: p.id, title: p.name, location: p.city, price: p.listingPrice?.toString() + " TL",
            image: "https://images.unsplash.com/photo-1512917774080",
            summary: p.aiSummary
          })),
          creditsRemaining,
          costCharged: (user?.id && isPaidRoute) ? finalCost : 0,
          isDowngraded, // Bildirim için
          routeUsed: route,
          marketContext: {
            demand: marketState.demandIndex,
            supply: marketState.supplyIndex,
            signal: equilibrium.marketSignal,
            pricingPressure: equilibrium.pricingPressure,
          }
        };

        // Semantic Cache Güncelleme
        await prisma.aISemanticCache.upsert({
          where: { queryHash },
          create: { queryHash, response: finalResponse as any, expiresAt: new Date(Date.now() + 1000 * 60 * 60) },
          update: { response: finalResponse as any, expiresAt: new Date(Date.now() + 1000 * 60 * 60) }
        });

        return finalResponse;
      });

    } catch (error) {
      console.error("AI Search Engine Error:", error);
      throw new Error("Search operation failed");
    }
  }
}
