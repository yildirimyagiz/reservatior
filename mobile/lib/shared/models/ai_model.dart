import 'ai_model_deployment.dart';
import 'ai_prediction.dart';
import 'organization.dart';

class AiModel {
  final String id;
  final String? orgId;
  final String modelName;
  final String modelVersion;
  final String modelType;
  final String provider;
  final String? endpointUrl;
  final String? apiKey;
  final String status;
  final double? accuracy;
  final DateTime? lastTrainedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Organization? org;
  final List<AiModelDeployment> deployments;
  final List<AiPrediction> predictions;

  const AiModel({
    required this.id,
    this.orgId,
    required this.modelName,
    required this.modelVersion,
    required this.modelType,
    required this.provider,
    this.endpointUrl,
    this.apiKey,
    required this.status,
    this.accuracy,
    this.lastTrainedAt,
    required this.createdAt,
    required this.updatedAt,
    this.org,
    this.deployments = const [],
    this.predictions = const [],
  });

  factory AiModel.fromJson(Map<String, dynamic> json) {
    return AiModel(
      id: json['id'] as String,
      orgId: json['orgId'] as String?,
      modelName: json['modelName'] as String,
      modelVersion: json['modelVersion'] as String,
      modelType: json['modelType'] as String,
      provider: json['provider'] as String,
      endpointUrl: json['endpointUrl'] as String?,
      apiKey: json['apiKey'] as String?,
      status: json['status'] as String,
      accuracy: (json['accuracy'] as num?)?.toDouble(),
      lastTrainedAt: json['lastTrainedAt'] != null ? DateTime.parse(json['lastTrainedAt'] as String) : null,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      org: json['org'] != null ? Organization.fromJson(json['org'] as Map<String, dynamic>) : null,
      deployments: (json['deployments'] as List<dynamic>?)?.map((e) => AiModelDeployment.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      predictions: (json['predictions'] as List<dynamic>?)?.map((e) => AiPrediction.fromJson(e as Map<String, dynamic>)).toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'modelName': modelName,
      'modelVersion': modelVersion,
      'modelType': modelType,
      'provider': provider,
      'endpointUrl': endpointUrl,
      'apiKey': apiKey,
      'status': status,
      'accuracy': accuracy,
      'lastTrainedAt': lastTrainedAt?.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'org': org?.toJson(),
      'deployments': deployments.map((e) => e.toJson()).toList(),
      'predictions': predictions.map((e) => e.toJson()).toList(),
    };
  }

  AiModel copyWith({
    String? id,
    String? orgId,
    String? modelName,
    String? modelVersion,
    String? modelType,
    String? provider,
    String? endpointUrl,
    String? apiKey,
    String? status,
    double? accuracy,
    DateTime? lastTrainedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
    Organization? org,
    List<AiModelDeployment>? deployments,
    List<AiPrediction>? predictions,
  }) {
    return AiModel(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      modelName: modelName ?? this.modelName,
      modelVersion: modelVersion ?? this.modelVersion,
      modelType: modelType ?? this.modelType,
      provider: provider ?? this.provider,
      endpointUrl: endpointUrl ?? this.endpointUrl,
      apiKey: apiKey ?? this.apiKey,
      status: status ?? this.status,
      accuracy: accuracy ?? this.accuracy,
      lastTrainedAt: lastTrainedAt ?? this.lastTrainedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      org: org ?? this.org,
      deployments: deployments ?? this.deployments,
      predictions: predictions ?? this.predictions,
    );
  }
}
