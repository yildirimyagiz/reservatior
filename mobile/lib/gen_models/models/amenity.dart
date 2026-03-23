
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'amenity_category.dart';
import 'organization.dart';
import 'property_amenity.dart';


class Amenity implements PrismaModel<String, Amenity> , Id<String> {
    @override
String? id;
	String? orgId;
	String? name;
	AmenityCategory? category;
	String? icon;
	DateTime? createdAt;
	DateTime? updatedAt;
	DateTime? deletedAt;
	Organization? org;
	List<PropertyAmenity>? propertyAmenities;
	int? $propertyAmenitiesCount;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    Amenity({ this.id,
	 this.orgId,
	 this.name,
	 this.category,
	 this.icon,
	 this.createdAt,
	 this.updatedAt,
	 this.deletedAt,
	 this.org,
	 this.propertyAmenities,
	this.$propertyAmenitiesCount,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<Amenity, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"orgId": (m) => m.orgId,

	"name": (m) => m.name,

	"category": (m) => m.category,

	"icon": (m) => m.icon,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"deletedAt": (m) => m.deletedAt,

	"org": (m) => m.org,

	"propertyAmenities": (m) => m.propertyAmenities,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(Amenity) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in Amenity');
    }
    return propFunction as V? Function(Amenity);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory Amenity.fromJson(JsonMap json) =>
      Amenity(
        id: json['id'] as String?,
	orgId: json['orgId'] as String?,
	name: json['name'] as String?,
	category: json['category'] != null ? AmenityCategory.fromJson(json['category']) : null,
	icon: json['icon'] as String?,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
	org: json['org'] != null ? Organization.fromJson(json['org'] as JsonMap) : null,
	propertyAmenities: json['propertyAmenities'] != null ? createModels<PropertyAmenity>((json['propertyAmenities'] as List).cast<JsonMap>(), PropertyAmenity.fromJson) : null,
	$propertyAmenitiesCount: json['_count']?['propertyAmenities'] as int?,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    Amenity copyWith({
        Value<String?>? id,
		Value<String?>? orgId,
		Value<String?>? name,
		Value<AmenityCategory?>? category,
		Value<String?>? icon,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<DateTime?>? deletedAt,
		Value<Organization?>? org,
		Value<List<PropertyAmenity>?>? propertyAmenities,
		int? $propertyAmenitiesCount,
        }) {
        return Amenity(
            id: id != null ? id.value : this.id,
		orgId: orgId != null ? orgId.value : this.orgId,
		name: name != null ? name.value : this.name,
		category: category != null ? category.value : this.category,
		icon: icon != null ? icon.value : this.icon,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		deletedAt: deletedAt != null ? deletedAt.value : this.deletedAt,
		org: org != null ? org.value : this.org,
		propertyAmenities: propertyAmenities != null ? propertyAmenities.value : this.propertyAmenities,
		$propertyAmenitiesCount: $propertyAmenitiesCount ?? this.$propertyAmenitiesCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    Amenity copyWithInstanceValues(Amenity amenity) {
        return Amenity(
            id: amenity.id ?? id,
		orgId: amenity.orgId ?? orgId,
		name: amenity.name ?? name,
		category: amenity.category ?? category,
		icon: amenity.icon ?? icon,
		createdAt: amenity.createdAt ?? createdAt,
		updatedAt: amenity.updatedAt ?? updatedAt,
		deletedAt: amenity.deletedAt ?? deletedAt,
		org: amenity.org ?? org,
		propertyAmenities: amenity.propertyAmenities ?? propertyAmenities,
		$propertyAmenitiesCount: amenity.$propertyAmenitiesCount ?? $propertyAmenitiesCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    Amenity mergeWithInstanceValues(Amenity amenity) {
        return Amenity(
            id: amenity.$assignedFields.contains('id') ? amenity.id : id,
		orgId: amenity.$assignedFields.contains('orgId') ? amenity.orgId : orgId,
		name: amenity.$assignedFields.contains('name') ? amenity.name : name,
		category: amenity.$assignedFields.contains('category') ? amenity.category : category,
		icon: amenity.$assignedFields.contains('icon') ? amenity.icon : icon,
		createdAt: amenity.$assignedFields.contains('createdAt') ? amenity.createdAt : createdAt,
		updatedAt: amenity.$assignedFields.contains('updatedAt') ? amenity.updatedAt : updatedAt,
		deletedAt: amenity.$assignedFields.contains('deletedAt') ? amenity.deletedAt : deletedAt,
		org: amenity.$assignedFields.contains('org') ? amenity.org : org,
		propertyAmenities: (amenity.$assignedFields.contains('propertyAmenities') && amenity.propertyAmenities != null) ? mergeModelLists(propertyAmenities, amenity.propertyAmenities) : propertyAmenities,
		$propertyAmenitiesCount: amenity.$propertyAmenitiesCount ?? $propertyAmenitiesCount
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    Amenity updateWithInstanceValues(Amenity amenity) {
        if (amenity.$assignedFields.contains('id')) { id = amenity.id; }
		if (amenity.$assignedFields.contains('orgId')) { orgId = amenity.orgId; }
		if (amenity.$assignedFields.contains('name')) { name = amenity.name; }
		if (amenity.$assignedFields.contains('category')) { category = amenity.category; }
		if (amenity.$assignedFields.contains('icon')) { icon = amenity.icon; }
		if (amenity.$assignedFields.contains('createdAt')) { createdAt = amenity.createdAt; }
		if (amenity.$assignedFields.contains('updatedAt')) { updatedAt = amenity.updatedAt; }
		if (amenity.$assignedFields.contains('deletedAt')) { deletedAt = amenity.deletedAt; }
		if (amenity.$assignedFields.contains('org')) { org = amenity.org; }
		if (amenity.$assignedFields.contains('propertyAmenities') && amenity.propertyAmenities != null) { propertyAmenities = mergeModelLists(propertyAmenities, amenity.propertyAmenities); }
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
          ? {...?serializedTypes, 'Amenity'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(orgId != null) 'orgId': orgId,
	if(name != null) 'name': name,
	if(category != null) 'category': category?.toJson(),
	if(icon != null) 'icon': icon,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(deletedAt != null) 'deletedAt': deletedAt?.toIso8601String(),
	if(org != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'org': org?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(propertyAmenities != null && (!preventCircularSerialization || !serializedModels.contains('PropertyAmenity'))) 'propertyAmenities': propertyAmenities?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
		if ($propertyAmenitiesCount != null) '_count': { 
		if ($propertyAmenitiesCount != null) 'propertyAmenities': $propertyAmenitiesCount, 
		},
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is Amenity &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    