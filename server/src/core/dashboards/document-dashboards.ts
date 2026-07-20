/**
 * Document OS Dashboard Configurations
 */

import { platformIntelligence, DashboardConfig } from '../platform-intelligence';

export const documentDashboards: DashboardConfig[] = [
  {
    id: 'document-overview',
    name: 'Document Overview',
    description: 'Overview of document management metrics',
    osModule: 'DocumentOS',
    refreshInterval: 300000,
    widgets: [
      {
        type: 'metric',
        title: 'Total Documents',
        metricName: 'documents.total',
        config: { format: 'number' },
        position: { x: 0, y: 0, w: 3, h: 2 }
      },
      {
        type: 'metric',
        title: 'Pending Approval',
        metricName: 'documents.pending_approval',
        config: { format: 'number' },
        position: { x: 3, y: 0, w: 3, h: 2 }
      },
      {
        type: 'metric',
        title: 'Signed Documents',
        metricName: 'documents.signed',
        config: { format: 'number' },
        position: { x: 6, y: 0, w: 3, h: 2 }
      },
      {
        type: 'metric',
        title: 'Processing Documents',
        metricName: 'documents.processing',
        config: { format: 'number' },
        position: { x: 9, y: 0, w: 3, h: 2 }
      },
      {
        type: 'chart',
        title: 'Document Uploads Trend',
        metricName: 'documents.uploads_trend',
        config: { chartType: 'line', timeRange: '30d' },
        position: { x: 0, y: 2, w: 6, h: 4 }
      },
      {
        type: 'chart',
        title: 'Documents by Type',
        metricName: 'documents.by_type',
        config: { chartType: 'pie' },
        position: { x: 6, y: 2, w: 6, h: 4 }
      },
      {
        type: 'table',
        title: 'Recent Documents',
        metricName: 'documents.recent',
        config: { columns: ['title', 'type', 'status', 'uploaded_by', 'created_at'] },
        position: { x: 0, y: 6, w: 12, h: 4 }
      }
    ]
  },
  {
    id: 'document-processing',
    name: 'Document Processing',
    description: 'OCR and AI processing metrics',
    osModule: 'DocumentOS',
    refreshInterval: 300000,
    widgets: [
      {
        type: 'metric',
        title: 'OCR Success Rate',
        metricName: 'documents.ocr_success_rate',
        config: { format: 'percentage' },
        position: { x: 0, y: 0, w: 4, h: 2 }
      },
      {
        type: 'metric',
        title: 'AI Classification Accuracy',
        metricName: 'documents.ai_classification_accuracy',
        config: { format: 'percentage' },
        position: { x: 4, y: 0, w: 4, h: 2 }
      },
      {
        type: 'metric',
        title: 'Average Processing Time',
        metricName: 'documents.avg_processing_time',
        config: { format: 'duration' },
        position: { x: 8, y: 0, w: 4, h: 2 }
      },
      {
        type: 'chart',
        title: 'Processing Queue Size',
        metricName: 'documents.queue_size',
        config: { chartType: 'gauge' },
        position: { x: 0, y: 2, w: 4, h: 4 }
      },
      {
        type: 'chart',
        title: 'Processing Time Trend',
        metricName: 'documents.processing_time_trend',
        config: { chartType: 'line' },
        position: { x: 4, y: 2, w: 4, h: 4 }
      },
      {
        type: 'chart',
        title: 'AI Features Usage',
        metricName: 'documents.ai_features_usage',
        config: { chartType: 'bar' },
        position: { x: 8, y: 2, w: 4, h: 4 }
      },
      {
        type: 'table',
        title: 'Processing Errors',
        metricName: 'documents.processing_errors',
        config: { columns: ['document_id', 'error_type', 'error_message', 'timestamp'] },
        position: { x: 0, y: 6, w: 12, h: 4 }
      }
    ]
  },
  {
    id: 'document-signatures',
    name: 'Document Signatures',
    description: 'Digital signature workflow metrics',
    osModule: 'DocumentOS',
    refreshInterval: 300000,
    widgets: [
      {
        type: 'metric',
        title: 'Pending Signatures',
        metricName: 'signatures.pending',
        config: { format: 'number' },
        position: { x: 0, y: 0, w: 3, h: 2 }
      },
      {
        type: 'metric',
        title: 'Completed Signatures',
        metricName: 'signatures.completed',
        config: { format: 'number' },
        position: { x: 3, y: 0, w: 3, h: 2 }
      },
      {
        type: 'metric',
        title: 'Signature Success Rate',
        metricName: 'signatures.success_rate',
        config: { format: 'percentage' },
        position: { x: 6, y: 0, w: 3, h: 2 }
      },
      {
        type: 'metric',
        title: 'Average Time to Sign',
        metricName: 'signatures.avg_time_to_sign',
        config: { format: 'duration' },
        position: { x: 9, y: 0, w: 3, h: 2 }
      },
      {
        type: 'chart',
        title: 'Signature Requests Trend',
        metricName: 'signatures.requests_trend',
        config: { chartType: 'line', timeRange: '30d' },
        position: { x: 0, y: 2, w: 6, h: 4 }
      },
      {
        type: 'chart',
        title: 'Signature Completion Rate',
        metricName: 'signatures.completion_rate',
        config: { chartType: 'area' },
        position: { x: 6, y: 2, w: 6, h: 4 }
      },
      {
        type: 'table',
        title: 'Pending Signature Requests',
        metricName: 'signatures.pending_requests',
        config: { columns: ['document_id', 'signer', 'sent_at', 'expires_at'] },
        position: { x: 0, y: 6, w: 12, h: 4 }
      }
    ]
  },
  {
    id: 'document-storage',
    name: 'Document Storage',
    description: 'Storage usage and capacity metrics',
    osModule: 'DocumentOS',
    refreshInterval: 600000,
    widgets: [
      {
        type: 'metric',
        title: 'Total Storage Used',
        metricName: 'storage.total_used',
        config: { format: 'bytes' },
        position: { x: 0, y: 0, w: 4, h: 2 }
      },
      {
        type: 'metric',
        title: 'Storage Capacity',
        metricName: 'storage.capacity',
        config: { format: 'bytes' },
        position: { x: 4, y: 0, w: 4, h: 2 }
      },
      {
        type: 'metric',
        title: 'Storage Utilization',
        metricName: 'storage.utilization',
        config: { format: 'percentage' },
        position: { x: 8, y: 0, w: 4, h: 2 }
      },
      {
        type: 'gauge',
        title: 'Storage Usage',
        metricName: 'storage.usage_gauge',
        config: { min: 0, max: 100, unit: '%' },
        position: { x: 0, y: 2, w: 4, h: 4 }
      },
      {
        type: 'chart',
        title: 'Storage Growth Trend',
        metricName: 'storage.growth_trend',
        config: { chartType: 'line', timeRange: '90d' },
        position: { x: 4, y: 2, w: 4, h: 4 }
      },
      {
        type: 'chart',
        title: 'Storage by Document Type',
        metricName: 'storage.by_type',
        config: { chartType: 'pie' },
        position: { x: 8, y: 2, w: 4, h: 4 }
      },
      {
        type: 'table',
        title: 'Largest Documents',
        metricName: 'storage.largest_documents',
        config: { columns: ['document_id', 'title', 'size', 'type', 'created_at'] },
        position: { x: 0, y: 6, w: 12, h: 4 }
      }
    ]
  }
];

/**
 * Register Document OS dashboards
 */
export function registerDocumentDashboards() {
  documentDashboards.forEach(dashboard => {
    platformIntelligence.registerDashboard(dashboard);
  });
  console.log(`[DocumentOS] Registered ${documentDashboards.length} dashboards`);
}
