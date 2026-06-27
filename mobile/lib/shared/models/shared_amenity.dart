import 'package:reservatior/shared/enums/amenity_access_type.dart';
import 'package:reservatior/shared/enums/shared_amenity_type.dart';
import 'facility.dart';

class SharedAmenity {
  final String id;
  final String facilityId;
  final String name;
  final SharedAmenityType type;
  final String? description;
  final String? location;
  final int? capacity;
  final bool isAvailable;
  final String? operatingHours;
  final AmenityAccessType accessType;
  final double? price;
  final List<String> images;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Facility facility;

  const SharedAmenity({
    required this.id,
    required this.facilityId,
    required this.name,
    required this.type,
    this.description,
    this.location,
    this.capacity,
    required this.isAvailable,
    this.operatingHours,
    required this.accessType,
    this.price,
    this.images = const [],
    required this.createdAt,
    required this.updatedAt,
    required this.facility,
  });

  factory SharedAmenity.fromJson(Map<String, dynamic> json) {
    return SharedAmenity(
      id: json['id'] as String,
      facilityId: json['facilityId'] as String,
      name: json['name'] as String,
      type: SharedAmenityType.values.firstWhere((v) => v.name == json['type']),
      description: json['description'] as String?,
      location: json['location'] as String?,
      capacity: json['capacity'] as int?,
      isAvailable: json['isAvailable'] as bool,
      operatingHours: json['operatingHours'] as String?,
      accessType: AmenityAccessType.values.firstWhere((v) => v.name == json['accessType']),
      price: (json['price'] as num?)?.toDouble(),
      images: (json['images'] as List<dynamic>?)?.cast<String>() ?? [],
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      facility: Facility.fromJson(json['facility'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'facilityId': facilityId,
      'name': name,
      'type': type.name,
      'description': description,
      'location': location,
      'capacity': capacity,
      'isAvailable': isAvailable,
      'operatingHours': operatingHours,
      'accessType': accessType.name,
      'price': price,
      'images': images,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'facility': facility.toJson(),
    };
  }

  SharedAmenity copyWith({
    String? id,
    String? facilityId,
    String? name,
    SharedAmenityType? type,
    String? description,
    String? location,
    int? capacity,
    bool? isAvailable,
    String? operatingHours,
    AmenityAccessType? accessType,
    double? price,
    List<String>? images,
    DateTime? createdAt,
    DateTime? updatedAt,
    Facility? facility,
  }) {
    return SharedAmenity(
      id: id ?? this.id,
      facilityId: facilityId ?? this.facilityId,
      name: name ?? this.name,
      type: type ?? this.type,
      description: description ?? this.description,
      location: location ?? this.location,
      capacity: capacity ?? this.capacity,
      isAvailable: isAvailable ?? this.isAvailable,
      operatingHours: operatingHours ?? this.operatingHours,
      accessType: accessType ?? this.accessType,
      price: price ?? this.price,
      images: images ?? this.images,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      facility: facility ?? this.facility,
    );
  }
}
