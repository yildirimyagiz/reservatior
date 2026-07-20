/**
 * Analytics OS Service
 * Enterprise analytics and business intelligence platform
 */

import { prisma } from '../lib/prisma';
import { eventBus } from '../core/events/event-bus';
import { GeminiService } from './gemini';


export interface AnalyticsMetric {
  id: string;
  metricType: 'revenue' | 'property' | 'financial' | 'user' | 'agent' | 'campaign' | 'partner' | 'trust' | 'ai' | 'country';
  value: number;
  previousValue?: number;
  changePercent?: number;
  timestamp: Date;
  dimensions?: Record<string, any>;
  countryCode?: string;
  language?: string;
  currency?: string;
}

export interface KPIConfig {
  id: string;
  name: string;
  description: string;
  metricType: string;
  formula: string;
  target?: number;
  threshold?: number;
  alertEnabled: boolean;
}

export interface DashboardWidget {
  id: string;
  type: 'chart' | 'metric' | 'table' | 'funnel' | 'heatmap' | 'gauge';
  title: string;
  metricType: string;
  config: Record<string, any>;
  refreshInterval?: number;
}

export interface AIInsight {
  id: string;
  insightType: 'anomaly' | 'trend' | 'prediction' | 'recommendation' | 'alert';
  title: string;
  description: string;
  confidence: number;
  impact: 'high' | 'medium' | 'low';
  actionable: boolean;
  suggestedActions?: string[];
  relatedMetrics: string[];
  timestamp: Date;
}

class AnalyticsOSService {
  /**
   * Track a metric event
   */
  async trackMetric(metricType: string, value: number, dimensions?: Record<string, any>, countryCode?: string, language?: string, currency?: string) {
    const metric = {
      id: crypto.randomUUID(),
      metricType,
      value,
      timestamp: new Date(),
      dimensions,
      countryCode,
      language,
      currency
    };

    // Store in database
    await prisma.analyticsMetric.create({
      data: metric
    });

    // Publish event
    await eventBus.publish('analytics.metric.recorded', metric, 'AnalyticsOS');

    return metric;
  }

  /**
   * Calculate KPI based on formula
   */
  async calculateKPI(kpiConfig: KPIConfig, timeRange: { start: Date; end: Date }) {
    // This would implement formula evaluation
    // For now, return mock implementation
    const metrics = await prisma.analyticsMetric.findMany({
      where: {
        metricType: kpiConfig.metricType,
        timestamp: {
          gte: timeRange.start,
          lte: timeRange.end
        }
      }
    });

    const value = metrics.reduce((sum: number, m: any) => sum + m.value, 0);
    
    return {
      kpiId: kpiConfig.id,
      value,
      target: kpiConfig.target,
      threshold: kpiConfig.threshold,
      achieved: kpiConfig.target ? value >= kpiConfig.target : undefined,
      timestamp: new Date()
    };
  }

  /**
   * Generate AI-powered insights
   */
  async generateInsights(metricType: string, timeRange: { start: Date; end: Date }): Promise<AIInsight[]> {
    const metrics = await prisma.analyticsMetric.findMany({
      where: {
        metricType,
        timestamp: {
          gte: timeRange.start,
          lte: timeRange.end
        }
      },
      orderBy: { timestamp: 'asc' }
    });

    if (metrics.length < 2) return [];

    // Use AI to analyze trends and generate insights
    const prompt = `
      Analyze the following metrics data for ${metricType}:
      ${JSON.stringify(metrics.map((m: any) => ({ value: m.value, timestamp: m.timestamp })))}
      
      Generate insights about:
      1. Trends (increasing, decreasing, stable)
      2. Anomalies (unusual spikes or drops)
      3. Predictions (next period forecast)
      4. Recommendations (actions to improve)
      
      Return as JSON with structure: {
        insights: [{
          type: "trend|anomaly|prediction|recommendation",
          title: string,
          description: string,
          confidence: number,
          impact: "high|medium|low",
          actionable: boolean,
          suggestedActions: string[]
        }]
      }
    `;

    try {
      const aiResponse = await GeminiService.processHubSearch(prompt, { role: 'ADMIN' });
      const parsed = JSON.parse(aiResponse);
      return parsed.insights.map((insight: any) => ({
        id: crypto.randomUUID(),
        ...insight,
        relatedMetrics: [metricType],
        timestamp: new Date()
      }));
    } catch (error) {
      console.error('Failed to generate AI insights:', error);
      return [];
    }
  }

