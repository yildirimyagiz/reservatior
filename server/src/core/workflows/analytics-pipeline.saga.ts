/**
 * Saga: Analytics Pipeline
 * 
 * Flow:
 *   analytics.query_requested
 *       |
 *   [Data collection & processing]
 *       |
 *   analytics.insight_generated
 *       |
 *   [Visualization creation]
 *       |
 *   analytics.dashboard_viewed
 *       |
 *   [Analytics complete]
 */

import { BaseSaga } from './saga-orchestrator';
import { LocalizationContext, EventMessage } from '../events/domain-events';
import { eventBus } from '../events/event-bus';
import { DomainEvents } from '../events/domain-events';

export class AnalyticsPipelineSaga extends BaseSaga {
  public queryId: string;
  public queryType: string;
  public userId: string;
  public organizationId: string;

  constructor(
    queryId: string,
    queryType: string,
    userId: string,
    organizationId: string,
    sagaId?: string,
    localization?: LocalizationContext
  ) {
    super(sagaId, { step: 'QUERY_REQUESTED', queryId, queryType, userId, organizationId }, localization);
    this.queryId = queryId;
    this.queryType = queryType;
    this.userId = userId;
    this.organizationId = organizationId;
  }

  protected async compensate(): Promise<void> {
    console.log(`[AnalyticsPipelineSaga] Compensating query ${this.queryId}. Cleaning up analytics data...`);
  }

  public async onQueryRequested() {
    console.log(`[AnalyticsPipelineSaga] Query ${this.queryId} requested. Collecting data...`);
    await this.transition({ step: 'COLLECTING_DATA' });

    // Simulate data collection from various OS modules
    setTimeout(() => {
      eventBus.publish(DomainEvents.ANALYTICS_INSIGHT_GENERATED, {
        queryId: this.queryId,
        queryType: this.queryType,
        insights: [
          { type: 'trend', value: '+15%', description: 'Revenue growth' },
          { type: 'anomaly', value: 'high', description: 'Unusual activity detected' },
        ],
        generatedAt: new Date().toISOString(),
        localization: this.localization
      }, 'AnalyticsOS', this.sagaId);
    }, 2000);
  }

  public async onInsightGenerated(msg: EventMessage) {
    console.log(`[AnalyticsPipelineSaga] Insights generated for query ${this.queryId}. Creating visualizations...`);
    await this.transition({ step: 'CREATING_VISUALIZATIONS' });

    // Simulate visualization creation
    setTimeout(() => {
      eventBus.publish(DomainEvents.ANALYTICS_DASHBOARD_VIEWED, {
        queryId: this.queryId,
        dashboardId: `dashboard_${this.queryId}`,
        viewedBy: this.userId,
        viewedAt: new Date().toISOString(),
        localization: this.localization
      }, 'AnalyticsOS', this.sagaId);
    }, 1500);
  }

  public async onDashboardViewed(msg: EventMessage) {
    console.log(`[AnalyticsPipelineSaga] Dashboard viewed for query ${this.queryId}. ANALYTICS SAGA COMPLETE.`);
    await this.complete();
  }

  public async onQueryFailed(msg: EventMessage) {
    console.log(`[AnalyticsPipelineSaga] Query ${this.queryId} failed. SAGA FAILED.`);
    await this.fail('Analytics query failed');
  }
}

// ─── Registry ─────────────────────────────────────────────────────────────────
const activeSagas = new Map<string, AnalyticsPipelineSaga>();

export function registerAnalyticsPipelineListeners() {
  eventBus.subscribe(DomainEvents.ANALYTICS_QUERY_REQUESTED, (msg) => {
    const { queryId, queryType, userId, organizationId } = msg.payload;
    const localization = msg.localization || {
      countryCode: 'US',
      language: 'en',
      currency: 'USD',
      timezone: 'America/New_York'
    };
    const saga = new AnalyticsPipelineSaga(queryId, queryType, userId, organizationId, msg.correlationId, localization);
    activeSagas.set(saga.sagaId, saga);
    saga.onQueryRequested();
    console.log(`[AnalyticsPipelineSaga] ✅ Started for Query ${queryId}`);
  });

  eventBus.subscribe(DomainEvents.ANALYTICS_INSIGHT_GENERATED, (msg) => {
    const saga = activeSagas.get(msg.correlationId!);
    if (saga) saga.onInsightGenerated(msg);
  });

  eventBus.subscribe(DomainEvents.ANALYTICS_DASHBOARD_VIEWED, (msg) => {
    const saga = activeSagas.get(msg.correlationId!);
    if (saga) saga.onDashboardViewed(msg);
  });

  eventBus.subscribe(DomainEvents.ANALYTICS_QUERY_FAILED, (msg) => {
    const saga = activeSagas.get(msg.correlationId!);
    if (saga) saga.onQueryFailed(msg);
  });
}
