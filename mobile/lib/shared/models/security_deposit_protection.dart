import 'lease.dart';
import 'organization.dart';

class SecurityDepositProtection {
  final String id;
  final String orgId;
  final String leaseId;
  final String schemeProvider;
  final String schemeReference;
  final double depositAmount;
  final String currency;
  final String protectionStatus;
  final DateTime? protectedDate;
  final DateTime? releasedDate;
  final String? disputeStatus;
  final String? disputeReason;
  final String? disputeResolution;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Lease lease;
  final Organization org;

  const SecurityDepositProtection({
    required this.id,
    required this.orgId,
    required this.leaseId,
    required this.schemeProvider,
    required this.schemeReference,
    required this.depositAmount,
    required this.currency,
    required this.protectionStatus,
    this.protectedDate,
    this.releasedDate,
    this.disputeStatus,
    this.disputeReason,
    this.disputeResolution,
    required this.createdAt,
    required this.updatedAt,
    required this.lease,
    required this.org,
  });

  factory SecurityDepositProtection.fromJson(Map<String, dynamic> json) {
    return SecurityDepositProtection(
      id: json['id'] as String,
      orgId: json['orgId'] as String,
      leaseId: json['leaseId'] as String,
      schemeProvider: json['schemeProvider'] as String,
      schemeReference: json['schemeReference'] as String,
      depositAmount: (json['depositAmount'] as num).toDouble(),
      currency: json['currency'] as String,
      protectionStatus: json['protectionStatus'] as String,
      protectedDate: json['protectedDate'] != null ? DateTime.parse(json['protectedDate'] as String) : null,
      releasedDate: json['releasedDate'] != null ? DateTime.parse(json['releasedDate'] as String) : null,
      disputeStatus: json['disputeStatus'] as String?,
      disputeReason: json['disputeReason'] as String?,
      disputeResolution: json['disputeResolution'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      lease: Lease.fromJson(json['lease'] as Map<String, dynamic>),
      org: Organization.fromJson(json['org'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'leaseId': leaseId,
      'schemeProvider': schemeProvider,
      'schemeReference': schemeReference,
      'depositAmount': depositAmount,
      'currency': currency,
      'protectionStatus': protectionStatus,
      'protectedDate': protectedDate?.toIso8601String(),
      'releasedDate': releasedDate?.toIso8601String(),
      'disputeStatus': disputeStatus,
      'disputeReason': disputeReason,
      'disputeResolution': disputeResolution,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'lease': lease.toJson(),
      'org': org.toJson(),
    };
  }

  SecurityDepositProtection copyWith({
    String? id,
    String? orgId,
    String? leaseId,
    String? schemeProvider,
    String? schemeReference,
    double? depositAmount,
    String? currency,
    String? protectionStatus,
    DateTime? protectedDate,
    DateTime? releasedDate,
    String? disputeStatus,
    String? disputeReason,
    String? disputeResolution,
    DateTime? createdAt,
    DateTime? updatedAt,
    Lease? lease,
    Organization? org,
  }) {
    return SecurityDepositProtection(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      leaseId: leaseId ?? this.leaseId,
      schemeProvider: schemeProvider ?? this.schemeProvider,
      schemeReference: schemeReference ?? this.schemeReference,
      depositAmount: depositAmount ?? this.depositAmount,
      currency: currency ?? this.currency,
      protectionStatus: protectionStatus ?? this.protectionStatus,
      protectedDate: protectedDate ?? this.protectedDate,
      releasedDate: releasedDate ?? this.releasedDate,
      disputeStatus: disputeStatus ?? this.disputeStatus,
      disputeReason: disputeReason ?? this.disputeReason,
      disputeResolution: disputeResolution ?? this.disputeResolution,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      lease: lease ?? this.lease,
      org: org ?? this.org,
    );
  }
}
