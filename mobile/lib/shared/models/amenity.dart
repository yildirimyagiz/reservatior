import 'package:reservatior/shared/enums/amenity_category.dart';
import 'organization.dart';
import 'property_amenity.dart';

class Amenity {
  final String id;
  final String orgId;
  final String name;
  final AmenityCategory category;
  final String? icon;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final Organization? org;
  final List<PropertyAmenity> propertyAmenities;

  const Amenity({
    required this.id,
    required this.orgId,
    required this.name,
    required this.category,
    this.icon,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.org,
    this.propertyAmenities = const [],
  });

  factory Amenity.fromJson(Map<String, dynamic> json) {
    return Amenity(
      id: json['id'] as String,
      orgId: json['orgId'] as String,
      name: json['name'] as String,
      category: (() {
        final valUpper = json['category']?.toString().toUpperCase() ?? '';
        return AmenityCategory.values.firstWhere(
          (v) => v.name.toUpperCase() == valUpper,
          orElse: () => AmenityCategory.OTHER,
        );
      })(),
      icon: json['icon'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      org: json['org'] != null ? Organization.fromJson(json['org'] as Map<String, dynamic>) : null,
      propertyAmenities: (json['propertyAmenities'] as List<dynamic>?)?.map((e) => PropertyAmenity.fromJson(e as Map<String, dynamic>)).toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'name': name,
      'category': category.name,
      'icon': icon,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'org': org?.toJson(),
      'propertyAmenities': propertyAmenities.map((e) => e.toJson()).toList(),
    };
  }

  Amenity copyWith({
    String? id,
    String? orgId,
    String? name,
    AmenityCategory? category,
    String? icon,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    Organization? org,
    List<PropertyAmenity>? propertyAmenities,
  }) {
    return Amenity(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      name: name ?? this.name,
      category: category ?? this.category,
      icon: icon ?? this.icon,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      org: org ?? this.org,
      propertyAmenities: propertyAmenities ?? this.propertyAmenities,
    );
  }
}
