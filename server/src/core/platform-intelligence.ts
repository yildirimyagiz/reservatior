/**
 * Platform Intelligence Layer
 * Central intelligence infrastructure for all OS modules
 */

import { eventBus } from './events/event-bus';
import { analyticsOSService } from '../services/analytics-os';
import { notificationOSService } from '../services/notification-os';
import { documentOSService } from '../services/document-os';
import { identityOSService } from '../services/identity-os';
import { localizationOSService } from '../services/localization-os';
import { GeminiService } from '../services/gemini';

export interface MetricDefinition {
  name: string;
  type: 'counter' | 'gauge' | 'histogram' | 'summary';
  description: string;
  labels?: string[];
  unit?: string;
}

export interface MetricData {
  name: string;
  value: number;
  labels?: Record<string, string>;
  timestamp: Date;
}

export interface APIEndpoint {
  path: string;
  method: 'GET' | 'POST' | 'PUT' | 'DELETE' | 'PATCH';
  description: string;
  authRequired: boolean;
  rateLimit?: number;
  osModule: string;
}

export interface AIRecommendation {
  id: string;
  type: string;
  title: string;
  description: string;
  confidence: number;
  priority: 'low' | 'medium' | 'high';
  actionItems: string[];
  relatedMetrics: string[];
  targetModule: string;
  expiresAt?: Date;
}

export interface DashboardConfig {
  id: string;
  name: string;
  description: string;
  osModule: string;
  widgets: Array<{
    type: 'metric' | 'chart' | 'table' | 'gauge' | 'heatmap';
    title: string;
    metricName: string;
    config: Record<string, any>;
    position: { x: number; y: number; w: number; h: number };
  }>;
  refreshInterval: number;
}

class PlatformIntelligenceLayer {
  private metrics: Map<string, MetricDefinition> = new Map();
  private metricData: MetricData[] = [];
  private apiEndpoints: Map<string, APIEndpoint> = new Map();
  private aiRecommendations: Map<string, AIRecommendation> = new Map();
  private dashboards: Map<string, DashboardConfig> = new Map();

  /**
   * Register a metric definition
   */
  registerMetric(definition: MetricDefinition) {
    this.metrics.set(definition.name, definition);
    console.log(`[PlatformIntelligence] Registered metric: ${definition.name}`);
  }

  /**
   * Record metric value
   */
  async recordMetric(data: MetricData) {
    if (!this.metrics.has(data.name)) {
      console.warn(`[PlatformIntelligence] Unknown metric: ${data.name}`);
      return;
    }

    this.metricData.push({
      ...data,
      timestamp: data.timestamp || new Date()
    });

    // Publish to event bus
    await eventBus.publish('platform.metric.recorded', data, 'PlatformIntelligence');

    // Also send to Analytics OS
    await analyticsOSService.trackMetric(data.name, data.value, data.labels);
  }

  /**
   * Get metric data
   */
  getMetricData(metricName: string, timeRange?: { start: Date; end: Date }): MetricData[] {
    let data = this.metricData.filter(m => m.name === metricName);

    if (timeRange) {
      data = data.filter(m => 
        m.timestamp >= timeRange.start && m.timestamp <= timeRange.end
      );
    }

    return data;
  }

  /**
   * Register API endpoint
   */
  registerAPIEndpoint(endpoint: APIEndpoint) {
    const key = `${endpoint.method}:${endpoint.path}`;
    this.apiEndpoints.set(key, endpoint);
    console.log(`[PlatformIntelligence] Registered API endpoint: ${key}`);
  }

  /**
   * Get API endpoints for OS module
   */
  getAPIEndpoints(osModule: string): APIEndpoint[] {
    return Array.from(this.apiEndpoints.values()).filter(
      endpoint => endpoint.osModule === osModule
    );
  }

  /**
   * Publish AI recommendation
   */
  async publishRecommendation(recommendation: Omit<AIRecommendation, 'id'>) {
    const rec: AIRecommendation = {
      ...recommendation,
      id: crypto.randomUUID()
    };

    this.aiRecommendations.set(rec.id, rec);

    // Publish to event bus
    await eventBus.publish('platform.recommendation.published', rec, 'PlatformIntelligence');

    // Send notification if high priority
    if (rec.priority === 'high') {
      await notificationOSService.send({
        userId: 'system', // Would be actual user in production
        type: 'ai_recommendation',
        title: rec.title,
        body: rec.description,
        channel: 'in_app',
        priority: 'high',
        metadata: { recommendationId: rec.id }
      });
    }

    return rec;
  }

  /**
   * Get recommendations for module
   */
  getRecommendations(targetModule: string): AIRecommendation[] {
    return Array.from(this.aiRecommendations.values()).filter(
      rec => rec.targetModule === targetModule && 
      (!rec.expiresAt || rec.expiresAt > new Date())
    );
  }

