/**
 * Autonomous Revenue Intelligence Loop
 * Tracks conversion from SEO pages to revenue and uses this data to improve SEO scoring
 */

export interface ConversionMetrics {
  pageId: string;
  visitors: number;
  leads: number;
  viewings: number;
  offers: number;
  transactions: number;
  commission: number;
  conversionRate: number;
  leadToViewingRate: number;
  viewingToOfferRate: number;
  offerToTransactionRate: number;
  revenuePerVisitor: number;
  period: string;
}

export interface RevenueFeedback {
  pageId: string;
  conversionProbability: number;
  previousConversionProbability: number;
  improvement: number;
  recommendation: string;
  action: 'GENERATE_SIMILAR' | 'UPDATE_CONTENT' | 'PAUSE_GENERATION' | 'NO_ACTION';
  similarRegions: string[];
}

export class RevenueIntelligenceLoop {
  private conversionHistory: Map<string, ConversionMetrics[]>;
  private learningEnabled: boolean;

  constructor() {
    this.conversionHistory = new Map();
    this.learningEnabled = true;
  }

  /**
   * Track conversion for a page
   */
  async trackConversion(pageId: string, metrics: ConversionMetrics): Promise<void> {
    const history = this.conversionHistory.get(pageId) || [];
    history.push(metrics);
    this.conversionHistory.set(pageId, history);

    console.log(`[RevenueLoop] Tracked conversion for ${pageId}: ${metrics.conversionRate}% conversion rate`);

    // Update SEO score based on conversion data
    if (this.learningEnabled) {
      await this.updateSEOScore(pageId, metrics);
    }
  }

  /**
   * Calculate conversion probability for a page
   */
  async calculateConversionProbability(pageId: string): Promise<number> {
    const history = this.conversionHistory.get(pageId);
    
    if (!history || history.length === 0) {
      return 0.5; // Default probability
    }

    // Calculate weighted average of recent conversion rates
    const recentMetrics = history.slice(-10); // Last 10 periods
    const totalWeight = recentMetrics.reduce((sum, _, index) => sum + (index + 1), 0);
    const weightedSum = recentMetrics.reduce((sum, metric, index) => {
      return sum + (metric.conversionRate * (index + 1));
    }, 0);

    return weightedSum / totalWeight;
  }

  /**
   * Update SEO score based on conversion data
   */
  private async updateSEOScore(pageId: string, metrics: ConversionMetrics): Promise<void> {
    const conversionProbability = await this.calculateConversionProbability(pageId);
    
    // In production, this would update the SEOOpportunityScore in the database
    console.log(`[RevenueLoop] Updated SEO score for ${pageId} based on conversion probability: ${conversionProbability.toFixed(2)}`);
  }

  /**
   * Generate revenue feedback for a page
   */
  async generateRevenueFeedback(pageId: string): Promise<RevenueFeedback> {
    const history = this.conversionHistory.get(pageId);
    
    if (!history || history.length === 0) {
      return {
        pageId,
        conversionProbability: 0.5,
        previousConversionProbability: 0.5,
        improvement: 0,
        recommendation: 'Insufficient data for feedback',
        action: 'NO_ACTION',
        similarRegions: []
      };
    }

    const currentProbability = await this.calculateConversionProbability(pageId);
    const previousProbability = history.length > 1 ? 
      history[history.length - 2].conversionRate : 
      currentProbability;
    
    const improvement = currentProbability - previousProbability;
    const latestMetrics = history[history.length - 1];

    let action: 'GENERATE_SIMILAR' | 'UPDATE_CONTENT' | 'PAUSE_GENERATION' | 'NO_ACTION';
    let recommendation: string;
    let similarRegions: string[] = [];

    if (currentProbability > 0.05 && improvement > 0.01) {
      // High conversion and improving - generate similar pages
      action = 'GENERATE_SIMILAR';
      recommendation = 'High conversion rate with positive trend. Generate similar pages in similar regions.';
      similarRegions = await this.findSimilarRegions(pageId);
    } else if (currentProbability > 0.05 && improvement < -0.01) {
      // High conversion but declining - update content
      action = 'UPDATE_CONTENT';
      recommendation = 'High conversion rate but declining. Refresh content to maintain performance.';
    } else if (currentProbability < 0.01) {
      // Low conversion - pause generation
      action = 'PAUSE_GENERATION';
      recommendation = 'Low conversion rate. Pause generation and investigate content quality.';
    } else {
      action = 'NO_ACTION';
      recommendation = 'Stable performance. Continue monitoring.';
    }

    return {
      pageId,
      conversionProbability: currentProbability,
      previousConversionProbability: previousProbability,
      improvement,
      recommendation,
      action,
      similarRegions
    };
  }

  /**
   * Find similar regions based on page performance
   */
  private async findSimilarRegions(pageId: string): Promise<string[]> {
    // In production, this would use the knowledge graph to find similar regions
    // For now, return mock similar regions
    return [
      'dubai-downtown',
      'dubai-palm-jumeirah',
      'dubai-business-bay'
    ];
  }

