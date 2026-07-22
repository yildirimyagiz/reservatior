import { GoogleGenerativeAI } from "@google/generative-ai";
import { prisma } from "../../lib/prisma";

const apiKey = process.env.GEMINI_API_KEY || "AIzaSy_MOCK_KEY_FOR_DEV";
const genAI = new GoogleGenerativeAI(apiKey);

export interface PricePredictionInput {
  propertyId: string;
  countryCode: string;
  currency: string;
  marketSegment?: "LUXURY" | "MID_RANGE" | "BUDGET";
  comparables?: number;
}

export interface ConfidenceScore {
  score: number;
  reasons: string[];
}

export interface PricePrediction {
  current: number;
  recommended: number;
  min: number;
  max: number;
  trend: "UP" | "DOWN" | "STABLE";
}

export interface VacancyPrediction {
  expectedDays: number;
  probability: number;
  factors: string[];
}

export interface RevenuePrediction {
  expectedAnnual: number;
  optimalAnnual: number;
  potentialGain: number;
}

export interface LiquidityPrediction {
  score: number;
  level: "HIGH" | "MEDIUM" | "LOW";
  timeToRent: number;
}

export interface MarketTrend {
  direction: "RISING" | "FALLING" | "STABLE";
  strength: number;
  forecast: string;
}

export interface PriceElasticity {
  elasticityCoefficient: number;
  optimalPrice: number;
  optimalRevenue: number;
  demandCurve: { price: number; demand: number }[];
}

export interface RevenueOptimization {
  rentalYield: number;
  occupancy: number;
  maintenance: number;
  commission: number;
  furniture: number;
  insurance: number;
  utilities: number;
  netOperatingIncome: number;
}

export interface ScenarioSimulation {
  scenarios: {
    name: string;
    price: number;
    revenue: number;
    occupancy: number;
    risk: "LOW" | "MEDIUM" | "HIGH";
  }[];
  recommended: string;
}

export interface MarketHeatIndex {
  index: number;
  classification: "HOT" | "WARM" | "BALANCED" | "SLOW" | "FROZEN";
  signals: string[];
}

export interface OpportunityScore {
  score: number;
  type: "BUY" | "SELL" | "HOLD";
  rationale: string;
}

export interface AdvisoryTimeline {
  day: number;
  action: string;
  impact: string;
  priority: "HIGH" | "MEDIUM" | "LOW";
}

export interface MultiPredictionResult {
  price: PricePrediction;
  vacancy: VacancyPrediction;
  revenue: RevenuePrediction;
  liquidity: LiquidityPrediction;
  marketTrend: MarketTrend;
}

export interface PricingIntelligenceResult {
  predictedPrice: PricePrediction;
  confidence: ConfidenceScore;
  revenueOptimization: RevenueOptimization;
  elasticity: PriceElasticity;
  scenarios: ScenarioSimulation;
  marketHeat: MarketHeatIndex;
  opportunity: OpportunityScore;
  liquidity: LiquidityPrediction;
  advisoryTimeline: AdvisoryTimeline[];
  marketTrend: MarketTrend;
  comparableProperties: number;
  generatedAt: Date;
}

