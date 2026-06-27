import 'facility.dart';

class FacilityBlock {
  final String id;
  final String facilityId;
  final String name;
  final int floors;
  final int? unitsPerFloor;
  final int totalUnits;
  final int? yearBuilt;
  final String? architect;
  final List<String> features;
  final List<String> images;
  final Facility facility;

  const FacilityBlock({
    required this.id,
    required this.facilityId,
    required this.name,
    required this.floors,
    this.unitsPerFloor,
    required this.totalUnits,
    this.yearBuilt,
    this.architect,
    this.features = const [],
    this.images = const [],
    required this.facility,
  });

  factory FacilityBlock.fromJson(Map<String, dynamic> json) {
    return FacilityBlock(
      id: json['id'] as String,
      facilityId: json['facilityId'] as String,
      name: json['name'] as String,
      floors: json['floors'] as int,
      unitsPerFloor: json['unitsPerFloor'] as int?,
      totalUnits: json['totalUnits'] as int,
      yearBuilt: json['yearBuilt'] as int?,
      architect: json['architect'] as String?,
      features: (json['features'] as List<dynamic>?)?.cast<String>() ?? [],
      images: (json['images'] as List<dynamic>?)?.cast<String>() ?? [],
      facility: Facility.fromJson(json['facility'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'facilityId': facilityId,
      'name': name,
      'floors': floors,
      'unitsPerFloor': unitsPerFloor,
      'totalUnits': totalUnits,
      'yearBuilt': yearBuilt,
      'architect': architect,
      'features': features,
      'images': images,
      'facility': facility.toJson(),
    };
  }

  FacilityBlock copyWith({
    String? id,
    String? facilityId,
    String? name,
    int? floors,
    int? unitsPerFloor,
    int? totalUnits,
    int? yearBuilt,
    String? architect,
    List<String>? features,
    List<String>? images,
    Facility? facility,
  }) {
    return FacilityBlock(
      id: id ?? this.id,
      facilityId: facilityId ?? this.facilityId,
      name: name ?? this.name,
      floors: floors ?? this.floors,
      unitsPerFloor: unitsPerFloor ?? this.unitsPerFloor,
      totalUnits: totalUnits ?? this.totalUnits,
      yearBuilt: yearBuilt ?? this.yearBuilt,
      architect: architect ?? this.architect,
      features: features ?? this.features,
      images: images ?? this.images,
      facility: facility ?? this.facility,
    );
  }
}
