import 'organization.dart';
import 'property.dart';

class AiInvestmentAnalysis {
  final String id;
  final String? orgId;
  final String propertyId;
  final String analysisType;
  final String timeHorizon;
  final double confidence;
  final DateTime generatedAt;
  final DateTime createdAt;
  final Organization? org;
  final Property property;

  const AiInvestmentAnalysis({
    required this.id,
    this.orgId,
    required this.propertyId,
    required this.analysisType,
    required this.timeHorizon,
    required this.confidence,
    required this.generatedAt,
    required this.createdAt,
    this.org,
    required this.property,
  });

  factory AiInvestmentAnalysis.fromJson(Map<String, dynamic> json) {
    return AiInvestmentAnalysis(
      id: json['id'] as String,
      orgId: json['orgId'] as String?,
      propertyId: json['propertyId'] as String,
      analysisType: json['analysisType'] as String,
      timeHorizon: json['timeHorizon'] as String,
      confidence: (json['confidence'] as num).toDouble(),
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
      'analysisType': analysisType,
      'timeHorizon': timeHorizon,
      'confidence': confidence,
      'generatedAt': generatedAt.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'org': org?.toJson(),
      'property': property.toJson(),
    };
  }

  AiInvestmentAnalysis copyWith({
    String? id,
    String? orgId,
    String? propertyId,
    String? analysisType,
    String? timeHorizon,
    double? confidence,
    DateTime? generatedAt,
    DateTime? createdAt,
    Organization? org,
    Property? property,
  }) {
    return AiInvestmentAnalysis(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      propertyId: propertyId ?? this.propertyId,
      analysisType: analysisType ?? this.analysisType,
      timeHorizon: timeHorizon ?? this.timeHorizon,
      confidence: confidence ?? this.confidence,
      generatedAt: generatedAt ?? this.generatedAt,
      createdAt: createdAt ?? this.createdAt,
      org: org ?? this.org,
      property: property ?? this.property,
    );
  }
}
