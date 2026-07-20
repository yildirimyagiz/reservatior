/**
 * Document OS Metrics Collection
 * Defines key performance indicators and metrics for document operations
 */

export interface DocumentOSMetrics {
  // Document Metrics
  totalDocuments: number;
  activeDocuments: number;
  archivedDocuments: number;
  documentGrowthRate: number;
  
  // Signature Metrics
  pendingSignatures: number;
  completedSignatures: number;
  signatureCompletionRate: number;
  averageSignatureTime: number;
  
  // Template Metrics
  totalTemplates: number;
  templateUsageRate: number;
  averageTemplateCreationTime: number;
  
  // Compliance Metrics
  complianceScore: number;
  compliantDocuments: number;
  nonCompliantDocuments: number;
  auditPassedRate: number;
  
  // Version Metrics
  averageVersionsPerDocument: number;
  versionRollbackRate: number;
  versionConflictRate: number;
  
  // Processing Metrics
  averageProcessingTime: number;
  processingSuccessRate: number;
  ocrAccuracy: number;
  
  // Storage Metrics
  totalStorageUsed: number;
  averageDocumentSize: number;
  storageGrowthRate: number;
  
  // Search Metrics
  searchSuccessRate: number;
  averageSearchTime: number;
  searchIndexHealth: number;
}

export interface DocumentOSMetricConfig {
  name: string;
  description: string;
  unit: string;
  category: 'document' | 'signature' | 'template' | 'compliance' | 'version' | 'processing' | 'storage' | 'search';
  aggregation: 'sum' | 'average' | 'rate' | 'count';
  dimensions: string[];
}

export const DocumentOSMetricDefinitions: Record<string, DocumentOSMetricConfig> = {
  // Document Metrics
  total_documents: {
    name: 'Total Documents',
    description: 'Total number of documents',
    unit: 'count',
    category: 'document',
    aggregation: 'count',
    dimensions: ['organization_id', 'document_type', 'status', 'time_period'],
  },
  active_documents: {
    name: 'Active Documents',
    description: 'Number of active documents',
    unit: 'count',
    category: 'document',
    aggregation: 'count',
    dimensions: ['organization_id', 'document_type', 'time_period'],
  },
  archived_documents: {
    name: 'Archived Documents',
    description: 'Number of archived documents',
    unit: 'count',
    category: 'document',
    aggregation: 'count',
    dimensions: ['organization_id', 'time_period'],
  },
  
  // Signature Metrics
  pending_signatures: {
    name: 'Pending Signatures',
    description: 'Number of pending signatures',
    unit: 'count',
    category: 'signature',
    aggregation: 'count',
    dimensions: ['organization_id', 'document_type', 'time_period'],
  },
  completed_signatures: {
    name: 'Completed Signatures',
    description: 'Number of completed signatures',
    unit: 'count',
    category: 'signature',
    aggregation: 'count',
    dimensions: ['organization_id', 'time_period'],
  },
  signature_completion_rate: {
    name: 'Signature Completion Rate',
    description: 'Percentage of signatures completed',
    unit: 'percentage',
    category: 'signature',
    aggregation: 'rate',
    dimensions: ['organization_id', 'time_period'],
  },
  average_signature_time: {
    name: 'Average Signature Time',
    description: 'Average time to complete signatures',
    unit: 'hours',
    category: 'signature',
    aggregation: 'average',
    dimensions: ['organization_id', 'document_type', 'time_period'],
  },
  
  // Template Metrics
  total_templates: {
    name: 'Total Templates',
    description: 'Total number of templates',
    unit: 'count',
    category: 'template',
    aggregation: 'count',
    dimensions: ['organization_id', 'template_type', 'time_period'],
  },
  template_usage_rate: {
    name: 'Template Usage Rate',
    description: 'Percentage of documents created from templates',
    unit: 'percentage',
    category: 'template',
    aggregation: 'rate',
    dimensions: ['organization_id', 'time_period'],
  },
  
  // Compliance Metrics
  compliance_score: {
    name: 'Compliance Score',
    description: 'Overall compliance score',
    unit: 'score',
    category: 'compliance',
    aggregation: 'average',
    dimensions: ['organization_id', 'compliance_framework', 'time_period'],
  },
  compliant_documents: {
    name: 'Compliant Documents',
    description: 'Number of compliant documents',
    unit: 'count',
    category: 'compliance',
    aggregation: 'count',
    dimensions: ['organization_id', 'time_period'],
  },
  audit_passed_rate: {
    name: 'Audit Passed Rate',
    description: 'Percentage of passed audits',
    unit: 'percentage',
    category: 'compliance',
    aggregation: 'rate',
    dimensions: ['organization_id', 'time_period'],
  },
  
  // Version Metrics
  average_versions_per_document: {
    name: 'Average Versions Per Document',
    description: 'Average number of versions per document',
    unit: 'count',
    category: 'version',
    aggregation: 'average',
    dimensions: ['organization_id', 'time_period'],
  },
  version_rollback_rate: {
    name: 'Version Rollback Rate',
    description: 'Percentage of version rollbacks',
    unit: 'percentage',
    category: 'version',
    aggregation: 'rate',
    dimensions: ['organization_id', 'time_period'],
  },
  
  // Processing Metrics
  average_processing_time: {
    name: 'Average Processing Time',
    description: 'Average time to process documents',
    unit: 'seconds',
    category: 'processing',
    aggregation: 'average',
    dimensions: ['organization_id', 'document_type', 'time_period'],
  },
  processing_success_rate: {
    name: 'Processing Success Rate',
    description: 'Percentage of successful processing',
    unit: 'percentage',
    category: 'processing',
    aggregation: 'rate',
    dimensions: ['organization_id', 'time_period'],
  },
  
  // Storage Metrics
  total_storage_used: {
    name: 'Total Storage Used',
    description: 'Total storage space used',
    unit: 'bytes',
    category: 'storage',
    aggregation: 'sum',
    dimensions: ['organization_id', 'time_period'],
  },
  average_document_size: {
    name: 'Average Document Size',
    description: 'Average size of documents',
    unit: 'bytes',
    category: 'storage',
    aggregation: 'average',
    dimensions: ['organization_id', 'document_type', 'time_period'],
  },
  
  // Search Metrics
  search_success_rate: {
    name: 'Search Success Rate',
    description: 'Percentage of successful searches',
    unit: 'percentage',
    category: 'search',
    aggregation: 'rate',
    dimensions: ['organization_id', 'time_period'],
  },
  average_search_time: {
    name: 'Average Search Time',
    description: 'Average time to complete searches',
    unit: 'milliseconds',
    category: 'search',
    aggregation: 'average',
    dimensions: ['organization_id', 'time_period'],
  },
};

