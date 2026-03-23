
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'organization.dart';
import 'property.dart';


class VirtualTour implements PrismaModel<String, VirtualTour> , Id<String> {
    @override
String? id;
	String? orgId;
	String? propertyId;
	String? name;
	String? description;
	String? tourType;
	String? videoUrl;
	String? embedCode;
	String? thumbnailUrl;
	int? duration;
	dynamic hotspots;
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
    VirtualTour({ this.id,
	 this.orgId,
	 this.propertyId,
	 this.name,
	 this.description,
	 this.tourType,
	 this.videoUrl,
	 this.embedCode,
	 this.thumbnailUrl,
	 this.duration,
	required this.hotspots,
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

    Map<String, GetPropertyValueFunction<VirtualTour, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"orgId": (m) => m.orgId,

	"propertyId": (m) => m.propertyId,

	"name": (m) => m.name,

	"description": (m) => m.description,

	"tourType": (m) => m.tourType,

	"videoUrl": (m) => m.videoUrl,

	"embedCode": (m) => m.embedCode,

	"thumbnailUrl": (m) => m.thumbnailUrl,

	"duration": (m) => m.duration,

	"hotspots": (m) => m.hotspots,

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
  V? Function(VirtualTour) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in VirtualTour');
    }
    return propFunction as V? Function(VirtualTour);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory VirtualTour.fromJson(JsonMap json) =>
      VirtualTour(
        id: json['id'] as String?,
	orgId: json['orgId'] as String?,
	propertyId: json['propertyId'] as String?,
	name: json['name'] as String?,
	description: json['description'] as String?,
	tourType: json['tourType'] as String?,
	videoUrl: json['videoUrl'] as String?,
	embedCode: json['embedCode'] as String?,
	thumbnailUrl: json['thumbnailUrl'] as String?,
	duration: int.tryParse(json['duration'].toString()),
	hotspots: json['hotspots'] as dynamic,
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
    VirtualTour copyWith({
        Value<String?>? id,
		Value<String?>? orgId,
		Value<String?>? propertyId,
		Value<String?>? name,
		Value<String?>? description,
		Value<String?>? tourType,
		Value<String?>? videoUrl,
		Value<String?>? embedCode,
		Value<String?>? thumbnailUrl,
		Value<int?>? duration,
		Value<dynamic>? hotspots,
		Value<bool?>? isActive,
		Value<String?>? createdBy,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<DateTime?>? deletedAt,
		Value<Organization?>? org,
		Value<Property?>? property,
        }) {
        return VirtualTour(
            id: id != null ? id.value : this.id,
		orgId: orgId != null ? orgId.value : this.orgId,
		propertyId: propertyId != null ? propertyId.value : this.propertyId,
		name: name != null ? name.value : this.name,
		description: description != null ? description.value : this.description,
		tourType: tourType != null ? tourType.value : this.tourType,
		videoUrl: videoUrl != null ? videoUrl.value : this.videoUrl,
		embedCode: embedCode != null ? embedCode.value : this.embedCode,
		thumbnailUrl: thumbnailUrl != null ? thumbnailUrl.value : this.thumbnailUrl,
		duration: duration != null ? duration.value : this.duration,
		hotspots: hotspots != null ? hotspots.value : this.hotspots,
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
    VirtualTour copyWithInstanceValues(VirtualTour virtualTour) {
        return VirtualTour(
            id: virtualTour.id ?? id,
		orgId: virtualTour.orgId ?? orgId,
		propertyId: virtualTour.propertyId ?? propertyId,
		name: virtualTour.name ?? name,
		description: virtualTour.description ?? description,
		tourType: virtualTour.tourType ?? tourType,
		videoUrl: virtualTour.videoUrl ?? videoUrl,
		embedCode: virtualTour.embedCode ?? embedCode,
		thumbnailUrl: virtualTour.thumbnailUrl ?? thumbnailUrl,
		duration: virtualTour.duration ?? duration,
		hotspots: virtualTour.hotspots ?? hotspots,
		isActive: virtualTour.isActive ?? isActive,
		createdBy: virtualTour.createdBy ?? createdBy,
		createdAt: virtualTour.createdAt ?? createdAt,
		updatedAt: virtualTour.updatedAt ?? updatedAt,
		deletedAt: virtualTour.deletedAt ?? deletedAt,
		org: virtualTour.org ?? org,
		property: virtualTour.property ?? property
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    VirtualTour mergeWithInstanceValues(VirtualTour virtualTour) {
        return VirtualTour(
            id: virtualTour.$assignedFields.contains('id') ? virtualTour.id : id,
		orgId: virtualTour.$assignedFields.contains('orgId') ? virtualTour.orgId : orgId,
		propertyId: virtualTour.$assignedFields.contains('propertyId') ? virtualTour.propertyId : propertyId,
		name: virtualTour.$assignedFields.contains('name') ? virtualTour.name : name,
		description: virtualTour.$assignedFields.contains('description') ? virtualTour.description : description,
		tourType: virtualTour.$assignedFields.contains('tourType') ? virtualTour.tourType : tourType,
		videoUrl: virtualTour.$assignedFields.contains('videoUrl') ? virtualTour.videoUrl : videoUrl,
		embedCode: virtualTour.$assignedFields.contains('embedCode') ? virtualTour.embedCode : embedCode,
		thumbnailUrl: virtualTour.$assignedFields.contains('thumbnailUrl') ? virtualTour.thumbnailUrl : thumbnailUrl,
		duration: virtualTour.$assignedFields.contains('duration') ? virtualTour.duration : duration,
		hotspots: virtualTour.$assignedFields.contains('hotspots') ? virtualTour.hotspots : hotspots,
		isActive: virtualTour.$assignedFields.contains('isActive') ? virtualTour.isActive : isActive,
		createdBy: virtualTour.$assignedFields.contains('createdBy') ? virtualTour.createdBy : createdBy,
		createdAt: virtualTour.$assignedFields.contains('createdAt') ? virtualTour.createdAt : createdAt,
		updatedAt: virtualTour.$assignedFields.contains('updatedAt') ? virtualTour.updatedAt : updatedAt,
		deletedAt: virtualTour.$assignedFields.contains('deletedAt') ? virtualTour.deletedAt : deletedAt,
		org: virtualTour.$assignedFields.contains('org') ? virtualTour.org : org,
		property: virtualTour.$assignedFields.contains('property') ? virtualTour.property : property
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    VirtualTour updateWithInstanceValues(VirtualTour virtualTour) {
        if (virtualTour.$assignedFields.contains('id')) { id = virtualTour.id; }
		if (virtualTour.$assignedFields.contains('orgId')) { orgId = virtualTour.orgId; }
		if (virtualTour.$assignedFields.contains('propertyId')) { propertyId = virtualTour.propertyId; }
		if (virtualTour.$assignedFields.contains('name')) { name = virtualTour.name; }
		if (virtualTour.$assignedFields.contains('description')) { description = virtualTour.description; }
		if (virtualTour.$assignedFields.contains('tourType')) { tourType = virtualTour.tourType; }
		if (virtualTour.$assignedFields.contains('videoUrl')) { videoUrl = virtualTour.videoUrl; }
		if (virtualTour.$assignedFields.contains('embedCode')) { embedCode = virtualTour.embedCode; }
		if (virtualTour.$assignedFields.contains('thumbnailUrl')) { thumbnailUrl = virtualTour.thumbnailUrl; }
		if (virtualTour.$assignedFields.contains('duration')) { duration = virtualTour.duration; }
		if (virtualTour.$assignedFields.contains('hotspots')) { hotspots = virtualTour.hotspots; }
		if (virtualTour.$assignedFields.contains('isActive')) { isActive = virtualTour.isActive; }
		if (virtualTour.$assignedFields.contains('createdBy')) { createdBy = virtualTour.createdBy; }
		if (virtualTour.$assignedFields.contains('createdAt')) { createdAt = virtualTour.createdAt; }
		if (virtualTour.$assignedFields.contains('updatedAt')) { updatedAt = virtualTour.updatedAt; }
		if (virtualTour.$assignedFields.contains('deletedAt')) { deletedAt = virtualTour.deletedAt; }
		if (virtualTour.$assignedFields.contains('org')) { org = virtualTour.org; }
		if (virtualTour.$assignedFields.contains('property')) { property = virtualTour.property; }
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
          ? {...?serializedTypes, 'VirtualTour'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(orgId != null) 'orgId': orgId,
	if(propertyId != null) 'propertyId': propertyId,
	if(name != null) 'name': name,
	if(description != null) 'description': description,
	if(tourType != null) 'tourType': tourType,
	if(videoUrl != null) 'videoUrl': videoUrl,
	if(embedCode != null) 'embedCode': embedCode,
	if(thumbnailUrl != null) 'thumbnailUrl': thumbnailUrl,
	if(duration != null) 'duration': duration,
	if(hotspots != null) 'hotspots': hotspots,
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
            identical(this, other) || other is VirtualTour &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    