import 'organization.dart';
import 'property.dart';

class Neighborhood {
  final String id;
  final String orgId;
  final String name;
  final String city;
  final String? state;
  final String? zip;
  final double? lat;
  final double? lng;
  final double? avgPrice;
  final double? medianPrice;
  final int propertyCount;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final Organization org;
  final List<Property> properties;

  const Neighborhood({
    required this.id,
    required this.orgId,
    required this.name,
    required this.city,
    this.state,
    this.zip,
    this.lat,
    this.lng,
    this.avgPrice,
    this.medianPrice,
    required this.propertyCount,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.org,
    this.properties = const [],
  });

  factory Neighborhood.fromJson(Map<String, dynamic> json) {
    return Neighborhood(
      id: json['id'] as String,
      orgId: json['orgId'] as String,
      name: json['name'] as String,
      city: json['city'] as String,
      state: json['state'] as String?,
      zip: json['zip'] as String?,
      lat: (json['lat'] as num?)?.toDouble(),
      lng: (json['lng'] as num?)?.toDouble(),
      avgPrice: (json['avgPrice'] as num?)?.toDouble(),
      medianPrice: (json['medianPrice'] as num?)?.toDouble(),
      propertyCount: json['propertyCount'] as int,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      org: Organization.fromJson(json['org'] as Map<String, dynamic>),
      properties: (json['properties'] as List<dynamic>?)?.map((e) => Property.fromJson(e as Map<String, dynamic>)).toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'name': name,
      'city': city,
      'state': state,
      'zip': zip,
      'lat': lat,
      'lng': lng,
      'avgPrice': avgPrice,
      'medianPrice': medianPrice,
      'propertyCount': propertyCount,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'org': org.toJson(),
      'properties': properties.map((e) => e.toJson()).toList(),
    };
  }

  Neighborhood copyWith({
    String? id,
    String? orgId,
    String? name,
    String? city,
    String? state,
    String? zip,
    double? lat,
    double? lng,
    double? avgPrice,
    double? medianPrice,
    int? propertyCount,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    Organization? org,
    List<Property>? properties,
  }) {
    return Neighborhood(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      name: name ?? this.name,
      city: city ?? this.city,
      state: state ?? this.state,
      zip: zip ?? this.zip,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      avgPrice: avgPrice ?? this.avgPrice,
      medianPrice: medianPrice ?? this.medianPrice,
      propertyCount: propertyCount ?? this.propertyCount,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      org: org ?? this.org,
      properties: properties ?? this.properties,
    );
  }
}
