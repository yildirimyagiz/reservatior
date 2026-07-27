/**
 * Strategic Brain v2 - Country-Aware AI Explanation
 * 
 * Uses Gemini AI (via Agent Gateway) to explain opportunity scores
 * Country-specific context integration
 */

import { agentGateway } from '../agents/agent-interface';
import { countryContextRegistry } from '../events/country/country-context';
import { OpportunityScoreResult } from './opportunity-engine-v2';

export interface StrategicAnalysisInput {
  country_code: string;
  opportunityScore: OpportunityScoreResult;
  propertyData: any;
  marketData: any;
}

export interface StrategicAnalysisOutput {
  propertyId: string;
  finalOpportunityScore: number;
  recommendedStrategy: string;
  whyScore: string;
  regionalStrengths: string[];
  targetCustomerSegments: string[];
  recommendedSalesStrategy: string;
  riskFactors: string[];
  timingRecommendations: string;
  confidenceScore: number;
  modelUsed: string;
  providerUsed: string;
  countryContext: any;
}

export class StrategicBrain {
  private systemPrompt: string;

  constructor() {
    this.systemPrompt = `You are a strategic real estate investment advisor. Analyze the following property opportunity and provide strategic recommendations.

Focus on actionable insights that can guide investment decisions. Be specific but concise.

Always provide responses in the specified JSON format with these fields:
- recommendedStrategy: One of: NORMAL_SALE, LUXURY_RENTAL, CORPORATE_TENANT, FURNISHED_RENTAL, SHORT_TERM_RENTAL, HOLD_FOR_APPRECIATION
- whyScore: Brief explanation of why this property received this score
- regionalStrengths: Array of what makes this location strong for investment
- targetCustomerSegments: Array of target customer segments
- recommendedSalesStrategy: Specific approach for marketing and selling this property
- riskFactors: Array of potential risks
- timingRecommendations: When and how quickly to act on this opportunity`;
  }

  /**
   * Generate strategic analysis using AI
   */
  async analyze(input: StrategicAnalysisInput): Promise<StrategicAnalysisOutput> {
    const { country_code, opportunityScore, propertyData, marketData } = input;
    
    // Get country context
    const countryContext = countryContextRegistry.getContext(country_code);
    if (!countryContext) {
      throw new Error(`Country context not found for: ${country_code}`);
    }
    
    // Build country-specific prompt
    const prompt = this.buildCountrySpecificPrompt(country_code, opportunityScore, propertyData, marketData, countryContext);
    
    // Generate AI response via Agent Gateway
    const aiResponse = await agentGateway.generateText({
      prompt,
      systemPrompt: this.systemPrompt,
      temperature: 0.7,
      maxTokens: 1000
    });
    
    // Parse AI response
    const analysis = this.parseAIResponse(aiResponse.content, propertyData.id || 'unknown');
    
    return {
      ...analysis,
      finalOpportunityScore: opportunityScore.overallScore,
      modelUsed: aiResponse.model,
      providerUsed: aiResponse.provider,
      countryContext
    };
  }

