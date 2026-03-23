
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'organization.dart';
import 'property.dart';


class Neighborhood implements PrismaModel<String, Neighborhood> , Id<String> {
    @override
String? id;
	String? orgId;
	String? name;
	String? city;
	String? state;
	String? zip;
	double? lat;
	double? lng;
	double? avgPrice;
	double? medianPrice;
	int? propertyCount;
	DateTime? createdAt;
	DateTime? updatedAt;
	DateTime? deletedAt;
	Organization? org;
	List<Property>? properties;
	int? $propertiesCount;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    Neighborhood({ this.id,
	 this.orgId,
	 this.name,
	 this.city,
	 this.state,
	 this.zip,
	 this.lat,
	 this.lng,
	 this.avgPrice,
	 this.medianPrice,
	 this.propertyCount = 0,
	 this.createdAt,
	 this.updatedAt,
	 this.deletedAt,
	 this.org,
	 this.properties,
	this.$propertiesCount,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<Neighborhood, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"orgId": (m) => m.orgId,

	"name": (m) => m.name,

	"city": (m) => m.city,

	"state": (m) => m.state,

	"zip": (m) => m.zip,

	"lat": (m) => m.lat,

	"lng": (m) => m.lng,

	"avgPrice": (m) => m.avgPrice,

	"medianPrice": (m) => m.medianPrice,

	"propertyCount": (m) => m.propertyCount,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"deletedAt": (m) => m.deletedAt,

	"org": (m) => m.org,

	"properties": (m) => m.properties,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(Neighborhood) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in Neighborhood');
    }
    return propFunction as V? Function(Neighborhood);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory Neighborhood.fromJson(JsonMap json) =>
      Neighborhood(
        id: json['id'] as String?,
	orgId: json['orgId'] as String?,
	name: json['name'] as String?,
	city: json['city'] as String?,
	state: json['state'] as String?,
	zip: json['zip'] as String?,
	lat: json['lat']?.toDouble(),
	lng: json['lng']?.toDouble(),
	avgPrice: json['avgPrice'] as double?,
	medianPrice: json['medianPrice'] as double?,
	propertyCount: int.tryParse(json['propertyCount'].toString()),
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
	org: json['org'] != null ? Organization.fromJson(json['org'] as JsonMap) : null,
	properties: json['properties'] != null ? createModels<Property>((json['properties'] as List).cast<JsonMap>(), Property.fromJson) : null,
	$propertiesCount: json['_count']?['properties'] as int?,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    Neighborhood copyWith({
        Value<String?>? id,
		Value<String?>? orgId,
		Value<String?>? name,
		Value<String?>? city,
		Value<String?>? state,
		Value<String?>? zip,
		Value<double?>? lat,
		Value<double?>? lng,
		Value<double?>? avgPrice,
		Value<double?>? medianPrice,
		Value<int?>? propertyCount,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<DateTime?>? deletedAt,
		Value<Organization?>? org,
		Value<List<Property>?>? properties,
		int? $propertiesCount,
        }) {
        return Neighborhood(
            id: id != null ? id.value : this.id,
		orgId: orgId != null ? orgId.value : this.orgId,
		name: name != null ? name.value : this.name,
		city: city != null ? city.value : this.city,
		state: state != null ? state.value : this.state,
		zip: zip != null ? zip.value : this.zip,
		lat: lat != null ? lat.value : this.lat,
		lng: lng != null ? lng.value : this.lng,
		avgPrice: avgPrice != null ? avgPrice.value : this.avgPrice,
		medianPrice: medianPrice != null ? medianPrice.value : this.medianPrice,
		propertyCount: propertyCount != null ? propertyCount.value : this.propertyCount,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		deletedAt: deletedAt != null ? deletedAt.value : this.deletedAt,
		org: org != null ? org.value : this.org,
		properties: properties != null ? properties.value : this.properties,
		$propertiesCount: $propertiesCount ?? this.$propertiesCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    Neighborhood copyWithInstanceValues(Neighborhood neighborhood) {
        return Neighborhood(
            id: neighborhood.id ?? id,
		orgId: neighborhood.orgId ?? orgId,
		name: neighborhood.name ?? name,
		city: neighborhood.city ?? city,
		state: neighborhood.state ?? state,
		zip: neighborhood.zip ?? zip,
		lat: neighborhood.lat ?? lat,
		lng: neighborhood.lng ?? lng,
		avgPrice: neighborhood.avgPrice ?? avgPrice,
		medianPrice: neighborhood.medianPrice ?? medianPrice,
		propertyCount: neighborhood.propertyCount ?? propertyCount,
		createdAt: neighborhood.createdAt ?? createdAt,
		updatedAt: neighborhood.updatedAt ?? updatedAt,
		deletedAt: neighborhood.deletedAt ?? deletedAt,
		org: neighborhood.org ?? org,
		properties: neighborhood.properties ?? properties,
		$propertiesCount: neighborhood.$propertiesCount ?? $propertiesCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    Neighborhood mergeWithInstanceValues(Neighborhood neighborhood) {
        return Neighborhood(
            id: neighborhood.$assignedFields.contains('id') ? neighborhood.id : id,
		orgId: neighborhood.$assignedFields.contains('orgId') ? neighborhood.orgId : orgId,
		name: neighborhood.$assignedFields.contains('name') ? neighborhood.name : name,
		city: neighborhood.$assignedFields.contains('city') ? neighborhood.city : city,
		state: neighborhood.$assignedFields.contains('state') ? neighborhood.state : state,
		zip: neighborhood.$assignedFields.contains('zip') ? neighborhood.zip : zip,
		lat: neighborhood.$assignedFields.contains('lat') ? neighborhood.lat : lat,
		lng: neighborhood.$assignedFields.contains('lng') ? neighborhood.lng : lng,
		avgPrice: neighborhood.$assignedFields.contains('avgPrice') ? neighborhood.avgPrice : avgPrice,
		medianPrice: neighborhood.$assignedFields.contains('medianPrice') ? neighborhood.medianPrice : medianPrice,
		propertyCount: neighborhood.$assignedFields.contains('propertyCount') ? neighborhood.propertyCount : propertyCount,
		createdAt: neighborhood.$assignedFields.contains('createdAt') ? neighborhood.createdAt : createdAt,
		updatedAt: neighborhood.$assignedFields.contains('updatedAt') ? neighborhood.updatedAt : updatedAt,
		deletedAt: neighborhood.$assignedFields.contains('deletedAt') ? neighborhood.deletedAt : deletedAt,
		org: neighborhood.$assignedFields.contains('org') ? neighborhood.org : org,
		properties: (neighborhood.$assignedFields.contains('properties') && neighborhood.properties != null) ? mergeModelLists(properties, neighborhood.properties) : properties,
		$propertiesCount: neighborhood.$propertiesCount ?? $propertiesCount
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    Neighborhood updateWithInstanceValues(Neighborhood neighborhood) {
        if (neighborhood.$assignedFields.contains('id')) { id = neighborhood.id; }
		if (neighborhood.$assignedFields.contains('orgId')) { orgId = neighborhood.orgId; }
		if (neighborhood.$assignedFields.contains('name')) { name = neighborhood.name; }
		if (neighborhood.$assignedFields.contains('city')) { city = neighborhood.city; }
		if (neighborhood.$assignedFields.contains('state')) { state = neighborhood.state; }
		if (neighborhood.$assignedFields.contains('zip')) { zip = neighborhood.zip; }
		if (neighborhood.$assignedFields.contains('lat')) { lat = neighborhood.lat; }
		if (neighborhood.$assignedFields.contains('lng')) { lng = neighborhood.lng; }
		if (neighborhood.$assignedFields.contains('avgPrice')) { avgPrice = neighborhood.avgPrice; }
		if (neighborhood.$assignedFields.contains('medianPrice')) { medianPrice = neighborhood.medianPrice; }
		if (neighborhood.$assignedFields.contains('propertyCount')) { propertyCount = neighborhood.propertyCount; }
		if (neighborhood.$assignedFields.contains('createdAt')) { createdAt = neighborhood.createdAt; }
		if (neighborhood.$assignedFields.contains('updatedAt')) { updatedAt = neighborhood.updatedAt; }
		if (neighborhood.$assignedFields.contains('deletedAt')) { deletedAt = neighborhood.deletedAt; }
		if (neighborhood.$assignedFields.contains('org')) { org = neighborhood.org; }
		if (neighborhood.$assignedFields.contains('properties') && neighborhood.properties != null) { properties = mergeModelLists(properties, neighborhood.properties); }
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
          ? {...?serializedTypes, 'Neighborhood'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(orgId != null) 'orgId': orgId,
	if(name != null) 'name': name,
	if(city != null) 'city': city,
	if(state != null) 'state': state,
	if(zip != null) 'zip': zip,
	if(lat != null) 'lat': lat,
	if(lng != null) 'lng': lng,
	if(avgPrice != null) 'avgPrice': avgPrice,
	if(medianPrice != null) 'medianPrice': medianPrice,
	if(propertyCount != null) 'propertyCount': propertyCount,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(deletedAt != null) 'deletedAt': deletedAt?.toIso8601String(),
	if(org != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'org': org?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(properties != null && (!preventCircularSerialization || !serializedModels.contains('Property'))) 'properties': properties?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
		if ($propertiesCount != null) '_count': { 
		if ($propertiesCount != null) 'properties': $propertiesCount, 
		},
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is Neighborhood &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    