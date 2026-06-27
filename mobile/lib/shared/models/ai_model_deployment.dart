import 'ai_model.dart';
import 'organization.dart';

class AiModelDeployment {
  final String id;
  final String? orgId;
  final String modelId;
  final String deploymentId;
  final String environment;
  final String status;
  final DateTime? deployedAt;
  final DateTime? lastHealthCheck;
  final DateTime createdAt;
  final DateTime updatedAt;
  final AiModel model;
  final Organization? org;

  const AiModelDeployment({
    required this.id,
    this.orgId,
    required this.modelId,
    required this.deploymentId,
    required this.environment,
    required this.status,
    this.deployedAt,
    this.lastHealthCheck,
    required this.createdAt,
    required this.updatedAt,
    required this.model,
    this.org,
  });

  factory AiModelDeployment.fromJson(Map<String, dynamic> json) {
    return AiModelDeployment(
      id: json['id'] as String,
      orgId: json['orgId'] as String?,
      modelId: json['modelId'] as String,
      deploymentId: json['deploymentId'] as String,
      environment: json['environment'] as String,
      status: json['status'] as String,
      deployedAt: json['deployedAt'] != null ? DateTime.parse(json['deployedAt'] as String) : null,
      lastHealthCheck: json['lastHealthCheck'] != null ? DateTime.parse(json['lastHealthCheck'] as String) : null,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      model: AiModel.fromJson(json['model'] as Map<String, dynamic>),
      org: json['org'] != null ? Organization.fromJson(json['org'] as Map<String, dynamic>) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'modelId': modelId,
      'deploymentId': deploymentId,
      'environment': environment,
      'status': status,
      'deployedAt': deployedAt?.toIso8601String(),
      'lastHealthCheck': lastHealthCheck?.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'model': model.toJson(),
      'org': org?.toJson(),
    };
  }

  AiModelDeployment copyWith({
    String? id,
    String? orgId,
    String? modelId,
    String? deploymentId,
    String? environment,
    String? status,
    DateTime? deployedAt,
    DateTime? lastHealthCheck,
    DateTime? createdAt,
    DateTime? updatedAt,
    AiModel? model,
    Organization? org,
  }) {
    return AiModelDeployment(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      modelId: modelId ?? this.modelId,
      deploymentId: deploymentId ?? this.deploymentId,
      environment: environment ?? this.environment,
      status: status ?? this.status,
      deployedAt: deployedAt ?? this.deployedAt,
      lastHealthCheck: lastHealthCheck ?? this.lastHealthCheck,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      model: model ?? this.model,
      org: org ?? this.org,
    );
  }
}
