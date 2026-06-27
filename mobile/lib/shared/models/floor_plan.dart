import 'organization.dart';
import 'property.dart';

class FloorPlan {
  final String id;
  final String orgId;
  final String propertyId;
  final String name;
  final String? description;
  final int floorLevel;
  final String imageUrl;
  final int? imageWidth;
  final int? imageHeight;
  final bool isActive;
  final String? createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final Organization org;
  final Property property;

  const FloorPlan({
    required this.id,
    required this.orgId,
    required this.propertyId,
    required this.name,
    this.description,
    required this.floorLevel,
    required this.imageUrl,
    this.imageWidth,
    this.imageHeight,
    required this.isActive,
    this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.org,
    required this.property,
  });

  factory FloorPlan.fromJson(Map<String, dynamic> json) {
    return FloorPlan(
      id: json['id'] as String,
      orgId: json['orgId'] as String,
      propertyId: json['propertyId'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      floorLevel: json['floorLevel'] as int,
      imageUrl: json['imageUrl'] as String,
      imageWidth: json['imageWidth'] as int?,
      imageHeight: json['imageHeight'] as int?,
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
      'floorLevel': floorLevel,
      'imageUrl': imageUrl,
      'imageWidth': imageWidth,
      'imageHeight': imageHeight,
      'isActive': isActive,
      'createdBy': createdBy,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'org': org.toJson(),
      'property': property.toJson(),
    };
  }

  FloorPlan copyWith({
    String? id,
    String? orgId,
    String? propertyId,
    String? name,
    String? description,
    int? floorLevel,
    String? imageUrl,
    int? imageWidth,
    int? imageHeight,
    bool? isActive,
    String? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    Organization? org,
    Property? property,
  }) {
    return FloorPlan(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      propertyId: propertyId ?? this.propertyId,
      name: name ?? this.name,
      description: description ?? this.description,
      floorLevel: floorLevel ?? this.floorLevel,
      imageUrl: imageUrl ?? this.imageUrl,
      imageWidth: imageWidth ?? this.imageWidth,
      imageHeight: imageHeight ?? this.imageHeight,
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
