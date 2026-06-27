import 'package:freezed_annotation/freezed_annotation.dart';

part 'property_marker.freezed.dart';
part 'property_marker.g.dart';

@freezed
class PropertyMarker with _$PropertyMarker {
  const factory PropertyMarker({
    required String id,
    required String title,
    required String price,
    required double latitude,
    required double longitude,
    @Default('property') String propertyType,
    String? imageUrl,
    String? description,
    @Default(0.0) double rating,
    String? address,
    @Default(0) int bedrooms,
    @Default(0) int bathrooms,
    @Default(0) double squareFeet,
    @Default(false) bool isAvailable,
    DateTime? listedDate,
    String? agentId,
    String? agentName,
    @Default([]) List<String> amenities,
    @Default([]) List<String> images,
    @Default(0.0) double distanceFromUser,
  }) = _PropertyMarker;

  factory PropertyMarker.fromJson(Map<String, dynamic> json) =>
      _$PropertyMarkerFromJson(json);
}

@freezed
class MapSearchResult with _$MapSearchResult {
  const factory MapSearchResult({
    required String placeId,
    required String description,
    required String mainText,
    required String secondaryText,
    @Default([]) List<String> types,
    Map<String, dynamic>? geometry,
  }) = _MapSearchResult;

  factory MapSearchResult.fromJson(Map<String, dynamic> json) =>
      _$MapSearchResultFromJson(json);
}

@freezed
class MapRoute with _$MapRoute {
  const factory MapRoute({
    required List<LatLng> points,
    required double distance,
    required String duration,
    required String distanceText,
    required String durationText,
    @Default([]) List<MapStep> steps,
  }) = _MapRoute;

  factory MapRoute.fromJson(Map<String, dynamic> json) =>
      _$MapRouteFromJson(json);
}

@freezed
class MapStep with _$MapStep {
  const factory MapStep({
    required String instruction,
    required double distance,
    required String distanceText,
    required String duration,
    required String durationText,
    required LatLng startLocation,
    required LatLng endLocation,
    @Default('driving') String travelMode,
  }) = _MapStep;

  factory MapStep.fromJson(Map<String, dynamic> json) =>
      _$MapStepFromJson(json);
}

class LatLng {
  final double latitude;
  final double longitude;

  const LatLng(this.latitude, this.longitude);

  Map<String, dynamic> toJson() => {
        'latitude': latitude,
        'longitude': longitude,
      };

  factory LatLng.fromJson(Map<String, dynamic> json) => LatLng(
        json['latitude'] as double,
        json['longitude'] as double,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LatLng &&
          runtimeType == other.runtimeType &&
          latitude == other.latitude &&
          longitude == other.longitude;

  @override
  int get hashCode => latitude.hashCode ^ longitude.hashCode;

  @override
  String toString() => 'LatLng($latitude, $longitude)';
}

// Property type enum
enum PropertyType {
  house,
  apartment,
  condo,
  townhouse,
  commercial,
  land,
  villa,
  studio,
}

extension PropertyTypeExtension on PropertyType {
  String get displayName {
    switch (this) {
      case PropertyType.house:
        return 'House';
      case PropertyType.apartment:
        return 'Apartment';
      case PropertyType.condo:
        return 'Condo';
      case PropertyType.townhouse:
        return 'Townhouse';
      case PropertyType.commercial:
        return 'Commercial';
      case PropertyType.land:
        return 'Land';
      case PropertyType.villa:
        return 'Villa';
      case PropertyType.studio:
        return 'Studio';
    }
  }

  String get iconPath {
    switch (this) {
      case PropertyType.house:
        return 'assets/icons/house.png';
      case PropertyType.apartment:
        return 'assets/icons/apartment.png';
      case PropertyType.condo:
        return 'assets/icons/condo.png';
      case PropertyType.townhouse:
        return 'assets/icons/townhouse.png';
      case PropertyType.commercial:
        return 'assets/icons/commercial.png';
      case PropertyType.land:
        return 'assets/icons/land.png';
      case PropertyType.villa:
        return 'assets/icons/villa.png';
      case PropertyType.studio:
        return 'assets/icons/studio.png';
    }
  }
}

// Property filter options
@freezed
class PropertyFilter with _$PropertyFilter {
  const factory PropertyFilter({
    PropertyType? propertyType,
    double? minPrice,
    double? maxPrice,
    int? minBedrooms,
    int? maxBedrooms,
    int? minBathrooms,
    int? maxBathrooms,
    double? minSquareFeet,
    double? maxSquareFeet,
    bool? isAvailable,
    double? maxDistance,
    @Default([]) List<String> amenities,
    String? agentId,
    DateTime? listedAfter,
    DateTime? listedBefore,
  }) = _PropertyFilter;

  factory PropertyFilter.fromJson(Map<String, dynamic> json) =>
      _$PropertyFilterFromJson(json);
}

// Map view preferences
@freezed
class MapPreferences with _$MapPreferences {
  const factory MapPreferences({
    @Default(MapType.normal) MapType mapType,
    @Default(14.0) double defaultZoom,
    @Default(true) bool showTraffic,
    @Default(true) bool showUserLocation,
    @Default(true) bool enableClustering,
    @Default([]) List<PropertyType> visiblePropertyTypes,
    @Default(true) bool showPriceLabels,
    @Default(true) bool showDistanceLabels,
  }) = _MapPreferences;

  factory MapPreferences.fromJson(Map<String, dynamic> json) =>
      _$MapPreferencesFromJson(json);
}

enum MapType {
  normal,
  satellite,
  hybrid,
  terrain,
}

extension MapTypeExtension on MapType {
  String get displayName {
    switch (this) {
      case MapType.normal:
        return 'Normal';
      case MapType.satellite:
        return 'Satellite';
      case MapType.hybrid:
        return 'Hybrid';
      case MapType.terrain:
        return 'Terrain';
    }
  }
}
