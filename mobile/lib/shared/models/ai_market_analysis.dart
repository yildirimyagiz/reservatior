import 'organization.dart';

class AiMarketAnalysis {
  final String id;
  final String? orgId;
  final String analysisType;
  final String location;
  final String analysisPeriod;
  final double confidence;
  final DateTime generatedAt;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Organization? org;

  const AiMarketAnalysis({
    required this.id,
    this.orgId,
    required this.analysisType,
    required this.location,
    required this.analysisPeriod,
    required this.confidence,
    required this.generatedAt,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.org,
  });

  factory AiMarketAnalysis.fromJson(Map<String, dynamic> json) {
    return AiMarketAnalysis(
      id: json['id'] as String,
      orgId: json['orgId'] as String?,
      analysisType: json['analysisType'] as String,
      location: json['location'] as String,
      analysisPeriod: json['analysisPeriod'] as String,
      confidence: (json['confidence'] as num).toDouble(),
      generatedAt: DateTime.parse(json['generatedAt'] as String),
      status: json['status'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      org: json['org'] != null ? Organization.fromJson(json['org'] as Map<String, dynamic>) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'analysisType': analysisType,
      'location': location,
      'analysisPeriod': analysisPeriod,
      'confidence': confidence,
      'generatedAt': generatedAt.toIso8601String(),
      'status': status,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'org': org?.toJson(),
    };
  }

  AiMarketAnalysis copyWith({
    String? id,
    String? orgId,
    String? analysisType,
    String? location,
    String? analysisPeriod,
    double? confidence,
    DateTime? generatedAt,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    Organization? org,
  }) {
    return AiMarketAnalysis(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      analysisType: analysisType ?? this.analysisType,
      location: location ?? this.location,
      analysisPeriod: analysisPeriod ?? this.analysisPeriod,
      confidence: confidence ?? this.confidence,
      generatedAt: generatedAt ?? this.generatedAt,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      org: org ?? this.org,
    );
  }
}
