import 'package:reservatior/shared/enums/compliance_type.dart';
import 'package:reservatior/shared/enums/document_type_usa.dart';
import 'analysis_job.dart';
import 'contract.dart';
import 'deal.dart';
import 'document_analysis.dart';
import 'listing.dart';
import 'organization.dart';
import 'property.dart';
import 'user.dart';

class Document {
  final String id;
  final String orgId;
  final String? dealId;
  final String? propertyId;
  final String? contractId;
  final String? userId;
  final String? listingId;
  final DocumentTypeUSA documentType;
  final String title;
  final String? description;
  final String fileUrl;
  final String fileName;
  final int fileSize;
  final String mimeType;
  final String checksum;
  final int version;
  final bool isRequired;
  final bool isSigned;
  final bool signatureRequired;
  final bool notarizationRequired;
  final bool recordingRequired;
  final DateTime? expiryDate;
  final ComplianceType? complianceType;
  final String? jurisdiction;
  final String? templateId;
  final List<String> tags;
  final String? analysisStatus;
  final DateTime? lastAnalyzedAt;
  final String? analysisJobId;
  final String? searchVector;
  final String? createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final Contract? contract;
  final Deal? deal;
  final Listing? listing;
  final Organization org;
  final Property? property;
  final User? user;
  final List<DocumentAnalysis> analyses;
  final List<AnalysisJob> analysisJobs;

  const Document({
    required this.id,
    required this.orgId,
    this.dealId,
    this.propertyId,
    this.contractId,
    this.userId,
    this.listingId,
    required this.documentType,
    required this.title,
    this.description,
    required this.fileUrl,
    required this.fileName,
    required this.fileSize,
    required this.mimeType,
    required this.checksum,
    required this.version,
    required this.isRequired,
    required this.isSigned,
    required this.signatureRequired,
    required this.notarizationRequired,
    required this.recordingRequired,
    this.expiryDate,
    this.complianceType,
    this.jurisdiction,
    this.templateId,
    this.tags = const [],
    this.analysisStatus,
    this.lastAnalyzedAt,
    this.analysisJobId,
    this.searchVector,
    this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.contract,
    this.deal,
    this.listing,
    required this.org,
    this.property,
    this.user,
    this.analyses = const [],
    this.analysisJobs = const [],
  });

  factory Document.fromJson(Map<String, dynamic> json) {
    return Document(
      id: json['id'] as String,
      orgId: json['orgId'] as String,
      dealId: json['dealId'] as String?,
      propertyId: json['propertyId'] as String?,
      contractId: json['contractId'] as String?,
      userId: json['userId'] as String?,
      listingId: json['listingId'] as String?,
      documentType: DocumentTypeUSA.values.firstWhere((v) => v.name == json['documentType']),
      title: json['title'] as String,
      description: json['description'] as String?,
      fileUrl: json['fileUrl'] as String,
      fileName: json['fileName'] as String,
      fileSize: json['fileSize'] as int,
      mimeType: json['mimeType'] as String,
      checksum: json['checksum'] as String,
      version: json['version'] as int,
      isRequired: json['isRequired'] as bool,
      isSigned: json['isSigned'] as bool,
      signatureRequired: json['signatureRequired'] as bool,
      notarizationRequired: json['notarizationRequired'] as bool,
      recordingRequired: json['recordingRequired'] as bool,
      expiryDate: json['expiryDate'] != null ? DateTime.parse(json['expiryDate'] as String) : null,
      complianceType: json['complianceType'] != null ? ComplianceType.values.firstWhere((v) => v.name == json['complianceType']) : null,
      jurisdiction: json['jurisdiction'] as String?,
      templateId: json['templateId'] as String?,
      tags: (json['tags'] as List<dynamic>?)?.cast<String>() ?? [],
      analysisStatus: json['analysisStatus'] as String?,
      lastAnalyzedAt: json['lastAnalyzedAt'] != null ? DateTime.parse(json['lastAnalyzedAt'] as String) : null,
      analysisJobId: json['analysisJobId'] as String?,
      searchVector: json['searchVector'] as String?,
      createdBy: json['createdBy'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      contract: json['contract'] != null ? Contract.fromJson(json['contract'] as Map<String, dynamic>) : null,
      deal: json['deal'] != null ? Deal.fromJson(json['deal'] as Map<String, dynamic>) : null,
      listing: json['listing'] != null ? Listing.fromJson(json['listing'] as Map<String, dynamic>) : null,
      org: Organization.fromJson(json['org'] as Map<String, dynamic>),
      property: json['property'] != null ? Property.fromJson(json['property'] as Map<String, dynamic>) : null,
      user: json['user'] != null ? User.fromJson(json['user'] as Map<String, dynamic>) : null,
      analyses: (json['analyses'] as List<dynamic>?)?.map((e) => DocumentAnalysis.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      analysisJobs: (json['analysisJobs'] as List<dynamic>?)?.map((e) => AnalysisJob.fromJson(e as Map<String, dynamic>)).toList() ?? [],
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
      'documentType': documentType.name,
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
      'searchVector': searchVector,
      'createdBy': createdBy,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'contract': contract?.toJson(),
      'deal': deal?.toJson(),
      'listing': listing?.toJson(),
      'org': org.toJson(),
      'property': property?.toJson(),
      'user': user?.toJson(),
      'analyses': analyses.map((e) => e.toJson()).toList(),
      'analysisJobs': analysisJobs.map((e) => e.toJson()).toList(),
    };
  }

  Document copyWith({
    String? id,
    String? orgId,
    String? dealId,
    String? propertyId,
    String? contractId,
    String? userId,
    String? listingId,
    DocumentTypeUSA? documentType,
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
    String? searchVector,
    String? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    Contract? contract,
    Deal? deal,
    Listing? listing,
    Organization? org,
    Property? property,
    User? user,
    List<DocumentAnalysis>? analyses,
    List<AnalysisJob>? analysisJobs,
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
      searchVector: searchVector ?? this.searchVector,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      contract: contract ?? this.contract,
      deal: deal ?? this.deal,
      listing: listing ?? this.listing,
      org: org ?? this.org,
      property: property ?? this.property,
      user: user ?? this.user,
      analyses: analyses ?? this.analyses,
      analysisJobs: analysisJobs ?? this.analysisJobs,
    );
  }
}
