import 'organization.dart';
import 'property.dart';

class AiPropertyDescription {
  final String id;
  final String? orgId;
  final String propertyId;
  final String generatedDescription;
  final String? originalDescription;
  final String tone;
  final String targetAudience;
  final double qualityScore;
  final DateTime generatedAt;
  final bool isApproved;
  final String? approvedBy;
  final DateTime? approvedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Organization? org;
  final Property property;

  const AiPropertyDescription({
    required this.id,
    this.orgId,
    required this.propertyId,
    required this.generatedDescription,
    this.originalDescription,
    required this.tone,
    required this.targetAudience,
    required this.qualityScore,
    required this.generatedAt,
    required this.isApproved,
    this.approvedBy,
    this.approvedAt,
    required this.createdAt,
    required this.updatedAt,
    this.org,
    required this.property,
  });

  factory AiPropertyDescription.fromJson(Map<String, dynamic> json) {
    return AiPropertyDescription(
      id: json['id'] as String,
      orgId: json['orgId'] as String?,
      propertyId: json['propertyId'] as String,
      generatedDescription: json['generatedDescription'] as String,
      originalDescription: json['originalDescription'] as String?,
      tone: json['tone'] as String,
      targetAudience: json['targetAudience'] as String,
      qualityScore: (json['qualityScore'] as num).toDouble(),
      generatedAt: DateTime.parse(json['generatedAt'] as String),
      isApproved: json['isApproved'] as bool,
      approvedBy: json['approvedBy'] as String?,
      approvedAt: json['approvedAt'] != null ? DateTime.parse(json['approvedAt'] as String) : null,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      org: json['org'] != null ? Organization.fromJson(json['org'] as Map<String, dynamic>) : null,
      property: Property.fromJson(json['property'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'propertyId': propertyId,
      'generatedDescription': generatedDescription,
      'originalDescription': originalDescription,
      'tone': tone,
      'targetAudience': targetAudience,
      'qualityScore': qualityScore,
      'generatedAt': generatedAt.toIso8601String(),
      'isApproved': isApproved,
      'approvedBy': approvedBy,
      'approvedAt': approvedAt?.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'org': org?.toJson(),
      'property': property.toJson(),
    };
  }

  AiPropertyDescription copyWith({
    String? id,
    String? orgId,
    String? propertyId,
    String? generatedDescription,
    String? originalDescription,
    String? tone,
    String? targetAudience,
    double? qualityScore,
    DateTime? generatedAt,
    bool? isApproved,
    String? approvedBy,
    DateTime? approvedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
    Organization? org,
    Property? property,
  }) {
    return AiPropertyDescription(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      propertyId: propertyId ?? this.propertyId,
      generatedDescription: generatedDescription ?? this.generatedDescription,
      originalDescription: originalDescription ?? this.originalDescription,
      tone: tone ?? this.tone,
      targetAudience: targetAudience ?? this.targetAudience,
      qualityScore: qualityScore ?? this.qualityScore,
      generatedAt: generatedAt ?? this.generatedAt,
      isApproved: isApproved ?? this.isApproved,
      approvedBy: approvedBy ?? this.approvedBy,
      approvedAt: approvedAt ?? this.approvedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      org: org ?? this.org,
      property: property ?? this.property,
    );
  }
}
