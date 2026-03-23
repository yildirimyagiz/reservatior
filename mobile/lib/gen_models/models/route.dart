
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'map_provider.dart';
import 'location.dart';
import 'organization.dart';


class Route implements PrismaModel<String, Route> , Id<String> {
    @override
String? id;
	String? orgId;
	String? name;
	String? type;
	String? startLocationId;
	String? endLocationId;
	dynamic waypoints;
	double? distance;
	int? duration;
	String? polyline;
	MapProvider? provider;
	dynamic instructions;
	dynamic trafficData;
	double? tolls;
	bool? isVisible;
	String? color;
	int? strokeWidth;
	double? opacity;
	String? createdBy;
	DateTime? createdAt;
	DateTime? updatedAt;
	DateTime? deletedAt;
	Location? endLocation;
	Organization? org;
	Location? startLocation;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    Route({ this.id,
	 this.orgId,
	 this.name,
	 this.type,
	 this.startLocationId,
	 this.endLocationId,
	required this.waypoints,
	 this.distance,
	 this.duration,
	 this.polyline,
	 this.provider,
	required this.instructions,
	required this.trafficData,
	 this.tolls,
	 this.isVisible = true,
	 this.color,
	 this.strokeWidth = 4,
	 this.opacity = 0.8,
	 this.createdBy,
	 this.createdAt,
	 this.updatedAt,
	 this.deletedAt,
	 this.endLocation,
	 this.org,
	 this.startLocation,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<Route, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"orgId": (m) => m.orgId,

	"name": (m) => m.name,

	"type": (m) => m.type,

	"startLocationId": (m) => m.startLocationId,

	"endLocationId": (m) => m.endLocationId,

	"waypoints": (m) => m.waypoints,

	"distance": (m) => m.distance,

	"duration": (m) => m.duration,

	"polyline": (m) => m.polyline,

	"provider": (m) => m.provider,

	"instructions": (m) => m.instructions,

	"trafficData": (m) => m.trafficData,

	"tolls": (m) => m.tolls,

	"isVisible": (m) => m.isVisible,

	"color": (m) => m.color,

	"strokeWidth": (m) => m.strokeWidth,

	"opacity": (m) => m.opacity,

	"createdBy": (m) => m.createdBy,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"deletedAt": (m) => m.deletedAt,

	"endLocation": (m) => m.endLocation,

	"org": (m) => m.org,

	"startLocation": (m) => m.startLocation,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(Route) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in Route');
    }
    return propFunction as V? Function(Route);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory Route.fromJson(JsonMap json) =>
      Route(
        id: json['id'] as String?,
	orgId: json['orgId'] as String?,
	name: json['name'] as String?,
	type: json['type'] as String?,
	startLocationId: json['startLocationId'] as String?,
	endLocationId: json['endLocationId'] as String?,
	waypoints: json['waypoints'] as dynamic,
	distance: json['distance']?.toDouble(),
	duration: int.tryParse(json['duration'].toString()),
	polyline: json['polyline'] as String?,
	provider: json['provider'] != null ? MapProvider.fromJson(json['provider']) : null,
	instructions: json['instructions'] as dynamic,
	trafficData: json['trafficData'] as dynamic,
	tolls: json['tolls']?.toDouble(),
	isVisible: json['isVisible'] as bool?,
	color: json['color'] as String?,
	strokeWidth: int.tryParse(json['strokeWidth'].toString()),
	opacity: json['opacity']?.toDouble(),
	createdBy: json['createdBy'] as String?,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
	endLocation: json['endLocation'] != null ? Location.fromJson(json['endLocation'] as JsonMap) : null,
	org: json['org'] != null ? Organization.fromJson(json['org'] as JsonMap) : null,
	startLocation: json['startLocation'] != null ? Location.fromJson(json['startLocation'] as JsonMap) : null,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    Route copyWith({
        Value<String?>? id,
		Value<String?>? orgId,
		Value<String?>? name,
		Value<String?>? type,
		Value<String?>? startLocationId,
		Value<String?>? endLocationId,
		Value<dynamic>? waypoints,
		Value<double?>? distance,
		Value<int?>? duration,
		Value<String?>? polyline,
		Value<MapProvider?>? provider,
		Value<dynamic>? instructions,
		Value<dynamic>? trafficData,
		Value<double?>? tolls,
		Value<bool?>? isVisible,
		Value<String?>? color,
		Value<int?>? strokeWidth,
		Value<double?>? opacity,
		Value<String?>? createdBy,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<DateTime?>? deletedAt,
		Value<Location?>? endLocation,
		Value<Organization?>? org,
		Value<Location?>? startLocation,
        }) {
        return Route(
            id: id != null ? id.value : this.id,
		orgId: orgId != null ? orgId.value : this.orgId,
		name: name != null ? name.value : this.name,
		type: type != null ? type.value : this.type,
		startLocationId: startLocationId != null ? startLocationId.value : this.startLocationId,
		endLocationId: endLocationId != null ? endLocationId.value : this.endLocationId,
		waypoints: waypoints != null ? waypoints.value : this.waypoints,
		distance: distance != null ? distance.value : this.distance,
		duration: duration != null ? duration.value : this.duration,
		polyline: polyline != null ? polyline.value : this.polyline,
		provider: provider != null ? provider.value : this.provider,
		instructions: instructions != null ? instructions.value : this.instructions,
		trafficData: trafficData != null ? trafficData.value : this.trafficData,
		tolls: tolls != null ? tolls.value : this.tolls,
		isVisible: isVisible != null ? isVisible.value : this.isVisible,
		color: color != null ? color.value : this.color,
		strokeWidth: strokeWidth != null ? strokeWidth.value : this.strokeWidth,
		opacity: opacity != null ? opacity.value : this.opacity,
		createdBy: createdBy != null ? createdBy.value : this.createdBy,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		deletedAt: deletedAt != null ? deletedAt.value : this.deletedAt,
		endLocation: endLocation != null ? endLocation.value : this.endLocation,
		org: org != null ? org.value : this.org,
		startLocation: startLocation != null ? startLocation.value : this.startLocation
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    Route copyWithInstanceValues(Route route) {
        return Route(
            id: route.id ?? id,
		orgId: route.orgId ?? orgId,
		name: route.name ?? name,
		type: route.type ?? type,
		startLocationId: route.startLocationId ?? startLocationId,
		endLocationId: route.endLocationId ?? endLocationId,
		waypoints: route.waypoints ?? waypoints,
		distance: route.distance ?? distance,
		duration: route.duration ?? duration,
		polyline: route.polyline ?? polyline,
		provider: route.provider ?? provider,
		instructions: route.instructions ?? instructions,
		trafficData: route.trafficData ?? trafficData,
		tolls: route.tolls ?? tolls,
		isVisible: route.isVisible ?? isVisible,
		color: route.color ?? color,
		strokeWidth: route.strokeWidth ?? strokeWidth,
		opacity: route.opacity ?? opacity,
		createdBy: route.createdBy ?? createdBy,
		createdAt: route.createdAt ?? createdAt,
		updatedAt: route.updatedAt ?? updatedAt,
		deletedAt: route.deletedAt ?? deletedAt,
		endLocation: route.endLocation ?? endLocation,
		org: route.org ?? org,
		startLocation: route.startLocation ?? startLocation
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    Route mergeWithInstanceValues(Route route) {
        return Route(
            id: route.$assignedFields.contains('id') ? route.id : id,
		orgId: route.$assignedFields.contains('orgId') ? route.orgId : orgId,
		name: route.$assignedFields.contains('name') ? route.name : name,
		type: route.$assignedFields.contains('type') ? route.type : type,
		startLocationId: route.$assignedFields.contains('startLocationId') ? route.startLocationId : startLocationId,
		endLocationId: route.$assignedFields.contains('endLocationId') ? route.endLocationId : endLocationId,
		waypoints: route.$assignedFields.contains('waypoints') ? route.waypoints : waypoints,
		distance: route.$assignedFields.contains('distance') ? route.distance : distance,
		duration: route.$assignedFields.contains('duration') ? route.duration : duration,
		polyline: route.$assignedFields.contains('polyline') ? route.polyline : polyline,
		provider: route.$assignedFields.contains('provider') ? route.provider : provider,
		instructions: route.$assignedFields.contains('instructions') ? route.instructions : instructions,
		trafficData: route.$assignedFields.contains('trafficData') ? route.trafficData : trafficData,
		tolls: route.$assignedFields.contains('tolls') ? route.tolls : tolls,
		isVisible: route.$assignedFields.contains('isVisible') ? route.isVisible : isVisible,
		color: route.$assignedFields.contains('color') ? route.color : color,
		strokeWidth: route.$assignedFields.contains('strokeWidth') ? route.strokeWidth : strokeWidth,
		opacity: route.$assignedFields.contains('opacity') ? route.opacity : opacity,
		createdBy: route.$assignedFields.contains('createdBy') ? route.createdBy : createdBy,
		createdAt: route.$assignedFields.contains('createdAt') ? route.createdAt : createdAt,
		updatedAt: route.$assignedFields.contains('updatedAt') ? route.updatedAt : updatedAt,
		deletedAt: route.$assignedFields.contains('deletedAt') ? route.deletedAt : deletedAt,
		endLocation: route.$assignedFields.contains('endLocation') ? route.endLocation : endLocation,
		org: route.$assignedFields.contains('org') ? route.org : org,
		startLocation: route.$assignedFields.contains('startLocation') ? route.startLocation : startLocation
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    Route updateWithInstanceValues(Route route) {
        if (route.$assignedFields.contains('id')) { id = route.id; }
		if (route.$assignedFields.contains('orgId')) { orgId = route.orgId; }
		if (route.$assignedFields.contains('name')) { name = route.name; }
		if (route.$assignedFields.contains('type')) { type = route.type; }
		if (route.$assignedFields.contains('startLocationId')) { startLocationId = route.startLocationId; }
		if (route.$assignedFields.contains('endLocationId')) { endLocationId = route.endLocationId; }
		if (route.$assignedFields.contains('waypoints')) { waypoints = route.waypoints; }
		if (route.$assignedFields.contains('distance')) { distance = route.distance; }
		if (route.$assignedFields.contains('duration')) { duration = route.duration; }
		if (route.$assignedFields.contains('polyline')) { polyline = route.polyline; }
		if (route.$assignedFields.contains('provider')) { provider = route.provider; }
		if (route.$assignedFields.contains('instructions')) { instructions = route.instructions; }
		if (route.$assignedFields.contains('trafficData')) { trafficData = route.trafficData; }
		if (route.$assignedFields.contains('tolls')) { tolls = route.tolls; }
		if (route.$assignedFields.contains('isVisible')) { isVisible = route.isVisible; }
		if (route.$assignedFields.contains('color')) { color = route.color; }
		if (route.$assignedFields.contains('strokeWidth')) { strokeWidth = route.strokeWidth; }
		if (route.$assignedFields.contains('opacity')) { opacity = route.opacity; }
		if (route.$assignedFields.contains('createdBy')) { createdBy = route.createdBy; }
		if (route.$assignedFields.contains('createdAt')) { createdAt = route.createdAt; }
		if (route.$assignedFields.contains('updatedAt')) { updatedAt = route.updatedAt; }
		if (route.$assignedFields.contains('deletedAt')) { deletedAt = route.deletedAt; }
		if (route.$assignedFields.contains('endLocation')) { endLocation = route.endLocation; }
		if (route.$assignedFields.contains('org')) { org = route.org; }
		if (route.$assignedFields.contains('startLocation')) { startLocation = route.startLocation; }
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
          ? {...?serializedTypes, 'Route'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(orgId != null) 'orgId': orgId,
	if(name != null) 'name': name,
	if(type != null) 'type': type,
	if(startLocationId != null) 'startLocationId': startLocationId,
	if(endLocationId != null) 'endLocationId': endLocationId,
	if(waypoints != null) 'waypoints': waypoints,
	if(distance != null) 'distance': distance,
	if(duration != null) 'duration': duration,
	if(polyline != null) 'polyline': polyline,
	if(provider != null) 'provider': provider?.toJson(),
	if(instructions != null) 'instructions': instructions,
	if(trafficData != null) 'trafficData': trafficData,
	if(tolls != null) 'tolls': tolls,
	if(isVisible != null) 'isVisible': isVisible,
	if(color != null) 'color': color,
	if(strokeWidth != null) 'strokeWidth': strokeWidth,
	if(opacity != null) 'opacity': opacity,
	if(createdBy != null) 'createdBy': createdBy,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(deletedAt != null) 'deletedAt': deletedAt?.toIso8601String(),
	if(endLocation != null && (!preventCircularSerialization || !serializedModels.contains('Location'))) 'endLocation': endLocation?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(org != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'org': org?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(startLocation != null && (!preventCircularSerialization || !serializedModels.contains('Location'))) 'startLocation': startLocation?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is Route &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    