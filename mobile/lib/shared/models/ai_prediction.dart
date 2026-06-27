import 'ai_model.dart';
import 'organization.dart';

class AiPrediction {
  final String id;
  final String orgId;
  final String? modelId;
  final String? requestId;
  final String? batchId;
  final String modelType;
  final double confidence;
  final int? processingTimeMs;
  final int? processingTime;
  final String status;
  final bool succes;
  final String? errorMessage;
  final String? userId;
  final String? propertyId;
  final DateTime createdAt;
  final AiModel? model;
  final Organization org;

  const AiPrediction({
    required this.id,
    required this.orgId,
    this.modelId,
    this.requestId,
    this.batchId,
    required this.modelType,
    required this.confidence,
    this.processingTimeMs,
    this.processingTime,
    required this.status,
    required this.succes,
    this.errorMessage,
    this.userId,
    this.propertyId,
    required this.createdAt,
    this.model,
    required this.org,
  });

  factory AiPrediction.fromJson(Map<String, dynamic> json) {
    return AiPrediction(
      id: json['id'] as String,
      orgId: json['orgId'] as String,
      modelId: json['modelId'] as String?,
      requestId: json['requestId'] as String?,
      batchId: json['batchId'] as String?,
      modelType: json['modelType'] as String,
      confidence: (json['confidence'] as num).toDouble(),
      processingTimeMs: json['processingTimeMs'] as int?,
      processingTime: json['processingTime'] as int?,
      status: json['status'] as String,
      succes: json['Succes'] as bool,
      errorMessage: json['errorMessage'] as String?,
      userId: json['userId'] as String?,
      propertyId: json['propertyId'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      model: json['model'] != null ? AiModel.fromJson(json['model'] as Map<String, dynamic>) : null,
      org: Organization.fromJson(json['org'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'modelId': modelId,
      'requestId': requestId,
      'batchId': batchId,
      'modelType': modelType,
      'confidence': confidence,
      'processingTimeMs': processingTimeMs,
      'processingTime': processingTime,
      'status': status,
      'Succes': succes,
      'errorMessage': errorMessage,
      'userId': userId,
      'propertyId': propertyId,
      'createdAt': createdAt.toIso8601String(),
      'model': model?.toJson(),
      'org': org.toJson(),
    };
  }

  AiPrediction copyWith({
    String? id,
    String? orgId,
    String? modelId,
    String? requestId,
    String? batchId,
    String? modelType,
    double? confidence,
    int? processingTimeMs,
    int? processingTime,
    String? status,
    bool? succes,
    String? errorMessage,
    String? userId,
    String? propertyId,
    DateTime? createdAt,
    AiModel? model,
    Organization? org,
  }) {
    return AiPrediction(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      modelId: modelId ?? this.modelId,
      requestId: requestId ?? this.requestId,
      batchId: batchId ?? this.batchId,
      modelType: modelType ?? this.modelType,
      confidence: confidence ?? this.confidence,
      processingTimeMs: processingTimeMs ?? this.processingTimeMs,
      processingTime: processingTime ?? this.processingTime,
      status: status ?? this.status,
      succes: succes ?? this.succes,
      errorMessage: errorMessage ?? this.errorMessage,
      userId: userId ?? this.userId,
      propertyId: propertyId ?? this.propertyId,
      createdAt: createdAt ?? this.createdAt,
      model: model ?? this.model,
      org: org ?? this.org,
    );
  }
}
