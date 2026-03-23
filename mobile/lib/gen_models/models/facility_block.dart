
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'facility.dart';


class FacilityBlock implements PrismaModel<String, FacilityBlock> , Id<String> {
    @override
String? id;
	String? facilityId;
	String? name;
	int? floors;
	int? unitsPerFloor;
	int? totalUnits;
	int? yearBuilt;
	String? architect;
	List<String>? features;
	List<String>? images;
	Facility? facility;
	int? $featuresCount;
	int? $imagesCount;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    FacilityBlock({ this.id,
	 this.facilityId,
	 this.name,
	 this.floors,
	 this.unitsPerFloor,
	 this.totalUnits,
	 this.yearBuilt,
	 this.architect,
	 this.features,
	 this.images,
	 this.facility,
	this.$featuresCount,
	this.$imagesCount,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<FacilityBlock, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"facilityId": (m) => m.facilityId,

	"name": (m) => m.name,

	"floors": (m) => m.floors,

	"unitsPerFloor": (m) => m.unitsPerFloor,

	"totalUnits": (m) => m.totalUnits,

	"yearBuilt": (m) => m.yearBuilt,

	"architect": (m) => m.architect,

	"features": (m) => m.features,

	"images": (m) => m.images,

	"facility": (m) => m.facility,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(FacilityBlock) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in FacilityBlock');
    }
    return propFunction as V? Function(FacilityBlock);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory FacilityBlock.fromJson(JsonMap json) =>
      FacilityBlock(
        id: json['id'] as String?,
	facilityId: json['facilityId'] as String?,
	name: json['name'] as String?,
	floors: int.tryParse(json['floors'].toString()),
	unitsPerFloor: int.tryParse(json['unitsPerFloor'].toString()),
	totalUnits: int.tryParse(json['totalUnits'].toString()),
	yearBuilt: int.tryParse(json['yearBuilt'].toString()),
	architect: json['architect'] as String?,
	features: json['features'] != null ? (json['features'] as List<dynamic>).map((e) => e.toString()).toList() : null,
	images: json['images'] != null ? (json['images'] as List<dynamic>).map((e) => e.toString()).toList() : null,
	facility: json['facility'] != null ? Facility.fromJson(json['facility'] as JsonMap) : null,
	$featuresCount: json['_count']?['features'] as int?,
	$imagesCount: json['_count']?['images'] as int?,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    FacilityBlock copyWith({
        Value<String?>? id,
		Value<String?>? facilityId,
		Value<String?>? name,
		Value<int?>? floors,
		Value<int?>? unitsPerFloor,
		Value<int?>? totalUnits,
		Value<int?>? yearBuilt,
		Value<String?>? architect,
		Value<List<String>?>? features,
		Value<List<String>?>? images,
		Value<Facility?>? facility,
		int? $featuresCount,
		int? $imagesCount,
        }) {
        return FacilityBlock(
            id: id != null ? id.value : this.id,
		facilityId: facilityId != null ? facilityId.value : this.facilityId,
		name: name != null ? name.value : this.name,
		floors: floors != null ? floors.value : this.floors,
		unitsPerFloor: unitsPerFloor != null ? unitsPerFloor.value : this.unitsPerFloor,
		totalUnits: totalUnits != null ? totalUnits.value : this.totalUnits,
		yearBuilt: yearBuilt != null ? yearBuilt.value : this.yearBuilt,
		architect: architect != null ? architect.value : this.architect,
		features: features != null ? features.value : this.features,
		images: images != null ? images.value : this.images,
		facility: facility != null ? facility.value : this.facility,
		$featuresCount: $featuresCount ?? this.$featuresCount,
		$imagesCount: $imagesCount ?? this.$imagesCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    FacilityBlock copyWithInstanceValues(FacilityBlock facilityBlock) {
        return FacilityBlock(
            id: facilityBlock.id ?? id,
		facilityId: facilityBlock.facilityId ?? facilityId,
		name: facilityBlock.name ?? name,
		floors: facilityBlock.floors ?? floors,
		unitsPerFloor: facilityBlock.unitsPerFloor ?? unitsPerFloor,
		totalUnits: facilityBlock.totalUnits ?? totalUnits,
		yearBuilt: facilityBlock.yearBuilt ?? yearBuilt,
		architect: facilityBlock.architect ?? architect,
		features: facilityBlock.features ?? features,
		images: facilityBlock.images ?? images,
		facility: facilityBlock.facility ?? facility,
		$featuresCount: facilityBlock.$featuresCount ?? $featuresCount,
		$imagesCount: facilityBlock.$imagesCount ?? $imagesCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    FacilityBlock mergeWithInstanceValues(FacilityBlock facilityBlock) {
        return FacilityBlock(
            id: facilityBlock.$assignedFields.contains('id') ? facilityBlock.id : id,
		facilityId: facilityBlock.$assignedFields.contains('facilityId') ? facilityBlock.facilityId : facilityId,
		name: facilityBlock.$assignedFields.contains('name') ? facilityBlock.name : name,
		floors: facilityBlock.$assignedFields.contains('floors') ? facilityBlock.floors : floors,
		unitsPerFloor: facilityBlock.$assignedFields.contains('unitsPerFloor') ? facilityBlock.unitsPerFloor : unitsPerFloor,
		totalUnits: facilityBlock.$assignedFields.contains('totalUnits') ? facilityBlock.totalUnits : totalUnits,
		yearBuilt: facilityBlock.$assignedFields.contains('yearBuilt') ? facilityBlock.yearBuilt : yearBuilt,
		architect: facilityBlock.$assignedFields.contains('architect') ? facilityBlock.architect : architect,
		features: facilityBlock.$assignedFields.contains('features') ? facilityBlock.features : features,
		images: facilityBlock.$assignedFields.contains('images') ? facilityBlock.images : images,
		facility: facilityBlock.$assignedFields.contains('facility') ? facilityBlock.facility : facility,
		$featuresCount: facilityBlock.$featuresCount ?? $featuresCount,
		$imagesCount: facilityBlock.$imagesCount ?? $imagesCount
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    FacilityBlock updateWithInstanceValues(FacilityBlock facilityBlock) {
        if (facilityBlock.$assignedFields.contains('id')) { id = facilityBlock.id; }
		if (facilityBlock.$assignedFields.contains('facilityId')) { facilityId = facilityBlock.facilityId; }
		if (facilityBlock.$assignedFields.contains('name')) { name = facilityBlock.name; }
		if (facilityBlock.$assignedFields.contains('floors')) { floors = facilityBlock.floors; }
		if (facilityBlock.$assignedFields.contains('unitsPerFloor')) { unitsPerFloor = facilityBlock.unitsPerFloor; }
		if (facilityBlock.$assignedFields.contains('totalUnits')) { totalUnits = facilityBlock.totalUnits; }
		if (facilityBlock.$assignedFields.contains('yearBuilt')) { yearBuilt = facilityBlock.yearBuilt; }
		if (facilityBlock.$assignedFields.contains('architect')) { architect = facilityBlock.architect; }
		if (facilityBlock.$assignedFields.contains('features')) { features = facilityBlock.features; }
		if (facilityBlock.$assignedFields.contains('images')) { images = facilityBlock.images; }
		if (facilityBlock.$assignedFields.contains('facility')) { facility = facilityBlock.facility; }
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
          ? {...?serializedTypes, 'FacilityBlock'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(facilityId != null) 'facilityId': facilityId,
	if(name != null) 'name': name,
	if(floors != null) 'floors': floors,
	if(unitsPerFloor != null) 'unitsPerFloor': unitsPerFloor,
	if(totalUnits != null) 'totalUnits': totalUnits,
	if(yearBuilt != null) 'yearBuilt': yearBuilt,
	if(architect != null) 'architect': architect,
	if(features != null) 'features': features,
	if(images != null) 'images': images,
	if(facility != null && (!preventCircularSerialization || !serializedModels.contains('Facility'))) 'facility': facility?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
		if ($featuresCount != null || $imagesCount != null) '_count': { 
		if ($featuresCount != null) 'features': $featuresCount, 
		if ($imagesCount != null) 'images': $imagesCount, 
		},
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is FacilityBlock &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    