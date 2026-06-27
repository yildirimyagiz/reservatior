import 'organization.dart';

class AiFraudDetection {
  final String id;
  final String? orgId;
  final String entityType;
  final String entityId;
  final double riskScore;
  final String riskCategory;
  final DateTime detectedAt;
  final DateTime? reviewedAt;
  final String? reviewedBy;
  final String? resolution;
  final DateTime createdAt;
  final Organization? org;

  const AiFraudDetection({
    required this.id,
    this.orgId,
    required this.entityType,
    required this.entityId,
    required this.riskScore,
    required this.riskCategory,
    required this.detectedAt,
    this.reviewedAt,
    this.reviewedBy,
    this.resolution,
    required this.createdAt,
    this.org,
  });

  factory AiFraudDetection.fromJson(Map<String, dynamic> json) {
    return AiFraudDetection(
      id: json['id'] as String,
      orgId: json['orgId'] as String?,
      entityType: json['entityType'] as String,
      entityId: json['entityId'] as String,
      riskScore: (json['riskScore'] as num).toDouble(),
      riskCategory: json['riskCategory'] as String,
      detectedAt: DateTime.parse(json['detectedAt'] as String),
      reviewedAt: json['reviewedAt'] != null ? DateTime.parse(json['reviewedAt'] as String) : null,
      reviewedBy: json['reviewedBy'] as String?,
      resolution: json['resolution'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      org: json['org'] != null ? Organization.fromJson(json['org'] as Map<String, dynamic>) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'entityType': entityType,
      'entityId': entityId,
      'riskScore': riskScore,
      'riskCategory': riskCategory,
      'detectedAt': detectedAt.toIso8601String(),
      'reviewedAt': reviewedAt?.toIso8601String(),
      'reviewedBy': reviewedBy,
      'resolution': resolution,
      'createdAt': createdAt.toIso8601String(),
      'org': org?.toJson(),
    };
  }

  AiFraudDetection copyWith({
    String? id,
    String? orgId,
    String? entityType,
    String? entityId,
    double? riskScore,
    String? riskCategory,
    DateTime? detectedAt,
    DateTime? reviewedAt,
    String? reviewedBy,
    String? resolution,
    DateTime? createdAt,
    Organization? org,
  }) {
    return AiFraudDetection(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      entityType: entityType ?? this.entityType,
      entityId: entityId ?? this.entityId,
      riskScore: riskScore ?? this.riskScore,
      riskCategory: riskCategory ?? this.riskCategory,
      detectedAt: detectedAt ?? this.detectedAt,
      reviewedAt: reviewedAt ?? this.reviewedAt,
      reviewedBy: reviewedBy ?? this.reviewedBy,
      resolution: resolution ?? this.resolution,
      createdAt: createdAt ?? this.createdAt,
      org: org ?? this.org,
    );
  }
}
