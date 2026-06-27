import 'organization.dart';
import 'property.dart';

class AiPredictiveMaintenance {
  final String id;
  final String? orgId;
  final String propertyId;
  final String componentType;
  final double failureProbability;
  final DateTime? predictedFailureDate;
  final String riskLevel;
  final double? estimatedCost;
  final DateTime? lastInspectionDate;
  final String? recommendedAction;
  final DateTime generatedAt;
  final DateTime createdAt;
  final Organization? org;
  final Property property;

  const AiPredictiveMaintenance({
    required this.id,
    this.orgId,
    required this.propertyId,
    required this.componentType,
    required this.failureProbability,
    this.predictedFailureDate,
    required this.riskLevel,
    this.estimatedCost,
    this.lastInspectionDate,
    this.recommendedAction,
    required this.generatedAt,
    required this.createdAt,
    this.org,
    required this.property,
  });

  factory AiPredictiveMaintenance.fromJson(Map<String, dynamic> json) {
    return AiPredictiveMaintenance(
      id: json['id'] as String,
      orgId: json['orgId'] as String?,
      propertyId: json['propertyId'] as String,
      componentType: json['componentType'] as String,
      failureProbability: (json['failureProbability'] as num).toDouble(),
      predictedFailureDate: json['predictedFailureDate'] != null ? DateTime.parse(json['predictedFailureDate'] as String) : null,
      riskLevel: json['riskLevel'] as String,
      estimatedCost: (json['estimatedCost'] as num?)?.toDouble(),
      lastInspectionDate: json['lastInspectionDate'] != null ? DateTime.parse(json['lastInspectionDate'] as String) : null,
      recommendedAction: json['recommendedAction'] as String?,
      generatedAt: DateTime.parse(json['generatedAt'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
      org: json['org'] != null ? Organization.fromJson(json['org'] as Map<String, dynamic>) : null,
      property: Property.fromJson(json['property'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'propertyId': propertyId,
      'componentType': componentType,
      'failureProbability': failureProbability,
      'predictedFailureDate': predictedFailureDate?.toIso8601String(),
      'riskLevel': riskLevel,
      'estimatedCost': estimatedCost,
      'lastInspectionDate': lastInspectionDate?.toIso8601String(),
      'recommendedAction': recommendedAction,
      'generatedAt': generatedAt.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'org': org?.toJson(),
      'property': property.toJson(),
    };
  }

  AiPredictiveMaintenance copyWith({
    String? id,
    String? orgId,
    String? propertyId,
    String? componentType,
    double? failureProbability,
    DateTime? predictedFailureDate,
    String? riskLevel,
    double? estimatedCost,
    DateTime? lastInspectionDate,
    String? recommendedAction,
    DateTime? generatedAt,
    DateTime? createdAt,
    Organization? org,
    Property? property,
  }) {
    return AiPredictiveMaintenance(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      propertyId: propertyId ?? this.propertyId,
      componentType: componentType ?? this.componentType,
      failureProbability: failureProbability ?? this.failureProbability,
      predictedFailureDate: predictedFailureDate ?? this.predictedFailureDate,
      riskLevel: riskLevel ?? this.riskLevel,
      estimatedCost: estimatedCost ?? this.estimatedCost,
      lastInspectionDate: lastInspectionDate ?? this.lastInspectionDate,
      recommendedAction: recommendedAction ?? this.recommendedAction,
      generatedAt: generatedAt ?? this.generatedAt,
      createdAt: createdAt ?? this.createdAt,
      org: org ?? this.org,
      property: property ?? this.property,
    );
  }
}
