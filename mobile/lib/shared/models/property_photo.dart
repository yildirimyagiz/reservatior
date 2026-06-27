import 'ai_image_analysis.dart';
import 'organization.dart';
import 'property.dart';

class PropertyPhoto {
  final String id;
  final String orgId;
  final String propertyId;
  final String url;
  final String? caption;
  final bool isPrimary;
  final int sortOrder;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final List<AiImageAnalysis> aiAnalyses;
  final Organization org;
  final Property property;

  const PropertyPhoto({
    required this.id,
    required this.orgId,
    required this.propertyId,
    required this.url,
    this.caption,
    required this.isPrimary,
    required this.sortOrder,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.aiAnalyses = const [],
    required this.org,
    required this.property,
  });

  factory PropertyPhoto.fromJson(Map<String, dynamic> json) {
    return PropertyPhoto(
      id: json['id'] as String,
      orgId: json['orgId'] as String,
      propertyId: json['propertyId'] as String,
      url: json['url'] as String,
      caption: json['caption'] as String?,
      isPrimary: json['isPrimary'] as bool,
      sortOrder: json['sortOrder'] as int,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      aiAnalyses: (json['aiAnalyses'] as List<dynamic>?)?.map((e) => AiImageAnalysis.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      org: Organization.fromJson(json['org'] as Map<String, dynamic>),
      property: Property.fromJson(json['property'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'propertyId': propertyId,
      'url': url,
      'caption': caption,
      'isPrimary': isPrimary,
      'sortOrder': sortOrder,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'aiAnalyses': aiAnalyses.map((e) => e.toJson()).toList(),
      'org': org.toJson(),
      'property': property.toJson(),
    };
  }

  PropertyPhoto copyWith({
    String? id,
    String? orgId,
    String? propertyId,
    String? url,
    String? caption,
    bool? isPrimary,
    int? sortOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    List<AiImageAnalysis>? aiAnalyses,
    Organization? org,
    Property? property,
  }) {
    return PropertyPhoto(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      propertyId: propertyId ?? this.propertyId,
      url: url ?? this.url,
      caption: caption ?? this.caption,
      isPrimary: isPrimary ?? this.isPrimary,
      sortOrder: sortOrder ?? this.sortOrder,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      aiAnalyses: aiAnalyses ?? this.aiAnalyses,
      org: org ?? this.org,
      property: property ?? this.property,
    );
  }
}
