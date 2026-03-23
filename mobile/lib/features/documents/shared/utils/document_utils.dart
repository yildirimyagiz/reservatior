import '../entities/document.dart';
import '../entities/document_analysis.dart';
import '../entities/document_template.dart';

// ── Document Utils
// Document işlemleri için yardımcı fonksiyonlar

class DocumentUtils {
  // File size formatting
  static String formatFileSize(int? bytes) {
    if (bytes == null) return 'Unknown';
    
    const units = ['B', 'KB', 'MB', 'GB'];
    int size = bytes;
    int unitIndex = 0;
    
    while (size >= 1024 && unitIndex < units.length - 1) {
      size /= 1024;
      unitIndex++;
    }
    
    return '${size.toStringAsFixed(1)} ${units[unitIndex]}';
  }

  // Date formatting
  static String formatDate(DateTime? date) {
    if (date == null) return 'Unknown';
    return '${date.day}/${date.month}/${date.year}';
  }

  static String formatDateTime(DateTime? date) {
    if (date == null) return 'Unknown';
    return '${formatDate(date)} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }

  // Document type display
  static String getDocumentTypeDisplayName(DocumentType? type) {
    switch (type) {
      case DocumentType.contract:
        return 'Contract';
      case DocumentType.lease:
        return 'Lease Agreement';
      case DocumentType.agreement:
        return 'Agreement';
      case DocumentType.identification:
        return 'Identification';
      case DocumentType.financial:
        return 'Financial Document';
      case DocumentType.property:
        return 'Property Document';
      case DocumentType.insurance:
        return 'Insurance';
      case DocumentType.tax:
        return 'Tax Document';
      case null:
        return 'Unknown';
      default:
        return 'Other';
    }
  }

  // Compliance type display
  static String getComplianceTypeDisplayName(ComplianceType? type) {
    switch (type) {
      case ComplianceType.federal:
        return 'Federal';
      case ComplianceType.state:
        return 'State';
      case ComplianceType.local:
        return 'Local';
      case ComplianceType.industry:
        return 'Industry';
      case ComplianceType.none:
        return 'None';
      case null:
        return 'Unknown';
    }
  }

  // Analysis status display
  static String getAnalysisStatusDisplayName(AnalysisStatus? status) {
    switch (status) {
      case AnalysisStatus.pending:
        return 'Pending';
      case AnalysisStatus.processing:
        return 'Processing';
      case AnalysisStatus.completed:
        return 'Completed';
      case AnalysisStatus.failed:
        return 'Failed';
      case null:
        return 'Unknown';
    }
  }

  // Template type display
  static String getTemplateTypeDisplayName(TemplateType? type) {
    switch (type) {
      case TemplateType.contract:
        return 'Contract';
      case TemplateType.lease:
        return 'Lease';
      case TemplateType.agreement:
        return 'Agreement';
      case TemplateType.form:
        return 'Form';
      case TemplateType.letter:
        return 'Letter';
      case TemplateType.notice:
        return 'Notice';
      case TemplateType.other:
        return 'Other';
      case null:
        return 'Unknown';
    }
  }

  // Template category display
  static String getTemplateCategoryDisplayName(TemplateCategory? category) {
    switch (category) {
      case TemplateCategory.legal:
        return 'Legal';
      case TemplateCategory.financial:
        return 'Financial';
      case TemplateCategory.property:
        return 'Property';
      case TemplateCategory.tenant:
        return 'Tenant';
      case TemplateCategory.landlord:
        return 'Landlord';
      case TemplateCategory.maintenance:
        return 'Maintenance';
      case TemplateCategory.other:
        return 'Other';
      case null:
        return 'Unknown';
    }
  }

  // Document validation
  static bool isValidDocument(Document document) {
    return document.title != null && 
           document.title!.isNotEmpty &&
           document.fileName != null && 
           document.fileName!.isNotEmpty;
  }

  // Template validation
  static bool isValidTemplate(DocumentTemplate template) {
    return template.name != null && 
           template.name!.isNotEmpty &&
           template.templateContent != null && 
           template.templateContent!.isNotEmpty;
  }

  // Analysis validation
  static bool isValidAnalysis(DocumentAnalysis analysis) {
    return analysis.documentId != null && 
           analysis.documentId!.isNotEmpty;
  }

  // Get file icon based on mime type
  static String getFileIcon(String? mimeType) {
    if (mimeType == null) return '📄';
    
    if (mimeType.startsWith('image/')) return '🖼️';
    if (mimeType.startsWith('video/')) return '🎥';
    if (mimeType.startsWith('audio/')) return '🎵';
    if (mimeType.contains('pdf')) return '📕';
    if (mimeType.contains('word')) return '📘';
    if (mimeType.contains('excel') || mimeType.contains('spreadsheet')) return '📗';
    if (mimeType.contains('powerpoint') || mimeType.contains('presentation')) return '📙';
    if (mimeType.contains('zip') || mimeType.contains('rar')) return '📦';
    if (mimeType.contains('text')) return '📝';
    
    return '📄';
  }

  // Check if document needs signature
  static bool needsSignature(Document document) {
    return document.signatureRequired == true && document.isSigned != true;
  }

  // Check if document is expired
  static bool isExpired(Document document) {
    if (document.expiryDate == null) return false;
    return DateTime.now().isAfter(document.expiryDate!);
  }

  // Get document status
  static DocumentStatus getDocumentStatus(Document document) {
    if (isExpired(document)) return DocumentStatus.expired;
    if (needsSignature(document)) return DocumentStatus.pendingSignature;
    if (document.isSigned == true) return DocumentStatus.signed;
    return DocumentStatus.active;
  }

  // Get document status color
  static String getDocumentStatusColor(DocumentStatus status) {
    switch (status) {
      case DocumentStatus.active:
        return 'green';
      case DocumentStatus.pendingSignature:
        return 'orange';
      case DocumentStatus.signed:
        return 'blue';
      case DocumentStatus.expired:
        return 'red';
    }
  }
}

// Document status enum
enum DocumentStatus {
  active,
  pendingSignature,
  signed,
  expired,
}
