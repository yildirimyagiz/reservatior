/**
 * Analytics OS API Contract
 * Defines the API interface for Analytics OS operations
 */

export interface AnalyticsOSAPIContract {
  // Query Operations
  createQuery(params: CreateQueryParams): Promise<QueryResponse>;
  getQuery(queryId: string): Promise<QueryResponse>;
  updateQuery(queryId: string, params: UpdateQueryParams): Promise<QueryResponse>;
  deleteQuery(queryId: string): Promise<void>;
  executeQuery(queryId: string): Promise<QueryExecutionResponse>;
  scheduleQuery(queryId: string, schedule: ScheduleParams): Promise<void>;
  
  // Dashboard Operations
  createDashboard(params: CreateDashboardParams): Promise<DashboardResponse>;
  getDashboard(dashboardId: string): Promise<DashboardResponse>;
  updateDashboard(dashboardId: string, params: UpdateDashboardParams): Promise<DashboardResponse>;
  deleteDashboard(dashboardId: string): Promise<void>;
  shareDashboard(dashboardId: string, shareParams: ShareParams): Promise<void>;
  publishDashboard(dashboardId: string): Promise<DashboardResponse>;
  
  // Metric Operations
  recordMetric(params: RecordMetricParams): Promise<MetricResponse>;
  getMetrics(params: MetricsParams): Promise<MetricResponse[]>;
  createMetric(params: CreateMetricParams): Promise<MetricResponse>;
  updateMetric(metricId: string, params: UpdateMetricParams): Promise<MetricResponse>;
  deleteMetric(metricId: string): Promise<void>;
  
  // Report Operations
  createReport(params: CreateReportParams): Promise<ReportResponse>;
  getReport(reportId: string): Promise<ReportResponse>;
  updateReport(reportId: string, params: UpdateReportParams): Promise<ReportResponse>;
  deleteReport(reportId: string): Promise<void>;
  scheduleReport(reportId: string, schedule: ScheduleParams): Promise<void>;
  exportReport(reportId: string, format: 'pdf' | 'excel' | 'csv'): Promise<ExportResponse>;
  
  // Insight Operations
  generateInsights(params: InsightParams): Promise<InsightResponse>;
  getInsights(params: InsightParams): Promise<InsightResponse[]>;
  
  // Data Operations
  accessData(params: DataAccessParams): Promise<DataResponse>;
  exportData(params: ExportDataParams): Promise<ExportResponse>;
  importData(params: ImportDataParams): Promise<ImportResponse>;
  
  // Advanced Analytics
  runPredictiveModel(params: PredictiveModelParams): Promise<PredictiveResponse>;
  runMLModel(params: MLModelParams): Promise<MLResponse>;
}

// Request/Response Types
export interface CreateQueryParams {
  name: string;
  query: string;
  dataSource: string;
  organizationId: string;
  createdBy: string;
  parameters?: Record<string, any>;
}

export interface UpdateQueryParams {
  name?: string;
  query?: string;
  parameters?: Record<string, any>;
}

export interface QueryResponse {
  id: string;
  name: string;
  query: string;
  dataSource: string;
  organizationId: string;
  createdBy: string;
  createdAt: string;
  updatedAt: string;
  status: 'active' | 'inactive';
}

export interface QueryExecutionResponse {
  queryId: string;
  executionId: string;
  status: 'running' | 'completed' | 'failed';
  results?: any[];
  rowCount?: number;
  executionTime?: number;
  error?: string;
}

export interface ScheduleParams {
  frequency: 'once' | 'hourly' | 'daily' | 'weekly' | 'monthly';
  startDate: string;
  endDate?: string;
  timezone?: string;
}

export interface CreateDashboardParams {
  name: string;
  description?: string;
  widgets: Widget[];
  organizationId: string;
  createdBy: string;
}

export interface UpdateDashboardParams {
  name?: string;
  description?: string;
  widgets?: Widget[];
}

export interface Widget {
  id: string;
  type: 'chart' | 'metric' | 'table' | 'text';
  queryId?: string;
  metricId?: string;
  position: { x: number; y: number; w: number; h: number };
  config?: Record<string, any>;
}

export interface DashboardResponse {
  id: string;
  name: string;
  description?: string;
  widgets: Widget[];
  organizationId: string;
  createdBy: string;
  createdAt: string;
  updatedAt: string;
  isPublished: boolean;
}

export interface ShareParams {
  shareWith: string[];
  permission: 'view' | 'edit';
}

export interface RecordMetricParams {
  metricName: string;
  value: number;
  dimensions?: Record<string, string>;
  timestamp?: string;
}

export interface MetricResponse {
  id: string;
  name: string;
  value: number;
  dimensions: Record<string, string>;
  timestamp: string;
}

export interface MetricsParams {
  metricNames?: string[];
  timeRange?: { start: string; end: string };
  dimensions?: Record<string, string>;
}

export interface CreateMetricParams {
  name: string;
  description?: string;
  unit: string;
  aggregation: 'sum' | 'average' | 'count' | 'rate';
}

export interface UpdateMetricParams {
  name?: string;
  description?: string;
  unit?: string;
}

export interface CreateReportParams {
  name: string;
  queryId: string;
  format: 'pdf' | 'excel' | 'csv';
  organizationId: string;
  createdBy: string;
}

export interface UpdateReportParams {
  name?: string;
  queryId?: string;
  format?: string;
}

export interface ReportResponse {
  id: string;
  name: string;
  queryId: string;
  format: string;
  organizationId: string;
  createdBy: string;
  createdAt: string;
  updatedAt: string;
  status: 'draft' | 'ready' | 'generating';
}

export interface ExportResponse {
  exportId: string;
  status: 'processing' | 'completed' | 'failed';
  downloadUrl?: string;
  format: string;
  expiresAt?: string;
}

export interface InsightParams {
  metrics: string[];
  timeRange: { start: string; end: string };
  context?: string;
}

export interface InsightResponse {
  id: string;
  type: string;
  title: string;
  description: string;
  impact: 'positive' | 'negative' | 'neutral';
  confidence: number;
  generatedAt: string;
}

export interface DataAccessParams {
  dataSource: string;
  query?: string;
  limit?: number;
}

export interface DataResponse {
  data: any[];
  rowCount: number;
  columns: string[];
}

export interface ExportDataParams {
  queryId: string;
  format: 'csv' | 'json' | 'excel';
}

export interface ImportDataParams {
  file: File;
  format: string;
  targetTable: string;
}

export interface ImportResponse {
  importId: string;
  status: 'processing' | 'completed' | 'failed';
  recordCount?: number;
  errors?: string[];
}

export interface PredictiveModelParams {
  modelType: string;
  inputData: any[];
  forecastPeriod: number;
}

export interface PredictiveResponse {
  modelId: string;
  forecast: Array<{
    period: string;
    predicted: number;
    confidence: number;
  }>;
  accuracy: number;
}

export interface MLModelParams {
  modelType: string;
  trainingData: any[];
  features: string[];
  target: string;
}

export interface MLResponse {
  modelId: string;
  accuracy: number;
  featureImportance: Array<{
    feature: string;
    importance: number;
  }>;
  predictions?: any[];
}
