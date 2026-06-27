import 'package:reservatior/shared/enums/model_type.dart';
import 'organization.dart';

class PredictiveModel {
  final String id;
  final String orgId;
  final ModelType modelType;
  final double? accuracy;
  final DateTime? lastTrained;
  final Organization org;

  const PredictiveModel({
    required this.id,
    required this.orgId,
    required this.modelType,
    this.accuracy,
    this.lastTrained,
    required this.org,
  });

  factory PredictiveModel.fromJson(Map<String, dynamic> json) {
    return PredictiveModel(
      id: json['id'] as String,
      orgId: json['orgId'] as String,
      modelType: ModelType.values.firstWhere((v) => v.name == json['modelType']),
      accuracy: (json['accuracy'] as num?)?.toDouble(),
      lastTrained: json['lastTrained'] != null ? DateTime.parse(json['lastTrained'] as String) : null,
      org: Organization.fromJson(json['org'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'modelType': modelType.name,
      'accuracy': accuracy,
      'lastTrained': lastTrained?.toIso8601String(),
      'org': org.toJson(),
    };
  }

  PredictiveModel copyWith({
    String? id,
    String? orgId,
    ModelType? modelType,
    double? accuracy,
    DateTime? lastTrained,
    Organization? org,
  }) {
    return PredictiveModel(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      modelType: modelType ?? this.modelType,
      accuracy: accuracy ?? this.accuracy,
      lastTrained: lastTrained ?? this.lastTrained,
      org: org ?? this.org,
    );
  }
}
