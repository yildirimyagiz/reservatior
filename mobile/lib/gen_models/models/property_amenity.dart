
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'amenity.dart';
import 'organization.dart';
import 'property.dart';


class PropertyAmenity implements PrismaModel<String, PropertyAmenity> , Id<String> {
    @override
String? id;
	String? propertyId;
	String? amenityId;
	String? orgId;
	DateTime? createdAt;
	DateTime? updatedAt;
	DateTime? deletedAt;
	Amenity? amenity;
	Organization? org;
	Property? property;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    PropertyAmenity({ this.id,
	 this.propertyId,
	 this.amenityId,
	 this.orgId,
	 this.createdAt,
	 this.updatedAt,
	 this.deletedAt,
	 this.amenity,
	 this.org,
	 this.property,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<PropertyAmenity, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"propertyId": (m) => m.propertyId,

	"amenityId": (m) => m.amenityId,

	"orgId": (m) => m.orgId,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"deletedAt": (m) => m.deletedAt,

	"amenity": (m) => m.amenity,

	"org": (m) => m.org,

	"property": (m) => m.property,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(PropertyAmenity) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in PropertyAmenity');
    }
    return propFunction as V? Function(PropertyAmenity);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory PropertyAmenity.fromJson(JsonMap json) =>
      PropertyAmenity(
        id: json['id'] as String?,
	propertyId: json['propertyId'] as String?,
	amenityId: json['amenityId'] as String?,
	orgId: json['orgId'] as String?,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
	amenity: json['amenity'] != null ? Amenity.fromJson(json['amenity'] as JsonMap) : null,
	org: json['org'] != null ? Organization.fromJson(json['org'] as JsonMap) : null,
	property: json['property'] != null ? Property.fromJson(json['property'] as JsonMap) : null,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    PropertyAmenity copyWith({
        Value<String?>? id,
		Value<String?>? propertyId,
		Value<String?>? amenityId,
		Value<String?>? orgId,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<DateTime?>? deletedAt,
		Value<Amenity?>? amenity,
		Value<Organization?>? org,
		Value<Property?>? property,
        }) {
        return PropertyAmenity(
            id: id != null ? id.value : this.id,
		propertyId: propertyId != null ? propertyId.value : this.propertyId,
		amenityId: amenityId != null ? amenityId.value : this.amenityId,
		orgId: orgId != null ? orgId.value : this.orgId,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		deletedAt: deletedAt != null ? deletedAt.value : this.deletedAt,
		amenity: amenity != null ? amenity.value : this.amenity,
		org: org != null ? org.value : this.org,
		property: property != null ? property.value : this.property
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    PropertyAmenity copyWithInstanceValues(PropertyAmenity propertyAmenity) {
        return PropertyAmenity(
            id: propertyAmenity.id ?? id,
		propertyId: propertyAmenity.propertyId ?? propertyId,
		amenityId: propertyAmenity.amenityId ?? amenityId,
		orgId: propertyAmenity.orgId ?? orgId,
		createdAt: propertyAmenity.createdAt ?? createdAt,
		updatedAt: propertyAmenity.updatedAt ?? updatedAt,
		deletedAt: propertyAmenity.deletedAt ?? deletedAt,
		amenity: propertyAmenity.amenity ?? amenity,
		org: propertyAmenity.org ?? org,
		property: propertyAmenity.property ?? property
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    PropertyAmenity mergeWithInstanceValues(PropertyAmenity propertyAmenity) {
        return PropertyAmenity(
            id: propertyAmenity.$assignedFields.contains('id') ? propertyAmenity.id : id,
		propertyId: propertyAmenity.$assignedFields.contains('propertyId') ? propertyAmenity.propertyId : propertyId,
		amenityId: propertyAmenity.$assignedFields.contains('amenityId') ? propertyAmenity.amenityId : amenityId,
		orgId: propertyAmenity.$assignedFields.contains('orgId') ? propertyAmenity.orgId : orgId,
		createdAt: propertyAmenity.$assignedFields.contains('createdAt') ? propertyAmenity.createdAt : createdAt,
		updatedAt: propertyAmenity.$assignedFields.contains('updatedAt') ? propertyAmenity.updatedAt : updatedAt,
		deletedAt: propertyAmenity.$assignedFields.contains('deletedAt') ? propertyAmenity.deletedAt : deletedAt,
		amenity: propertyAmenity.$assignedFields.contains('amenity') ? propertyAmenity.amenity : amenity,
		org: propertyAmenity.$assignedFields.contains('org') ? propertyAmenity.org : org,
		property: propertyAmenity.$assignedFields.contains('property') ? propertyAmenity.property : property
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    PropertyAmenity updateWithInstanceValues(PropertyAmenity propertyAmenity) {
        if (propertyAmenity.$assignedFields.contains('id')) { id = propertyAmenity.id; }
		if (propertyAmenity.$assignedFields.contains('propertyId')) { propertyId = propertyAmenity.propertyId; }
		if (propertyAmenity.$assignedFields.contains('amenityId')) { amenityId = propertyAmenity.amenityId; }
		if (propertyAmenity.$assignedFields.contains('orgId')) { orgId = propertyAmenity.orgId; }
		if (propertyAmenity.$assignedFields.contains('createdAt')) { createdAt = propertyAmenity.createdAt; }
		if (propertyAmenity.$assignedFields.contains('updatedAt')) { updatedAt = propertyAmenity.updatedAt; }
		if (propertyAmenity.$assignedFields.contains('deletedAt')) { deletedAt = propertyAmenity.deletedAt; }
		if (propertyAmenity.$assignedFields.contains('amenity')) { amenity = propertyAmenity.amenity; }
		if (propertyAmenity.$assignedFields.contains('org')) { org = propertyAmenity.org; }
		if (propertyAmenity.$assignedFields.contains('property')) { property = propertyAmenity.property; }
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
          ? {...?serializedTypes, 'PropertyAmenity'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(propertyId != null) 'propertyId': propertyId,
	if(amenityId != null) 'amenityId': amenityId,
	if(orgId != null) 'orgId': orgId,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(deletedAt != null) 'deletedAt': deletedAt?.toIso8601String(),
	if(amenity != null && (!preventCircularSerialization || !serializedModels.contains('Amenity'))) 'amenity': amenity?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(org != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'org': org?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(property != null && (!preventCircularSerialization || !serializedModels.contains('Property'))) 'property': property?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is PropertyAmenity &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    