
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';


class MapData implements PrismaModel<String, MapData> , Id<String> {
    @override
String? id;
	String? projectId;
	dynamic coordinates;
	String? address;
	String? placeId;
	dynamic amenities;
	dynamic geocodingData;
	DateTime? createdAt;
	DateTime? updatedAt;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    MapData({ this.id,
	 this.projectId,
	required this.coordinates,
	 this.address,
	 this.placeId,
	required this.amenities,
	required this.geocodingData,
	 this.createdAt,
	 this.updatedAt,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<MapData, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"projectId": (m) => m.projectId,

	"coordinates": (m) => m.coordinates,

	"address": (m) => m.address,

	"placeId": (m) => m.placeId,

	"amenities": (m) => m.amenities,

	"geocodingData": (m) => m.geocodingData,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(MapData) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in MapData');
    }
    return propFunction as V? Function(MapData);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory MapData.fromJson(JsonMap json) =>
      MapData(
        id: json['id'] as String?,
	projectId: json['projectId'] as String?,
	coordinates: json['coordinates'] as dynamic,
	address: json['address'] as String?,
	placeId: json['placeId'] as String?,
	amenities: json['amenities'] as dynamic,
	geocodingData: json['geocodingData'] as dynamic,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    MapData copyWith({
        Value<String?>? id,
		Value<String?>? projectId,
		Value<dynamic>? coordinates,
		Value<String?>? address,
		Value<String?>? placeId,
		Value<dynamic>? amenities,
		Value<dynamic>? geocodingData,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
        }) {
        return MapData(
            id: id != null ? id.value : this.id,
		projectId: projectId != null ? projectId.value : this.projectId,
		coordinates: coordinates != null ? coordinates.value : this.coordinates,
		address: address != null ? address.value : this.address,
		placeId: placeId != null ? placeId.value : this.placeId,
		amenities: amenities != null ? amenities.value : this.amenities,
		geocodingData: geocodingData != null ? geocodingData.value : this.geocodingData,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    MapData copyWithInstanceValues(MapData mapData) {
        return MapData(
            id: mapData.id ?? id,
		projectId: mapData.projectId ?? projectId,
		coordinates: mapData.coordinates ?? coordinates,
		address: mapData.address ?? address,
		placeId: mapData.placeId ?? placeId,
		amenities: mapData.amenities ?? amenities,
		geocodingData: mapData.geocodingData ?? geocodingData,
		createdAt: mapData.createdAt ?? createdAt,
		updatedAt: mapData.updatedAt ?? updatedAt
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    MapData mergeWithInstanceValues(MapData mapData) {
        return MapData(
            id: mapData.$assignedFields.contains('id') ? mapData.id : id,
		projectId: mapData.$assignedFields.contains('projectId') ? mapData.projectId : projectId,
		coordinates: mapData.$assignedFields.contains('coordinates') ? mapData.coordinates : coordinates,
		address: mapData.$assignedFields.contains('address') ? mapData.address : address,
		placeId: mapData.$assignedFields.contains('placeId') ? mapData.placeId : placeId,
		amenities: mapData.$assignedFields.contains('amenities') ? mapData.amenities : amenities,
		geocodingData: mapData.$assignedFields.contains('geocodingData') ? mapData.geocodingData : geocodingData,
		createdAt: mapData.$assignedFields.contains('createdAt') ? mapData.createdAt : createdAt,
		updatedAt: mapData.$assignedFields.contains('updatedAt') ? mapData.updatedAt : updatedAt
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    MapData updateWithInstanceValues(MapData mapData) {
        if (mapData.$assignedFields.contains('id')) { id = mapData.id; }
		if (mapData.$assignedFields.contains('projectId')) { projectId = mapData.projectId; }
		if (mapData.$assignedFields.contains('coordinates')) { coordinates = mapData.coordinates; }
		if (mapData.$assignedFields.contains('address')) { address = mapData.address; }
		if (mapData.$assignedFields.contains('placeId')) { placeId = mapData.placeId; }
		if (mapData.$assignedFields.contains('amenities')) { amenities = mapData.amenities; }
		if (mapData.$assignedFields.contains('geocodingData')) { geocodingData = mapData.geocodingData; }
		if (mapData.$assignedFields.contains('createdAt')) { createdAt = mapData.createdAt; }
		if (mapData.$assignedFields.contains('updatedAt')) { updatedAt = mapData.updatedAt; }
        return this;
    }

    /// Converts this instance to a JSON object.
    /// 
    /// [serializedTypes] - Internal parameter tracking which model types have been serialized
    /// in the current chain to prevent circular references.
    /// [preventCircularSerialization] - When true (default), prevents infinite recursion by
    /// skipping relations whose types have already been serialized in the current chain.
    /// Set to false to serialize all relations (use with caution - may cause infinite loops).
    @override
    JsonMap toJson({
      Set<String>? serializedTypes,
      bool preventCircularSerialization = true,
    }) {
      final Set<String> serializedModels = preventCircularSerialization 
          ? {...?serializedTypes, 'MapData'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(projectId != null) 'projectId': projectId,
	if(coordinates != null) 'coordinates': coordinates,
	if(address != null) 'address': address,
	if(placeId != null) 'placeId': placeId,
	if(amenities != null) 'amenities': amenities,
	if(geocodingData != null) 'geocodingData': geocodingData,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String()
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is MapData &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    