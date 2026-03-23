import 'document_analysis.dart';
import 'document_template.dart';

// ── Document Entity
// Ana document entity'si - tüm document işlemleri için merkezi nokta

class Document {
  final String? id;
  final String? orgId;
  final String? dealId;
  final String? propertyId;
  final String? contractId;
  final String? userId;
  final String? listingId;
  final DocumentType? documentType;
  final String? title;
  final String? description;
  final String? fileUrl;
  final String? fileName;
  final int? fileSize;
  final String? mimeType;
  final String? checksum;
  final int? version;
  final bool? isRequired;
  final bool? isSigned;
  final bool? signatureRequired;
  final bool? notarizationRequired;
  final bool? recordingRequired;
  final DateTime? expiryDate;
  final ComplianceType? complianceType;
  final String? jurisdiction;
  final String? templateId;
  final List<String>? tags;
  final String? analysisStatus;
  final DateTime? lastAnalyzedAt;
  final String? analysisJobId;
  final dynamic duplicates;
  final String? searchVector;
  final String? createdBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;
  
  // Relations
  final DocumentTemplate? template;
  final List<DocumentAnalysis>? analyses;

  const Document({
    this.id,
    this.orgId,
    this.dealId,
    this.propertyId,
    this.contractId,
    this.userId,
    this.listingId,
    this.documentType,
    this.title,
    this.description,
    this.fileUrl,
    this.fileName,
    this.fileSize,
    this.mimeType,
    this.checksum,
    this.version,
    this.isRequired,
    this.isSigned,
    this.signatureRequired,
    this.notarizationRequired,
    this.recordingRequired,
    this.expiryDate,
    this.complianceType,
    this.jurisdiction,
    this.templateId,
    this.tags,
    this.analysisStatus,
    this.lastAnalyzedAt,
    this.analysisJobId,
    this.duplicates,
    this.searchVector,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.template,
    this.analyses,
  });

  Document copyWith({
    String? id,
    String? orgId,
    String? dealId,
    String? propertyId,
    String? contractId,
    String? userId,
    String? listingId,
    DocumentType? documentType,
    String? title,
    String? description,
    String? fileUrl,
    String? fileName,
    int? fileSize,
    String? mimeType,
    String? checksum,
    int? version,
    bool? isRequired,
    bool? isSigned,
    bool? signatureRequired,
    bool? notarizationRequired,
    bool? recordingRequired,
    DateTime? expiryDate,
    ComplianceType? complianceType,
    String? jurisdiction,
    String? templateId,
    List<String>? tags,
    String? analysisStatus,
    DateTime? lastAnalyzedAt,
    String? analysisJobId,
    dynamic duplicates,
    String? searchVector,
    String? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    DocumentTemplate? template,
    List<DocumentAnalysis>? analyses,
  }) {
    return Document(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      dealId: dealId ?? this.dealId,
      propertyId: propertyId ?? this.propertyId,
      contractId: contractId ?? this.contractId,
      userId: userId ?? this.userId,
      listingId: listingId ?? this.listingId,
      documentType: documentType ?? this.documentType,
      title: title ?? this.title,
      description: description ?? this.description,
      fileUrl: fileUrl ?? this.fileUrl,
      fileName: fileName ?? this.fileName,
      fileSize: fileSize ?? this.fileSize,
      mimeType: mimeType ?? this.mimeType,
      checksum: checksum ?? this.checksum,
      version: version ?? this.version,
      isRequired: isRequired ?? this.isRequired,
      isSigned: isSigned ?? this.isSigned,
      signatureRequired: signatureRequired ?? this.signatureRequired,
      notarizationRequired: notarizationRequired ?? this.notarizationRequired,
      recordingRequired: recordingRequired ?? this.recordingRequired,
      expiryDate: expiryDate ?? this.expiryDate,
      complianceType: complianceType ?? this.complianceType,
      jurisdiction: jurisdiction ?? this.jurisdiction,
      templateId: templateId ?? this.templateId,
      tags: tags ?? this.tags,
      analysisStatus: analysisStatus ?? this.analysisStatus,
      lastAnalyzedAt: lastAnalyzedAt ?? this.lastAnalyzedAt,
      analysisJobId: analysisJobId ?? this.analysisJobId,
      duplicates: duplicates ?? this.duplicates,
      searchVector: searchVector ?? this.searchVector,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      template: template ?? this.template,
      analyses: analyses ?? this.analyses,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Document && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'Document(id: $id, title: $title, fileName: $fileName)';
  }
}

// Enums
enum DocumentType {
  contract,
  lease,
  agreement,
  identification,
  financial,
  property,
  insurance,
  tax,
  other,
}

enum ComplianceType {
  federal,
  state,
  local,
  industry,
  none,
}

enum AnalysisStatus {
  pending,
  processing,
  completed,
  failed,
}
