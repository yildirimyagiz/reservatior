
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'lease.dart';
import 'organization.dart';
import 'property.dart';


class PropertyInventory implements PrismaModel<String, PropertyInventory> , Id<String> {
    @override
String? id;
	String? orgId;
	String? propertyId;
	String? leaseId;
	String? inventoryType;
	DateTime? inventoryDate;
	String? conductedBy;
	List<String>? presentAtCheck;
	dynamic rooms;
	String? overallCondition;
	dynamic damages;
	bool? cleaningRequired;
	String? tenantSignature;
	String? landlordSignature;
	String? agentSignature;
	String? reportUrl;
	dynamic photos;
	DateTime? createdAt;
	DateTime? updatedAt;
	Lease? lease;
	Organization? org;
	Property? property;
	int? $presentAtCheckCount;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    PropertyInventory({ this.id,
	 this.orgId,
	 this.propertyId,
	 this.leaseId,
	 this.inventoryType,
	 this.inventoryDate,
	 this.conductedBy,
	 this.presentAtCheck,
	required this.rooms,
	 this.overallCondition,
	required this.damages,
	 this.cleaningRequired = false,
	 this.tenantSignature,
	 this.landlordSignature,
	 this.agentSignature,
	 this.reportUrl,
	required this.photos,
	 this.createdAt,
	 this.updatedAt,
	 this.lease,
	 this.org,
	 this.property,
	this.$presentAtCheckCount,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<PropertyInventory, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"orgId": (m) => m.orgId,

	"propertyId": (m) => m.propertyId,

	"leaseId": (m) => m.leaseId,

	"inventoryType": (m) => m.inventoryType,

	"inventoryDate": (m) => m.inventoryDate,

	"conductedBy": (m) => m.conductedBy,

	"presentAtCheck": (m) => m.presentAtCheck,

	"rooms": (m) => m.rooms,

	"overallCondition": (m) => m.overallCondition,

	"damages": (m) => m.damages,

	"cleaningRequired": (m) => m.cleaningRequired,

	"tenantSignature": (m) => m.tenantSignature,

	"landlordSignature": (m) => m.landlordSignature,

	"agentSignature": (m) => m.agentSignature,

	"reportUrl": (m) => m.reportUrl,

	"photos": (m) => m.photos,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"lease": (m) => m.lease,

	"org": (m) => m.org,

	"property": (m) => m.property,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(PropertyInventory) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in PropertyInventory');
    }
    return propFunction as V? Function(PropertyInventory);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory PropertyInventory.fromJson(JsonMap json) =>
      PropertyInventory(
        id: json['id'] as String?,
	orgId: json['orgId'] as String?,
	propertyId: json['propertyId'] as String?,
	leaseId: json['leaseId'] as String?,
	inventoryType: json['inventoryType'] as String?,
	inventoryDate: json['inventoryDate'] != null ? DateTime.parse(json['inventoryDate']) : null,
	conductedBy: json['conductedBy'] as String?,
	presentAtCheck: json['presentAtCheck'] != null ? (json['presentAtCheck'] as List<dynamic>).map((e) => e.toString()).toList() : null,
	rooms: json['rooms'] as dynamic,
	overallCondition: json['overallCondition'] as String?,
	damages: json['damages'] as dynamic,
	cleaningRequired: json['cleaningRequired'] as bool?,
	tenantSignature: json['tenantSignature'] as String?,
	landlordSignature: json['landlordSignature'] as String?,
	agentSignature: json['agentSignature'] as String?,
	reportUrl: json['reportUrl'] as String?,
	photos: json['photos'] as dynamic,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	lease: json['lease'] != null ? Lease.fromJson(json['lease'] as JsonMap) : null,
	org: json['org'] != null ? Organization.fromJson(json['org'] as JsonMap) : null,
	property: json['property'] != null ? Property.fromJson(json['property'] as JsonMap) : null,
	$presentAtCheckCount: json['_count']?['presentAtCheck'] as int?,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    PropertyInventory copyWith({
        Value<String?>? id,
		Value<String?>? orgId,
		Value<String?>? propertyId,
		Value<String?>? leaseId,
		Value<String?>? inventoryType,
		Value<DateTime?>? inventoryDate,
		Value<String?>? conductedBy,
		Value<List<String>?>? presentAtCheck,
		Value<dynamic>? rooms,
		Value<String?>? overallCondition,
		Value<dynamic>? damages,
		Value<bool?>? cleaningRequired,
		Value<String?>? tenantSignature,
		Value<String?>? landlordSignature,
		Value<String?>? agentSignature,
		Value<String?>? reportUrl,
		Value<dynamic>? photos,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<Lease?>? lease,
		Value<Organization?>? org,
		Value<Property?>? property,
		int? $presentAtCheckCount,
        }) {
        return PropertyInventory(
            id: id != null ? id.value : this.id,
		orgId: orgId != null ? orgId.value : this.orgId,
		propertyId: propertyId != null ? propertyId.value : this.propertyId,
		leaseId: leaseId != null ? leaseId.value : this.leaseId,
		inventoryType: inventoryType != null ? inventoryType.value : this.inventoryType,
		inventoryDate: inventoryDate != null ? inventoryDate.value : this.inventoryDate,
		conductedBy: conductedBy != null ? conductedBy.value : this.conductedBy,
		presentAtCheck: presentAtCheck != null ? presentAtCheck.value : this.presentAtCheck,
		rooms: rooms != null ? rooms.value : this.rooms,
		overallCondition: overallCondition != null ? overallCondition.value : this.overallCondition,
		damages: damages != null ? damages.value : this.damages,
		cleaningRequired: cleaningRequired != null ? cleaningRequired.value : this.cleaningRequired,
		tenantSignature: tenantSignature != null ? tenantSignature.value : this.tenantSignature,
		landlordSignature: landlordSignature != null ? landlordSignature.value : this.landlordSignature,
		agentSignature: agentSignature != null ? agentSignature.value : this.agentSignature,
		reportUrl: reportUrl != null ? reportUrl.value : this.reportUrl,
		photos: photos != null ? photos.value : this.photos,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		lease: lease != null ? lease.value : this.lease,
		org: org != null ? org.value : this.org,
		property: property != null ? property.value : this.property,
		$presentAtCheckCount: $presentAtCheckCount ?? this.$presentAtCheckCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    PropertyInventory copyWithInstanceValues(PropertyInventory propertyInventory) {
        return PropertyInventory(
            id: propertyInventory.id ?? id,
		orgId: propertyInventory.orgId ?? orgId,
		propertyId: propertyInventory.propertyId ?? propertyId,
		leaseId: propertyInventory.leaseId ?? leaseId,
		inventoryType: propertyInventory.inventoryType ?? inventoryType,
		inventoryDate: propertyInventory.inventoryDate ?? inventoryDate,
		conductedBy: propertyInventory.conductedBy ?? conductedBy,
		presentAtCheck: propertyInventory.presentAtCheck ?? presentAtCheck,
		rooms: propertyInventory.rooms ?? rooms,
		overallCondition: propertyInventory.overallCondition ?? overallCondition,
		damages: propertyInventory.damages ?? damages,
		cleaningRequired: propertyInventory.cleaningRequired ?? cleaningRequired,
		tenantSignature: propertyInventory.tenantSignature ?? tenantSignature,
		landlordSignature: propertyInventory.landlordSignature ?? landlordSignature,
		agentSignature: propertyInventory.agentSignature ?? agentSignature,
		reportUrl: propertyInventory.reportUrl ?? reportUrl,
		photos: propertyInventory.photos ?? photos,
		createdAt: propertyInventory.createdAt ?? createdAt,
		updatedAt: propertyInventory.updatedAt ?? updatedAt,
		lease: propertyInventory.lease ?? lease,
		org: propertyInventory.org ?? org,
		property: propertyInventory.property ?? property,
		$presentAtCheckCount: propertyInventory.$presentAtCheckCount ?? $presentAtCheckCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    PropertyInventory mergeWithInstanceValues(PropertyInventory propertyInventory) {
        return PropertyInventory(
            id: propertyInventory.$assignedFields.contains('id') ? propertyInventory.id : id,
		orgId: propertyInventory.$assignedFields.contains('orgId') ? propertyInventory.orgId : orgId,
		propertyId: propertyInventory.$assignedFields.contains('propertyId') ? propertyInventory.propertyId : propertyId,
		leaseId: propertyInventory.$assignedFields.contains('leaseId') ? propertyInventory.leaseId : leaseId,
		inventoryType: propertyInventory.$assignedFields.contains('inventoryType') ? propertyInventory.inventoryType : inventoryType,
		inventoryDate: propertyInventory.$assignedFields.contains('inventoryDate') ? propertyInventory.inventoryDate : inventoryDate,
		conductedBy: propertyInventory.$assignedFields.contains('conductedBy') ? propertyInventory.conductedBy : conductedBy,
		presentAtCheck: propertyInventory.$assignedFields.contains('presentAtCheck') ? propertyInventory.presentAtCheck : presentAtCheck,
		rooms: propertyInventory.$assignedFields.contains('rooms') ? propertyInventory.rooms : rooms,
		overallCondition: propertyInventory.$assignedFields.contains('overallCondition') ? propertyInventory.overallCondition : overallCondition,
		damages: propertyInventory.$assignedFields.contains('damages') ? propertyInventory.damages : damages,
		cleaningRequired: propertyInventory.$assignedFields.contains('cleaningRequired') ? propertyInventory.cleaningRequired : cleaningRequired,
		tenantSignature: propertyInventory.$assignedFields.contains('tenantSignature') ? propertyInventory.tenantSignature : tenantSignature,
		landlordSignature: propertyInventory.$assignedFields.contains('landlordSignature') ? propertyInventory.landlordSignature : landlordSignature,
		agentSignature: propertyInventory.$assignedFields.contains('agentSignature') ? propertyInventory.agentSignature : agentSignature,
		reportUrl: propertyInventory.$assignedFields.contains('reportUrl') ? propertyInventory.reportUrl : reportUrl,
		photos: propertyInventory.$assignedFields.contains('photos') ? propertyInventory.photos : photos,
		createdAt: propertyInventory.$assignedFields.contains('createdAt') ? propertyInventory.createdAt : createdAt,
		updatedAt: propertyInventory.$assignedFields.contains('updatedAt') ? propertyInventory.updatedAt : updatedAt,
		lease: propertyInventory.$assignedFields.contains('lease') ? propertyInventory.lease : lease,
		org: propertyInventory.$assignedFields.contains('org') ? propertyInventory.org : org,
		property: propertyInventory.$assignedFields.contains('property') ? propertyInventory.property : property,
		$presentAtCheckCount: propertyInventory.$presentAtCheckCount ?? $presentAtCheckCount
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    PropertyInventory updateWithInstanceValues(PropertyInventory propertyInventory) {
        if (propertyInventory.$assignedFields.contains('id')) { id = propertyInventory.id; }
		if (propertyInventory.$assignedFields.contains('orgId')) { orgId = propertyInventory.orgId; }
		if (propertyInventory.$assignedFields.contains('propertyId')) { propertyId = propertyInventory.propertyId; }
		if (propertyInventory.$assignedFields.contains('leaseId')) { leaseId = propertyInventory.leaseId; }
		if (propertyInventory.$assignedFields.contains('inventoryType')) { inventoryType = propertyInventory.inventoryType; }
		if (propertyInventory.$assignedFields.contains('inventoryDate')) { inventoryDate = propertyInventory.inventoryDate; }
		if (propertyInventory.$assignedFields.contains('conductedBy')) { conductedBy = propertyInventory.conductedBy; }
		if (propertyInventory.$assignedFields.contains('presentAtCheck')) { presentAtCheck = propertyInventory.presentAtCheck; }
		if (propertyInventory.$assignedFields.contains('rooms')) { rooms = propertyInventory.rooms; }
		if (propertyInventory.$assignedFields.contains('overallCondition')) { overallCondition = propertyInventory.overallCondition; }
		if (propertyInventory.$assignedFields.contains('damages')) { damages = propertyInventory.damages; }
		if (propertyInventory.$assignedFields.contains('cleaningRequired')) { cleaningRequired = propertyInventory.cleaningRequired; }
		if (propertyInventory.$assignedFields.contains('tenantSignature')) { tenantSignature = propertyInventory.tenantSignature; }
		if (propertyInventory.$assignedFields.contains('landlordSignature')) { landlordSignature = propertyInventory.landlordSignature; }
		if (propertyInventory.$assignedFields.contains('agentSignature')) { agentSignature = propertyInventory.agentSignature; }
		if (propertyInventory.$assignedFields.contains('reportUrl')) { reportUrl = propertyInventory.reportUrl; }
		if (propertyInventory.$assignedFields.contains('photos')) { photos = propertyInventory.photos; }
		if (propertyInventory.$assignedFields.contains('createdAt')) { createdAt = propertyInventory.createdAt; }
		if (propertyInventory.$assignedFields.contains('updatedAt')) { updatedAt = propertyInventory.updatedAt; }
		if (propertyInventory.$assignedFields.contains('lease')) { lease = propertyInventory.lease; }
		if (propertyInventory.$assignedFields.contains('org')) { org = propertyInventory.org; }
		if (propertyInventory.$assignedFields.contains('property')) { property = propertyInventory.property; }
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
          ? {...?serializedTypes, 'PropertyInventory'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(orgId != null) 'orgId': orgId,
	if(propertyId != null) 'propertyId': propertyId,
	if(leaseId != null) 'leaseId': leaseId,
	if(inventoryType != null) 'inventoryType': inventoryType,
	if(inventoryDate != null) 'inventoryDate': inventoryDate?.toIso8601String(),
	if(conductedBy != null) 'conductedBy': conductedBy,
	if(presentAtCheck != null) 'presentAtCheck': presentAtCheck,
	if(rooms != null) 'rooms': rooms,
	if(overallCondition != null) 'overallCondition': overallCondition,
	if(damages != null) 'damages': damages,
	if(cleaningRequired != null) 'cleaningRequired': cleaningRequired,
	if(tenantSignature != null) 'tenantSignature': tenantSignature,
	if(landlordSignature != null) 'landlordSignature': landlordSignature,
	if(agentSignature != null) 'agentSignature': agentSignature,
	if(reportUrl != null) 'reportUrl': reportUrl,
	if(photos != null) 'photos': photos,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(lease != null && (!preventCircularSerialization || !serializedModels.contains('Lease'))) 'lease': lease?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(org != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'org': org?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(property != null && (!preventCircularSerialization || !serializedModels.contains('Property'))) 'property': property?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
		if ($presentAtCheckCount != null) '_count': { 
		if ($presentAtCheckCount != null) 'presentAtCheck': $presentAtCheckCount, 
		},
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is PropertyInventory &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    