  /**
   * Get executive dashboard data
   */
  async getExecutiveDashboard(orgId: string) {
    const timeRange = {
      start: new Date(Date.now() - 30 * 24 * 60 * 60 * 1000), // 30 days
      end: new Date()
    };

    const [revenue, properties, users, agents, campaigns] = await Promise.all([
      this.getRevenueMetrics(timeRange, orgId),
      this.getPropertyMetrics(timeRange, orgId),
      this.getUserMetrics(timeRange, orgId),
      this.getAgentMetrics(timeRange, orgId),
      this.getCampaignMetrics(timeRange, orgId)
    ]);

    const insights = await this.generateInsights('revenue', timeRange);

    return {
      timeRange,
      metrics: {
        revenue,
        properties,
        users,
        agents,
        campaigns
      },
      insights,
      kpis: await this.getKPIs(orgId)
    };
  }

  /**
   * Revenue analytics
   */
  private async getRevenueMetrics(timeRange: { start: Date; end: Date }, orgId: string) {
    const deals = await prisma.deal.findMany({
      where: {
        organizationId: orgId,
        createdAt: { gte: timeRange.start, lte: timeRange.end }
      }
    });

    const totalRevenue = deals.reduce((sum: number, d: any) => sum + (d.amount || 0), 0);
    const previousRevenue = await this.getPreviousRevenue(timeRange, orgId);
    const change = previousRevenue ? ((totalRevenue - previousRevenue) / previousRevenue) * 100 : 0;

    return {
      total: totalRevenue,
      change,
      dealCount: deals.length,
      averageDealValue: deals.length > 0 ? totalRevenue / deals.length : 0
    };
  }

  /**
   * Property analytics
   */
  private async getPropertyMetrics(timeRange: { start: Date; end: Date }, orgId: string) {
    const properties = await prisma.property.findMany({
      where: {
        organizationId: orgId,
        createdAt: { gte: timeRange.start, lte: timeRange.end }
      }
    });

    return {
      total: properties.length,
      published: properties.filter((p: any) => p.status === 'published').length,
      pending: properties.filter((p: any) => p.status === 'pending').length
    };
  }

  /**
   * User analytics
   */
  private async getUserMetrics(timeRange: { start: Date; end: Date }, orgId: string) {
    const users = await prisma.user.findMany({
      where: {
        organizationId: orgId,
        createdAt: { gte: timeRange.start, lte: timeRange.end }
      }
    });

    return {
      total: users.length,
      active: users.filter((u: any) => u.lastActiveAt && u.lastActiveAt > new Date(Date.now() - 7 * 24 * 60 * 60 * 1000)).length
    };
  }

  /**
   * Agent analytics
   */
  private async getAgentMetrics(timeRange: { start: Date; end: Date }, orgId: string) {
    const agents = await prisma.agent.findMany({
      where: {
        organizationId: orgId,
        createdAt: { gte: timeRange.start, lte: timeRange.end }
      }
    });

    return {
      total: agents.length,
      active: agents.filter((a: any) => a.status === 'active').length
    };
  }

  /**
   * Campaign analytics
   */
  private async getCampaignMetrics(timeRange: { start: Date; end: Date }, orgId: string) {
    const campaigns = await prisma.marketingCampaign.findMany({
      where: {
        organizationId: orgId,
        createdAt: { gte: timeRange.start, lte: timeRange.end }
      }
    });

    return {
      total: campaigns.length,
      active: campaigns.filter((c: any) => c.status === 'active').length
    };
  }

  /**
   * Get previous period revenue for comparison
   */
  private async getPreviousRevenue(timeRange: { start: Date; end: Date }, orgId: string) {
    const duration = timeRange.end.getTime() - timeRange.start.getTime();
    const previousStart = new Date(timeRange.start.getTime() - duration);
    const previousEnd = timeRange.start;

    const deals = await prisma.deal.findMany({
      where: {
        organizationId: orgId,
        createdAt: { gte: previousStart, lte: previousEnd }
      }
    });

    return deals.reduce((sum: number, d: any) => sum + (d.amount || 0), 0);
  }

  /**
   * Get KPIs for organization
   */
  private async getKPIs(orgId: string) {
    const kpiConfigs = await prisma.dashboardConfiguration.findMany({
      where: { organizationId: orgId }
    });

    const timeRange = {
      start: new Date(Date.now() - 30 * 24 * 60 * 60 * 1000),
      end: new Date()
    };

    return Promise.all(
      kpiConfigs.map((config: any) => this.calculateKPI(config as any, timeRange))
    );
  }

  /**
   * Create custom dashboard widget
   */
  async createWidget(widget: DashboardWidget, orgId: string) {
    return prisma.dashboardWidget.create({
      data: {
        ...widget,
        organizationId: orgId
      }
    });
  }

  /**
   * Get dashboard widgets
   */
  async getWidgets(orgId: string) {
    return prisma.dashboardWidget.findMany({
      where: { organizationId: orgId }
    });
  }
}

export const analyticsOSService = new AnalyticsOSService();
