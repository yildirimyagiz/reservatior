
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'payment_status.dart';
import 'lease.dart';
import 'organization.dart';


class RentSchedule implements PrismaModel<String, RentSchedule> , Id<String> {
    @override
String? id;
	String? orgId;
	String? leaseId;
	DateTime? dueDate;
	double? amount;
	String? currency;
	PaymentStatus? status;
	DateTime? paidAt;
	DateTime? createdAt;
	DateTime? updatedAt;
	DateTime? deletedAt;
	Lease? lease;
	Organization? org;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    RentSchedule({ this.id,
	 this.orgId,
	 this.leaseId,
	 this.dueDate,
	 this.amount,
	 this.currency,
	 this.status = PaymentStatus.UNPAID,
	 this.paidAt,
	 this.createdAt,
	 this.updatedAt,
	 this.deletedAt,
	 this.lease,
	 this.org,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<RentSchedule, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"orgId": (m) => m.orgId,

	"leaseId": (m) => m.leaseId,

	"dueDate": (m) => m.dueDate,

	"amount": (m) => m.amount,

	"currency": (m) => m.currency,

	"status": (m) => m.status,

	"paidAt": (m) => m.paidAt,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"deletedAt": (m) => m.deletedAt,

	"lease": (m) => m.lease,

	"org": (m) => m.org,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(RentSchedule) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in RentSchedule');
    }
    return propFunction as V? Function(RentSchedule);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory RentSchedule.fromJson(JsonMap json) =>
      RentSchedule(
        id: json['id'] as String?,
	orgId: json['orgId'] as String?,
	leaseId: json['leaseId'] as String?,
	dueDate: json['dueDate'] != null ? DateTime.parse(json['dueDate']) : null,
	amount: json['amount'] as double?,
	currency: json['currency'] as String?,
	status: json['status'] != null ? PaymentStatus.fromJson(json['status']) : null,
	paidAt: json['paidAt'] != null ? DateTime.parse(json['paidAt']) : null,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
	lease: json['lease'] != null ? Lease.fromJson(json['lease'] as JsonMap) : null,
	org: json['org'] != null ? Organization.fromJson(json['org'] as JsonMap) : null,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    RentSchedule copyWith({
        Value<String?>? id,
		Value<String?>? orgId,
		Value<String?>? leaseId,
		Value<DateTime?>? dueDate,
		Value<double?>? amount,
		Value<String?>? currency,
		Value<PaymentStatus?>? status,
		Value<DateTime?>? paidAt,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<DateTime?>? deletedAt,
		Value<Lease?>? lease,
		Value<Organization?>? org,
        }) {
        return RentSchedule(
            id: id != null ? id.value : this.id,
		orgId: orgId != null ? orgId.value : this.orgId,
		leaseId: leaseId != null ? leaseId.value : this.leaseId,
		dueDate: dueDate != null ? dueDate.value : this.dueDate,
		amount: amount != null ? amount.value : this.amount,
		currency: currency != null ? currency.value : this.currency,
		status: status != null ? status.value : this.status,
		paidAt: paidAt != null ? paidAt.value : this.paidAt,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		deletedAt: deletedAt != null ? deletedAt.value : this.deletedAt,
		lease: lease != null ? lease.value : this.lease,
		org: org != null ? org.value : this.org
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    RentSchedule copyWithInstanceValues(RentSchedule rentSchedule) {
        return RentSchedule(
            id: rentSchedule.id ?? id,
		orgId: rentSchedule.orgId ?? orgId,
		leaseId: rentSchedule.leaseId ?? leaseId,
		dueDate: rentSchedule.dueDate ?? dueDate,
		amount: rentSchedule.amount ?? amount,
		currency: rentSchedule.currency ?? currency,
		status: rentSchedule.status ?? status,
		paidAt: rentSchedule.paidAt ?? paidAt,
		createdAt: rentSchedule.createdAt ?? createdAt,
		updatedAt: rentSchedule.updatedAt ?? updatedAt,
		deletedAt: rentSchedule.deletedAt ?? deletedAt,
		lease: rentSchedule.lease ?? lease,
		org: rentSchedule.org ?? org
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    RentSchedule mergeWithInstanceValues(RentSchedule rentSchedule) {
        return RentSchedule(
            id: rentSchedule.$assignedFields.contains('id') ? rentSchedule.id : id,
		orgId: rentSchedule.$assignedFields.contains('orgId') ? rentSchedule.orgId : orgId,
		leaseId: rentSchedule.$assignedFields.contains('leaseId') ? rentSchedule.leaseId : leaseId,
		dueDate: rentSchedule.$assignedFields.contains('dueDate') ? rentSchedule.dueDate : dueDate,
		amount: rentSchedule.$assignedFields.contains('amount') ? rentSchedule.amount : amount,
		currency: rentSchedule.$assignedFields.contains('currency') ? rentSchedule.currency : currency,
		status: rentSchedule.$assignedFields.contains('status') ? rentSchedule.status : status,
		paidAt: rentSchedule.$assignedFields.contains('paidAt') ? rentSchedule.paidAt : paidAt,
		createdAt: rentSchedule.$assignedFields.contains('createdAt') ? rentSchedule.createdAt : createdAt,
		updatedAt: rentSchedule.$assignedFields.contains('updatedAt') ? rentSchedule.updatedAt : updatedAt,
		deletedAt: rentSchedule.$assignedFields.contains('deletedAt') ? rentSchedule.deletedAt : deletedAt,
		lease: rentSchedule.$assignedFields.contains('lease') ? rentSchedule.lease : lease,
		org: rentSchedule.$assignedFields.contains('org') ? rentSchedule.org : org
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    RentSchedule updateWithInstanceValues(RentSchedule rentSchedule) {
        if (rentSchedule.$assignedFields.contains('id')) { id = rentSchedule.id; }
		if (rentSchedule.$assignedFields.contains('orgId')) { orgId = rentSchedule.orgId; }
		if (rentSchedule.$assignedFields.contains('leaseId')) { leaseId = rentSchedule.leaseId; }
		if (rentSchedule.$assignedFields.contains('dueDate')) { dueDate = rentSchedule.dueDate; }
		if (rentSchedule.$assignedFields.contains('amount')) { amount = rentSchedule.amount; }
		if (rentSchedule.$assignedFields.contains('currency')) { currency = rentSchedule.currency; }
		if (rentSchedule.$assignedFields.contains('status')) { status = rentSchedule.status; }
		if (rentSchedule.$assignedFields.contains('paidAt')) { paidAt = rentSchedule.paidAt; }
		if (rentSchedule.$assignedFields.contains('createdAt')) { createdAt = rentSchedule.createdAt; }
		if (rentSchedule.$assignedFields.contains('updatedAt')) { updatedAt = rentSchedule.updatedAt; }
		if (rentSchedule.$assignedFields.contains('deletedAt')) { deletedAt = rentSchedule.deletedAt; }
		if (rentSchedule.$assignedFields.contains('lease')) { lease = rentSchedule.lease; }
		if (rentSchedule.$assignedFields.contains('org')) { org = rentSchedule.org; }
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
          ? {...?serializedTypes, 'RentSchedule'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(orgId != null) 'orgId': orgId,
	if(leaseId != null) 'leaseId': leaseId,
	if(dueDate != null) 'dueDate': dueDate?.toIso8601String(),
	if(amount != null) 'amount': amount,
	if(currency != null) 'currency': currency,
	if(status != null) 'status': status?.toJson(),
	if(paidAt != null) 'paidAt': paidAt?.toIso8601String(),
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(deletedAt != null) 'deletedAt': deletedAt?.toIso8601String(),
	if(lease != null && (!preventCircularSerialization || !serializedModels.contains('Lease'))) 'lease': lease?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(org != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'org': org?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is RentSchedule &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    