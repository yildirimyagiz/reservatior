import 'organization.dart';
import 'user.dart';

class Referral {
  final String id;
  final String userId;
  final String code;
  final double commissionRate;
  final int bonusPoints;
  final DateTime? expiresAt;
  final int totalReferrals;
  final int successfulReferrals;
  final double totalEarnings;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? organizationId;
  final Organization? organization;
  final User user;

  const Referral({
    required this.id,
    required this.userId,
    required this.code,
    required this.commissionRate,
    required this.bonusPoints,
    this.expiresAt,
    required this.totalReferrals,
    required this.successfulReferrals,
    required this.totalEarnings,
    required this.createdAt,
    required this.updatedAt,
    this.organizationId,
    this.organization,
    required this.user,
  });

  factory Referral.fromJson(Map<String, dynamic> json) {
    return Referral(
      id: json['id'] as String,
      userId: json['userId'] as String,
      code: json['code'] as String,
      commissionRate: (json['commissionRate'] as num).toDouble(),
      bonusPoints: json['bonusPoints'] as int,
      expiresAt: json['expiresAt'] != null ? DateTime.parse(json['expiresAt'] as String) : null,
      totalReferrals: json['totalReferrals'] as int,
      successfulReferrals: json['successfulReferrals'] as int,
      totalEarnings: (json['totalEarnings'] as num).toDouble(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      organizationId: json['organizationId'] as String?,
      organization: json['organization'] != null ? Organization.fromJson(json['organization'] as Map<String, dynamic>) : null,
      user: User.fromJson(json['user'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'code': code,
      'commissionRate': commissionRate,
      'bonusPoints': bonusPoints,
      'expiresAt': expiresAt?.toIso8601String(),
      'totalReferrals': totalReferrals,
      'successfulReferrals': successfulReferrals,
      'totalEarnings': totalEarnings,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'organizationId': organizationId,
      'organization': organization?.toJson(),
      'user': user.toJson(),
    };
  }

  Referral copyWith({
    String? id,
    String? userId,
    String? code,
    double? commissionRate,
    int? bonusPoints,
    DateTime? expiresAt,
    int? totalReferrals,
    int? successfulReferrals,
    double? totalEarnings,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? organizationId,
    Organization? organization,
    User? user,
  }) {
    return Referral(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      code: code ?? this.code,
      commissionRate: commissionRate ?? this.commissionRate,
      bonusPoints: bonusPoints ?? this.bonusPoints,
      expiresAt: expiresAt ?? this.expiresAt,
      totalReferrals: totalReferrals ?? this.totalReferrals,
      successfulReferrals: successfulReferrals ?? this.successfulReferrals,
      totalEarnings: totalEarnings ?? this.totalEarnings,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      organizationId: organizationId ?? this.organizationId,
      organization: organization ?? this.organization,
      user: user ?? this.user,
    );
  }
}
