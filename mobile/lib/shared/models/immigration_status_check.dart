import 'contact.dart';
import 'lease.dart';
import 'organization.dart';

class ImmigrationStatusCheck {
  final String id;
  final String orgId;
  final String leaseId;
  final String tenantId;
  final String checkStatus;
  final DateTime? checkDate;
  final DateTime? validUntil;
  final String? immigrationStatus;
  final String? visaType;
  final DateTime? visaExpiry;
  final String? documentType;
  final String? documentNumber;
  final bool documentVerified;
  final String? shareCode;
  final String? checkReference;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Lease lease;
  final Organization org;
  final Contact tenant;

  const ImmigrationStatusCheck({
    required this.id,
    required this.orgId,
    required this.leaseId,
    required this.tenantId,
    required this.checkStatus,
    this.checkDate,
    this.validUntil,
    this.immigrationStatus,
    this.visaType,
    this.visaExpiry,
    this.documentType,
    this.documentNumber,
    required this.documentVerified,
    this.shareCode,
    this.checkReference,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
    required this.lease,
    required this.org,
    required this.tenant,
  });

  factory ImmigrationStatusCheck.fromJson(Map<String, dynamic> json) {
    return ImmigrationStatusCheck(
      id: json['id'] as String,
      orgId: json['orgId'] as String,
      leaseId: json['leaseId'] as String,
      tenantId: json['tenantId'] as String,
      checkStatus: json['checkStatus'] as String,
      checkDate: json['checkDate'] != null ? DateTime.parse(json['checkDate'] as String) : null,
      validUntil: json['validUntil'] != null ? DateTime.parse(json['validUntil'] as String) : null,
      immigrationStatus: json['immigrationStatus'] as String?,
      visaType: json['visaType'] as String?,
      visaExpiry: json['visaExpiry'] != null ? DateTime.parse(json['visaExpiry'] as String) : null,
      documentType: json['documentType'] as String?,
      documentNumber: json['documentNumber'] as String?,
      documentVerified: json['documentVerified'] as bool,
      shareCode: json['shareCode'] as String?,
      checkReference: json['checkReference'] as String?,
      notes: json['notes'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      lease: Lease.fromJson(json['lease'] as Map<String, dynamic>),
      org: Organization.fromJson(json['org'] as Map<String, dynamic>),
      tenant: Contact.fromJson(json['tenant'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'leaseId': leaseId,
      'tenantId': tenantId,
      'checkStatus': checkStatus,
      'checkDate': checkDate?.toIso8601String(),
      'validUntil': validUntil?.toIso8601String(),
      'immigrationStatus': immigrationStatus,
      'visaType': visaType,
      'visaExpiry': visaExpiry?.toIso8601String(),
      'documentType': documentType,
      'documentNumber': documentNumber,
      'documentVerified': documentVerified,
      'shareCode': shareCode,
      'checkReference': checkReference,
      'notes': notes,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'lease': lease.toJson(),
      'org': org.toJson(),
      'tenant': tenant.toJson(),
    };
  }

  ImmigrationStatusCheck copyWith({
    String? id,
    String? orgId,
    String? leaseId,
    String? tenantId,
    String? checkStatus,
    DateTime? checkDate,
    DateTime? validUntil,
    String? immigrationStatus,
    String? visaType,
    DateTime? visaExpiry,
    String? documentType,
    String? documentNumber,
    bool? documentVerified,
    String? shareCode,
    String? checkReference,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
    Lease? lease,
    Organization? org,
    Contact? tenant,
  }) {
    return ImmigrationStatusCheck(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      leaseId: leaseId ?? this.leaseId,
      tenantId: tenantId ?? this.tenantId,
      checkStatus: checkStatus ?? this.checkStatus,
      checkDate: checkDate ?? this.checkDate,
      validUntil: validUntil ?? this.validUntil,
      immigrationStatus: immigrationStatus ?? this.immigrationStatus,
      visaType: visaType ?? this.visaType,
      visaExpiry: visaExpiry ?? this.visaExpiry,
      documentType: documentType ?? this.documentType,
      documentNumber: documentNumber ?? this.documentNumber,
      documentVerified: documentVerified ?? this.documentVerified,
      shareCode: shareCode ?? this.shareCode,
      checkReference: checkReference ?? this.checkReference,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      lease: lease ?? this.lease,
      org: org ?? this.org,
      tenant: tenant ?? this.tenant,
    );
  }
}
