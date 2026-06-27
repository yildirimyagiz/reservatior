import 'lease.dart';
import 'organization.dart';

class DepositProtection {
  final String id;
  final String orgId;
  final String leaseId;
  final String provider;
  final String scheme;
  final String reference;
  final double amount;
  final String currency;
  final String status;
  final DateTime? protectedAt;
  final DateTime? claimedAt;
  final DateTime? returnedAt;
  final String? createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final Lease lease;
  final Organization org;

  const DepositProtection({
    required this.id,
    required this.orgId,
    required this.leaseId,
    required this.provider,
    required this.scheme,
    required this.reference,
    required this.amount,
    required this.currency,
    required this.status,
    this.protectedAt,
    this.claimedAt,
    this.returnedAt,
    this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.lease,
    required this.org,
  });

  factory DepositProtection.fromJson(Map<String, dynamic> json) {
    return DepositProtection(
      id: json['id'] as String,
      orgId: json['orgId'] as String,
      leaseId: json['leaseId'] as String,
      provider: json['provider'] as String,
      scheme: json['scheme'] as String,
      reference: json['reference'] as String,
      amount: (json['amount'] as num).toDouble(),
      currency: json['currency'] as String,
      status: json['status'] as String,
      protectedAt: json['protectedAt'] != null ? DateTime.parse(json['protectedAt'] as String) : null,
      claimedAt: json['claimedAt'] != null ? DateTime.parse(json['claimedAt'] as String) : null,
      returnedAt: json['returnedAt'] != null ? DateTime.parse(json['returnedAt'] as String) : null,
      createdBy: json['createdBy'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      lease: Lease.fromJson(json['lease'] as Map<String, dynamic>),
      org: Organization.fromJson(json['org'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'leaseId': leaseId,
      'provider': provider,
      'scheme': scheme,
      'reference': reference,
      'amount': amount,
      'currency': currency,
      'status': status,
      'protectedAt': protectedAt?.toIso8601String(),
      'claimedAt': claimedAt?.toIso8601String(),
      'returnedAt': returnedAt?.toIso8601String(),
      'createdBy': createdBy,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'lease': lease.toJson(),
      'org': org.toJson(),
    };
  }

  DepositProtection copyWith({
    String? id,
    String? orgId,
    String? leaseId,
    String? provider,
    String? scheme,
    String? reference,
    double? amount,
    String? currency,
    String? status,
    DateTime? protectedAt,
    DateTime? claimedAt,
    DateTime? returnedAt,
    String? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    Lease? lease,
    Organization? org,
  }) {
    return DepositProtection(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      leaseId: leaseId ?? this.leaseId,
      provider: provider ?? this.provider,
      scheme: scheme ?? this.scheme,
      reference: reference ?? this.reference,
      amount: amount ?? this.amount,
      currency: currency ?? this.currency,
      status: status ?? this.status,
      protectedAt: protectedAt ?? this.protectedAt,
      claimedAt: claimedAt ?? this.claimedAt,
      returnedAt: returnedAt ?? this.returnedAt,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      lease: lease ?? this.lease,
      org: org ?? this.org,
    );
  }
}
