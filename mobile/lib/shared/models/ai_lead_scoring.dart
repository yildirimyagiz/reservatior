import 'ai_lead_score.dart';
import 'organization.dart';

class AiLeadScoring {
  final String id;
  final String? orgId;
  final String modelName;
  final String modelVersion;
  final double accuracy;
  final DateTime lastTrainedAt;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<AiLeadScore> scores;
  final Organization? org;

  const AiLeadScoring({
    required this.id,
    this.orgId,
    required this.modelName,
    required this.modelVersion,
    required this.accuracy,
    required this.lastTrainedAt,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    this.scores = const [],
    this.org,
  });

  factory AiLeadScoring.fromJson(Map<String, dynamic> json) {
    return AiLeadScoring(
      id: json['id'] as String,
      orgId: json['orgId'] as String?,
      modelName: json['modelName'] as String,
      modelVersion: json['modelVersion'] as String,
      accuracy: (json['accuracy'] as num).toDouble(),
      lastTrainedAt: DateTime.parse(json['lastTrainedAt'] as String),
      isActive: json['isActive'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      scores: (json['scores'] as List<dynamic>?)?.map((e) => AiLeadScore.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      org: json['org'] != null ? Organization.fromJson(json['org'] as Map<String, dynamic>) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'modelName': modelName,
      'modelVersion': modelVersion,
      'accuracy': accuracy,
      'lastTrainedAt': lastTrainedAt.toIso8601String(),
      'isActive': isActive,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'scores': scores.map((e) => e.toJson()).toList(),
      'org': org?.toJson(),
    };
  }

  AiLeadScoring copyWith({
    String? id,
    String? orgId,
    String? modelName,
    String? modelVersion,
    double? accuracy,
    DateTime? lastTrainedAt,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<AiLeadScore>? scores,
    Organization? org,
  }) {
    return AiLeadScoring(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      modelName: modelName ?? this.modelName,
      modelVersion: modelVersion ?? this.modelVersion,
      accuracy: accuracy ?? this.accuracy,
      lastTrainedAt: lastTrainedAt ?? this.lastTrainedAt,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      scores: scores ?? this.scores,
      org: org ?? this.org,
    );
  }
}