export class PricingIntelligence {
  static async analyze(input: PricePredictionInput): Promise<PricingIntelligenceResult> {
    console.log(`[PricingIntelligence] Analyzing property ${input.propertyId}...`);

    const property = await prisma.property.findUnique({
      where: { id: input.propertyId },
      include: { location: true, amenities: { include: { amenity: true } } },
    });

    if (!property) throw new Error("Property not found");

    const model = genAI.getGenerativeModel({ model: "gemini-2.5-flash" });

    const propertyDetails = `
      Name: ${property.name}
      Type: ${property.type}
      City: ${property.city}
      State: ${property.state}
      Region: ${property.region}
      Currency: ${property.currency}
      Market Segment: ${input.marketSegment || "MID_RANGE"}
      Amenities: ${property.amenities.map((a) => a.amenity.name).join(", ")}
    `;

    const prompt = `
      You are a Senior Real Estate Pricing Intelligence Analyst.
      Analyze the following property and market data to produce a comprehensive pricing intelligence report.

      Property Details:
      ${propertyDetails}
      Country: ${input.countryCode}
      Base Currency: ${input.currency}

      Respond ONLY with a valid JSON object matching this structure:
      {
        "pricePrediction": {
          "current": number,
          "recommended": number,
          "min": number,
          "max": number,
          "trend": "UP" | "DOWN" | "STABLE"
        },
        "confidence": {
          "score": number (0.0 to 1.0),
          "reasons": string[]
        },
        "revenueOptimization": {
          "rentalYield": number,
          "occupancy": number,
          "maintenance": number,
          "commission": number,
          "furniture": number,
          "insurance": number,
          "utilities": number,
          "netOperatingIncome": number
        },
        "elasticity": {
          "elasticityCoefficient": number,
          "optimalPrice": number,
          "optimalRevenue": number,
          "demandCurve": [{ "price": number, "demand": number }]
        },
        "scenarios": {
          "scenarios": [{ "name": string, "price": number, "revenue": number, "occupancy": number, "risk": "LOW" | "MEDIUM" | "HIGH" }],
          "recommended": string
        },
        "marketHeat": {
          "index": number (0-100),
          "classification": "HOT" | "WARM" | "BALANCED" | "SLOW" | "FROZEN",
          "signals": string[]
        },
        "opportunity": {
          "score": number (0-100),
          "type": "BUY" | "SELL" | "HOLD",
          "rationale": string
        },
        "liquidity": {
          "score": number (0-100),
          "level": "HIGH" | "MEDIUM" | "LOW",
          "timeToRent": number
        },
        "marketTrend": {
          "direction": "RISING" | "FALLING" | "STABLE",
          "strength": number (0-1),
          "forecast": string
        },
        "advisoryTimeline": [
          { "day": number, "action": string, "impact": string, "priority": "HIGH" | "MEDIUM" | "LOW" }
        ]
      }

      Ensure all numeric values are realistic for the given market.
      The confidence score must reflect data quality and market predictability.
      The advisory timeline should contain 3-5 actionable recommendations.
    `;

    let result: PricingIntelligenceResult;

    try {
      const response = await model.generateContent(prompt);
      const text = response.response.text();
      const jsonMatch = text.match(/\{[\s\S]*\}/);
      if (!jsonMatch) throw new Error("No JSON found in response");
      const parsed = JSON.parse(jsonMatch[0]);

      result = {
        predictedPrice: parsed.pricePrediction,
        confidence: parsed.confidence,
        revenueOptimization: parsed.revenueOptimization,
        elasticity: parsed.elasticity,
        scenarios: parsed.scenarios,
        marketHeat: parsed.marketHeat,
        opportunity: parsed.opportunity,
        liquidity: parsed.liquidity,
        advisoryTimeline: parsed.advisoryTimeline || [],
        marketTrend: parsed.marketTrend,
        comparableProperties: input.comparables || 0,
        generatedAt: new Date(),
      };
    } catch (err) {
      console.warn(`[PricingIntelligence] AI analysis failed, using fallback: ${err}`);
      result = this.fallbackAnalysis(property);
    }

    await this.storeResults(input.propertyId, result);
    return result;
  }

  static async multiPredict(input: PricePredictionInput): Promise<MultiPredictionResult> {
    const analysis = await this.analyze(input);
    return {
      price: analysis.predictedPrice,
      vacancy: {
        expectedDays: analysis.liquidity.timeToRent,
        probability: 1 - analysis.liquidity.score / 100,
        factors: analysis.marketHeat.signals,
      },
      revenue: {
        expectedAnnual: analysis.revenueOptimization.netOperatingIncome,
        optimalAnnual: analysis.revenueOptimization.rentalYield * analysis.revenueOptimization.optimalPrice,
        potentialGain:
          analysis.revenueOptimization.rentalYield *
            (analysis.elasticity.optimalPrice - analysis.predictedPrice.recommended) || 0,
      },
      liquidity: analysis.liquidity,
      marketTrend: analysis.marketTrend,
    };
  }

  static async learnFromOutcome(propertyId: string, actualPrice: number, previousPrediction: PricePrediction): Promise<void> {
    console.log(`[PricingIntelligence] Learning from outcome for property ${propertyId}...`);

    const predictionError = Math.abs(actualPrice - previousPrediction.recommended) / previousPrediction.recommended;

    await prisma.aIPriceOptimization.updateMany({
      where: { propertyId },
      data: {
        actualOutcomePrice: actualPrice,
        predictionError,
        learnedAt: new Date(),
      },
    });

    console.log(`[PricingIntelligence] Prediction error: ${(predictionError * 100).toFixed(2)}%. Model updated.`);
  }

