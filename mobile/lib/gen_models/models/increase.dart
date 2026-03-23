
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'increase_status.dart';
import 'contract.dart';
import 'property.dart';
import 'tenant.dart';
import 'offer.dart';


class Increase implements PrismaModel<String, Increase> , Id<String> {
    @override
String? id;
	String? propertyId;
	String? tenantId;
	String? proposedBy;
	double? oldRent;
	double? newRent;
	DateTime? effectiveDate;
	IncreaseStatus? status;
	DateTime? createdAt;
	DateTime? updatedAt;
	DateTime? deletedAt;
	String? contractId;
	Contract? Contract;
	Property? Property;
	Tenant? Tenant;
	Offer? Offer;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    Increase({ this.id,
	 this.propertyId,
	 this.tenantId,
	 this.proposedBy,
	 this.oldRent,
	 this.newRent,
	 this.effectiveDate,
	 this.status = IncreaseStatus.PENDING,
	 this.createdAt,
	 this.updatedAt,
	 this.deletedAt,
	 this.contractId,
	 this.Contract,
	 this.Property,
	 this.Tenant,
	 this.Offer,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<Increase, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"propertyId": (m) => m.propertyId,

	"tenantId": (m) => m.tenantId,

	"proposedBy": (m) => m.proposedBy,

	"oldRent": (m) => m.oldRent,

	"newRent": (m) => m.newRent,

	"effectiveDate": (m) => m.effectiveDate,

	"status": (m) => m.status,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"deletedAt": (m) => m.deletedAt,

	"contractId": (m) => m.contractId,

	"Contract": (m) => m.Contract,

	"Property": (m) => m.Property,

	"Tenant": (m) => m.Tenant,

	"Offer": (m) => m.Offer,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(Increase) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in Increase');
    }
    return propFunction as V? Function(Increase);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory Increase.fromJson(JsonMap json) =>
      Increase(
        id: json['id'] as String?,
	propertyId: json['propertyId'] as String?,
	tenantId: json['tenantId'] as String?,
	proposedBy: json['proposedBy'] as String?,
	oldRent: json['oldRent']?.toDouble(),
	newRent: json['newRent']?.toDouble(),
	effectiveDate: json['effectiveDate'] != null ? DateTime.parse(json['effectiveDate']) : null,
	status: json['status'] != null ? IncreaseStatus.fromJson(json['status']) : null,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
	contractId: json['contractId'] as String?,
	Contract: json['Contract'] != null ? Contract.fromJson(json['Contract'] as JsonMap) : null,
	Property: json['Property'] != null ? Property.fromJson(json['Property'] as JsonMap) : null,
	Tenant: json['Tenant'] != null ? Tenant.fromJson(json['Tenant'] as JsonMap) : null,
	Offer: json['Offer'] != null ? Offer.fromJson(json['Offer'] as JsonMap) : null,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    Increase copyWith({
        Value<String?>? id,
		Value<String?>? propertyId,
		Value<String?>? tenantId,
		Value<String?>? proposedBy,
		Value<double?>? oldRent,
		Value<double?>? newRent,
		Value<DateTime?>? effectiveDate,
		Value<IncreaseStatus?>? status,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<DateTime?>? deletedAt,
		Value<String?>? contractId,
		Value<Contract?>? Contract,
		Value<Property?>? Property,
		Value<Tenant?>? Tenant,
		Value<Offer?>? Offer,
        }) {
        return Increase(
            id: id != null ? id.value : this.id,
		propertyId: propertyId != null ? propertyId.value : this.propertyId,
		tenantId: tenantId != null ? tenantId.value : this.tenantId,
		proposedBy: proposedBy != null ? proposedBy.value : this.proposedBy,
		oldRent: oldRent != null ? oldRent.value : this.oldRent,
		newRent: newRent != null ? newRent.value : this.newRent,
		effectiveDate: effectiveDate != null ? effectiveDate.value : this.effectiveDate,
		status: status != null ? status.value : this.status,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		deletedAt: deletedAt != null ? deletedAt.value : this.deletedAt,
		contractId: contractId != null ? contractId.value : this.contractId,
		Contract: Contract != null ? Contract.value : this.Contract,
		Property: Property != null ? Property.value : this.Property,
		Tenant: Tenant != null ? Tenant.value : this.Tenant,
		Offer: Offer != null ? Offer.value : this.Offer
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    Increase copyWithInstanceValues(Increase increase) {
        return Increase(
            id: increase.id ?? id,
		propertyId: increase.propertyId ?? propertyId,
		tenantId: increase.tenantId ?? tenantId,
		proposedBy: increase.proposedBy ?? proposedBy,
		oldRent: increase.oldRent ?? oldRent,
		newRent: increase.newRent ?? newRent,
		effectiveDate: increase.effectiveDate ?? effectiveDate,
		status: increase.status ?? status,
		createdAt: increase.createdAt ?? createdAt,
		updatedAt: increase.updatedAt ?? updatedAt,
		deletedAt: increase.deletedAt ?? deletedAt,
		contractId: increase.contractId ?? contractId,
		Contract: increase.Contract ?? Contract,
		Property: increase.Property ?? Property,
		Tenant: increase.Tenant ?? Tenant,
		Offer: increase.Offer ?? Offer
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    Increase mergeWithInstanceValues(Increase increase) {
        return Increase(
            id: increase.$assignedFields.contains('id') ? increase.id : id,
		propertyId: increase.$assignedFields.contains('propertyId') ? increase.propertyId : propertyId,
		tenantId: increase.$assignedFields.contains('tenantId') ? increase.tenantId : tenantId,
		proposedBy: increase.$assignedFields.contains('proposedBy') ? increase.proposedBy : proposedBy,
		oldRent: increase.$assignedFields.contains('oldRent') ? increase.oldRent : oldRent,
		newRent: increase.$assignedFields.contains('newRent') ? increase.newRent : newRent,
		effectiveDate: increase.$assignedFields.contains('effectiveDate') ? increase.effectiveDate : effectiveDate,
		status: increase.$assignedFields.contains('status') ? increase.status : status,
		createdAt: increase.$assignedFields.contains('createdAt') ? increase.createdAt : createdAt,
		updatedAt: increase.$assignedFields.contains('updatedAt') ? increase.updatedAt : updatedAt,
		deletedAt: increase.$assignedFields.contains('deletedAt') ? increase.deletedAt : deletedAt,
		contractId: increase.$assignedFields.contains('contractId') ? increase.contractId : contractId,
		Contract: increase.$assignedFields.contains('Contract') ? increase.Contract : Contract,
		Property: increase.$assignedFields.contains('Property') ? increase.Property : Property,
		Tenant: increase.$assignedFields.contains('Tenant') ? increase.Tenant : Tenant,
		Offer: increase.$assignedFields.contains('Offer') ? increase.Offer : Offer
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    Increase updateWithInstanceValues(Increase increase) {
        if (increase.$assignedFields.contains('id')) { id = increase.id; }
		if (increase.$assignedFields.contains('propertyId')) { propertyId = increase.propertyId; }
		if (increase.$assignedFields.contains('tenantId')) { tenantId = increase.tenantId; }
		if (increase.$assignedFields.contains('proposedBy')) { proposedBy = increase.proposedBy; }
		if (increase.$assignedFields.contains('oldRent')) { oldRent = increase.oldRent; }
		if (increase.$assignedFields.contains('newRent')) { newRent = increase.newRent; }
		if (increase.$assignedFields.contains('effectiveDate')) { effectiveDate = increase.effectiveDate; }
		if (increase.$assignedFields.contains('status')) { status = increase.status; }
		if (increase.$assignedFields.contains('createdAt')) { createdAt = increase.createdAt; }
		if (increase.$assignedFields.contains('updatedAt')) { updatedAt = increase.updatedAt; }
		if (increase.$assignedFields.contains('deletedAt')) { deletedAt = increase.deletedAt; }
		if (increase.$assignedFields.contains('contractId')) { contractId = increase.contractId; }
		if (increase.$assignedFields.contains('Contract')) { Contract = increase.Contract; }
		if (increase.$assignedFields.contains('Property')) { Property = increase.Property; }
		if (increase.$assignedFields.contains('Tenant')) { Tenant = increase.Tenant; }
		if (increase.$assignedFields.contains('Offer')) { Offer = increase.Offer; }
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
          ? {...?serializedTypes, 'Increase'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(propertyId != null) 'propertyId': propertyId,
	if(tenantId != null) 'tenantId': tenantId,
	if(proposedBy != null) 'proposedBy': proposedBy,
	if(oldRent != null) 'oldRent': oldRent,
	if(newRent != null) 'newRent': newRent,
	if(effectiveDate != null) 'effectiveDate': effectiveDate?.toIso8601String(),
	if(status != null) 'status': status?.toJson(),
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(deletedAt != null) 'deletedAt': deletedAt?.toIso8601String(),
	if(contractId != null) 'contractId': contractId,
	if(Contract != null && (!preventCircularSerialization || !serializedModels.contains('Contract'))) 'Contract': Contract?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(Property != null && (!preventCircularSerialization || !serializedModels.contains('Property'))) 'Property': Property?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(Tenant != null && (!preventCircularSerialization || !serializedModels.contains('Tenant'))) 'Tenant': Tenant?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(Offer != null && (!preventCircularSerialization || !serializedModels.contains('Offer'))) 'Offer': Offer?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is Increase &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    