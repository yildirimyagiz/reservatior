import 'amenity.dart';
import 'organization.dart';
import 'property.dart';

class PropertyAmenity {
  final String id;
  final String propertyId;
  final String amenityId;
  final String orgId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final Amenity? amenity;
  final Organization? org;
  final Property? property;

  const PropertyAmenity({
    required this.id,
    required this.propertyId,
    required this.amenityId,
    required this.orgId,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.amenity,
    this.org,
    this.property,
  });

  factory PropertyAmenity.fromJson(Map<String, dynamic> json) {
    return PropertyAmenity(
      id: json['id'] as String,
      propertyId: json['propertyId'] as String,
      amenityId: json['amenityId'] as String,
      orgId: json['orgId'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      amenity: json['amenity'] != null ? Amenity.fromJson(json['amenity'] as Map<String, dynamic>) : null,
      org: json['org'] != null ? Organization.fromJson(json['org'] as Map<String, dynamic>) : null,
      property: json['property'] != null ? Property.fromJson(json['property'] as Map<String, dynamic>) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'propertyId': propertyId,
      'amenityId': amenityId,
      'orgId': orgId,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'amenity': amenity?.toJson(),
      'org': org?.toJson(),
      'property': property?.toJson(),
    };
  }

  PropertyAmenity copyWith({
    String? id,
    String? propertyId,
    String? amenityId,
    String? orgId,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    Amenity? amenity,
    Organization? org,
    Property? property,
  }) {
    return PropertyAmenity(
      id: id ?? this.id,
      propertyId: propertyId ?? this.propertyId,
      amenityId: amenityId ?? this.amenityId,
      orgId: orgId ?? this.orgId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      amenity: amenity ?? this.amenity,
      org: org ?? this.org,
      property: property ?? this.property,
    );
  }
}
