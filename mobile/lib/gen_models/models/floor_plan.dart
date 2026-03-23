
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'organization.dart';
import 'property.dart';


class FloorPlan implements PrismaModel<String, FloorPlan> , Id<String> {
    @override
String? id;
	String? orgId;
	String? propertyId;
	String? name;
	String? description;
	int? floorLevel;
	String? imageUrl;
	int? imageWidth;
	int? imageHeight;
	dynamic rooms;
	bool? isActive;
	String? createdBy;
	DateTime? createdAt;
	DateTime? updatedAt;
	DateTime? deletedAt;
	Organization? org;
	Property? property;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    FloorPlan({ this.id,
	 this.orgId,
	 this.propertyId,
	 this.name,
	 this.description,
	 this.floorLevel,
	 this.imageUrl,
	 this.imageWidth,
	 this.imageHeight,
	required this.rooms,
	 this.isActive = true,
	 this.createdBy,
	 this.createdAt,
	 this.updatedAt,
	 this.deletedAt,
	 this.org,
	 this.property,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<FloorPlan, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"orgId": (m) => m.orgId,

	"propertyId": (m) => m.propertyId,

	"name": (m) => m.name,

	"description": (m) => m.description,

	"floorLevel": (m) => m.floorLevel,

	"imageUrl": (m) => m.imageUrl,

	"imageWidth": (m) => m.imageWidth,

	"imageHeight": (m) => m.imageHeight,

	"rooms": (m) => m.rooms,

	"isActive": (m) => m.isActive,

	"createdBy": (m) => m.createdBy,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"deletedAt": (m) => m.deletedAt,

	"org": (m) => m.org,

	"property": (m) => m.property,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(FloorPlan) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in FloorPlan');
    }
    return propFunction as V? Function(FloorPlan);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory FloorPlan.fromJson(JsonMap json) =>
      FloorPlan(
        id: json['id'] as String?,
	orgId: json['orgId'] as String?,
	propertyId: json['propertyId'] as String?,
	name: json['name'] as String?,
	description: json['description'] as String?,
	floorLevel: int.tryParse(json['floorLevel'].toString()),
	imageUrl: json['imageUrl'] as String?,
	imageWidth: int.tryParse(json['imageWidth'].toString()),
	imageHeight: int.tryParse(json['imageHeight'].toString()),
	rooms: json['rooms'] as dynamic,
	isActive: json['isActive'] as bool?,
	createdBy: json['createdBy'] as String?,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
	org: json['org'] != null ? Organization.fromJson(json['org'] as JsonMap) : null,
	property: json['property'] != null ? Property.fromJson(json['property'] as JsonMap) : null,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    FloorPlan copyWith({
        Value<String?>? id,
		Value<String?>? orgId,
		Value<String?>? propertyId,
		Value<String?>? name,
		Value<String?>? description,
		Value<int?>? floorLevel,
		Value<String?>? imageUrl,
		Value<int?>? imageWidth,
		Value<int?>? imageHeight,
		Value<dynamic>? rooms,
		Value<bool?>? isActive,
		Value<String?>? createdBy,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<DateTime?>? deletedAt,
		Value<Organization?>? org,
		Value<Property?>? property,
        }) {
        return FloorPlan(
            id: id != null ? id.value : this.id,
		orgId: orgId != null ? orgId.value : this.orgId,
		propertyId: propertyId != null ? propertyId.value : this.propertyId,
		name: name != null ? name.value : this.name,
		description: description != null ? description.value : this.description,
		floorLevel: floorLevel != null ? floorLevel.value : this.floorLevel,
		imageUrl: imageUrl != null ? imageUrl.value : this.imageUrl,
		imageWidth: imageWidth != null ? imageWidth.value : this.imageWidth,
		imageHeight: imageHeight != null ? imageHeight.value : this.imageHeight,
		rooms: rooms != null ? rooms.value : this.rooms,
		isActive: isActive != null ? isActive.value : this.isActive,
		createdBy: createdBy != null ? createdBy.value : this.createdBy,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		deletedAt: deletedAt != null ? deletedAt.value : this.deletedAt,
		org: org != null ? org.value : this.org,
		property: property != null ? property.value : this.property
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    FloorPlan copyWithInstanceValues(FloorPlan floorPlan) {
        return FloorPlan(
            id: floorPlan.id ?? id,
		orgId: floorPlan.orgId ?? orgId,
		propertyId: floorPlan.propertyId ?? propertyId,
		name: floorPlan.name ?? name,
		description: floorPlan.description ?? description,
		floorLevel: floorPlan.floorLevel ?? floorLevel,
		imageUrl: floorPlan.imageUrl ?? imageUrl,
		imageWidth: floorPlan.imageWidth ?? imageWidth,
		imageHeight: floorPlan.imageHeight ?? imageHeight,
		rooms: floorPlan.rooms ?? rooms,
		isActive: floorPlan.isActive ?? isActive,
		createdBy: floorPlan.createdBy ?? createdBy,
		createdAt: floorPlan.createdAt ?? createdAt,
		updatedAt: floorPlan.updatedAt ?? updatedAt,
		deletedAt: floorPlan.deletedAt ?? deletedAt,
		org: floorPlan.org ?? org,
		property: floorPlan.property ?? property
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    FloorPlan mergeWithInstanceValues(FloorPlan floorPlan) {
        return FloorPlan(
            id: floorPlan.$assignedFields.contains('id') ? floorPlan.id : id,
		orgId: floorPlan.$assignedFields.contains('orgId') ? floorPlan.orgId : orgId,
		propertyId: floorPlan.$assignedFields.contains('propertyId') ? floorPlan.propertyId : propertyId,
		name: floorPlan.$assignedFields.contains('name') ? floorPlan.name : name,
		description: floorPlan.$assignedFields.contains('description') ? floorPlan.description : description,
		floorLevel: floorPlan.$assignedFields.contains('floorLevel') ? floorPlan.floorLevel : floorLevel,
		imageUrl: floorPlan.$assignedFields.contains('imageUrl') ? floorPlan.imageUrl : imageUrl,
		imageWidth: floorPlan.$assignedFields.contains('imageWidth') ? floorPlan.imageWidth : imageWidth,
		imageHeight: floorPlan.$assignedFields.contains('imageHeight') ? floorPlan.imageHeight : imageHeight,
		rooms: floorPlan.$assignedFields.contains('rooms') ? floorPlan.rooms : rooms,
		isActive: floorPlan.$assignedFields.contains('isActive') ? floorPlan.isActive : isActive,
		createdBy: floorPlan.$assignedFields.contains('createdBy') ? floorPlan.createdBy : createdBy,
		createdAt: floorPlan.$assignedFields.contains('createdAt') ? floorPlan.createdAt : createdAt,
		updatedAt: floorPlan.$assignedFields.contains('updatedAt') ? floorPlan.updatedAt : updatedAt,
		deletedAt: floorPlan.$assignedFields.contains('deletedAt') ? floorPlan.deletedAt : deletedAt,
		org: floorPlan.$assignedFields.contains('org') ? floorPlan.org : org,
		property: floorPlan.$assignedFields.contains('property') ? floorPlan.property : property
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    FloorPlan updateWithInstanceValues(FloorPlan floorPlan) {
        if (floorPlan.$assignedFields.contains('id')) { id = floorPlan.id; }
		if (floorPlan.$assignedFields.contains('orgId')) { orgId = floorPlan.orgId; }
		if (floorPlan.$assignedFields.contains('propertyId')) { propertyId = floorPlan.propertyId; }
		if (floorPlan.$assignedFields.contains('name')) { name = floorPlan.name; }
		if (floorPlan.$assignedFields.contains('description')) { description = floorPlan.description; }
		if (floorPlan.$assignedFields.contains('floorLevel')) { floorLevel = floorPlan.floorLevel; }
		if (floorPlan.$assignedFields.contains('imageUrl')) { imageUrl = floorPlan.imageUrl; }
		if (floorPlan.$assignedFields.contains('imageWidth')) { imageWidth = floorPlan.imageWidth; }
		if (floorPlan.$assignedFields.contains('imageHeight')) { imageHeight = floorPlan.imageHeight; }
		if (floorPlan.$assignedFields.contains('rooms')) { rooms = floorPlan.rooms; }
		if (floorPlan.$assignedFields.contains('isActive')) { isActive = floorPlan.isActive; }
		if (floorPlan.$assignedFields.contains('createdBy')) { createdBy = floorPlan.createdBy; }
		if (floorPlan.$assignedFields.contains('createdAt')) { createdAt = floorPlan.createdAt; }
		if (floorPlan.$assignedFields.contains('updatedAt')) { updatedAt = floorPlan.updatedAt; }
		if (floorPlan.$assignedFields.contains('deletedAt')) { deletedAt = floorPlan.deletedAt; }
		if (floorPlan.$assignedFields.contains('org')) { org = floorPlan.org; }
		if (floorPlan.$assignedFields.contains('property')) { property = floorPlan.property; }
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
          ? {...?serializedTypes, 'FloorPlan'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(orgId != null) 'orgId': orgId,
	if(propertyId != null) 'propertyId': propertyId,
	if(name != null) 'name': name,
	if(description != null) 'description': description,
	if(floorLevel != null) 'floorLevel': floorLevel,
	if(imageUrl != null) 'imageUrl': imageUrl,
	if(imageWidth != null) 'imageWidth': imageWidth,
	if(imageHeight != null) 'imageHeight': imageHeight,
	if(rooms != null) 'rooms': rooms,
	if(isActive != null) 'isActive': isActive,
	if(createdBy != null) 'createdBy': createdBy,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(deletedAt != null) 'deletedAt': deletedAt?.toIso8601String(),
	if(org != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'org': org?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(property != null && (!preventCircularSerialization || !serializedModels.contains('Property'))) 'property': property?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is FloorPlan &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    