  /**
   * Generate AI-powered insights
   */
  async generateInsights(module: string, context: Record<string, any>): Promise<AIRecommendation[]> {
    try {
      const prompt = `
        Analyze the following platform data for ${module}:
        ${JSON.stringify(context)}
        
        Generate 3-5 actionable recommendations to improve:
        - Performance
        - User experience
        - Business metrics
        - Operational efficiency
        
        For each recommendation, provide:
        - type: performance|ux|business|operations
        - title: concise title
        - description: detailed explanation
        - confidence: 0-1 score
        - priority: low|medium|high
        - actionItems: 3-5 specific actions
        - relatedMetrics: metric names to track
        
        Return as JSON array.
      `;

      const response = await GeminiService.processHubSearch(prompt, { role: 'ADMIN' });
      const insights = JSON.parse(response);

      const recommendations = await Promise.all(
        insights.map((insight: any) =>
          this.publishRecommendation({
            ...insight,
            targetModule: module
          })
        )
      );

      return recommendations;
    } catch (error) {
      console.error('AI insight generation failed:', error);
      return [];
    }
  }

  /**
   * Register dashboard configuration
   */
  registerDashboard(config: DashboardConfig) {
    this.dashboards.set(config.id, config);
    console.log(`[PlatformIntelligence] Registered dashboard: ${config.name}`);
  }

  /**
   * Get dashboard configuration
   */
  getDashboard(dashboardId: string): DashboardConfig | undefined {
    return this.dashboards.get(dashboardId);
  }

  /**
   * Get dashboards for OS module
   */
  getDashboards(osModule: string): DashboardConfig[] {
    return Array.from(this.dashboards.values()).filter(
      dashboard => dashboard.osModule === osModule
    );
  }

  /**
   * Get platform health metrics
   */
  async getPlatformHealth(): Promise<{
    status: 'healthy' | 'degraded' | 'unhealthy';
    modules: Record<string, {
      status: 'healthy' | 'degraded' | 'unhealthy';
      metrics: Record<string, number>;
      lastUpdated: Date;
    }>;
    overallMetrics: Record<string, number>;
  }> {
    const modules = ['AnalyticsOS', 'DocumentOS', 'NotificationOS', 'IdentityOS', 'LocalizationOS'];
    
    const moduleStatus = await Promise.all(
      modules.map(async (module) => {
        const moduleMetrics = this.getModuleMetrics(module);
        const status = this.determineModuleStatus(moduleMetrics);
        
        return {
          [module]: {
            status,
            metrics: moduleMetrics,
            lastUpdated: new Date()
          }
        };
      })
    );

    const overallStatus = this.determineOverallStatus(
      Object.values(moduleStatus).reduce((acc, curr) => ({ ...acc, ...curr }), {})
    );

    return {
      status: overallStatus,
      modules: moduleStatus.reduce((acc, curr) => ({ ...acc, ...curr }), {}),
      overallMetrics: this.getOverallMetrics()
    };
  }

  /**
   * Get metrics for specific module
   */
  private getModuleMetrics(module: string): Record<string, number> {
    const modulePrefix = module.toLowerCase().replace('os', '');
    const relevantMetrics = Array.from(this.metrics.keys())
      .filter(name => name.startsWith(modulePrefix));

    return relevantMetrics.reduce((acc, metricName) => {
      const data = this.getMetricData(metricName);
      const latest = data[data.length - 1];
      if (latest) {
        acc[metricName] = latest.value;
      }
      return acc;
    }, {} as Record<string, number>);
  }

  /**
   * Determine module status based on metrics
   */
  private determineModuleStatus(metrics: Record<string, number>): 'healthy' | 'degraded' | 'unhealthy' {
    // Simple health check logic
    // In production, use more sophisticated rules
    const metricCount = Object.keys(metrics).length;
    if (metricCount === 0) return 'degraded';
    
    // Check if any metric is below threshold
    for (const [name, value] of Object.entries(metrics)) {
      if (value < 0) return 'unhealthy';
    }

    return 'healthy';
  }

  /**
   * Determine overall platform status
   */
  private determineOverallStatus(moduleStatuses: Record<string, any>): 'healthy' | 'degraded' | 'unhealthy' {
    const statuses = Object.values(moduleStatuses).map((m: any) => m.status);
    
    if (statuses.some(s => s === 'unhealthy')) return 'unhealthy';
    if (statuses.some(s => s === 'degraded')) return 'degraded';
    return 'healthy';
  }

  /**
   * Get overall platform metrics
   */
  private getOverallMetrics(): Record<string, number> {
    return {
      totalMetrics: this.metrics.size,
      totalAPIEndpoints: this.apiEndpoints.size,
      activeRecommendations: this.aiRecommendations.size,
      totalDashboards: this.dashboards.size,
      metricDataPoints: this.metricData.length
    };
  }

