/**
 * Observability Layer - OpenTelemetry Integration
 * Provides distributed tracing, metrics, and logging
 */

import { platformIntelligence } from '../platform-intelligence';

export interface TraceConfig {
  serviceName: string;
  serviceVersion: string;
  environment: string;
  exporterUrl?: string;
  sampleRate?: number;
}

export interface MetricConfig {
  name: string;
  description: string;
  type: 'counter' | 'gauge' | 'histogram' | 'summary';
  labels?: string[];
  buckets?: number[];
}

export interface LogConfig {
  level: 'debug' | 'info' | 'warn' | 'error';
  format: 'json' | 'text';
  includeContext: boolean;
}

class TelemetryService {
  private config: TraceConfig;
  private metrics: Map<string, any> = new Map();
  private traces: Map<string, any> = new Map();
  private activeSpans: Map<string, any> = new Map();

  constructor(config: TraceConfig) {
    this.config = config;
    this.initializeTelemetry();
  }

  /**
   * Initialize OpenTelemetry
   */
  private initializeTelemetry() {
    console.log(`[Telemetry] Initializing telemetry for ${this.config.serviceName}`);
    
    // In production, this would initialize actual OpenTelemetry SDK
    // For now, we'll use a mock implementation
    
    // Register core metrics
    this.registerCoreMetrics();
    
    console.log('[Telemetry] Telemetry initialized successfully');
  }

  /**
   * Register core metrics
   */
  private registerCoreMetrics() {
    const coreMetrics: MetricConfig[] = [
      { name: 'http_requests_total', description: 'Total HTTP requests', type: 'counter', labels: ['method', 'route', 'status'] },
      { name: 'http_request_duration_ms', description: 'HTTP request duration in milliseconds', type: 'histogram', labels: ['method', 'route'], buckets: [1, 5, 10, 25, 50, 100, 250, 500, 1000] },
      { name: 'http_requests_in_progress', description: 'HTTP requests currently in progress', type: 'gauge', labels: ['method', 'route'] },
      { name: 'db_query_duration_ms', description: 'Database query duration in milliseconds', type: 'histogram', labels: ['operation', 'table'], buckets: [1, 5, 10, 25, 50, 100, 250, 500] },
      { name: 'db_connections_active', description: 'Active database connections', type: 'gauge' },
      { name: 'cache_hits_total', description: 'Total cache hits', type: 'counter', labels: ['cache'] },
      { name: 'cache_misses_total', description: 'Total cache misses', type: 'counter', labels: ['cache'] },
      { name: 'external_api_calls_total', description: 'Total external API calls', type: 'counter', labels: ['service', 'endpoint', 'status'] },
      { name: 'external_api_duration_ms', description: 'External API call duration in milliseconds', type: 'histogram', labels: ['service', 'endpoint'], buckets: [50, 100, 250, 500, 1000, 2500, 5000] },
      { name: 'business_operations_total', description: 'Total business operations', type: 'counter', labels: ['operation', 'status'] },
      { name: 'business_operation_duration_ms', description: 'Business operation duration in milliseconds', type: 'histogram', labels: ['operation'], buckets: [10, 50, 100, 250, 500, 1000, 2500, 5000] },
      { name: 'error_total', description: 'Total errors', type: 'counter', labels: ['type', 'severity'] },
      { name: 'queue_size', description: 'Queue size', type: 'gauge', labels: ['queue'] },
      { name: 'queue_processing_duration_ms', description: 'Queue processing duration in milliseconds', type: 'histogram', labels: ['queue'], buckets: [10, 50, 100, 250, 500, 1000] }
    ];

    coreMetrics.forEach(metric => {
      this.registerMetric(metric);
    });
  }

  /**
   * Register a metric
   */
  registerMetric(config: MetricConfig) {
    this.metrics.set(config.name, {
      ...config,
      values: [],
      createdAt: new Date()
    });

    // Also register with platform intelligence
    platformIntelligence.registerMetric({
      name: config.name,
      type: config.type,
      description: config.description,
      labels: config.labels
    });

    console.log(`[Telemetry] Registered metric: ${config.name}`);
  }

