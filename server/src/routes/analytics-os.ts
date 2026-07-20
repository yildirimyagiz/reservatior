/**
 * Analytics OS API Routes
 */

import { Elysia, t } from 'elysia';
import { analyticsOSService } from '../services/analytics-os';
import { platformIntelligence } from '../core/platform-intelligence';

export const analyticsOSRoutes = new Elysia({ prefix: '/analytics' })
  /**
   * GET /api/analytics/dashboard
   * Get executive dashboard data
   */
  .get('/dashboard', async ({ query, set }) => {
    const orgId = query.orgId;
    
    if (!orgId) {
      set.status = 400;
      return { error: 'Organization ID required' };
    }

    try {
      const dashboard = await analyticsOSService.getExecutiveDashboard(orgId);
      return dashboard;
    } catch (error) {
      set.status = 500;
      return { error: 'Failed to fetch dashboard data' };
    }
  })

  /**
   * POST /api/analytics/metrics
   * Track a metric
   */
  .post('/metrics', async ({ body, set }) => {
    try {
      const metric = await analyticsOSService.trackMetric(
        body.metricType,
        body.value,
        body.dimensions
      );
      return metric;
    } catch (error) {
      set.status = 500;
      return { error: 'Failed to track metric' };
    }
  }, {
    body: t.Object({
      metricType: t.String(),
      value: t.Number(),
      dimensions: t.Optional(t.Record(t.String, t.Any()))
    })
  })

  /**
   * GET /api/analytics/metrics/:type
   * Get metrics by type
   */
  .get('/metrics/:type', async ({ params, query, set }) => {
    const metricType = params.type;
    const start = query.start;
    const end = query.end;

    try {
      const timeRange = start && end ? {
        start: new Date(start),
        end: new Date(end)
      } : {
        start: new Date(Date.now() - 30 * 24 * 60 * 60 * 1000),
        end: new Date()
      };

      const insights = await analyticsOSService.generateInsights(metricType, timeRange);
      return { insights };
    } catch (error) {
      set.status = 500;
      return { error: 'Failed to fetch metrics' };
    }
  })

  /**
   * POST /api/analytics/widgets
   * Create dashboard widget
   */
  .post('/widgets', async ({ body, set }) => {
    const orgId = body.orgId;

    try {
      const widget = await analyticsOSService.createWidget(body, orgId);
      return widget;
    } catch (error) {
      set.status = 500;
      return { error: 'Failed to create widget' };
    }
  })

  /**
   * GET /api/analytics/widgets
   * Get dashboard widgets
   */
  .get('/widgets', async ({ query, set }) => {
    const orgId = query.orgId;

    try {
      const widgets = await analyticsOSService.getWidgets(orgId);
      return widgets;
    } catch (error) {
      set.status = 500;
      return { error: 'Failed to fetch widgets' };
    }
  })

  /**
   * GET /api/analytics/insights
   * Get AI-powered insights
   */
  .get('/insights', async ({ query, set }) => {
    const metricType = query.metricType;

    if (!metricType) {
      set.status = 400;
      return { error: 'Metric type required' };
    }

    try {
      const timeRange = {
        start: new Date(Date.now() - 30 * 24 * 60 * 60 * 1000),
        end: new Date()
      };

      const insights = await analyticsOSService.generateInsights(metricType, timeRange);
      return insights;
    } catch (error) {
      set.status = 500;
      return { error: 'Failed to generate insights' };
    }
  })

  /**
   * POST /api/analytics/insights/generate
   * Generate AI insights for module
   */
  .post('/insights/generate', async ({ body, set }) => {
    const { module, context } = body;

    try {
      const insights = await platformIntelligence.generateInsights(module, context);
      return insights;
    } catch (error) {
      set.status = 500;
      return { error: 'Failed to generate insights' };
    }
  }, {
    body: t.Object({
      module: t.String(),
      context: t.Record(t.String, t.Any())
    })
  });
