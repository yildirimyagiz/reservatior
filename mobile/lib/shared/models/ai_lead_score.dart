import 'ai_lead_scoring.dart';
import 'lead.dart';
import 'organization.dart';

class AiLeadScore {
  final String id;
  final String? orgId;
  final String modelId;
  final String leadId;
  final double score;
  final double confidence;
  final DateTime scoredAt;
  final String status;
  final DateTime createdAt;
  final Lead lead;
  final AiLeadScoring model;
  final Organization? org;

  const AiLeadScore({
    required this.id,
    this.orgId,
    required this.modelId,
    required this.leadId,
    required this.score,
    required this.confidence,
    required this.scoredAt,
    required this.status,
    required this.createdAt,
    required this.lead,
    required this.model,
    this.org,
  });

  factory AiLeadScore.fromJson(Map<String, dynamic> json) {
    return AiLeadScore(
      id: json['id'] as String,
      orgId: json['orgId'] as String?,
      modelId: json['modelId'] as String,
      leadId: json['leadId'] as String,
      score: (json['score'] as num).toDouble(),
      confidence: (json['confidence'] as num).toDouble(),
      scoredAt: DateTime.parse(json['scoredAt'] as String),
      status: json['status'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      lead: Lead.fromJson(json['lead'] as Map<String, dynamic>),
      model: AiLeadScoring.fromJson(json['model'] as Map<String, dynamic>),
      org: json['org'] != null ? Organization.fromJson(json['org'] as Map<String, dynamic>) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'modelId': modelId,
      'leadId': leadId,
      'score': score,
      'confidence': confidence,
      'scoredAt': scoredAt.toIso8601String(),
      'status': status,
      'createdAt': createdAt.toIso8601String(),
      'lead': lead.toJson(),
      'model': model.toJson(),
      'org': org?.toJson(),
    };
  }

  AiLeadScore copyWith({
    String? id,
    String? orgId,
    String? modelId,
    String? leadId,
    double? score,
    double? confidence,
    DateTime? scoredAt,
    String? status,
    DateTime? createdAt,
    Lead? lead,
    AiLeadScoring? model,
    Organization? org,
  }) {
    return AiLeadScore(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      modelId: modelId ?? this.modelId,
      leadId: leadId ?? this.leadId,
      score: score ?? this.score,
      confidence: confidence ?? this.confidence,
      scoredAt: scoredAt ?? this.scoredAt,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      lead: lead ?? this.lead,
      model: model ?? this.model,
      org: org ?? this.org,
    );
  }
}
