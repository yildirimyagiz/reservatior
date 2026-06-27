import 'organization.dart';

class AiTenantScreening {
  final String id;
  final String? orgId;
  final String applicationId;
  final double overallScore;
  final String riskAssessment;
  final double? creditScore;
  final double? incomeStability;
  final double? rentalHistory;
  final double? backgroundCheck;
  final DateTime screenedAt;
  final String? reviewedBy;
  final String? finalDecision;
  final DateTime createdAt;
  final Organization? org;

  const AiTenantScreening({
    required this.id,
    this.orgId,
    required this.applicationId,
    required this.overallScore,
    required this.riskAssessment,
    this.creditScore,
    this.incomeStability,
    this.rentalHistory,
    this.backgroundCheck,
    required this.screenedAt,
    this.reviewedBy,
    this.finalDecision,
    required this.createdAt,
    this.org,
  });

  factory AiTenantScreening.fromJson(Map<String, dynamic> json) {
    return AiTenantScreening(
      id: json['id'] as String,
      orgId: json['orgId'] as String?,
      applicationId: json['applicationId'] as String,
      overallScore: (json['overallScore'] as num).toDouble(),
      riskAssessment: json['riskAssessment'] as String,
      creditScore: (json['creditScore'] as num?)?.toDouble(),
      incomeStability: (json['incomeStability'] as num?)?.toDouble(),
      rentalHistory: (json['rentalHistory'] as num?)?.toDouble(),
      backgroundCheck: (json['backgroundCheck'] as num?)?.toDouble(),
      screenedAt: DateTime.parse(json['screenedAt'] as String),
      reviewedBy: json['reviewedBy'] as String?,
      finalDecision: json['finalDecision'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      org: json['org'] != null ? Organization.fromJson(json['org'] as Map<String, dynamic>) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'applicationId': applicationId,
      'overallScore': overallScore,
      'riskAssessment': riskAssessment,
      'creditScore': creditScore,
      'incomeStability': incomeStability,
      'rentalHistory': rentalHistory,
      'backgroundCheck': backgroundCheck,
      'screenedAt': screenedAt.toIso8601String(),
      'reviewedBy': reviewedBy,
      'finalDecision': finalDecision,
      'createdAt': createdAt.toIso8601String(),
      'org': org?.toJson(),
    };
  }

  AiTenantScreening copyWith({
    String? id,
    String? orgId,
    String? applicationId,
    double? overallScore,
    String? riskAssessment,
    double? creditScore,
    double? incomeStability,
    double? rentalHistory,
    double? backgroundCheck,
    DateTime? screenedAt,
    String? reviewedBy,
    String? finalDecision,
    DateTime? createdAt,
    Organization? org,
  }) {
    return AiTenantScreening(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      applicationId: applicationId ?? this.applicationId,
      overallScore: overallScore ?? this.overallScore,
      riskAssessment: riskAssessment ?? this.riskAssessment,
      creditScore: creditScore ?? this.creditScore,
      incomeStability: incomeStability ?? this.incomeStability,
      rentalHistory: rentalHistory ?? this.rentalHistory,
      backgroundCheck: backgroundCheck ?? this.backgroundCheck,
      screenedAt: screenedAt ?? this.screenedAt,
      reviewedBy: reviewedBy ?? this.reviewedBy,
      finalDecision: finalDecision ?? this.finalDecision,
      createdAt: createdAt ?? this.createdAt,
      org: org ?? this.org,
    );
  }
}
