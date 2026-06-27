import 'package:reservatior/shared/enums/region.dart';
import 'package:reservatior/shared/enums/risk_tolerance.dart';
import 'recommendation_result.dart';
import 'user.dart';

class UserFinancialProfile {
  final String id;
  final String userId;
  final Region region;
  final String currency;
  final double monthlyIncome;
  final double monthlyObligations;
  final RiskTolerance riskTolerance;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final List<RecommendationResult> results;
  final User user;

  const UserFinancialProfile({
    required this.id,
    required this.userId,
    required this.region,
    required this.currency,
    required this.monthlyIncome,
    required this.monthlyObligations,
    required this.riskTolerance,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.results = const [],
    required this.user,
  });

  factory UserFinancialProfile.fromJson(Map<String, dynamic> json) {
    return UserFinancialProfile(
      id: json['id'] as String,
      userId: json['userId'] as String,
      region: Region.values.firstWhere((v) => v.name == json['region']),
      currency: json['currency'] as String,
      monthlyIncome: (json['monthlyIncome'] as num).toDouble(),
      monthlyObligations: (json['monthlyObligations'] as num).toDouble(),
      riskTolerance: RiskTolerance.values.firstWhere((v) => v.name == json['riskTolerance']),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      results: (json['results'] as List<dynamic>?)?.map((e) => RecommendationResult.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      user: User.fromJson(json['user'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'region': region.name,
      'currency': currency,
      'monthlyIncome': monthlyIncome,
      'monthlyObligations': monthlyObligations,
      'riskTolerance': riskTolerance.name,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'results': results.map((e) => e.toJson()).toList(),
      'user': user.toJson(),
    };
  }

  UserFinancialProfile copyWith({
    String? id,
    String? userId,
    Region? region,
    String? currency,
    double? monthlyIncome,
    double? monthlyObligations,
    RiskTolerance? riskTolerance,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    List<RecommendationResult>? results,
    User? user,
  }) {
    return UserFinancialProfile(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      region: region ?? this.region,
      currency: currency ?? this.currency,
      monthlyIncome: monthlyIncome ?? this.monthlyIncome,
      monthlyObligations: monthlyObligations ?? this.monthlyObligations,
      riskTolerance: riskTolerance ?? this.riskTolerance,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      results: results ?? this.results,
      user: user ?? this.user,
    );
  }
}
