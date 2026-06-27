import 'ai_valuation_model.dart';
import 'organization.dart';
import 'property.dart';

class AiPropertyValuation {
  final String id;
  final String? orgId;
  final String modelId;
  final String propertyId;
  final double predictedValue;
  final double confidenceScore;
  final DateTime valuationDate;
  final String status;
  final DateTime createdAt;
  final AiValuationModel model;
  final Organization? org;
  final Property property;

  const AiPropertyValuation({
    required this.id,
    this.orgId,
    required this.modelId,
    required this.propertyId,
    required this.predictedValue,
    required this.confidenceScore,
    required this.valuationDate,
    required this.status,
    required this.createdAt,
    required this.model,
    this.org,
    required this.property,
  });

  factory AiPropertyValuation.fromJson(Map<String, dynamic> json) {
    return AiPropertyValuation(
      id: json['id'] as String,
      orgId: json['orgId'] as String?,
      modelId: json['modelId'] as String,
      propertyId: json['propertyId'] as String,
      predictedValue: (json['predictedValue'] as num).toDouble(),
      confidenceScore: (json['confidenceScore'] as num).toDouble(),
      valuationDate: DateTime.parse(json['valuationDate'] as String),
      status: json['status'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      model: AiValuationModel.fromJson(json['model'] as Map<String, dynamic>),
      org: json['org'] != null ? Organization.fromJson(json['org'] as Map<String, dynamic>) : null,
      property: Property.fromJson(json['property'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'modelId': modelId,
      'propertyId': propertyId,
      'predictedValue': predictedValue,
      'confidenceScore': confidenceScore,
      'valuationDate': valuationDate.toIso8601String(),
      'status': status,
      'createdAt': createdAt.toIso8601String(),
      'model': model.toJson(),
      'org': org?.toJson(),
      'property': property.toJson(),
    };
  }

  AiPropertyValuation copyWith({
    String? id,
    String? orgId,
    String? modelId,
    String? propertyId,
    double? predictedValue,
    double? confidenceScore,
    DateTime? valuationDate,
    String? status,
    DateTime? createdAt,
    AiValuationModel? model,
    Organization? org,
    Property? property,
  }) {
    return AiPropertyValuation(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      modelId: modelId ?? this.modelId,
      propertyId: propertyId ?? this.propertyId,
      predictedValue: predictedValue ?? this.predictedValue,
      confidenceScore: confidenceScore ?? this.confidenceScore,
      valuationDate: valuationDate ?? this.valuationDate,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      model: model ?? this.model,
      org: org ?? this.org,
      property: property ?? this.property,
    );
  }
}
