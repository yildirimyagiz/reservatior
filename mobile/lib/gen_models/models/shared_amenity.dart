
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'shared_amenity_type.dart';
import 'amenity_access_type.dart';
import 'facility.dart';


class SharedAmenity implements PrismaModel<String, SharedAmenity> , Id<String> {
    @override
String? id;
	String? facilityId;
	String? name;
	SharedAmenityType? type;
	String? description;
	String? location;
	int? capacity;
	bool? isAvailable;
	String? operatingHours;
	AmenityAccessType? accessType;
	double? price;
	List<String>? images;
	DateTime? createdAt;
	DateTime? updatedAt;
	Facility? facility;
	int? $imagesCount;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    SharedAmenity({ this.id,
	 this.facilityId,
	 this.name,
	 this.type,
	 this.description,
	 this.location,
	 this.capacity,
	 this.isAvailable = true,
	 this.operatingHours,
	 this.accessType = AmenityAccessType.FREE,
	 this.price,
	 this.images,
	 this.createdAt,
	 this.updatedAt,
	 this.facility,
	this.$imagesCount,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<SharedAmenity, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"facilityId": (m) => m.facilityId,

	"name": (m) => m.name,

	"type": (m) => m.type,

	"description": (m) => m.description,

	"location": (m) => m.location,

	"capacity": (m) => m.capacity,

	"isAvailable": (m) => m.isAvailable,

	"operatingHours": (m) => m.operatingHours,

	"accessType": (m) => m.accessType,

	"price": (m) => m.price,

	"images": (m) => m.images,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"facility": (m) => m.facility,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(SharedAmenity) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in SharedAmenity');
    }
    return propFunction as V? Function(SharedAmenity);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory SharedAmenity.fromJson(JsonMap json) =>
      SharedAmenity(
        id: json['id'] as String?,
	facilityId: json['facilityId'] as String?,
	name: json['name'] as String?,
	type: json['type'] != null ? SharedAmenityType.fromJson(json['type']) : null,
	description: json['description'] as String?,
	location: json['location'] as String?,
	capacity: int.tryParse(json['capacity'].toString()),
	isAvailable: json['isAvailable'] as bool?,
	operatingHours: json['operatingHours'] as String?,
	accessType: json['accessType'] != null ? AmenityAccessType.fromJson(json['accessType']) : null,
	price: json['price']?.toDouble(),
	images: json['images'] != null ? (json['images'] as List<dynamic>).map((e) => e.toString()).toList() : null,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	facility: json['facility'] != null ? Facility.fromJson(json['facility'] as JsonMap) : null,
	$imagesCount: json['_count']?['images'] as int?,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    SharedAmenity copyWith({
        Value<String?>? id,
		Value<String?>? facilityId,
		Value<String?>? name,
		Value<SharedAmenityType?>? type,
		Value<String?>? description,
		Value<String?>? location,
		Value<int?>? capacity,
		Value<bool?>? isAvailable,
		Value<String?>? operatingHours,
		Value<AmenityAccessType?>? accessType,
		Value<double?>? price,
		Value<List<String>?>? images,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<Facility?>? facility,
		int? $imagesCount,
        }) {
        return SharedAmenity(
            id: id != null ? id.value : this.id,
		facilityId: facilityId != null ? facilityId.value : this.facilityId,
		name: name != null ? name.value : this.name,
		type: type != null ? type.value : this.type,
		description: description != null ? description.value : this.description,
		location: location != null ? location.value : this.location,
		capacity: capacity != null ? capacity.value : this.capacity,
		isAvailable: isAvailable != null ? isAvailable.value : this.isAvailable,
		operatingHours: operatingHours != null ? operatingHours.value : this.operatingHours,
		accessType: accessType != null ? accessType.value : this.accessType,
		price: price != null ? price.value : this.price,
		images: images != null ? images.value : this.images,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		facility: facility != null ? facility.value : this.facility,
		$imagesCount: $imagesCount ?? this.$imagesCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    SharedAmenity copyWithInstanceValues(SharedAmenity sharedAmenity) {
        return SharedAmenity(
            id: sharedAmenity.id ?? id,
		facilityId: sharedAmenity.facilityId ?? facilityId,
		name: sharedAmenity.name ?? name,
		type: sharedAmenity.type ?? type,
		description: sharedAmenity.description ?? description,
		location: sharedAmenity.location ?? location,
		capacity: sharedAmenity.capacity ?? capacity,
		isAvailable: sharedAmenity.isAvailable ?? isAvailable,
		operatingHours: sharedAmenity.operatingHours ?? operatingHours,
		accessType: sharedAmenity.accessType ?? accessType,
		price: sharedAmenity.price ?? price,
		images: sharedAmenity.images ?? images,
		createdAt: sharedAmenity.createdAt ?? createdAt,
		updatedAt: sharedAmenity.updatedAt ?? updatedAt,
		facility: sharedAmenity.facility ?? facility,
		$imagesCount: sharedAmenity.$imagesCount ?? $imagesCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    SharedAmenity mergeWithInstanceValues(SharedAmenity sharedAmenity) {
        return SharedAmenity(
            id: sharedAmenity.$assignedFields.contains('id') ? sharedAmenity.id : id,
		facilityId: sharedAmenity.$assignedFields.contains('facilityId') ? sharedAmenity.facilityId : facilityId,
		name: sharedAmenity.$assignedFields.contains('name') ? sharedAmenity.name : name,
		type: sharedAmenity.$assignedFields.contains('type') ? sharedAmenity.type : type,
		description: sharedAmenity.$assignedFields.contains('description') ? sharedAmenity.description : description,
		location: sharedAmenity.$assignedFields.contains('location') ? sharedAmenity.location : location,
		capacity: sharedAmenity.$assignedFields.contains('capacity') ? sharedAmenity.capacity : capacity,
		isAvailable: sharedAmenity.$assignedFields.contains('isAvailable') ? sharedAmenity.isAvailable : isAvailable,
		operatingHours: sharedAmenity.$assignedFields.contains('operatingHours') ? sharedAmenity.operatingHours : operatingHours,
		accessType: sharedAmenity.$assignedFields.contains('accessType') ? sharedAmenity.accessType : accessType,
		price: sharedAmenity.$assignedFields.contains('price') ? sharedAmenity.price : price,
		images: sharedAmenity.$assignedFields.contains('images') ? sharedAmenity.images : images,
		createdAt: sharedAmenity.$assignedFields.contains('createdAt') ? sharedAmenity.createdAt : createdAt,
		updatedAt: sharedAmenity.$assignedFields.contains('updatedAt') ? sharedAmenity.updatedAt : updatedAt,
		facility: sharedAmenity.$assignedFields.contains('facility') ? sharedAmenity.facility : facility,
		$imagesCount: sharedAmenity.$imagesCount ?? $imagesCount
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    SharedAmenity updateWithInstanceValues(SharedAmenity sharedAmenity) {
        if (sharedAmenity.$assignedFields.contains('id')) { id = sharedAmenity.id; }
		if (sharedAmenity.$assignedFields.contains('facilityId')) { facilityId = sharedAmenity.facilityId; }
		if (sharedAmenity.$assignedFields.contains('name')) { name = sharedAmenity.name; }
		if (sharedAmenity.$assignedFields.contains('type')) { type = sharedAmenity.type; }
		if (sharedAmenity.$assignedFields.contains('description')) { description = sharedAmenity.description; }
		if (sharedAmenity.$assignedFields.contains('location')) { location = sharedAmenity.location; }
		if (sharedAmenity.$assignedFields.contains('capacity')) { capacity = sharedAmenity.capacity; }
		if (sharedAmenity.$assignedFields.contains('isAvailable')) { isAvailable = sharedAmenity.isAvailable; }
		if (sharedAmenity.$assignedFields.contains('operatingHours')) { operatingHours = sharedAmenity.operatingHours; }
		if (sharedAmenity.$assignedFields.contains('accessType')) { accessType = sharedAmenity.accessType; }
		if (sharedAmenity.$assignedFields.contains('price')) { price = sharedAmenity.price; }
		if (sharedAmenity.$assignedFields.contains('images')) { images = sharedAmenity.images; }
		if (sharedAmenity.$assignedFields.contains('createdAt')) { createdAt = sharedAmenity.createdAt; }
		if (sharedAmenity.$assignedFields.contains('updatedAt')) { updatedAt = sharedAmenity.updatedAt; }
		if (sharedAmenity.$assignedFields.contains('facility')) { facility = sharedAmenity.facility; }
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
          ? {...?serializedTypes, 'SharedAmenity'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(facilityId != null) 'facilityId': facilityId,
	if(name != null) 'name': name,
	if(type != null) 'type': type?.toJson(),
	if(description != null) 'description': description,
	if(location != null) 'location': location,
	if(capacity != null) 'capacity': capacity,
	if(isAvailable != null) 'isAvailable': isAvailable,
	if(operatingHours != null) 'operatingHours': operatingHours,
	if(accessType != null) 'accessType': accessType?.toJson(),
	if(price != null) 'price': price,
	if(images != null) 'images': images,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(facility != null && (!preventCircularSerialization || !serializedModels.contains('Facility'))) 'facility': facility?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
		if ($imagesCount != null) '_count': { 
		if ($imagesCount != null) 'images': $imagesCount, 
		},
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is SharedAmenity &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    