import 'organization.dart';

class AiRecommendation {
  final String id;
  final String? orgId;
  final String userType;
  final String userId;
  final String? sessionId;
  final String recommendationType;
  final DateTime generatedAt;
  final DateTime? expiresAt;
  final DateTime createdAt;
  final Organization? org;

  const AiRecommendation({
    required this.id,
    this.orgId,
    required this.userType,
    required this.userId,
    this.sessionId,
    required this.recommendationType,
    required this.generatedAt,
    this.expiresAt,
    required this.createdAt,
    this.org,
  });

  factory AiRecommendation.fromJson(Map<String, dynamic> json) {
    return AiRecommendation(
      id: json['id'] as String,
      orgId: json['orgId'] as String?,
      userType: json['userType'] as String,
      userId: json['userId'] as String,
      sessionId: json['sessionId'] as String?,
      recommendationType: json['recommendationType'] as String,
      generatedAt: DateTime.parse(json['generatedAt'] as String),
      expiresAt: json['expiresAt'] != null ? DateTime.parse(json['expiresAt'] as String) : null,
      createdAt: DateTime.parse(json['createdAt'] as String),
      org: json['org'] != null ? Organization.fromJson(json['org'] as Map<String, dynamic>) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'userType': userType,
      'userId': userId,
      'sessionId': sessionId,
      'recommendationType': recommendationType,
      'generatedAt': generatedAt.toIso8601String(),
      'expiresAt': expiresAt?.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'org': org?.toJson(),
    };
  }

  AiRecommendation copyWith({
    String? id,
    String? orgId,
    String? userType,
    String? userId,
    String? sessionId,
    String? recommendationType,
    DateTime? generatedAt,
    DateTime? expiresAt,
    DateTime? createdAt,
    Organization? org,
  }) {
    return AiRecommendation(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      userType: userType ?? this.userType,
      userId: userId ?? this.userId,
      sessionId: sessionId ?? this.sessionId,
      recommendationType: recommendationType ?? this.recommendationType,
      generatedAt: generatedAt ?? this.generatedAt,
      expiresAt: expiresAt ?? this.expiresAt,
      createdAt: createdAt ?? this.createdAt,
      org: org ?? this.org,
    );
  }
}