  /**
   * Learn from successful pages and generate similar pages
   */
  async learnFromSuccess(pageId: string): Promise<string[]> {
    const feedback = await this.generateRevenueFeedback(pageId);
    
    if (feedback.action !== 'GENERATE_SIMILAR') {
      return [];
    }

    const generatedPages: string[] = [];

    for (const region of feedback.similarRegions) {
      const newPageId = await this.generateSimilarPage(region, pageId);
      generatedPages.push(newPageId);
    }

    console.log(`[RevenueLoop] Generated ${generatedPages.length} similar pages based on ${pageId} success`);

    return generatedPages;
  }

  /**
   * Generate similar page in a different region
   */
  private async generateSimilarPage(region: string, sourcePageId: string): Promise<string> {
    const newPageId = `${region}-investment-analysis`;
    
    // In production, this would trigger the SEO Intelligence Agent to generate the page
    console.log(`[RevenueLoop] Generating page ${newPageId} based on successful ${sourcePageId}`);

    return newPageId;
  }

  /**
   * Get revenue statistics for all pages
   */
  getRevenueStatistics(): {
    totalPages: number;
    totalVisitors: number;
    totalLeads: number;
    totalTransactions: number;
    totalCommission: number;
    averageConversionRate: number;
    topPerformingPages: Array<{
      pageId: string;
      conversionRate: number;
      commission: number;
    }>;
  } {
    let totalVisitors = 0;
    let totalLeads = 0;
    let totalTransactions = 0;
    let totalCommission = 0;
    let totalConversionRate = 0;
    const pagePerformance: Array<{ pageId: string; conversionRate: number; commission: number }> = [];

    this.conversionHistory.forEach((history, pageId) => {
      const latest = history[history.length - 1];
      if (latest) {
        totalVisitors += latest.visitors;
        totalLeads += latest.leads;
        totalTransactions += latest.transactions;
        totalCommission += latest.commission;
        totalConversionRate += latest.conversionRate;

        pagePerformance.push({
          pageId,
          conversionRate: latest.conversionRate,
          commission: latest.commission
        });
      }
    });

    const averageConversionRate = pagePerformance.length > 0 ? 
      totalConversionRate / pagePerformance.length : 0;

    const topPerformingPages = pagePerformance
      .sort((a, b) => b.commission - a.commission)
      .slice(0, 10);

    return {
      totalPages: this.conversionHistory.size,
      totalVisitors,
      totalLeads,
      totalTransactions,
      totalCommission,
      averageConversionRate,
      topPerformingPages
    };
  }

  /**
   * Enable or disable learning
   */
  setLearningEnabled(enabled: boolean): void {
    this.learningEnabled = enabled;
    console.log(`[RevenueLoop] Learning ${enabled ? 'enabled' : 'disabled'}`);
  }

  /**
   * Clear conversion history
   */
  clearHistory(pageId?: string): void {
    if (pageId) {
      this.conversionHistory.delete(pageId);
      console.log(`[RevenueLoop] Cleared history for ${pageId}`);
    } else {
      this.conversionHistory.clear();
      console.log('[RevenueLoop] Cleared all conversion history');
    }
  }

  /**
   * Get conversion history for a page
   */
  getPageHistory(pageId: string): ConversionMetrics[] {
    return this.conversionHistory.get(pageId) || [];
  }

  /**
   * Batch track conversions for multiple pages
   */
  async batchTrackConversions(metricsArray: ConversionMetrics[]): Promise<void> {
    for (const metrics of metricsArray) {
      await this.trackConversion(metrics.pageId, metrics);
    }
  }

  /**
   * Generate batch revenue feedback
   */
  async batchGenerateFeedback(pageIds: string[]): Promise<RevenueFeedback[]> {
    const feedbackArray = [];

    for (const pageId of pageIds) {
      const feedback = await this.generateRevenueFeedback(pageId);
      feedbackArray.push(feedback);
    }

    return feedbackArray;
  }
}

// Singleton instance
export const revenueIntelligenceLoop = new RevenueIntelligenceLoop();

/**
 * Example: Kadıköy Investment Page conversion tracking
 */
export function exampleRevenueLoop() {
  const loop = new RevenueIntelligenceLoop();

  const kadikoyMetrics: ConversionMetrics = {
    pageId: 'kadikoy-investment-page',
    visitors: 100000,
    leads: 500,
    viewings: 50,
    offers: 20,
    transactions: 10,
    commission: 50000,
    conversionRate: 0.01, // 1%
    leadToViewingRate: 0.1, // 10%
    viewingToOfferRate: 0.4, // 40%
    offerToTransactionRate: 0.5, // 50%
    revenuePerVisitor: 0.5,
    period: '2026-07'
  };

  return loop.trackConversion('kadikoy-investment-page', kadikoyMetrics);
}
