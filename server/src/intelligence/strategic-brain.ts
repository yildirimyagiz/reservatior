/**
 * Strategic Brain - Gemini AI Explanation Layer
 * 
 * Takes mathematical scores from Opportunity Engine and provides AI explanations
 * Uses Gemini to explain:
 * - Why the score is high/low
 * - Regional strengths
 * - Target customer segments
 * - Recommended sales strategies
 */

import { GoogleGenerativeAI } from '@google/generative-ai';
import { OpportunityScoreResult } from './opportunity-engine';

export interface StrategicAnalysisInput {
  propertyId: string;
  opportunityScore: OpportunityScoreResult;
  propertyData: {
    location: string;
    propertyType: string;
    price: number;
    size: number;
    rooms: number;
    features: string[];
  };
  marketData: {
    areaName: string;
    averagePrice: number;
    priceTrend: string;
    demandLevel: string;
    competitionLevel: string;
  };
}

export interface StrategicAnalysisOutput {
  propertyId: string;
  finalOpportunityScore: number;
  recommendedStrategy: string;
  explanation: {
    whyScore: string;
    regionalStrengths: string;
    targetCustomerSegments: string[];
    recommendedSalesStrategy: string;
    riskFactors: string[];
    timingRecommendations: string;
  };
  confidenceScore: number;
  modelUsed: string;
  processingTimeMs: number;
  timestamp: Date;
}

export class StrategicBrain {
  private genAI: GoogleGenerativeAI;
  private model: any;
  private modelName: string;

  constructor() {
    const apiKey = process.env.GEMINI_API_KEY;
    if (!apiKey) {
      throw new Error('GEMINI_API_KEY environment variable is required');
    }
    
    this.genAI = new GoogleGenerativeAI(apiKey);
    this.modelName = process.env.GEMINI_MODEL || 'gemini-2.5-flash';
    this.model = this.genAI.getGenerativeModel({ model: this.modelName });
  }

  /**
   * Analyze opportunity and provide strategic explanation
   */
  async analyze(input: StrategicAnalysisInput): Promise<StrategicAnalysisOutput> {
    const startTime = Date.now();

    // Construct prompt for Gemini
    const prompt = this.constructPrompt(input);

    try {
      const result = await this.model.generateContent(prompt);
      const response = await result.response;
      const text = response.text();

      // Parse the structured response
      const analysis = this.parseGeminiResponse(text, input.propertyId);

      const processingTimeMs = Date.now() - startTime;

      return {
        ...analysis,
        propertyId: input.propertyId,
        finalOpportunityScore: input.opportunityScore.overallScore,
        confidenceScore: this.calculateConfidence(input.opportunityScore),
        modelUsed: this.modelName,
        processingTimeMs,
        timestamp: new Date()
      };
    } catch (error) {
      console.error('[StrategicBrain] Error analyzing opportunity:', error);
      throw new Error(`Strategic analysis failed: ${error}`);
    }
  }

  /**
   * Construct detailed prompt for Gemini
   */
  private constructPrompt(input: StrategicAnalysisInput): string {
    const { opportunityScore, propertyData, marketData } = input;

    return `
You are a strategic real estate investment advisor. Analyze the following property opportunity and provide strategic recommendations.

PROPERTY DETAILS:
- Location: ${propertyData.location}
- Type: ${propertyData.propertyType}
- Price: ${propertyData.price}
- Size: ${propertyData.size} sqm
- Rooms: ${propertyData.rooms}
- Features: ${propertyData.features.join(', ')}

MARKET CONTEXT:
- Area: ${marketData.areaName}
- Average Price: ${marketData.averagePrice}
- Price Trend: ${marketData.priceTrend}
- Demand Level: ${marketData.demandLevel}
- Competition: ${marketData.competitionLevel}

OPPORTUNITY SCORE ANALYSIS:
- Overall Score: ${opportunityScore.overallScore}/100
- Opportunity Tier: ${opportunityScore.opportunityTier}
- Acquisition Urgency: ${opportunityScore.acquisitionUrgency}

COMPONENT SCORES:
- Yield Score: ${opportunityScore.yieldScore}/100 (Weight: ${opportunityScore.yieldContribution}%)
- Price Gap Score: ${opportunityScore.priceGapScore}/100 (Weight: ${opportunityScore.priceGapContribution}%)
- Demand Score: ${opportunityScore.demandScore}/100 (Weight: ${opportunityScore.demandContribution}%)
- Vacancy Score: ${opportunityScore.vacancyScore}/100 (Weight: ${opportunityScore.vacancyContribution}%)
- Risk Score: ${opportunityScore.riskScore}/100 (Weight: ${opportunityScore.riskContribution}%)
- Liquidity Score: ${opportunityScore.liquidityScore}/100 (Weight: ${opportunityScore.liquidityContribution}%)

Please provide a strategic analysis in the following JSON format:

{
  "recommendedStrategy": "One of: NORMAL_SALE, LUXURY_RENTAL, CORPORATE_TENANT, FURNISHED_RENTAL, SHORT_TERM_RENTAL, HOLD_FOR_APPRECIATION",
  "whyScore": "Brief explanation of why this property received this score",
  "regionalStrengths": "What makes this location strong for investment",
  "targetCustomerSegments": ["segment1", "segment2", "segment3"],
  "recommendedSalesStrategy": "Specific approach for marketing and selling this property",
  "riskFactors": ["risk1", "risk2", "risk3"],
  "timingRecommendations": "When and how quickly to act on this opportunity"
}

Focus on actionable insights that can guide investment decisions. Be specific but concise.
`;
  }

