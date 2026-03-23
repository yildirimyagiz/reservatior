
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'map_provider.dart';
import 'organization.dart';


class MapLayer implements PrismaModel<String, MapLayer> , Id<String> {
    @override
String? id;
	String? orgId;
	String? name;
	String? type;
	MapProvider? provider;
	String? url;
	dynamic config;
	bool? isVisible;
	double? opacity;
	int? zIndex;
	double? northEastLat;
	double? northEastLng;
	double? southWestLat;
	double? southWestLng;
	double? centerLat;
	double? centerLng;
	int? zoomLevel;
	int? minZoom;
	int? maxZoom;
	String? fillColor;
	String? strokeColor;
	double? strokeWidth;
	double? fillOpacity;
	String? createdBy;
	DateTime? createdAt;
	DateTime? updatedAt;
	DateTime? deletedAt;
	Organization? org;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    MapLayer({ this.id,
	 this.orgId,
	 this.name,
	 this.type,
	 this.provider,
	 this.url,
	required this.config,
	 this.isVisible = true,
	 this.opacity = 1,
	 this.zIndex = 0,
	 this.northEastLat,
	 this.northEastLng,
	 this.southWestLat,
	 this.southWestLng,
	 this.centerLat,
	 this.centerLng,
	 this.zoomLevel,
	 this.minZoom,
	 this.maxZoom,
	 this.fillColor,
	 this.strokeColor,
	 this.strokeWidth,
	 this.fillOpacity,
	 this.createdBy,
	 this.createdAt,
	 this.updatedAt,
	 this.deletedAt,
	 this.org,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<MapLayer, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"orgId": (m) => m.orgId,

	"name": (m) => m.name,

	"type": (m) => m.type,

	"provider": (m) => m.provider,

	"url": (m) => m.url,

	"config": (m) => m.config,

	"isVisible": (m) => m.isVisible,

	"opacity": (m) => m.opacity,

	"zIndex": (m) => m.zIndex,

	"northEastLat": (m) => m.northEastLat,

	"northEastLng": (m) => m.northEastLng,

	"southWestLat": (m) => m.southWestLat,

	"southWestLng": (m) => m.southWestLng,

	"centerLat": (m) => m.centerLat,

	"centerLng": (m) => m.centerLng,

	"zoomLevel": (m) => m.zoomLevel,

	"minZoom": (m) => m.minZoom,

	"maxZoom": (m) => m.maxZoom,

	"fillColor": (m) => m.fillColor,

	"strokeColor": (m) => m.strokeColor,

	"strokeWidth": (m) => m.strokeWidth,

	"fillOpacity": (m) => m.fillOpacity,

	"createdBy": (m) => m.createdBy,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"deletedAt": (m) => m.deletedAt,

	"org": (m) => m.org,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(MapLayer) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in MapLayer');
    }
    return propFunction as V? Function(MapLayer);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory MapLayer.fromJson(JsonMap json) =>
      MapLayer(
        id: json['id'] as String?,
	orgId: json['orgId'] as String?,
	name: json['name'] as String?,
	type: json['type'] as String?,
	provider: json['provider'] != null ? MapProvider.fromJson(json['provider']) : null,
	url: json['url'] as String?,
	config: json['config'] as dynamic,
	isVisible: json['isVisible'] as bool?,
	opacity: json['opacity']?.toDouble(),
	zIndex: int.tryParse(json['zIndex'].toString()),
	northEastLat: json['northEastLat']?.toDouble(),
	northEastLng: json['northEastLng']?.toDouble(),
	southWestLat: json['southWestLat']?.toDouble(),
	southWestLng: json['southWestLng']?.toDouble(),
	centerLat: json['centerLat']?.toDouble(),
	centerLng: json['centerLng']?.toDouble(),
	zoomLevel: int.tryParse(json['zoomLevel'].toString()),
	minZoom: int.tryParse(json['minZoom'].toString()),
	maxZoom: int.tryParse(json['maxZoom'].toString()),
	fillColor: json['fillColor'] as String?,
	strokeColor: json['strokeColor'] as String?,
	strokeWidth: json['strokeWidth']?.toDouble(),
	fillOpacity: json['fillOpacity']?.toDouble(),
	createdBy: json['createdBy'] as String?,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
	org: json['org'] != null ? Organization.fromJson(json['org'] as JsonMap) : null,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    MapLayer copyWith({
        Value<String?>? id,
		Value<String?>? orgId,
		Value<String?>? name,
		Value<String?>? type,
		Value<MapProvider?>? provider,
		Value<String?>? url,
		Value<dynamic>? config,
		Value<bool?>? isVisible,
		Value<double?>? opacity,
		Value<int?>? zIndex,
		Value<double?>? northEastLat,
		Value<double?>? northEastLng,
		Value<double?>? southWestLat,
		Value<double?>? southWestLng,
		Value<double?>? centerLat,
		Value<double?>? centerLng,
		Value<int?>? zoomLevel,
		Value<int?>? minZoom,
		Value<int?>? maxZoom,
		Value<String?>? fillColor,
		Value<String?>? strokeColor,
		Value<double?>? strokeWidth,
		Value<double?>? fillOpacity,
		Value<String?>? createdBy,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<DateTime?>? deletedAt,
		Value<Organization?>? org,
        }) {
        return MapLayer(
            id: id != null ? id.value : this.id,
		orgId: orgId != null ? orgId.value : this.orgId,
		name: name != null ? name.value : this.name,
		type: type != null ? type.value : this.type,
		provider: provider != null ? provider.value : this.provider,
		url: url != null ? url.value : this.url,
		config: config != null ? config.value : this.config,
		isVisible: isVisible != null ? isVisible.value : this.isVisible,
		opacity: opacity != null ? opacity.value : this.opacity,
		zIndex: zIndex != null ? zIndex.value : this.zIndex,
		northEastLat: northEastLat != null ? northEastLat.value : this.northEastLat,
		northEastLng: northEastLng != null ? northEastLng.value : this.northEastLng,
		southWestLat: southWestLat != null ? southWestLat.value : this.southWestLat,
		southWestLng: southWestLng != null ? southWestLng.value : this.southWestLng,
		centerLat: centerLat != null ? centerLat.value : this.centerLat,
		centerLng: centerLng != null ? centerLng.value : this.centerLng,
		zoomLevel: zoomLevel != null ? zoomLevel.value : this.zoomLevel,
		minZoom: minZoom != null ? minZoom.value : this.minZoom,
		maxZoom: maxZoom != null ? maxZoom.value : this.maxZoom,
		fillColor: fillColor != null ? fillColor.value : this.fillColor,
		strokeColor: strokeColor != null ? strokeColor.value : this.strokeColor,
		strokeWidth: strokeWidth != null ? strokeWidth.value : this.strokeWidth,
		fillOpacity: fillOpacity != null ? fillOpacity.value : this.fillOpacity,
		createdBy: createdBy != null ? createdBy.value : this.createdBy,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		deletedAt: deletedAt != null ? deletedAt.value : this.deletedAt,
		org: org != null ? org.value : this.org
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    MapLayer copyWithInstanceValues(MapLayer mapLayer) {
        return MapLayer(
            id: mapLayer.id ?? id,
		orgId: mapLayer.orgId ?? orgId,
		name: mapLayer.name ?? name,
		type: mapLayer.type ?? type,
		provider: mapLayer.provider ?? provider,
		url: mapLayer.url ?? url,
		config: mapLayer.config ?? config,
		isVisible: mapLayer.isVisible ?? isVisible,
		opacity: mapLayer.opacity ?? opacity,
		zIndex: mapLayer.zIndex ?? zIndex,
		northEastLat: mapLayer.northEastLat ?? northEastLat,
		northEastLng: mapLayer.northEastLng ?? northEastLng,
		southWestLat: mapLayer.southWestLat ?? southWestLat,
		southWestLng: mapLayer.southWestLng ?? southWestLng,
		centerLat: mapLayer.centerLat ?? centerLat,
		centerLng: mapLayer.centerLng ?? centerLng,
		zoomLevel: mapLayer.zoomLevel ?? zoomLevel,
		minZoom: mapLayer.minZoom ?? minZoom,
		maxZoom: mapLayer.maxZoom ?? maxZoom,
		fillColor: mapLayer.fillColor ?? fillColor,
		strokeColor: mapLayer.strokeColor ?? strokeColor,
		strokeWidth: mapLayer.strokeWidth ?? strokeWidth,
		fillOpacity: mapLayer.fillOpacity ?? fillOpacity,
		createdBy: mapLayer.createdBy ?? createdBy,
		createdAt: mapLayer.createdAt ?? createdAt,
		updatedAt: mapLayer.updatedAt ?? updatedAt,
		deletedAt: mapLayer.deletedAt ?? deletedAt,
		org: mapLayer.org ?? org
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    MapLayer mergeWithInstanceValues(MapLayer mapLayer) {
        return MapLayer(
            id: mapLayer.$assignedFields.contains('id') ? mapLayer.id : id,
		orgId: mapLayer.$assignedFields.contains('orgId') ? mapLayer.orgId : orgId,
		name: mapLayer.$assignedFields.contains('name') ? mapLayer.name : name,
		type: mapLayer.$assignedFields.contains('type') ? mapLayer.type : type,
		provider: mapLayer.$assignedFields.contains('provider') ? mapLayer.provider : provider,
		url: mapLayer.$assignedFields.contains('url') ? mapLayer.url : url,
		config: mapLayer.$assignedFields.contains('config') ? mapLayer.config : config,
		isVisible: mapLayer.$assignedFields.contains('isVisible') ? mapLayer.isVisible : isVisible,
		opacity: mapLayer.$assignedFields.contains('opacity') ? mapLayer.opacity : opacity,
		zIndex: mapLayer.$assignedFields.contains('zIndex') ? mapLayer.zIndex : zIndex,
		northEastLat: mapLayer.$assignedFields.contains('northEastLat') ? mapLayer.northEastLat : northEastLat,
		northEastLng: mapLayer.$assignedFields.contains('northEastLng') ? mapLayer.northEastLng : northEastLng,
		southWestLat: mapLayer.$assignedFields.contains('southWestLat') ? mapLayer.southWestLat : southWestLat,
		southWestLng: mapLayer.$assignedFields.contains('southWestLng') ? mapLayer.southWestLng : southWestLng,
		centerLat: mapLayer.$assignedFields.contains('centerLat') ? mapLayer.centerLat : centerLat,
		centerLng: mapLayer.$assignedFields.contains('centerLng') ? mapLayer.centerLng : centerLng,
		zoomLevel: mapLayer.$assignedFields.contains('zoomLevel') ? mapLayer.zoomLevel : zoomLevel,
		minZoom: mapLayer.$assignedFields.contains('minZoom') ? mapLayer.minZoom : minZoom,
		maxZoom: mapLayer.$assignedFields.contains('maxZoom') ? mapLayer.maxZoom : maxZoom,
		fillColor: mapLayer.$assignedFields.contains('fillColor') ? mapLayer.fillColor : fillColor,
		strokeColor: mapLayer.$assignedFields.contains('strokeColor') ? mapLayer.strokeColor : strokeColor,
		strokeWidth: mapLayer.$assignedFields.contains('strokeWidth') ? mapLayer.strokeWidth : strokeWidth,
		fillOpacity: mapLayer.$assignedFields.contains('fillOpacity') ? mapLayer.fillOpacity : fillOpacity,
		createdBy: mapLayer.$assignedFields.contains('createdBy') ? mapLayer.createdBy : createdBy,
		createdAt: mapLayer.$assignedFields.contains('createdAt') ? mapLayer.createdAt : createdAt,
		updatedAt: mapLayer.$assignedFields.contains('updatedAt') ? mapLayer.updatedAt : updatedAt,
		deletedAt: mapLayer.$assignedFields.contains('deletedAt') ? mapLayer.deletedAt : deletedAt,
		org: mapLayer.$assignedFields.contains('org') ? mapLayer.org : org
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    MapLayer updateWithInstanceValues(MapLayer mapLayer) {
        if (mapLayer.$assignedFields.contains('id')) { id = mapLayer.id; }
		if (mapLayer.$assignedFields.contains('orgId')) { orgId = mapLayer.orgId; }
		if (mapLayer.$assignedFields.contains('name')) { name = mapLayer.name; }
		if (mapLayer.$assignedFields.contains('type')) { type = mapLayer.type; }
		if (mapLayer.$assignedFields.contains('provider')) { provider = mapLayer.provider; }
		if (mapLayer.$assignedFields.contains('url')) { url = mapLayer.url; }
		if (mapLayer.$assignedFields.contains('config')) { config = mapLayer.config; }
		if (mapLayer.$assignedFields.contains('isVisible')) { isVisible = mapLayer.isVisible; }
		if (mapLayer.$assignedFields.contains('opacity')) { opacity = mapLayer.opacity; }
		if (mapLayer.$assignedFields.contains('zIndex')) { zIndex = mapLayer.zIndex; }
		if (mapLayer.$assignedFields.contains('northEastLat')) { northEastLat = mapLayer.northEastLat; }
		if (mapLayer.$assignedFields.contains('northEastLng')) { northEastLng = mapLayer.northEastLng; }
		if (mapLayer.$assignedFields.contains('southWestLat')) { southWestLat = mapLayer.southWestLat; }
		if (mapLayer.$assignedFields.contains('southWestLng')) { southWestLng = mapLayer.southWestLng; }
		if (mapLayer.$assignedFields.contains('centerLat')) { centerLat = mapLayer.centerLat; }
		if (mapLayer.$assignedFields.contains('centerLng')) { centerLng = mapLayer.centerLng; }
		if (mapLayer.$assignedFields.contains('zoomLevel')) { zoomLevel = mapLayer.zoomLevel; }
		if (mapLayer.$assignedFields.contains('minZoom')) { minZoom = mapLayer.minZoom; }
		if (mapLayer.$assignedFields.contains('maxZoom')) { maxZoom = mapLayer.maxZoom; }
		if (mapLayer.$assignedFields.contains('fillColor')) { fillColor = mapLayer.fillColor; }
		if (mapLayer.$assignedFields.contains('strokeColor')) { strokeColor = mapLayer.strokeColor; }
		if (mapLayer.$assignedFields.contains('strokeWidth')) { strokeWidth = mapLayer.strokeWidth; }
		if (mapLayer.$assignedFields.contains('fillOpacity')) { fillOpacity = mapLayer.fillOpacity; }
		if (mapLayer.$assignedFields.contains('createdBy')) { createdBy = mapLayer.createdBy; }
		if (mapLayer.$assignedFields.contains('createdAt')) { createdAt = mapLayer.createdAt; }
		if (mapLayer.$assignedFields.contains('updatedAt')) { updatedAt = mapLayer.updatedAt; }
		if (mapLayer.$assignedFields.contains('deletedAt')) { deletedAt = mapLayer.deletedAt; }
		if (mapLayer.$assignedFields.contains('org')) { org = mapLayer.org; }
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
          ? {...?serializedTypes, 'MapLayer'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(orgId != null) 'orgId': orgId,
	if(name != null) 'name': name,
	if(type != null) 'type': type,
	if(provider != null) 'provider': provider?.toJson(),
	if(url != null) 'url': url,
	if(config != null) 'config': config,
	if(isVisible != null) 'isVisible': isVisible,
	if(opacity != null) 'opacity': opacity,
	if(zIndex != null) 'zIndex': zIndex,
	if(northEastLat != null) 'northEastLat': northEastLat,
	if(northEastLng != null) 'northEastLng': northEastLng,
	if(southWestLat != null) 'southWestLat': southWestLat,
	if(southWestLng != null) 'southWestLng': southWestLng,
	if(centerLat != null) 'centerLat': centerLat,
	if(centerLng != null) 'centerLng': centerLng,
	if(zoomLevel != null) 'zoomLevel': zoomLevel,
	if(minZoom != null) 'minZoom': minZoom,
	if(maxZoom != null) 'maxZoom': maxZoom,
	if(fillColor != null) 'fillColor': fillColor,
	if(strokeColor != null) 'strokeColor': strokeColor,
	if(strokeWidth != null) 'strokeWidth': strokeWidth,
	if(fillOpacity != null) 'fillOpacity': fillOpacity,
	if(createdBy != null) 'createdBy': createdBy,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(deletedAt != null) 'deletedAt': deletedAt?.toIso8601String(),
	if(org != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'org': org?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is MapLayer &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    