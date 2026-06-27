import 'organization.dart';

class VendorProfile {
  final String id;
  final String orgId;
  final String? legalName;
  final String? serviceAreas;
  final int? defaultCommissionBps;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final Organization org;

  const VendorProfile({
    required this.id,
    required this.orgId,
    this.legalName,
    this.serviceAreas,
    this.defaultCommissionBps,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.org,
  });

  factory VendorProfile.fromJson(Map<String, dynamic> json) {
    return VendorProfile(
      id: json['id'] as String,
      orgId: json['orgId'] as String,
      legalName: json['legalName'] as String?,
      serviceAreas: json['serviceAreas'] as String?,
      defaultCommissionBps: json['defaultCommissionBps'] as int?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      org: Organization.fromJson(json['org'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'legalName': legalName,
      'serviceAreas': serviceAreas,
      'defaultCommissionBps': defaultCommissionBps,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'org': org.toJson(),
    };
  }

  VendorProfile copyWith({
    String? id,
    String? orgId,
    String? legalName,
    String? serviceAreas,
    int? defaultCommissionBps,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    Organization? org,
  }) {
    return VendorProfile(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      legalName: legalName ?? this.legalName,
      serviceAreas: serviceAreas ?? this.serviceAreas,
      defaultCommissionBps: defaultCommissionBps ?? this.defaultCommissionBps,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      org: org ?? this.org,
    );
  }
}
