import 'organization.dart';

class GiftCard {
  final String id;
  final String code;
  final String orgId;
  final double amount;
  final double balance;
  final String currency;
  final DateTime? expiresAt;
  final bool isActive;
  final String? issuedTo;
  final String? issuedBy;
  final String? issuedFor;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Organization org;

  const GiftCard({
    required this.id,
    required this.code,
    required this.orgId,
    required this.amount,
    required this.balance,
    required this.currency,
    this.expiresAt,
    required this.isActive,
    this.issuedTo,
    this.issuedBy,
    this.issuedFor,
    required this.createdAt,
    required this.updatedAt,
    required this.org,
  });

  factory GiftCard.fromJson(Map<String, dynamic> json) {
    return GiftCard(
      id: json['id'] as String,
      code: json['code'] as String,
      orgId: json['orgId'] as String,
      amount: (json['amount'] as num).toDouble(),
      balance: (json['balance'] as num).toDouble(),
      currency: json['currency'] as String,
      expiresAt: json['expiresAt'] != null ? DateTime.parse(json['expiresAt'] as String) : null,
      isActive: json['isActive'] as bool,
      issuedTo: json['issuedTo'] as String?,
      issuedBy: json['issuedBy'] as String?,
      issuedFor: json['issuedFor'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      org: Organization.fromJson(json['org'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'orgId': orgId,
      'amount': amount,
      'balance': balance,
      'currency': currency,
      'expiresAt': expiresAt?.toIso8601String(),
      'isActive': isActive,
      'issuedTo': issuedTo,
      'issuedBy': issuedBy,
      'issuedFor': issuedFor,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'org': org.toJson(),
    };
  }

  GiftCard copyWith({
    String? id,
    String? code,
    String? orgId,
    double? amount,
    double? balance,
    String? currency,
    DateTime? expiresAt,
    bool? isActive,
    String? issuedTo,
    String? issuedBy,
    String? issuedFor,
    DateTime? createdAt,
    DateTime? updatedAt,
    Organization? org,
  }) {
    return GiftCard(
      id: id ?? this.id,
      code: code ?? this.code,
      orgId: orgId ?? this.orgId,
      amount: amount ?? this.amount,
      balance: balance ?? this.balance,
      currency: currency ?? this.currency,
      expiresAt: expiresAt ?? this.expiresAt,
      isActive: isActive ?? this.isActive,
      issuedTo: issuedTo ?? this.issuedTo,
      issuedBy: issuedBy ?? this.issuedBy,
      issuedFor: issuedFor ?? this.issuedFor,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      org: org ?? this.org,
    );
  }
}
