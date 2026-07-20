/**
 * Analytics Insight Saga
 *
 * Flow: analytics data collected → update insight metrics
 *       report generated → log report, trigger notification if KPI crossed
 */
import { eventBus } from "../events/event-bus";
import { DomainEvents, EventMessage } from "../events/domain-events";

export function registerAnalyticsInsightListeners() {
  eventBus.subscribe(DomainEvents.ANALYTICS_DATA_COLLECTED, async (msg: EventMessage) => {
    const { datasetId, orgId, metricType, value } = msg.payload;
    console.log(`[AnalyticsInsightSaga] 📊 Analytics data collected: ${metricType} = ${value} (dataset: ${datasetId})`);

    eventBus.publish(DomainEvents.AUDIT_LOG_CREATED, {
      action: "ANALYTICS_DATA_COLLECTED",
      datasetId,
      metricType,
      value,
      orgId,
      timestamp: new Date(),
    }, "AnalyticsOS", msg.correlationId);
  });

  eventBus.subscribe(DomainEvents.REPORT_GENERATED, async (msg: EventMessage) => {
    const { reportId, orgId, reportType } = msg.payload;
    console.log(`[AnalyticsInsightSaga] 📈 Report generated: ${reportId} (type: ${reportType})`);

    eventBus.publish(DomainEvents.AUDIT_LOG_CREATED, {
      action: "REPORT_GENERATED",
      reportId,
      reportType,
      orgId,
      timestamp: new Date(),
    }, "AnalyticsOS", msg.correlationId);
  });

  eventBus.subscribe(DomainEvents.KPI_THRESHOLD_CROSSED, async (msg: EventMessage) => {
    const { kpiName, orgId, currentValue, threshold } = msg.payload;
    console.log(`[AnalyticsInsightSaga] 🚨 KPI threshold crossed: ${kpiName} (${currentValue} > ${threshold})`);

    eventBus.publish(DomainEvents.PERFORMANCE_ALERT_FIRED, {
      kpiName,
      currentValue,
      threshold,
      orgId,
      firedAt: new Date(),
    }, "AnalyticsOS", msg.correlationId);
  });
}
