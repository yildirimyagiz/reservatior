
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'organization.dart';
import 'property.dart';
import 'agency.dart';
import 'expense.dart';
import 'extra_charge.dart';
import 'facility_block.dart';
import 'included_service.dart';
import 'shared_amenity.dart';


class Facility implements PrismaModel<String, Facility> , Id<String> {
    @override
String? id;
	String? orgId;
	String? propertyId;
	String? name;
	double? feeAmount;
	String? feeCurrency;
	String? notes;
	String? createdBy;
	DateTime? createdAt;
	DateTime? updatedAt;
	DateTime? deletedAt;
	Organization? org;
	Property? property;
	List<Agency>? agencies;
	List<Expense>? expenses;
	List<ExtraCharge>? extraCharges;
	List<FacilityBlock>? facilityBlocks;
	List<IncludedService>? includedServices;
	List<SharedAmenity>? sharedAmenities;
	int? $agenciesCount;
	int? $expensesCount;
	int? $extraChargesCount;
	int? $facilityBlocksCount;
	int? $includedServicesCount;
	int? $sharedAmenitiesCount;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    Facility({ this.id,
	 this.orgId,
	 this.propertyId,
	 this.name,
	 this.feeAmount,
	 this.feeCurrency,
	 this.notes,
	 this.createdBy,
	 this.createdAt,
	 this.updatedAt,
	 this.deletedAt,
	 this.org,
	 this.property,
	 this.agencies,
	 this.expenses,
	 this.extraCharges,
	 this.facilityBlocks,
	 this.includedServices,
	 this.sharedAmenities,
	this.$agenciesCount,
	this.$expensesCount,
	this.$extraChargesCount,
	this.$facilityBlocksCount,
	this.$includedServicesCount,
	this.$sharedAmenitiesCount,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<Facility, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"orgId": (m) => m.orgId,

	"propertyId": (m) => m.propertyId,

	"name": (m) => m.name,

	"feeAmount": (m) => m.feeAmount,

	"feeCurrency": (m) => m.feeCurrency,

	"notes": (m) => m.notes,

	"createdBy": (m) => m.createdBy,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"deletedAt": (m) => m.deletedAt,

	"org": (m) => m.org,

	"property": (m) => m.property,

	"agencies": (m) => m.agencies,

	"expenses": (m) => m.expenses,

	"extraCharges": (m) => m.extraCharges,

	"facilityBlocks": (m) => m.facilityBlocks,

	"includedServices": (m) => m.includedServices,

	"sharedAmenities": (m) => m.sharedAmenities,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(Facility) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in Facility');
    }
    return propFunction as V? Function(Facility);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory Facility.fromJson(JsonMap json) =>
      Facility(
        id: json['id'] as String?,
	orgId: json['orgId'] as String?,
	propertyId: json['propertyId'] as String?,
	name: json['name'] as String?,
	feeAmount: json['feeAmount'] as double?,
	feeCurrency: json['feeCurrency'] as String?,
	notes: json['notes'] as String?,
	createdBy: json['createdBy'] as String?,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
	org: json['org'] != null ? Organization.fromJson(json['org'] as JsonMap) : null,
	property: json['property'] != null ? Property.fromJson(json['property'] as JsonMap) : null,
	agencies: json['agencies'] != null ? createModels<Agency>((json['agencies'] as List).cast<JsonMap>(), Agency.fromJson) : null,
	expenses: json['expenses'] != null ? createModels<Expense>((json['expenses'] as List).cast<JsonMap>(), Expense.fromJson) : null,
	extraCharges: json['extraCharges'] != null ? createModels<ExtraCharge>((json['extraCharges'] as List).cast<JsonMap>(), ExtraCharge.fromJson) : null,
	facilityBlocks: json['facilityBlocks'] != null ? createModels<FacilityBlock>((json['facilityBlocks'] as List).cast<JsonMap>(), FacilityBlock.fromJson) : null,
	includedServices: json['includedServices'] != null ? createModels<IncludedService>((json['includedServices'] as List).cast<JsonMap>(), IncludedService.fromJson) : null,
	sharedAmenities: json['sharedAmenities'] != null ? createModels<SharedAmenity>((json['sharedAmenities'] as List).cast<JsonMap>(), SharedAmenity.fromJson) : null,
	$agenciesCount: json['_count']?['agencies'] as int?,
	$expensesCount: json['_count']?['expenses'] as int?,
	$extraChargesCount: json['_count']?['extraCharges'] as int?,
	$facilityBlocksCount: json['_count']?['facilityBlocks'] as int?,
	$includedServicesCount: json['_count']?['includedServices'] as int?,
	$sharedAmenitiesCount: json['_count']?['sharedAmenities'] as int?,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    Facility copyWith({
        Value<String?>? id,
		Value<String?>? orgId,
		Value<String?>? propertyId,
		Value<String?>? name,
		Value<double?>? feeAmount,
		Value<String?>? feeCurrency,
		Value<String?>? notes,
		Value<String?>? createdBy,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<DateTime?>? deletedAt,
		Value<Organization?>? org,
		Value<Property?>? property,
		Value<List<Agency>?>? agencies,
		Value<List<Expense>?>? expenses,
		Value<List<ExtraCharge>?>? extraCharges,
		Value<List<FacilityBlock>?>? facilityBlocks,
		Value<List<IncludedService>?>? includedServices,
		Value<List<SharedAmenity>?>? sharedAmenities,
		int? $agenciesCount,
		int? $expensesCount,
		int? $extraChargesCount,
		int? $facilityBlocksCount,
		int? $includedServicesCount,
		int? $sharedAmenitiesCount,
        }) {
        return Facility(
            id: id != null ? id.value : this.id,
		orgId: orgId != null ? orgId.value : this.orgId,
		propertyId: propertyId != null ? propertyId.value : this.propertyId,
		name: name != null ? name.value : this.name,
		feeAmount: feeAmount != null ? feeAmount.value : this.feeAmount,
		feeCurrency: feeCurrency != null ? feeCurrency.value : this.feeCurrency,
		notes: notes != null ? notes.value : this.notes,
		createdBy: createdBy != null ? createdBy.value : this.createdBy,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		deletedAt: deletedAt != null ? deletedAt.value : this.deletedAt,
		org: org != null ? org.value : this.org,
		property: property != null ? property.value : this.property,
		agencies: agencies != null ? agencies.value : this.agencies,
		expenses: expenses != null ? expenses.value : this.expenses,
		extraCharges: extraCharges != null ? extraCharges.value : this.extraCharges,
		facilityBlocks: facilityBlocks != null ? facilityBlocks.value : this.facilityBlocks,
		includedServices: includedServices != null ? includedServices.value : this.includedServices,
		sharedAmenities: sharedAmenities != null ? sharedAmenities.value : this.sharedAmenities,
		$agenciesCount: $agenciesCount ?? this.$agenciesCount,
		$expensesCount: $expensesCount ?? this.$expensesCount,
		$extraChargesCount: $extraChargesCount ?? this.$extraChargesCount,
		$facilityBlocksCount: $facilityBlocksCount ?? this.$facilityBlocksCount,
		$includedServicesCount: $includedServicesCount ?? this.$includedServicesCount,
		$sharedAmenitiesCount: $sharedAmenitiesCount ?? this.$sharedAmenitiesCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    Facility copyWithInstanceValues(Facility facility) {
        return Facility(
            id: facility.id ?? id,
		orgId: facility.orgId ?? orgId,
		propertyId: facility.propertyId ?? propertyId,
		name: facility.name ?? name,
		feeAmount: facility.feeAmount ?? feeAmount,
		feeCurrency: facility.feeCurrency ?? feeCurrency,
		notes: facility.notes ?? notes,
		createdBy: facility.createdBy ?? createdBy,
		createdAt: facility.createdAt ?? createdAt,
		updatedAt: facility.updatedAt ?? updatedAt,
		deletedAt: facility.deletedAt ?? deletedAt,
		org: facility.org ?? org,
		property: facility.property ?? property,
		agencies: facility.agencies ?? agencies,
		expenses: facility.expenses ?? expenses,
		extraCharges: facility.extraCharges ?? extraCharges,
		facilityBlocks: facility.facilityBlocks ?? facilityBlocks,
		includedServices: facility.includedServices ?? includedServices,
		sharedAmenities: facility.sharedAmenities ?? sharedAmenities,
		$agenciesCount: facility.$agenciesCount ?? $agenciesCount,
		$expensesCount: facility.$expensesCount ?? $expensesCount,
		$extraChargesCount: facility.$extraChargesCount ?? $extraChargesCount,
		$facilityBlocksCount: facility.$facilityBlocksCount ?? $facilityBlocksCount,
		$includedServicesCount: facility.$includedServicesCount ?? $includedServicesCount,
		$sharedAmenitiesCount: facility.$sharedAmenitiesCount ?? $sharedAmenitiesCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    Facility mergeWithInstanceValues(Facility facility) {
        return Facility(
            id: facility.$assignedFields.contains('id') ? facility.id : id,
		orgId: facility.$assignedFields.contains('orgId') ? facility.orgId : orgId,
		propertyId: facility.$assignedFields.contains('propertyId') ? facility.propertyId : propertyId,
		name: facility.$assignedFields.contains('name') ? facility.name : name,
		feeAmount: facility.$assignedFields.contains('feeAmount') ? facility.feeAmount : feeAmount,
		feeCurrency: facility.$assignedFields.contains('feeCurrency') ? facility.feeCurrency : feeCurrency,
		notes: facility.$assignedFields.contains('notes') ? facility.notes : notes,
		createdBy: facility.$assignedFields.contains('createdBy') ? facility.createdBy : createdBy,
		createdAt: facility.$assignedFields.contains('createdAt') ? facility.createdAt : createdAt,
		updatedAt: facility.$assignedFields.contains('updatedAt') ? facility.updatedAt : updatedAt,
		deletedAt: facility.$assignedFields.contains('deletedAt') ? facility.deletedAt : deletedAt,
		org: facility.$assignedFields.contains('org') ? facility.org : org,
		property: facility.$assignedFields.contains('property') ? facility.property : property,
		agencies: (facility.$assignedFields.contains('agencies') && facility.agencies != null) ? mergeModelLists(agencies, facility.agencies) : agencies,
		expenses: (facility.$assignedFields.contains('expenses') && facility.expenses != null) ? mergeModelLists(expenses, facility.expenses) : expenses,
		extraCharges: (facility.$assignedFields.contains('extraCharges') && facility.extraCharges != null) ? mergeModelLists(extraCharges, facility.extraCharges) : extraCharges,
		facilityBlocks: (facility.$assignedFields.contains('facilityBlocks') && facility.facilityBlocks != null) ? mergeModelLists(facilityBlocks, facility.facilityBlocks) : facilityBlocks,
		includedServices: (facility.$assignedFields.contains('includedServices') && facility.includedServices != null) ? mergeModelLists(includedServices, facility.includedServices) : includedServices,
		sharedAmenities: (facility.$assignedFields.contains('sharedAmenities') && facility.sharedAmenities != null) ? mergeModelLists(sharedAmenities, facility.sharedAmenities) : sharedAmenities,
		$agenciesCount: facility.$agenciesCount ?? $agenciesCount,
		$expensesCount: facility.$expensesCount ?? $expensesCount,
		$extraChargesCount: facility.$extraChargesCount ?? $extraChargesCount,
		$facilityBlocksCount: facility.$facilityBlocksCount ?? $facilityBlocksCount,
		$includedServicesCount: facility.$includedServicesCount ?? $includedServicesCount,
		$sharedAmenitiesCount: facility.$sharedAmenitiesCount ?? $sharedAmenitiesCount
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    Facility updateWithInstanceValues(Facility facility) {
        if (facility.$assignedFields.contains('id')) { id = facility.id; }
		if (facility.$assignedFields.contains('orgId')) { orgId = facility.orgId; }
		if (facility.$assignedFields.contains('propertyId')) { propertyId = facility.propertyId; }
		if (facility.$assignedFields.contains('name')) { name = facility.name; }
		if (facility.$assignedFields.contains('feeAmount')) { feeAmount = facility.feeAmount; }
		if (facility.$assignedFields.contains('feeCurrency')) { feeCurrency = facility.feeCurrency; }
		if (facility.$assignedFields.contains('notes')) { notes = facility.notes; }
		if (facility.$assignedFields.contains('createdBy')) { createdBy = facility.createdBy; }
		if (facility.$assignedFields.contains('createdAt')) { createdAt = facility.createdAt; }
		if (facility.$assignedFields.contains('updatedAt')) { updatedAt = facility.updatedAt; }
		if (facility.$assignedFields.contains('deletedAt')) { deletedAt = facility.deletedAt; }
		if (facility.$assignedFields.contains('org')) { org = facility.org; }
		if (facility.$assignedFields.contains('property')) { property = facility.property; }
		if (facility.$assignedFields.contains('agencies') && facility.agencies != null) { agencies = mergeModelLists(agencies, facility.agencies); }
		if (facility.$assignedFields.contains('expenses') && facility.expenses != null) { expenses = mergeModelLists(expenses, facility.expenses); }
		if (facility.$assignedFields.contains('extraCharges') && facility.extraCharges != null) { extraCharges = mergeModelLists(extraCharges, facility.extraCharges); }
		if (facility.$assignedFields.contains('facilityBlocks') && facility.facilityBlocks != null) { facilityBlocks = mergeModelLists(facilityBlocks, facility.facilityBlocks); }
		if (facility.$assignedFields.contains('includedServices') && facility.includedServices != null) { includedServices = mergeModelLists(includedServices, facility.includedServices); }
		if (facility.$assignedFields.contains('sharedAmenities') && facility.sharedAmenities != null) { sharedAmenities = mergeModelLists(sharedAmenities, facility.sharedAmenities); }
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
          ? {...?serializedTypes, 'Facility'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(orgId != null) 'orgId': orgId,
	if(propertyId != null) 'propertyId': propertyId,
	if(name != null) 'name': name,
	if(feeAmount != null) 'feeAmount': feeAmount,
	if(feeCurrency != null) 'feeCurrency': feeCurrency,
	if(notes != null) 'notes': notes,
	if(createdBy != null) 'createdBy': createdBy,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(deletedAt != null) 'deletedAt': deletedAt?.toIso8601String(),
	if(org != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'org': org?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(property != null && (!preventCircularSerialization || !serializedModels.contains('Property'))) 'property': property?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(agencies != null && (!preventCircularSerialization || !serializedModels.contains('Agency'))) 'agencies': agencies?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(expenses != null && (!preventCircularSerialization || !serializedModels.contains('Expense'))) 'expenses': expenses?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(extraCharges != null && (!preventCircularSerialization || !serializedModels.contains('ExtraCharge'))) 'extraCharges': extraCharges?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(facilityBlocks != null && (!preventCircularSerialization || !serializedModels.contains('FacilityBlock'))) 'facilityBlocks': facilityBlocks?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(includedServices != null && (!preventCircularSerialization || !serializedModels.contains('IncludedService'))) 'includedServices': includedServices?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(sharedAmenities != null && (!preventCircularSerialization || !serializedModels.contains('SharedAmenity'))) 'sharedAmenities': sharedAmenities?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
		if ($agenciesCount != null || $expensesCount != null || $extraChargesCount != null || $facilityBlocksCount != null || $includedServicesCount != null || $sharedAmenitiesCount != null) '_count': { 
		if ($agenciesCount != null) 'agencies': $agenciesCount, 
		if ($expensesCount != null) 'expenses': $expensesCount, 
		if ($extraChargesCount != null) 'extraCharges': $extraChargesCount, 
		if ($facilityBlocksCount != null) 'facilityBlocks': $facilityBlocksCount, 
		if ($includedServicesCount != null) 'includedServices': $includedServicesCount, 
		if ($sharedAmenitiesCount != null) 'sharedAmenities': $sharedAmenitiesCount, 
		},
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is Facility &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    