  /**
   * Parse Gemini's JSON response
   */
  private parseGeminiResponse(text: string, propertyId: string): Omit<StrategicAnalysisOutput, 'confidenceScore' | 'modelUsed' | 'processingTimeMs' | 'timestamp'> {
    try {
      // Extract JSON from response (in case there's extra text)
      const jsonMatch = text.match(/\{[\s\S]*\}/);
      if (!jsonMatch) {
        throw new Error('No JSON found in Gemini response');
      }

      const parsed = JSON.parse(jsonMatch[0]);

      return {
        propertyId,
        finalOpportunityScore: 0, // Will be set from input
        recommendedStrategy: parsed.recommendedStrategy || 'NORMAL_SALE',
        explanation: {
          whyScore: parsed.whyScore || 'No explanation provided',
          regionalStrengths: parsed.regionalStrengths || 'No regional analysis provided',
          targetCustomerSegments: parsed.targetCustomerSegments || [],
          recommendedSalesStrategy: parsed.recommendedSalesStrategy || 'No strategy provided',
          riskFactors: parsed.riskFactors || [],
          timingRecommendations: parsed.timingRecommendations || 'No timing advice provided'
        }
      };
    } catch (error) {
      console.error('[StrategicBrain] Error parsing Gemini response:', error);
      
      // Return fallback response
      return {
        propertyId,
        finalOpportunityScore: 0,
        recommendedStrategy: 'NORMAL_SALE',
        explanation: {
          whyScore: 'Unable to generate AI explanation',
          regionalStrengths: 'Analysis unavailable',
          targetCustomerSegments: [],
          recommendedSalesStrategy: 'Standard approach recommended',
          riskFactors: ['Analysis unavailable'],
          timingRecommendations: 'Proceed with caution'
        }
      };
    }
  }

  /**
   * Calculate confidence score based on opportunity score consistency
   */
  private calculateConfidence(score: OpportunityScoreResult): number {
    // Higher confidence when component scores are consistent
    const scores = [
      score.yieldScore,
      score.priceGapScore,
      score.demandScore,
      score.vacancyScore,
      score.riskScore,
      score.liquidityScore
    ];

    const mean = scores.reduce((sum, s) => sum + s, 0) / scores.length;
    const variance = scores.reduce((sum, s) => sum + Math.pow(s - mean, 2), 0) / scores.length;
    const standardDeviation = Math.sqrt(variance);

    // Lower standard deviation = higher confidence
    const confidence = Math.max(0, Math.min(100, 100 - (standardDeviation * 2)));
    
    return Math.round(confidence);
  }

  /**
   * Batch analyze multiple properties
   */
  async batchAnalyze(inputs: StrategicAnalysisInput[]): Promise<StrategicAnalysisOutput[]> {
    const analyses = await Promise.all(
      inputs.map(input => this.analyze(input))
    );
    
    return analyses;
  }

  /**
   * Get current model information
   */
  getModelInfo() {
    return {
      modelName: this.modelName,
      provider: 'Google Generative AI',
      version: '2.5-flash'
    };
  }

  /**
   * Switch to different Gemini model
   */
  switchModel(modelName: string) {
    this.modelName = modelName;
    this.model = this.genAI.getGenerativeModel({ model: modelName });
    console.log(`[StrategicBrain] Switched to model: ${modelName}`);
  }
}

export const strategicBrain = new StrategicBrain();