  /**
   * Record a metric value
   */
  recordMetric(name: string, value: number, labels?: Record<string, string>) {
    const metric = this.metrics.get(name);
    if (!metric) {
      console.warn(`[Telemetry] Unknown metric: ${name}`);
      return;
    }

    const record = {
      value,
      labels: labels || {},
      timestamp: new Date()
    };

    if (!metric.values) metric.values = [];
    metric.values.push(record);

    // Keep only last 1000 values to prevent memory issues
    if (metric.values.length > 1000) {
      metric.values = metric.values.slice(-1000);
    }

    // Also send to platform intelligence
    platformIntelligence.recordMetric({
      name,
      value,
      labels,
      timestamp: record.timestamp
    });
  }

  /**
   * Increment a counter metric
   */
  incrementCounter(name: string, value: number = 1, labels?: Record<string, string>) {
    this.recordMetric(name, value, labels);
  }

  /**
   * Set a gauge metric
   */
  setGauge(name: string, value: number, labels?: Record<string, string>) {
    this.recordMetric(name, value, labels);
  }

  /**
   * Record a histogram value
   */
  recordHistogram(name: string, value: number, labels?: Record<string, string>) {
    this.recordMetric(name, value, labels);
  }

  /**
   * Start a trace span
   */
  startSpan(name: string, parentSpanId?: string): string {
    const spanId = crypto.randomUUID();
    const traceId = parentSpanId ? this.getTraceId(parentSpanId) : crypto.randomUUID();

    const span = {
      spanId,
      traceId,
      parentSpanId,
      name,
      startTime: Date.now(),
      endTime: null,
      duration: null,
      status: 'started',
      tags: {},
      events: [],
      attributes: {}
    };

    this.activeSpans.set(spanId, span);

    return spanId;
  }

  /**
   * End a trace span
   */
  endSpan(spanId: string, status: string = 'completed', error?: Error) {
    const span = this.activeSpans.get(spanId);
    if (!span) {
      console.warn(`[Telemetry] Span not found: ${spanId}`);
      return;
    }

    span.endTime = Date.now();
    span.duration = span.endTime - span.startTime;
    span.status = status;

    if (error) {
      span.status = 'error';
      span.error = {
        message: error.message,
        stack: error.stack
      };
      this.incrementCounter('error_total', 1, {
        type: 'span',
        severity: 'error'
      });
    }

    // Store completed span
    this.traces.set(spanId, span);
    this.activeSpans.delete(spanId);

    // Record span duration as metric
    this.recordHistogram('business_operation_duration_ms', span.duration, {
      operation: span.name
    });

    return span;
  }

  /**
   * Add tag to span
   */
  addSpanTag(spanId: string, key: string, value: string) {
    const span = this.activeSpans.get(spanId);
    if (span) {
      span.tags[key] = value;
    }
  }

  /**
   * Add event to span
   */
  addSpanEvent(spanId: string, name: string, attributes?: Record<string, any>) {
    const span = this.activeSpans.get(spanId);
    if (span) {
      span.events.push({
        name,
        timestamp: Date.now(),
        attributes: attributes || {}
      });
    }
  }

  /**
   * Get trace ID from span ID
   */
  private getTraceId(spanId: string): string {
    const span = this.traces.get(spanId) || this.activeSpans.get(spanId);
    return span?.traceId || crypto.randomUUID();
  }

  /**
   * Get trace by ID
   */
  getTrace(traceId: string) {
    const spans = Array.from(this.traces.values()).filter(
      span => span.traceId === traceId
    );
    
    // Also include active spans
    const activeSpans = Array.from(this.activeSpans.values()).filter(
      span => span.traceId === traceId
    );

    return [...spans, ...activeSpans].sort((a, b) => a.startTime - b.startTime);
  }