  /**
   * Build country-specific prompt
   */
  private buildCountrySpecificPrompt(
    countryCode: string,
    opportunityScore: OpportunityScoreResult,
    propertyData: any,
    marketData: any,
    countryContext: any
  ): string {
    const communicationPrefs = countryContext.agent_rules.communication;
    
    return `
PROPERTY DETAILS:
- Location: ${propertyData.location}
- Type: ${propertyData.propertyType}
- Price: ${propertyData.price}
- Size: ${propertyData.size} sqm
- Rooms: ${propertyData.rooms}
- Features: ${propertyData.features || 'N/A'}

MARKET CONTEXT:
- Area: ${propertyData.neighborhood || 'N/A'}
- Country: ${countryContext.country_name}
- Average Price: ${marketData.averagePrice}
- Price Trend: ${marketData.priceTrend}
- Demand Level: ${marketData.demandLevel}
- Competition: ${marketData.competitionLevel}

OPPORTUNITY SCORE ANALYSIS:
- Overall Score: ${opportunityScore.overallScore}/100
- Opportunity Tier: ${opportunityScore.opportunityTier}
- Acquisition Urgency: ${opportunityScore.acquisitionUrgency}

COMPONENT SCORES:
- Yield Score: ${opportunityScore.yieldScore}/100 (Weight: ${(opportunityScore.weights.yield * 100).toFixed(0)}%)
- Price Gap Score: ${opportunityScore.priceGapScore}/100 (Weight: ${(opportunityScore.weights.priceGap * 100).toFixed(0)}%)
- Demand Score: ${opportunityScore.demandScore}/100 (Weight: ${(opportunityScore.weights.demand * 100).toFixed(0)}%)
- Vacancy Score: ${opportunityScore.vacancyScore}/100 (Weight: ${(opportunityScore.weights.vacancy * 100).toFixed(0)}%)
- Risk Score: ${opportunityScore.riskScore}/100 (Weight: ${(opportunityScore.weights.risk * 100).toFixed(0)}%)
- Liquidity Score: ${opportunityScore.liquidityScore}/100 (Weight: ${(opportunityScore.weights.liquidity * 100).toFixed(0)}%)

COUNTRY-SPECIFIC CONTEXT:
- Currency: ${countryContext.currency}
- Foreign Ownership: ${countryContext.legal_framework.property_ownership.foreign_ownership_allowed ? 'Allowed' : 'Restricted'}
- Rental Regulations: ${countryContext.legal_framework.rental_regulations.rent_control ? 'Rent Controlled' : 'Free Market'}
- Taxation: Property Tax ${(countryContext.legal_framework.taxation.property_tax_rate * 100).toFixed(1)}%, Capital Gains ${(countryContext.legal_framework.taxation.capital_gains_tax * 100).toFixed(0)}%
- Market Factors: ${countryContext.market_specifics.demand_factors.join(', ')}
- Risk Factors: ${countryContext.market_specifics.risk_factors.join(', ')}

COUNTRY-SPECIFIC OPPORTUNITY FACTORS:
${countryContext.agent_rules.acquisition.opportunity_factors.map((f: string) => `- ${f}`).join('\n')}

COUNTRY-SPECIFIC RISK FACTORS:
${countryContext.agent_rules.acquisition.risk_factors.map((f: string) => `- ${f}`).join('\n')}

COMMUNICATION PREFERENCES:
- Language: ${communicationPrefs.language}
- Cultural Considerations: ${communicationPrefs.cultural_considerations.join(', ')}

Please provide a strategic analysis in the JSON format specified in the system prompt, considering the country-specific context above.
`;
  }

  /**
   * Parse AI response
   */
  private parseAIResponse(content: string, propertyId: string): Omit<StrategicAnalysisOutput, 'finalOpportunityScore' | 'modelUsed' | 'providerUsed' | 'countryContext'> {
    try {
      // Extract JSON from response
      const jsonMatch = content.match(/\{[\s\S]*\}/);
      if (!jsonMatch) {
        throw new Error('No JSON found in AI response');
      }
      
      const parsed = JSON.parse(jsonMatch[0]);
      
      return {
        propertyId,
        recommendedStrategy: parsed.recommendedStrategy || 'NORMAL_SALE',
        whyScore: parsed.whyScore || 'No explanation provided',
        regionalStrengths: parsed.regionalStrengths || [],
        targetCustomerSegments: parsed.targetCustomerSegments || [],
        recommendedSalesStrategy: parsed.recommendedSalesStrategy || 'Standard approach',
        riskFactors: parsed.riskFactors || [],
        timingRecommendations: parsed.timingRecommendations || 'No specific timing recommendation',
        confidenceScore: 75 // Default confidence
      };
    } catch (error) {
      console.error('[StrategicBrain] Failed to parse AI response:', error);
      
      // Return fallback response
      return {
        propertyId,
        recommendedStrategy: 'NORMAL_SALE',
        whyScore: 'Analysis failed - using default strategy',
        regionalStrengths: [],
        targetCustomerSegments: [],
        recommendedSalesStrategy: 'Standard approach',
        riskFactors: ['Analysis failed'],
        timingRecommendations: 'No specific timing recommendation',
        confidenceScore: 50
      };
    }
  }

  /**
   * Batch analyze properties
   */
  async batchAnalyze(inputs: StrategicAnalysisInput[]): Promise<StrategicAnalysisOutput[]> {
    const results = await Promise.all(
      inputs.map(input => this.analyze(input))
    );
    return results;
  }

  /**
   * Switch AI provider
   */
  async switchProvider(providerId: string): Promise<void> {
    await agentGateway.switchProvider(providerId);
    console.log(`[StrategicBrain] Switched to AI provider: ${providerId}`);
  }

  /**
   * Get current provider status
   */
  getProviderStatus() {
    return agentGateway.getUsageStats();
  }
}

export const strategicBrain = new StrategicBrain();
