
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'maintenance_block_type.dart';
import 'listing.dart';
import 'organization.dart';
import 'property.dart';


class MaintenanceBlock implements PrismaModel<String, MaintenanceBlock> , Id<String> {
    @override
String? id;
	String? orgId;
	String? propertyId;
	String? listingId;
	MaintenanceBlockType? type;
	DateTime? startDate;
	DateTime? endDate;
	String? reason;
	String? createdBy;
	DateTime? createdAt;
	DateTime? updatedAt;
	DateTime? deletedAt;
	Listing? listing;
	Organization? org;
	Property? property;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    MaintenanceBlock({ this.id,
	 this.orgId,
	 this.propertyId,
	 this.listingId,
	 this.type,
	 this.startDate,
	 this.endDate,
	 this.reason,
	 this.createdBy,
	 this.createdAt,
	 this.updatedAt,
	 this.deletedAt,
	 this.listing,
	 this.org,
	 this.property,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<MaintenanceBlock, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"orgId": (m) => m.orgId,

	"propertyId": (m) => m.propertyId,

	"listingId": (m) => m.listingId,

	"type": (m) => m.type,

	"startDate": (m) => m.startDate,

	"endDate": (m) => m.endDate,

	"reason": (m) => m.reason,

	"createdBy": (m) => m.createdBy,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"deletedAt": (m) => m.deletedAt,

	"listing": (m) => m.listing,

	"org": (m) => m.org,

	"property": (m) => m.property,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(MaintenanceBlock) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in MaintenanceBlock');
    }
    return propFunction as V? Function(MaintenanceBlock);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory MaintenanceBlock.fromJson(JsonMap json) =>
      MaintenanceBlock(
        id: json['id'] as String?,
	orgId: json['orgId'] as String?,
	propertyId: json['propertyId'] as String?,
	listingId: json['listingId'] as String?,
	type: json['type'] != null ? MaintenanceBlockType.fromJson(json['type']) : null,
	startDate: json['startDate'] != null ? DateTime.parse(json['startDate']) : null,
	endDate: json['endDate'] != null ? DateTime.parse(json['endDate']) : null,
	reason: json['reason'] as String?,
	createdBy: json['createdBy'] as String?,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
	listing: json['listing'] != null ? Listing.fromJson(json['listing'] as JsonMap) : null,
	org: json['org'] != null ? Organization.fromJson(json['org'] as JsonMap) : null,
	property: json['property'] != null ? Property.fromJson(json['property'] as JsonMap) : null,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    MaintenanceBlock copyWith({
        Value<String?>? id,
		Value<String?>? orgId,
		Value<String?>? propertyId,
		Value<String?>? listingId,
		Value<MaintenanceBlockType?>? type,
		Value<DateTime?>? startDate,
		Value<DateTime?>? endDate,
		Value<String?>? reason,
		Value<String?>? createdBy,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<DateTime?>? deletedAt,
		Value<Listing?>? listing,
		Value<Organization?>? org,
		Value<Property?>? property,
        }) {
        return MaintenanceBlock(
            id: id != null ? id.value : this.id,
		orgId: orgId != null ? orgId.value : this.orgId,
		propertyId: propertyId != null ? propertyId.value : this.propertyId,
		listingId: listingId != null ? listingId.value : this.listingId,
		type: type != null ? type.value : this.type,
		startDate: startDate != null ? startDate.value : this.startDate,
		endDate: endDate != null ? endDate.value : this.endDate,
		reason: reason != null ? reason.value : this.reason,
		createdBy: createdBy != null ? createdBy.value : this.createdBy,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		deletedAt: deletedAt != null ? deletedAt.value : this.deletedAt,
		listing: listing != null ? listing.value : this.listing,
		org: org != null ? org.value : this.org,
		property: property != null ? property.value : this.property
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    MaintenanceBlock copyWithInstanceValues(MaintenanceBlock maintenanceBlock) {
        return MaintenanceBlock(
            id: maintenanceBlock.id ?? id,
		orgId: maintenanceBlock.orgId ?? orgId,
		propertyId: maintenanceBlock.propertyId ?? propertyId,
		listingId: maintenanceBlock.listingId ?? listingId,
		type: maintenanceBlock.type ?? type,
		startDate: maintenanceBlock.startDate ?? startDate,
		endDate: maintenanceBlock.endDate ?? endDate,
		reason: maintenanceBlock.reason ?? reason,
		createdBy: maintenanceBlock.createdBy ?? createdBy,
		createdAt: maintenanceBlock.createdAt ?? createdAt,
		updatedAt: maintenanceBlock.updatedAt ?? updatedAt,
		deletedAt: maintenanceBlock.deletedAt ?? deletedAt,
		listing: maintenanceBlock.listing ?? listing,
		org: maintenanceBlock.org ?? org,
		property: maintenanceBlock.property ?? property
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    MaintenanceBlock mergeWithInstanceValues(MaintenanceBlock maintenanceBlock) {
        return MaintenanceBlock(
            id: maintenanceBlock.$assignedFields.contains('id') ? maintenanceBlock.id : id,
		orgId: maintenanceBlock.$assignedFields.contains('orgId') ? maintenanceBlock.orgId : orgId,
		propertyId: maintenanceBlock.$assignedFields.contains('propertyId') ? maintenanceBlock.propertyId : propertyId,
		listingId: maintenanceBlock.$assignedFields.contains('listingId') ? maintenanceBlock.listingId : listingId,
		type: maintenanceBlock.$assignedFields.contains('type') ? maintenanceBlock.type : type,
		startDate: maintenanceBlock.$assignedFields.contains('startDate') ? maintenanceBlock.startDate : startDate,
		endDate: maintenanceBlock.$assignedFields.contains('endDate') ? maintenanceBlock.endDate : endDate,
		reason: maintenanceBlock.$assignedFields.contains('reason') ? maintenanceBlock.reason : reason,
		createdBy: maintenanceBlock.$assignedFields.contains('createdBy') ? maintenanceBlock.createdBy : createdBy,
		createdAt: maintenanceBlock.$assignedFields.contains('createdAt') ? maintenanceBlock.createdAt : createdAt,
		updatedAt: maintenanceBlock.$assignedFields.contains('updatedAt') ? maintenanceBlock.updatedAt : updatedAt,
		deletedAt: maintenanceBlock.$assignedFields.contains('deletedAt') ? maintenanceBlock.deletedAt : deletedAt,
		listing: maintenanceBlock.$assignedFields.contains('listing') ? maintenanceBlock.listing : listing,
		org: maintenanceBlock.$assignedFields.contains('org') ? maintenanceBlock.org : org,
		property: maintenanceBlock.$assignedFields.contains('property') ? maintenanceBlock.property : property
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    MaintenanceBlock updateWithInstanceValues(MaintenanceBlock maintenanceBlock) {
        if (maintenanceBlock.$assignedFields.contains('id')) { id = maintenanceBlock.id; }
		if (maintenanceBlock.$assignedFields.contains('orgId')) { orgId = maintenanceBlock.orgId; }
		if (maintenanceBlock.$assignedFields.contains('propertyId')) { propertyId = maintenanceBlock.propertyId; }
		if (maintenanceBlock.$assignedFields.contains('listingId')) { listingId = maintenanceBlock.listingId; }
		if (maintenanceBlock.$assignedFields.contains('type')) { type = maintenanceBlock.type; }
		if (maintenanceBlock.$assignedFields.contains('startDate')) { startDate = maintenanceBlock.startDate; }
		if (maintenanceBlock.$assignedFields.contains('endDate')) { endDate = maintenanceBlock.endDate; }
		if (maintenanceBlock.$assignedFields.contains('reason')) { reason = maintenanceBlock.reason; }
		if (maintenanceBlock.$assignedFields.contains('createdBy')) { createdBy = maintenanceBlock.createdBy; }
		if (maintenanceBlock.$assignedFields.contains('createdAt')) { createdAt = maintenanceBlock.createdAt; }
		if (maintenanceBlock.$assignedFields.contains('updatedAt')) { updatedAt = maintenanceBlock.updatedAt; }
		if (maintenanceBlock.$assignedFields.contains('deletedAt')) { deletedAt = maintenanceBlock.deletedAt; }
		if (maintenanceBlock.$assignedFields.contains('listing')) { listing = maintenanceBlock.listing; }
		if (maintenanceBlock.$assignedFields.contains('org')) { org = maintenanceBlock.org; }
		if (maintenanceBlock.$assignedFields.contains('property')) { property = maintenanceBlock.property; }
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
          ? {...?serializedTypes, 'MaintenanceBlock'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(orgId != null) 'orgId': orgId,
	if(propertyId != null) 'propertyId': propertyId,
	if(listingId != null) 'listingId': listingId,
	if(type != null) 'type': type?.toJson(),
	if(startDate != null) 'startDate': startDate?.toIso8601String(),
	if(endDate != null) 'endDate': endDate?.toIso8601String(),
	if(reason != null) 'reason': reason,
	if(createdBy != null) 'createdBy': createdBy,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(deletedAt != null) 'deletedAt': deletedAt?.toIso8601String(),
	if(listing != null && (!preventCircularSerialization || !serializedModels.contains('Listing'))) 'listing': listing?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(org != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'org': org?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(property != null && (!preventCircularSerialization || !serializedModels.contains('Property'))) 'property': property?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is MaintenanceBlock &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    