  /**
   * Get metric data for Prometheus export
   */
  getMetricsForPrometheus(): string {
    const lines: string[] = [];

    for (const [name, metric] of this.metrics.entries()) {
      if (metric.type === 'counter' || metric.type === 'gauge') {
        const latest = metric.values?.[metric.values.length - 1];
        if (latest) {
          const labels = latest.labels 
            ? `{${Object.entries(latest.labels).map(([k, v]) => `${k}="${v}"`).join(',')}}`
            : '';
          lines.push(`${name}${labels} ${latest.value} ${latest.timestamp.getTime()}`);
        }
      } else if (metric.type === 'histogram') {
        // For histograms, we'd calculate bucket values
        // Simplified implementation
        const values = metric.values || [];
        if (values.length > 0) {
          const sum = values.reduce((acc: number, v: any) => acc + v.value, 0);
          const count = values.length;
          lines.push(`${name}_sum ${sum}`);
          lines.push(`${name}_count ${count}`);
        }
      }
    }

    return lines.join('\n');
  }

  /**
   * Get trace data for export
   */
  getTracesForExport(timeRange?: { start: Date; end: Date }) {
    let traces = Array.from(this.traces.values());

    if (timeRange) {
      traces = traces.filter(span => 
        span.startTime >= timeRange.start.getTime() && 
        span.startTime <= timeRange.end.getTime()
      );
    }

    return traces;
  }

  /**
   * Get telemetry statistics
   */
  getStatistics() {
    return {
      metrics: {
        total: this.metrics.size,
        byType: this.getMetricsByType()
      },
      traces: {
        total: this.traces.size,
        active: this.activeSpans.size,
        avgDuration: this.getAverageTraceDuration()
      },
      uptime: process.uptime(),
      memory: process.memoryUsage(),
      cpu: process.cpuUsage()
    };
  }

  /**
   * Get metrics by type
   */
  private getMetricsByType() {
    const byType: Record<string, number> = {};
    
    for (const metric of this.metrics.values()) {
      byType[metric.type] = (byType[metric.type] || 0) + 1;
    }

    return byType;
  }

  /**
   * Get average trace duration
   */
  private getAverageTraceDuration() {
    const traces = Array.from(this.traces.values());
    if (traces.length === 0) return 0;

    const totalDuration = traces.reduce((sum, span) => sum + (span.duration || 0), 0);
    return totalDuration / traces.length;
  }

  /**
   * Create a traced function wrapper
   */
  traceFunction<T extends (...args: any[]) => any>(
    name: string,
    fn: T
  ): T {
    return ((...args: any[]) => {
      const spanId = this.startSpan(name);
      
      try {
        const result = fn(...args);
        
        if (result instanceof Promise) {
          return result
            .then((res: any) => {
              this.endSpan(spanId, 'completed');
              return res;
            })
            .catch((error: Error) => {
              this.endSpan(spanId, 'error', error);
              throw error;
            });
        }
        
        this.endSpan(spanId, 'completed');
        return result;
      } catch (error) {
        this.endSpan(spanId, 'error', error as Error);
        throw error;
      }
    }) as T;
  }

  /**
   * Cleanup old data
   */
  cleanupOldData(retentionMs: number = 24 * 60 * 60 * 1000) {
    const cutoffTime = Date.now() - retentionMs;

    // Clean up old traces
    for (const [spanId, span] of this.traces.entries()) {
      if (span.startTime < cutoffTime) {
        this.traces.delete(spanId);
      }
    }

    // Clean up old metric values
    for (const metric of this.metrics.values()) {
      if (metric.values) {
        metric.values = metric.values.filter(
          (v: any) => v.timestamp.getTime() > cutoffTime
        );
      }
    }

    console.log('[Telemetry] Cleaned up old telemetry data');
  }
}

// Initialize telemetry service
const telemetryConfig: TraceConfig = {
  serviceName: 'reservatior-platform',
  serviceVersion: '1.0.0',
  environment: process.env.NODE_ENV || 'development',
  exporterUrl: process.env.OTEL_EXPORTER_URL,
  sampleRate: 1.0
};

export const telemetry = new TelemetryService(telemetryConfig);
