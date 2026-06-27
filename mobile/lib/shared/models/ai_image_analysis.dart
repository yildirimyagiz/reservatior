import 'organization.dart';
import 'property.dart';
import 'property_photo.dart';

class AiImageAnalysis {
  final String id;
  final String? orgId;
  final String propertyId;
  final String? photoId;
  final String analysisType;
  final double? qualityScore;
  final double? lightingQuality;
  final DateTime analyzedAt;
  final double confidence;
  final DateTime createdAt;
  final Organization? org;
  final PropertyPhoto? photo;
  final Property property;

  const AiImageAnalysis({
    required this.id,
    this.orgId,
    required this.propertyId,
    this.photoId,
    required this.analysisType,
    this.qualityScore,
    this.lightingQuality,
    required this.analyzedAt,
    required this.confidence,
    required this.createdAt,
    this.org,
    this.photo,
    required this.property,
  });

  factory AiImageAnalysis.fromJson(Map<String, dynamic> json) {
    return AiImageAnalysis(
      id: json['id'] as String,
      orgId: json['orgId'] as String?,
      propertyId: json['propertyId'] as String,
      photoId: json['photoId'] as String?,
      analysisType: json['analysisType'] as String,
      qualityScore: (json['qualityScore'] as num?)?.toDouble(),
      lightingQuality: (json['lightingQuality'] as num?)?.toDouble(),
      analyzedAt: DateTime.parse(json['analyzedAt'] as String),
      confidence: (json['confidence'] as num).toDouble(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      org: json['org'] != null ? Organization.fromJson(json['org'] as Map<String, dynamic>) : null,
      photo: json['photo'] != null ? PropertyPhoto.fromJson(json['photo'] as Map<String, dynamic>) : null,
      property: Property.fromJson(json['property'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'propertyId': propertyId,
      'photoId': photoId,
      'analysisType': analysisType,
      'qualityScore': qualityScore,
      'lightingQuality': lightingQuality,
      'analyzedAt': analyzedAt.toIso8601String(),
      'confidence': confidence,
      'createdAt': createdAt.toIso8601String(),
      'org': org?.toJson(),
      'photo': photo?.toJson(),
      'property': property.toJson(),
    };
  }

  AiImageAnalysis copyWith({
    String? id,
    String? orgId,
    String? propertyId,
    String? photoId,
    String? analysisType,
    double? qualityScore,
    double? lightingQuality,
    DateTime? analyzedAt,
    double? confidence,
    DateTime? createdAt,
    Organization? org,
    PropertyPhoto? photo,
    Property? property,
  }) {
    return AiImageAnalysis(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      propertyId: propertyId ?? this.propertyId,
      photoId: photoId ?? this.photoId,
      analysisType: analysisType ?? this.analysisType,
      qualityScore: qualityScore ?? this.qualityScore,
      lightingQuality: lightingQuality ?? this.lightingQuality,
      analyzedAt: analyzedAt ?? this.analyzedAt,
      confidence: confidence ?? this.confidence,
      createdAt: createdAt ?? this.createdAt,
      org: org ?? this.org,
      photo: photo ?? this.photo,
      property: property ?? this.property,
    );
  }
}
