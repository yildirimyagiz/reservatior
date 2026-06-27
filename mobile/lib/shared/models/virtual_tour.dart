import 'organization.dart';
import 'property.dart';

class VirtualTour {
  final String id;
  final String orgId;
  final String propertyId;
  final String name;
  final String? description;
  final String tourType;
  final String? videoUrl;
  final String? embedCode;
  final String? thumbnailUrl;
  final int? duration;
  final bool isActive;
  final String? createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final Organization org;
  final Property property;

  const VirtualTour({
    required this.id,
    required this.orgId,
    required this.propertyId,
    required this.name,
    this.description,
    required this.tourType,
    this.videoUrl,
    this.embedCode,
    this.thumbnailUrl,
    this.duration,
    required this.isActive,
    this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.org,
    required this.property,
  });

  factory VirtualTour.fromJson(Map<String, dynamic> json) {
    return VirtualTour(
      id: json['id'] as String,
      orgId: json['orgId'] as String,
      propertyId: json['propertyId'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      tourType: json['tourType'] as String,
      videoUrl: json['videoUrl'] as String?,
      embedCode: json['embedCode'] as String?,
      thumbnailUrl: json['thumbnailUrl'] as String?,
      duration: json['duration'] as int?,
      isActive: json['isActive'] as bool,
      createdBy: json['createdBy'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      org: Organization.fromJson(json['org'] as Map<String, dynamic>),
      property: Property.fromJson(json['property'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'propertyId': propertyId,
      'name': name,
      'description': description,
      'tourType': tourType,
      'videoUrl': videoUrl,
      'embedCode': embedCode,
      'thumbnailUrl': thumbnailUrl,
      'duration': duration,
      'isActive': isActive,
      'createdBy': createdBy,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'org': org.toJson(),
      'property': property.toJson(),
    };
  }

  VirtualTour copyWith({
    String? id,
    String? orgId,
    String? propertyId,
    String? name,
    String? description,
    String? tourType,
    String? videoUrl,
    String? embedCode,
    String? thumbnailUrl,
    int? duration,
    bool? isActive,
    String? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    Organization? org,
    Property? property,
  }) {
    return VirtualTour(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      propertyId: propertyId ?? this.propertyId,
      name: name ?? this.name,
      description: description ?? this.description,
      tourType: tourType ?? this.tourType,
      videoUrl: videoUrl ?? this.videoUrl,
      embedCode: embedCode ?? this.embedCode,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      duration: duration ?? this.duration,
      isActive: isActive ?? this.isActive,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      org: org ?? this.org,
      property: property ?? this.property,
    );
  }
}
