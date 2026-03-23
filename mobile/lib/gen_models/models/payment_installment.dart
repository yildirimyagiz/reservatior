
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'payment_status.dart';
import 'payment_method_u_s.dart';
import 'payment_negotiation.dart';
import 'organization.dart';


class PaymentInstallment implements PrismaModel<String, PaymentInstallment> , Id<String> {
    @override
String? id;
	String? orgId;
	String? negotiationId;
	int? installmentNo;
	double? amount;
	String? currency;
	DateTime? dueDate;
	PaymentStatus? status;
	DateTime? paidAt;
	PaymentMethodUS? paymentMethod;
	String? referenceNo;
	String? notes;
	DateTime? deletedAt;
	DateTime? createdAt;
	DateTime? updatedAt;
	PaymentNegotiation? negotiation;
	Organization? org;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    PaymentInstallment({ this.id,
	 this.orgId,
	 this.negotiationId,
	 this.installmentNo,
	 this.amount,
	 this.currency = "USD",
	 this.dueDate,
	 this.status = PaymentStatus.UNPAID,
	 this.paidAt,
	 this.paymentMethod,
	 this.referenceNo,
	 this.notes,
	 this.deletedAt,
	 this.createdAt,
	 this.updatedAt,
	 this.negotiation,
	 this.org,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<PaymentInstallment, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"orgId": (m) => m.orgId,

	"negotiationId": (m) => m.negotiationId,

	"installmentNo": (m) => m.installmentNo,

	"amount": (m) => m.amount,

	"currency": (m) => m.currency,

	"dueDate": (m) => m.dueDate,

	"status": (m) => m.status,

	"paidAt": (m) => m.paidAt,

	"paymentMethod": (m) => m.paymentMethod,

	"referenceNo": (m) => m.referenceNo,

	"notes": (m) => m.notes,

	"deletedAt": (m) => m.deletedAt,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"negotiation": (m) => m.negotiation,

	"org": (m) => m.org,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(PaymentInstallment) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in PaymentInstallment');
    }
    return propFunction as V? Function(PaymentInstallment);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory PaymentInstallment.fromJson(JsonMap json) =>
      PaymentInstallment(
        id: json['id'] as String?,
	orgId: json['orgId'] as String?,
	negotiationId: json['negotiationId'] as String?,
	installmentNo: int.tryParse(json['installmentNo'].toString()),
	amount: json['amount'] as double?,
	currency: json['currency'] as String?,
	dueDate: json['dueDate'] != null ? DateTime.parse(json['dueDate']) : null,
	status: json['status'] != null ? PaymentStatus.fromJson(json['status']) : null,
	paidAt: json['paidAt'] != null ? DateTime.parse(json['paidAt']) : null,
	paymentMethod: json['paymentMethod'] != null ? PaymentMethodUS.fromJson(json['paymentMethod']) : null,
	referenceNo: json['referenceNo'] as String?,
	notes: json['notes'] as String?,
	deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	negotiation: json['negotiation'] != null ? PaymentNegotiation.fromJson(json['negotiation'] as JsonMap) : null,
	org: json['org'] != null ? Organization.fromJson(json['org'] as JsonMap) : null,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    PaymentInstallment copyWith({
        Value<String?>? id,
		Value<String?>? orgId,
		Value<String?>? negotiationId,
		Value<int?>? installmentNo,
		Value<double?>? amount,
		Value<String?>? currency,
		Value<DateTime?>? dueDate,
		Value<PaymentStatus?>? status,
		Value<DateTime?>? paidAt,
		Value<PaymentMethodUS?>? paymentMethod,
		Value<String?>? referenceNo,
		Value<String?>? notes,
		Value<DateTime?>? deletedAt,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<PaymentNegotiation?>? negotiation,
		Value<Organization?>? org,
        }) {
        return PaymentInstallment(
            id: id != null ? id.value : this.id,
		orgId: orgId != null ? orgId.value : this.orgId,
		negotiationId: negotiationId != null ? negotiationId.value : this.negotiationId,
		installmentNo: installmentNo != null ? installmentNo.value : this.installmentNo,
		amount: amount != null ? amount.value : this.amount,
		currency: currency != null ? currency.value : this.currency,
		dueDate: dueDate != null ? dueDate.value : this.dueDate,
		status: status != null ? status.value : this.status,
		paidAt: paidAt != null ? paidAt.value : this.paidAt,
		paymentMethod: paymentMethod != null ? paymentMethod.value : this.paymentMethod,
		referenceNo: referenceNo != null ? referenceNo.value : this.referenceNo,
		notes: notes != null ? notes.value : this.notes,
		deletedAt: deletedAt != null ? deletedAt.value : this.deletedAt,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		negotiation: negotiation != null ? negotiation.value : this.negotiation,
		org: org != null ? org.value : this.org
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    PaymentInstallment copyWithInstanceValues(PaymentInstallment paymentInstallment) {
        return PaymentInstallment(
            id: paymentInstallment.id ?? id,
		orgId: paymentInstallment.orgId ?? orgId,
		negotiationId: paymentInstallment.negotiationId ?? negotiationId,
		installmentNo: paymentInstallment.installmentNo ?? installmentNo,
		amount: paymentInstallment.amount ?? amount,
		currency: paymentInstallment.currency ?? currency,
		dueDate: paymentInstallment.dueDate ?? dueDate,
		status: paymentInstallment.status ?? status,
		paidAt: paymentInstallment.paidAt ?? paidAt,
		paymentMethod: paymentInstallment.paymentMethod ?? paymentMethod,
		referenceNo: paymentInstallment.referenceNo ?? referenceNo,
		notes: paymentInstallment.notes ?? notes,
		deletedAt: paymentInstallment.deletedAt ?? deletedAt,
		createdAt: paymentInstallment.createdAt ?? createdAt,
		updatedAt: paymentInstallment.updatedAt ?? updatedAt,
		negotiation: paymentInstallment.negotiation ?? negotiation,
		org: paymentInstallment.org ?? org
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    PaymentInstallment mergeWithInstanceValues(PaymentInstallment paymentInstallment) {
        return PaymentInstallment(
            id: paymentInstallment.$assignedFields.contains('id') ? paymentInstallment.id : id,
		orgId: paymentInstallment.$assignedFields.contains('orgId') ? paymentInstallment.orgId : orgId,
		negotiationId: paymentInstallment.$assignedFields.contains('negotiationId') ? paymentInstallment.negotiationId : negotiationId,
		installmentNo: paymentInstallment.$assignedFields.contains('installmentNo') ? paymentInstallment.installmentNo : installmentNo,
		amount: paymentInstallment.$assignedFields.contains('amount') ? paymentInstallment.amount : amount,
		currency: paymentInstallment.$assignedFields.contains('currency') ? paymentInstallment.currency : currency,
		dueDate: paymentInstallment.$assignedFields.contains('dueDate') ? paymentInstallment.dueDate : dueDate,
		status: paymentInstallment.$assignedFields.contains('status') ? paymentInstallment.status : status,
		paidAt: paymentInstallment.$assignedFields.contains('paidAt') ? paymentInstallment.paidAt : paidAt,
		paymentMethod: paymentInstallment.$assignedFields.contains('paymentMethod') ? paymentInstallment.paymentMethod : paymentMethod,
		referenceNo: paymentInstallment.$assignedFields.contains('referenceNo') ? paymentInstallment.referenceNo : referenceNo,
		notes: paymentInstallment.$assignedFields.contains('notes') ? paymentInstallment.notes : notes,
		deletedAt: paymentInstallment.$assignedFields.contains('deletedAt') ? paymentInstallment.deletedAt : deletedAt,
		createdAt: paymentInstallment.$assignedFields.contains('createdAt') ? paymentInstallment.createdAt : createdAt,
		updatedAt: paymentInstallment.$assignedFields.contains('updatedAt') ? paymentInstallment.updatedAt : updatedAt,
		negotiation: paymentInstallment.$assignedFields.contains('negotiation') ? paymentInstallment.negotiation : negotiation,
		org: paymentInstallment.$assignedFields.contains('org') ? paymentInstallment.org : org
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    PaymentInstallment updateWithInstanceValues(PaymentInstallment paymentInstallment) {
        if (paymentInstallment.$assignedFields.contains('id')) { id = paymentInstallment.id; }
		if (paymentInstallment.$assignedFields.contains('orgId')) { orgId = paymentInstallment.orgId; }
		if (paymentInstallment.$assignedFields.contains('negotiationId')) { negotiationId = paymentInstallment.negotiationId; }
		if (paymentInstallment.$assignedFields.contains('installmentNo')) { installmentNo = paymentInstallment.installmentNo; }
		if (paymentInstallment.$assignedFields.contains('amount')) { amount = paymentInstallment.amount; }
		if (paymentInstallment.$assignedFields.contains('currency')) { currency = paymentInstallment.currency; }
		if (paymentInstallment.$assignedFields.contains('dueDate')) { dueDate = paymentInstallment.dueDate; }
		if (paymentInstallment.$assignedFields.contains('status')) { status = paymentInstallment.status; }
		if (paymentInstallment.$assignedFields.contains('paidAt')) { paidAt = paymentInstallment.paidAt; }
		if (paymentInstallment.$assignedFields.contains('paymentMethod')) { paymentMethod = paymentInstallment.paymentMethod; }
		if (paymentInstallment.$assignedFields.contains('referenceNo')) { referenceNo = paymentInstallment.referenceNo; }
		if (paymentInstallment.$assignedFields.contains('notes')) { notes = paymentInstallment.notes; }
		if (paymentInstallment.$assignedFields.contains('deletedAt')) { deletedAt = paymentInstallment.deletedAt; }
		if (paymentInstallment.$assignedFields.contains('createdAt')) { createdAt = paymentInstallment.createdAt; }
		if (paymentInstallment.$assignedFields.contains('updatedAt')) { updatedAt = paymentInstallment.updatedAt; }
		if (paymentInstallment.$assignedFields.contains('negotiation')) { negotiation = paymentInstallment.negotiation; }
		if (paymentInstallment.$assignedFields.contains('org')) { org = paymentInstallment.org; }
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
          ? {...?serializedTypes, 'PaymentInstallment'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(orgId != null) 'orgId': orgId,
	if(negotiationId != null) 'negotiationId': negotiationId,
	if(installmentNo != null) 'installmentNo': installmentNo,
	if(amount != null) 'amount': amount,
	if(currency != null) 'currency': currency,
	if(dueDate != null) 'dueDate': dueDate?.toIso8601String(),
	if(status != null) 'status': status?.toJson(),
	if(paidAt != null) 'paidAt': paidAt?.toIso8601String(),
	if(paymentMethod != null) 'paymentMethod': paymentMethod?.toJson(),
	if(referenceNo != null) 'referenceNo': referenceNo,
	if(notes != null) 'notes': notes,
	if(deletedAt != null) 'deletedAt': deletedAt?.toIso8601String(),
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(negotiation != null && (!preventCircularSerialization || !serializedModels.contains('PaymentNegotiation'))) 'negotiation': negotiation?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(org != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'org': org?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is PaymentInstallment &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    