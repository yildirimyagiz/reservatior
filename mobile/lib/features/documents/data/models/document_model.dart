import '../../domain/entities/document.dart';

// ── Document Model
// Document entity'si için data model

class DocumentModel {
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

  const DocumentModel({
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
  });

  factory DocumentModel.fromJson(Map<String, dynamic> json) {
    return DocumentModel(
      id: json['id'] as String?,
      orgId: json['orgId'] as String?,
      dealId: json['dealId'] as String?,
      propertyId: json['propertyId'] as String?,
      contractId: json['contractId'] as String?,
      userId: json['userId'] as String?,
      listingId: json['listingId'] as String?,
      documentType: _parseDocumentType(json['documentType']),
      title: json['title'] as String?,
      description: json['description'] as String?,
      fileUrl: json['fileUrl'] as String?,
      fileName: json['fileName'] as String?,
      fileSize: json['fileSize'] as int?,
      mimeType: json['mimeType'] as String?,
      checksum: json['checksum'] as String?,
      version: json['version'] as int?,
      isRequired: json['isRequired'] as bool?,
      isSigned: json['isSigned'] as bool?,
      signatureRequired: json['signatureRequired'] as bool?,
      notarizationRequired: json['notarizationRequired'] as bool?,
      recordingRequired: json['recordingRequired'] as bool?,
      expiryDate: json['expiryDate'] != null 
          ? DateTime.parse(json['expiryDate'] as String) 
          : null,
      complianceType: _parseComplianceType(json['complianceType']),
      jurisdiction: json['jurisdiction'] as String?,
      templateId: json['templateId'] as String?,
      tags: (json['tags'] as List<dynamic>?)?.cast<String>(),
      analysisStatus: json['analysisStatus'] as String?,
      lastAnalyzedAt: json['lastAnalyzedAt'] != null 
          ? DateTime.parse(json['lastAnalyzedAt'] as String) 
          : null,
      analysisJobId: json['analysisJobId'] as String?,
      duplicates: json['duplicates'],
      searchVector: json['searchVector'] as String?,
      createdBy: json['createdBy'] as String?,
      createdAt: json['createdAt'] != null 
          ? DateTime.parse(json['createdAt'] as String) 
          : null,
      updatedAt: json['updatedAt'] != null 
          ? DateTime.parse(json['updatedAt'] as String) 
          : null,
      deletedAt: json['deletedAt'] != null 
          ? DateTime.parse(json['deletedAt'] as String) 
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'dealId': dealId,
      'propertyId': propertyId,
      'contractId': contractId,
      'userId': userId,
      'listingId': listingId,
      'documentType': documentType?.name,
      'title': title,
      'description': description,
      'fileUrl': fileUrl,
      'fileName': fileName,
      'fileSize': fileSize,
      'mimeType': mimeType,
      'checksum': checksum,
      'version': version,
      'isRequired': isRequired,
      'isSigned': isSigned,
      'signatureRequired': signatureRequired,
      'notarizationRequired': notarizationRequired,
      'recordingRequired': recordingRequired,
      'expiryDate': expiryDate?.toIso8601String(),
      'complianceType': complianceType?.name,
      'jurisdiction': jurisdiction,
      'templateId': templateId,
      'tags': tags,
      'analysisStatus': analysisStatus,
      'lastAnalyzedAt': lastAnalyzedAt?.toIso8601String(),
      'analysisJobId': analysisJobId,
      'duplicates': duplicates,
      'searchVector': searchVector,
      'createdBy': createdBy,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
    };
  }

  DocumentModel copyWith({
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
  }) {
    return DocumentModel(
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
    );
  }

  static DocumentType? _parseDocumentType(String? type) {
    if (type == null) return null;
    try {
      return DocumentType.values.firstWhere((e) => e.name == type);
    } catch (e) {
      return null;
    }
  }

  static ComplianceType? _parseComplianceType(String? type) {
    if (type == null) return null;
    try {
      return ComplianceType.values.firstWhere((e) => e.name == type);
    } catch (e) {
      return null;
    }
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is DocumentModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'DocumentModel(id: $id, title: $title, fileName: $fileName)';
  }
}
