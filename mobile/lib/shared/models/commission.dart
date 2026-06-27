import 'organization.dart';
import 'payout.dart';

class Commission {
  final String id;
  final String orgId;
  final String? listingId;
  final String? leaseId;
  final String? bookingId;
  final String? transactionId;
  final String? beneficiaryUserId;
  final String? beneficiaryOrgId;
  final double amountBase;
  final double commissionAmount;
  final String currency;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final Organization org;
  final List<Payout> payouts;

  const Commission({
    required this.id,
    required this.orgId,
    this.listingId,
    this.leaseId,
    this.bookingId,
    this.transactionId,
    this.beneficiaryUserId,
    this.beneficiaryOrgId,
    required this.amountBase,
    required this.commissionAmount,
    required this.currency,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.org,
    this.payouts = const [],
  });

  factory Commission.fromJson(Map<String, dynamic> json) {
    return Commission(
      id: json['id'] as String,
      orgId: json['orgId'] as String,
      listingId: json['listingId'] as String?,
      leaseId: json['leaseId'] as String?,
      bookingId: json['bookingId'] as String?,
      transactionId: json['transactionId'] as String?,
      beneficiaryUserId: json['beneficiaryUserId'] as String?,
      beneficiaryOrgId: json['beneficiaryOrgId'] as String?,
      amountBase: (json['amountBase'] as num).toDouble(),
      commissionAmount: (json['commissionAmount'] as num).toDouble(),
      currency: json['currency'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      org: Organization.fromJson(json['org'] as Map<String, dynamic>),
      payouts: (json['payouts'] as List<dynamic>?)?.map((e) => Payout.fromJson(e as Map<String, dynamic>)).toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'listingId': listingId,
      'leaseId': leaseId,
      'bookingId': bookingId,
      'transactionId': transactionId,
      'beneficiaryUserId': beneficiaryUserId,
      'beneficiaryOrgId': beneficiaryOrgId,
      'amountBase': amountBase,
      'commissionAmount': commissionAmount,
      'currency': currency,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'org': org.toJson(),
      'payouts': payouts.map((e) => e.toJson()).toList(),
    };
  }

  Commission copyWith({
    String? id,
    String? orgId,
    String? listingId,
    String? leaseId,
    String? bookingId,
    String? transactionId,
    String? beneficiaryUserId,
    String? beneficiaryOrgId,
    double? amountBase,
    double? commissionAmount,
    String? currency,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    Organization? org,
    List<Payout>? payouts,
  }) {
    return Commission(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      listingId: listingId ?? this.listingId,
      leaseId: leaseId ?? this.leaseId,
      bookingId: bookingId ?? this.bookingId,
      transactionId: transactionId ?? this.transactionId,
      beneficiaryUserId: beneficiaryUserId ?? this.beneficiaryUserId,
      beneficiaryOrgId: beneficiaryOrgId ?? this.beneficiaryOrgId,
      amountBase: amountBase ?? this.amountBase,
      commissionAmount: commissionAmount ?? this.commissionAmount,
      currency: currency ?? this.currency,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      org: org ?? this.org,
      payouts: payouts ?? this.payouts,
    );
  }
}