/**
 * Metric collection helper
 */
export class DocumentOSMetricsCollector {
  private metrics: Map<string, number> = new Map();
  private dimensions: Map<string, Map<string, string>> = new Map();

  recordMetric(metricName: string, value: number, dimensions?: Record<string, string>): void {
    this.metrics.set(metricName, value);
    if (dimensions) {
      const metricDimensions = this.dimensions.get(metricName) || new Map();
      Object.entries(dimensions).forEach(([key, val]) => {
        metricDimensions.set(key, val);
      });
      this.dimensions.set(metricName, metricDimensions);
    }
  }

  getMetric(metricName: string): number | undefined {
    return this.metrics.get(metricName);
  }

  getMetricDimensions(metricName: string): Map<string, string> | undefined {
    return this.dimensions.get(metricName);
  }

  getAllMetrics(): Record<string, number> {
    return Object.fromEntries(this.metrics);
  }

  aggregateMetrics(metricNames: string[], aggregation: 'sum' | 'average' | 'rate'): number {
    const values = metricNames
      .map(name => this.metrics.get(name))
      .filter((val): val is number => val !== undefined);

    if (values.length === 0) return 0;

    switch (aggregation) {
      case 'sum':
        return values.reduce((a, b) => a + b, 0);
      case 'average':
        return values.reduce((a, b) => a + b, 0) / values.length;
      case 'rate':
        const total = values.reduce((a, b) => a + b, 0);
        return total / values.length;
      default:
        return 0;
    }
  }

  calculateSignatureCompletionRate(pendingSignatures: number, completedSignatures: number): number {
    const total = pendingSignatures + completedSignatures;
    if (total === 0) return 0;
    return (completedSignatures / total) * 100;
  }

  calculateComplianceScore(compliantDocuments: number, totalDocuments: number): number {
    if (totalDocuments === 0) return 0;
    return (compliantDocuments / totalDocuments) * 100;
  }

  reset(): void {
    this.metrics.clear();
    this.dimensions.clear();
  }
}