  /**
   * Initialize platform intelligence
   */
  async initialize() {
    console.log('[PlatformIntelligence] Initializing platform intelligence layer');

    // Register core metrics
    this.registerCoreMetrics();

    // Register core API endpoints
    this.registerCoreAPIEndpoints();

    // Register default dashboards
    this.registerDefaultDashboards();

    // Subscribe to platform events
    this.subscribeToEvents();

    console.log('[PlatformIntelligence] Platform intelligence layer initialized');
  }

  /**
   * Register core metrics
   */
  private registerCoreMetrics() {
    const coreMetrics: MetricDefinition[] = [
      { name: 'platform_requests_total', type: 'counter', description: 'Total platform requests' },
      { name: 'platform_errors_total', type: 'counter', description: 'Total platform errors' },
      { name: 'platform_latency_ms', type: 'histogram', description: 'Platform latency in milliseconds', unit: 'ms' },
      { name: 'platform_active_users', type: 'gauge', description: 'Active platform users' },
      { name: 'platform_cpu_usage', type: 'gauge', description: 'Platform CPU usage', unit: '%' },
      { name: 'platform_memory_usage', type: 'gauge', description: 'Platform memory usage', unit: 'MB' },
    ];

    coreMetrics.forEach(metric => this.registerMetric(metric));
  }

  /**
   * Register core API endpoints
   */
  private registerCoreAPIEndpoints() {
    const coreEndpoints: APIEndpoint[] = [
      {
        path: '/api/analytics/dashboard',
        method: 'GET',
        description: 'Get analytics dashboard data',
        authRequired: true,
        osModule: 'AnalyticsOS'
      },
      {
        path: '/api/documents',
        method: 'POST',
        description: 'Upload document',
        authRequired: true,
        osModule: 'DocumentOS'
      },
      {
        path: '/api/notifications/send',
        method: 'POST',
        description: 'Send notification',
        authRequired: true,
        osModule: 'NotificationOS'
      },
      {
        path: '/api/identity/organizations',
        method: 'POST',
        description: 'Create organization',
        authRequired: true,
        osModule: 'IdentityOS'
      },
      {
        path: '/api/localization/translate',
        method: 'POST',
        description: 'Translate content',
        authRequired: true,
        osModule: 'LocalizationOS'
      }
    ];

    coreEndpoints.forEach(endpoint => this.registerAPIEndpoint(endpoint));
  }

  /**
   * Register default dashboards
   */
  private registerDefaultDashboards() {
    const defaultDashboards: DashboardConfig[] = [
      {
        id: 'platform-overview',
        name: 'Platform Overview',
        description: 'Overview of platform health and metrics',
        osModule: 'Platform',
        refreshInterval: 30000,
        widgets: [
          {
            type: 'metric',
            title: 'Total Requests',
            metricName: 'platform_requests_total',
            config: {},
            position: { x: 0, y: 0, w: 3, h: 2 }
          },
          {
            type: 'metric',
            title: 'Active Users',
            metricName: 'platform_active_users',
            config: {},
            position: { x: 3, y: 0, w: 3, h: 2 }
          },
          {
            type: 'gauge',
            title: 'CPU Usage',
            metricName: 'platform_cpu_usage',
            config: { min: 0, max: 100 },
            position: { x: 6, y: 0, w: 3, h: 2 }
          }
        ]
      }
    ];

    defaultDashboards.forEach(dashboard => this.registerDashboard(dashboard));
  }

  /**
   * Subscribe to platform events
   */
  private subscribeToEvents() {
    // Subscribe to all OS events for analytics
    eventBus.subscribe('*', async (message) => {
      await this.recordMetric({
        name: 'platform_events_total',
        value: 1,
        labels: { eventType: message.type as string },
        timestamp: new Date()
      });
    });
  }

  /**
   * Cleanup old metric data
   */
  cleanupOldData(retentionDays: number = 30) {
    const cutoffDate = new Date(Date.now() - retentionDays * 24 * 60 * 60 * 1000);
    
    const beforeCount = this.metricData.length;
    this.metricData = this.metricData.filter(m => m.timestamp > cutoffDate);
    const afterCount = this.metricData.length;

    console.log(`[PlatformIntelligence] Cleaned up ${beforeCount - afterCount} old metric data points`);
  }

  /**
   * Export metrics for external monitoring
   */
  exportMetrics(): string {
    const lines: string[] = [];

    // Export in Prometheus format
    for (const [name, definition] of this.metrics.entries()) {
      const data = this.getMetricData(name);
      if (data.length > 0) {
        const latest = data[data.length - 1];
        const labels = latest.labels 
          ? `{${Object.entries(latest.labels).map(([k, v]) => `${k}="${v}"`).join(',')}}`
          : '';
        lines.push(`${name}${labels} ${latest.value} ${latest.timestamp.getTime()}`);
      }
    }

    return lines.join('\n');
  }
}

export const platformIntelligence = new PlatformIntelligenceLayer();
