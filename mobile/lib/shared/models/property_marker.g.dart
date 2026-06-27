// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'property_marker.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PropertyMarkerImpl _$$PropertyMarkerImplFromJson(
  Map<String, dynamic> json,
) => _$PropertyMarkerImpl(
  id: json['id'] as String,
  title: json['title'] as String,
  price: json['price'] as String,
  latitude: (json['latitude'] as num).toDouble(),
  longitude: (json['longitude'] as num).toDouble(),
  propertyType: json['propertyType'] as String? ?? 'property',
  imageUrl: json['imageUrl'] as String?,
  description: json['description'] as String?,
  rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
  address: json['address'] as String?,
  bedrooms: (json['bedrooms'] as num?)?.toInt() ?? 0,
  bathrooms: (json['bathrooms'] as num?)?.toInt() ?? 0,
  squareFeet: (json['squareFeet'] as num?)?.toDouble() ?? 0,
  isAvailable: json['isAvailable'] as bool? ?? false,
  listedDate: json['listedDate'] == null
      ? null
      : DateTime.parse(json['listedDate'] as String),
  agentId: json['agentId'] as String?,
  agentName: json['agentName'] as String?,
  amenities:
      (json['amenities'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  images:
      (json['images'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  distanceFromUser: (json['distanceFromUser'] as num?)?.toDouble() ?? 0.0,
);

Map<String, dynamic> _$$PropertyMarkerImplToJson(
  _$PropertyMarkerImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'price': instance.price,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'propertyType': instance.propertyType,
  'imageUrl': instance.imageUrl,
  'description': instance.description,
  'rating': instance.rating,
  'address': instance.address,
  'bedrooms': instance.bedrooms,
  'bathrooms': instance.bathrooms,
  'squareFeet': instance.squareFeet,
  'isAvailable': instance.isAvailable,
  'listedDate': instance.listedDate?.toIso8601String(),
  'agentId': instance.agentId,
  'agentName': instance.agentName,
  'amenities': instance.amenities,
  'images': instance.images,
  'distanceFromUser': instance.distanceFromUser,
};

_$MapSearchResultImpl _$$MapSearchResultImplFromJson(
  Map<String, dynamic> json,
) => _$MapSearchResultImpl(
  placeId: json['placeId'] as String,
  description: json['description'] as String,
  mainText: json['mainText'] as String,
  secondaryText: json['secondaryText'] as String,
  types:
      (json['types'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  geometry: json['geometry'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$$MapSearchResultImplToJson(
  _$MapSearchResultImpl instance,
) => <String, dynamic>{
  'placeId': instance.placeId,
  'description': instance.description,
  'mainText': instance.mainText,
  'secondaryText': instance.secondaryText,
  'types': instance.types,
  'geometry': instance.geometry,
};

_$MapRouteImpl _$$MapRouteImplFromJson(Map<String, dynamic> json) =>
    _$MapRouteImpl(
      points: (json['points'] as List<dynamic>)
          .map((e) => LatLng.fromJson(e as Map<String, dynamic>))
          .toList(),
      distance: (json['distance'] as num).toDouble(),
      duration: json['duration'] as String,
      distanceText: json['distanceText'] as String,
      durationText: json['durationText'] as String,
      steps:
          (json['steps'] as List<dynamic>?)
              ?.map((e) => MapStep.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$MapRouteImplToJson(_$MapRouteImpl instance) =>
    <String, dynamic>{
      'points': instance.points,
      'distance': instance.distance,
      'duration': instance.duration,
      'distanceText': instance.distanceText,
      'durationText': instance.durationText,
      'steps': instance.steps,
    };

_$MapStepImpl _$$MapStepImplFromJson(Map<String, dynamic> json) =>
    _$MapStepImpl(
      instruction: json['instruction'] as String,
      distance: (json['distance'] as num).toDouble(),
      distanceText: json['distanceText'] as String,
      duration: json['duration'] as String,
      durationText: json['durationText'] as String,
      startLocation: LatLng.fromJson(
        json['startLocation'] as Map<String, dynamic>,
      ),
      endLocation: LatLng.fromJson(json['endLocation'] as Map<String, dynamic>),
      travelMode: json['travelMode'] as String? ?? 'driving',
    );

Map<String, dynamic> _$$MapStepImplToJson(_$MapStepImpl instance) =>
    <String, dynamic>{
      'instruction': instance.instruction,
      'distance': instance.distance,
      'distanceText': instance.distanceText,
      'duration': instance.duration,
      'durationText': instance.durationText,
      'startLocation': instance.startLocation,
      'endLocation': instance.endLocation,
      'travelMode': instance.travelMode,
    };

_$PropertyFilterImpl _$$PropertyFilterImplFromJson(Map<String, dynamic> json) =>
    _$PropertyFilterImpl(
      propertyType: $enumDecodeNullable(
        _$PropertyTypeEnumMap,
        json['propertyType'],
      ),
      minPrice: (json['minPrice'] as num?)?.toDouble(),
      maxPrice: (json['maxPrice'] as num?)?.toDouble(),
      minBedrooms: (json['minBedrooms'] as num?)?.toInt(),
      maxBedrooms: (json['maxBedrooms'] as num?)?.toInt(),
      minBathrooms: (json['minBathrooms'] as num?)?.toInt(),
      maxBathrooms: (json['maxBathrooms'] as num?)?.toInt(),
      minSquareFeet: (json['minSquareFeet'] as num?)?.toDouble(),
      maxSquareFeet: (json['maxSquareFeet'] as num?)?.toDouble(),
      isAvailable: json['isAvailable'] as bool?,
      maxDistance: (json['maxDistance'] as num?)?.toDouble(),
      amenities:
          (json['amenities'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      agentId: json['agentId'] as String?,
      listedAfter: json['listedAfter'] == null
          ? null
          : DateTime.parse(json['listedAfter'] as String),
      listedBefore: json['listedBefore'] == null
          ? null
          : DateTime.parse(json['listedBefore'] as String),
    );

Map<String, dynamic> _$$PropertyFilterImplToJson(
  _$PropertyFilterImpl instance,
) => <String, dynamic>{
  'propertyType': _$PropertyTypeEnumMap[instance.propertyType],
  'minPrice': instance.minPrice,
  'maxPrice': instance.maxPrice,
  'minBedrooms': instance.minBedrooms,
  'maxBedrooms': instance.maxBedrooms,
  'minBathrooms': instance.minBathrooms,
  'maxBathrooms': instance.maxBathrooms,
  'minSquareFeet': instance.minSquareFeet,
  'maxSquareFeet': instance.maxSquareFeet,
  'isAvailable': instance.isAvailable,
  'maxDistance': instance.maxDistance,
  'amenities': instance.amenities,
  'agentId': instance.agentId,
  'listedAfter': instance.listedAfter?.toIso8601String(),
  'listedBefore': instance.listedBefore?.toIso8601String(),
};

const _$PropertyTypeEnumMap = {
  PropertyType.house: 'house',
  PropertyType.apartment: 'apartment',
  PropertyType.condo: 'condo',
  PropertyType.townhouse: 'townhouse',
  PropertyType.commercial: 'commercial',
  PropertyType.land: 'land',
  PropertyType.villa: 'villa',
  PropertyType.studio: 'studio',
};

_$MapPreferencesImpl _$$MapPreferencesImplFromJson(Map<String, dynamic> json) =>
    _$MapPreferencesImpl(
      mapType:
          $enumDecodeNullable(_$MapTypeEnumMap, json['mapType']) ??
          MapType.normal,
      defaultZoom: (json['defaultZoom'] as num?)?.toDouble() ?? 14.0,
      showTraffic: json['showTraffic'] as bool? ?? true,
      showUserLocation: json['showUserLocation'] as bool? ?? true,
      enableClustering: json['enableClustering'] as bool? ?? true,
      visiblePropertyTypes:
          (json['visiblePropertyTypes'] as List<dynamic>?)
              ?.map((e) => $enumDecode(_$PropertyTypeEnumMap, e))
              .toList() ??
          const [],
      showPriceLabels: json['showPriceLabels'] as bool? ?? true,
      showDistanceLabels: json['showDistanceLabels'] as bool? ?? true,
    );

Map<String, dynamic> _$$MapPreferencesImplToJson(
  _$MapPreferencesImpl instance,
) => <String, dynamic>{
  'mapType': _$MapTypeEnumMap[instance.mapType]!,
  'defaultZoom': instance.defaultZoom,
  'showTraffic': instance.showTraffic,
  'showUserLocation': instance.showUserLocation,
  'enableClustering': instance.enableClustering,
  'visiblePropertyTypes': instance.visiblePropertyTypes
      .map((e) => _$PropertyTypeEnumMap[e]!)
      .toList(),
  'showPriceLabels': instance.showPriceLabels,
  'showDistanceLabels': instance.showDistanceLabels,
};

const _$MapTypeEnumMap = {
  MapType.normal: 'normal',
  MapType.satellite: 'satellite',
  MapType.hybrid: 'hybrid',
  MapType.terrain: 'terrain',
};