  private static fallbackAnalysis(property: any): PricingIntelligenceResult {
    const basePrice = property.price || 100000;
    const baseYield = property.type === "COMMERCIAL" ? 0.06 : 0.04;

    return {
      predictedPrice: {
        current: basePrice,
        recommended: basePrice * 0.95,
        min: basePrice * 0.85,
        max: basePrice * 1.15,
        trend: "STABLE",
      },
      confidence: {
        score: 0.5,
        reasons: ["Insufficient market data for AI analysis", "Using fallback estimation model"],
      },
      revenueOptimization: {
        rentalYield: baseYield,
        occupancy: 70,
        maintenance: basePrice * 0.01,
        commission: basePrice * 0.04,
        furniture: basePrice * 0.02,
        insurance: basePrice * 0.005,
        utilities: basePrice * 0.008,
        netOperatingIncome: basePrice * baseYield * 0.7,
      },
      elasticity: {
        elasticityCoefficient: -0.8,
        optimalPrice: basePrice * 0.95,
        optimalRevenue: basePrice * baseYield * 0.75,
        demandCurve: [
          { price: basePrice * 0.8, demand: 120 },
          { price: basePrice * 0.9, demand: 100 },
          { price: basePrice, demand: 80 },
          { price: basePrice * 1.1, demand: 60 },
          { price: basePrice * 1.2, demand: 40 },
        ],
      },
      scenarios: {
        scenarios: [
          { name: "Conservative", price: basePrice * 0.9, revenue: basePrice * baseYield * 0.8, occupancy: 80, risk: "LOW" },
          { name: "Moderate", price: basePrice, revenue: basePrice * baseYield * 0.7, occupancy: 70, risk: "MEDIUM" },
          { name: "Aggressive", price: basePrice * 1.1, revenue: basePrice * baseYield * 0.6, occupancy: 55, risk: "HIGH" },
        ],
        recommended: "Moderate",
      },
      marketHeat: {
        index: 50,
        classification: "BALANCED",
        signals: ["Fallback mode - no real market data available"],
      },
      opportunity: {
        score: 50,
        type: "HOLD",
        rationale: "Insufficient data for a definitive recommendation",
      },
      liquidity: {
        score: 50,
        level: "MEDIUM",
        timeToRent: 45,
      },
      advisoryTimeline: [
        { day: 1, action: "Run AI valuation with complete property data", impact: "Accurate pricing baseline", priority: "HIGH" },
        { day: 7, action: "Review comparable listings", impact: "Market positioning", priority: "MEDIUM" },
        { day: 14, action: "Adjust price based on showing feedback", impact: "Optimized time-to-rent", priority: "MEDIUM" },
        { day: 30, action: "Evaluate if price reduction needed", impact: "Prevent stale listing", priority: "LOW" },
      ],
      marketTrend: {
        direction: "STABLE",
        strength: 0.3,
        forecast: "Limited data available for trend analysis",
      },
      comparableProperties: 0,
      generatedAt: new Date(),
    };
  }

  private static async storeResults(propertyId: string, result: PricingIntelligenceResult): Promise<void> {
    try {
      const listing = await prisma.listing.findFirst({
        where: { propertyId },
        select: { id: true, price: true },
      });
      if (!listing) {
        console.warn(`[PricingIntelligence] No listing found for property ${propertyId}, skipping store`);
        return;
      }
      await prisma.aIPriceOptimization.upsert({
        where: { listingId: listing.id },
        update: {
          propertyId,
          currentPrice: listing.price ?? result.predictedPrice.current,
          recommendedPrice: result.predictedPrice.recommended,
          confidence: result.confidence.score,
          priceRange: { min: result.predictedPrice.min, max: result.predictedPrice.max, trend: result.predictedPrice.trend },
          factors: result.confidence.reasons,
          comparableData: { count: result.comparableProperties },
          marketTrends: result.marketTrend,
          marketData: result as any,
          generatedAt: result.generatedAt,
          lastAnalyzedAt: new Date(),
        },
        create: {
          listingId: listing.id,
          propertyId,
          currentPrice: listing.price ?? result.predictedPrice.current,
          recommendedPrice: result.predictedPrice.recommended,
          confidence: result.confidence.score,
          priceRange: { min: result.predictedPrice.min, max: result.predictedPrice.max, trend: result.predictedPrice.trend },
          factors: result.confidence.reasons,
          comparableData: { count: result.comparableProperties },
          marketTrends: result.marketTrend,
          marketData: result as any,
          generatedAt: result.generatedAt,
          lastAnalyzedAt: new Date(),
        },
      });
    } catch (err) {
      console.warn(`[PricingIntelligence] Failed to store results: ${err}`);
    }
  }
}
