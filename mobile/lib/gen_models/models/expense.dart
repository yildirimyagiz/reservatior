
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'expense_type.dart';
import 'expense_status.dart';
import 'agency.dart';
import 'currency.dart';
import 'extra_charge.dart';
import 'facility.dart';
import 'included_service.dart';
import 'property.dart';
import 'tenant.dart';
import 'payment.dart';


class Expense implements PrismaModel<String, Expense> , Id<String> {
    @override
String? id;
	String? propertyId;
	String? tenantId;
	String? agencyId;
	ExpenseType? type;
	double? amount;
	String? currencyId;
	DateTime? dueDate;
	DateTime? paidDate;
	ExpenseStatus? status;
	String? notes;
	DateTime? createdAt;
	DateTime? updatedAt;
	DateTime? deletedAt;
	String? facilityId;
	String? includedServiceId;
	String? extraChargeId;
	Agency? Agency;
	Currency? Currency;
	ExtraCharge? ExtraCharge;
	Facility? Facility;
	IncludedService? IncludedService;
	Property? Property;
	Tenant? Tenant;
	List<Payment>? Payment;
	int? $PaymentCount;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    Expense({ this.id,
	 this.propertyId,
	 this.tenantId,
	 this.agencyId,
	 this.type,
	 this.amount,
	 this.currencyId,
	 this.dueDate,
	 this.paidDate,
	 this.status = ExpenseStatus.PENDING,
	 this.notes,
	 this.createdAt,
	 this.updatedAt,
	 this.deletedAt,
	 this.facilityId,
	 this.includedServiceId,
	 this.extraChargeId,
	 this.Agency,
	 this.Currency,
	 this.ExtraCharge,
	 this.Facility,
	 this.IncludedService,
	 this.Property,
	 this.Tenant,
	 this.Payment,
	this.$PaymentCount,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<Expense, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"propertyId": (m) => m.propertyId,

	"tenantId": (m) => m.tenantId,

	"agencyId": (m) => m.agencyId,

	"type": (m) => m.type,

	"amount": (m) => m.amount,

	"currencyId": (m) => m.currencyId,

	"dueDate": (m) => m.dueDate,

	"paidDate": (m) => m.paidDate,

	"status": (m) => m.status,

	"notes": (m) => m.notes,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"deletedAt": (m) => m.deletedAt,

	"facilityId": (m) => m.facilityId,

	"includedServiceId": (m) => m.includedServiceId,

	"extraChargeId": (m) => m.extraChargeId,

	"Agency": (m) => m.Agency,

	"Currency": (m) => m.Currency,

	"ExtraCharge": (m) => m.ExtraCharge,

	"Facility": (m) => m.Facility,

	"IncludedService": (m) => m.IncludedService,

	"Property": (m) => m.Property,

	"Tenant": (m) => m.Tenant,

	"Payment": (m) => m.Payment,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(Expense) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in Expense');
    }
    return propFunction as V? Function(Expense);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory Expense.fromJson(JsonMap json) =>
      Expense(
        id: json['id'] as String?,
	propertyId: json['propertyId'] as String?,
	tenantId: json['tenantId'] as String?,
	agencyId: json['agencyId'] as String?,
	type: json['type'] != null ? ExpenseType.fromJson(json['type']) : null,
	amount: json['amount']?.toDouble(),
	currencyId: json['currencyId'] as String?,
	dueDate: json['dueDate'] != null ? DateTime.parse(json['dueDate']) : null,
	paidDate: json['paidDate'] != null ? DateTime.parse(json['paidDate']) : null,
	status: json['status'] != null ? ExpenseStatus.fromJson(json['status']) : null,
	notes: json['notes'] as String?,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
	facilityId: json['facilityId'] as String?,
	includedServiceId: json['includedServiceId'] as String?,
	extraChargeId: json['extraChargeId'] as String?,
	Agency: json['Agency'] != null ? Agency.fromJson(json['Agency'] as JsonMap) : null,
	Currency: json['Currency'] != null ? Currency.fromJson(json['Currency'] as JsonMap) : null,
	ExtraCharge: json['ExtraCharge'] != null ? ExtraCharge.fromJson(json['ExtraCharge'] as JsonMap) : null,
	Facility: json['Facility'] != null ? Facility.fromJson(json['Facility'] as JsonMap) : null,
	IncludedService: json['IncludedService'] != null ? IncludedService.fromJson(json['IncludedService'] as JsonMap) : null,
	Property: json['Property'] != null ? Property.fromJson(json['Property'] as JsonMap) : null,
	Tenant: json['Tenant'] != null ? Tenant.fromJson(json['Tenant'] as JsonMap) : null,
	Payment: json['Payment'] != null ? createModels<Payment>((json['Payment'] as List).cast<JsonMap>(), Payment.fromJson) : null,
	$PaymentCount: json['_count']?['Payment'] as int?,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    Expense copyWith({
        Value<String?>? id,
		Value<String?>? propertyId,
		Value<String?>? tenantId,
		Value<String?>? agencyId,
		Value<ExpenseType?>? type,
		Value<double?>? amount,
		Value<String?>? currencyId,
		Value<DateTime?>? dueDate,
		Value<DateTime?>? paidDate,
		Value<ExpenseStatus?>? status,
		Value<String?>? notes,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<DateTime?>? deletedAt,
		Value<String?>? facilityId,
		Value<String?>? includedServiceId,
		Value<String?>? extraChargeId,
		Value<Agency?>? Agency,
		Value<Currency?>? Currency,
		Value<ExtraCharge?>? ExtraCharge,
		Value<Facility?>? Facility,
		Value<IncludedService?>? IncludedService,
		Value<Property?>? Property,
		Value<Tenant?>? Tenant,
		Value<List<Payment>?>? Payment,
		int? $PaymentCount,
        }) {
        return Expense(
            id: id != null ? id.value : this.id,
		propertyId: propertyId != null ? propertyId.value : this.propertyId,
		tenantId: tenantId != null ? tenantId.value : this.tenantId,
		agencyId: agencyId != null ? agencyId.value : this.agencyId,
		type: type != null ? type.value : this.type,
		amount: amount != null ? amount.value : this.amount,
		currencyId: currencyId != null ? currencyId.value : this.currencyId,
		dueDate: dueDate != null ? dueDate.value : this.dueDate,
		paidDate: paidDate != null ? paidDate.value : this.paidDate,
		status: status != null ? status.value : this.status,
		notes: notes != null ? notes.value : this.notes,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		deletedAt: deletedAt != null ? deletedAt.value : this.deletedAt,
		facilityId: facilityId != null ? facilityId.value : this.facilityId,
		includedServiceId: includedServiceId != null ? includedServiceId.value : this.includedServiceId,
		extraChargeId: extraChargeId != null ? extraChargeId.value : this.extraChargeId,
		Agency: Agency != null ? Agency.value : this.Agency,
		Currency: Currency != null ? Currency.value : this.Currency,
		ExtraCharge: ExtraCharge != null ? ExtraCharge.value : this.ExtraCharge,
		Facility: Facility != null ? Facility.value : this.Facility,
		IncludedService: IncludedService != null ? IncludedService.value : this.IncludedService,
		Property: Property != null ? Property.value : this.Property,
		Tenant: Tenant != null ? Tenant.value : this.Tenant,
		Payment: Payment != null ? Payment.value : this.Payment,
		$PaymentCount: $PaymentCount ?? this.$PaymentCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    Expense copyWithInstanceValues(Expense expense) {
        return Expense(
            id: expense.id ?? id,
		propertyId: expense.propertyId ?? propertyId,
		tenantId: expense.tenantId ?? tenantId,
		agencyId: expense.agencyId ?? agencyId,
		type: expense.type ?? type,
		amount: expense.amount ?? amount,
		currencyId: expense.currencyId ?? currencyId,
		dueDate: expense.dueDate ?? dueDate,
		paidDate: expense.paidDate ?? paidDate,
		status: expense.status ?? status,
		notes: expense.notes ?? notes,
		createdAt: expense.createdAt ?? createdAt,
		updatedAt: expense.updatedAt ?? updatedAt,
		deletedAt: expense.deletedAt ?? deletedAt,
		facilityId: expense.facilityId ?? facilityId,
		includedServiceId: expense.includedServiceId ?? includedServiceId,
		extraChargeId: expense.extraChargeId ?? extraChargeId,
		Agency: expense.Agency ?? Agency,
		Currency: expense.Currency ?? Currency,
		ExtraCharge: expense.ExtraCharge ?? ExtraCharge,
		Facility: expense.Facility ?? Facility,
		IncludedService: expense.IncludedService ?? IncludedService,
		Property: expense.Property ?? Property,
		Tenant: expense.Tenant ?? Tenant,
		Payment: expense.Payment ?? Payment,
		$PaymentCount: expense.$PaymentCount ?? $PaymentCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    Expense mergeWithInstanceValues(Expense expense) {
        return Expense(
            id: expense.$assignedFields.contains('id') ? expense.id : id,
		propertyId: expense.$assignedFields.contains('propertyId') ? expense.propertyId : propertyId,
		tenantId: expense.$assignedFields.contains('tenantId') ? expense.tenantId : tenantId,
		agencyId: expense.$assignedFields.contains('agencyId') ? expense.agencyId : agencyId,
		type: expense.$assignedFields.contains('type') ? expense.type : type,
		amount: expense.$assignedFields.contains('amount') ? expense.amount : amount,
		currencyId: expense.$assignedFields.contains('currencyId') ? expense.currencyId : currencyId,
		dueDate: expense.$assignedFields.contains('dueDate') ? expense.dueDate : dueDate,
		paidDate: expense.$assignedFields.contains('paidDate') ? expense.paidDate : paidDate,
		status: expense.$assignedFields.contains('status') ? expense.status : status,
		notes: expense.$assignedFields.contains('notes') ? expense.notes : notes,
		createdAt: expense.$assignedFields.contains('createdAt') ? expense.createdAt : createdAt,
		updatedAt: expense.$assignedFields.contains('updatedAt') ? expense.updatedAt : updatedAt,
		deletedAt: expense.$assignedFields.contains('deletedAt') ? expense.deletedAt : deletedAt,
		facilityId: expense.$assignedFields.contains('facilityId') ? expense.facilityId : facilityId,
		includedServiceId: expense.$assignedFields.contains('includedServiceId') ? expense.includedServiceId : includedServiceId,
		extraChargeId: expense.$assignedFields.contains('extraChargeId') ? expense.extraChargeId : extraChargeId,
		Agency: expense.$assignedFields.contains('Agency') ? expense.Agency : Agency,
		Currency: expense.$assignedFields.contains('Currency') ? expense.Currency : Currency,
		ExtraCharge: expense.$assignedFields.contains('ExtraCharge') ? expense.ExtraCharge : ExtraCharge,
		Facility: expense.$assignedFields.contains('Facility') ? expense.Facility : Facility,
		IncludedService: expense.$assignedFields.contains('IncludedService') ? expense.IncludedService : IncludedService,
		Property: expense.$assignedFields.contains('Property') ? expense.Property : Property,
		Tenant: expense.$assignedFields.contains('Tenant') ? expense.Tenant : Tenant,
		Payment: (expense.$assignedFields.contains('Payment') && expense.Payment != null) ? mergeModelLists(Payment, expense.Payment) : Payment,
		$PaymentCount: expense.$PaymentCount ?? $PaymentCount
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    Expense updateWithInstanceValues(Expense expense) {
        if (expense.$assignedFields.contains('id')) { id = expense.id; }
		if (expense.$assignedFields.contains('propertyId')) { propertyId = expense.propertyId; }
		if (expense.$assignedFields.contains('tenantId')) { tenantId = expense.tenantId; }
		if (expense.$assignedFields.contains('agencyId')) { agencyId = expense.agencyId; }
		if (expense.$assignedFields.contains('type')) { type = expense.type; }
		if (expense.$assignedFields.contains('amount')) { amount = expense.amount; }
		if (expense.$assignedFields.contains('currencyId')) { currencyId = expense.currencyId; }
		if (expense.$assignedFields.contains('dueDate')) { dueDate = expense.dueDate; }
		if (expense.$assignedFields.contains('paidDate')) { paidDate = expense.paidDate; }
		if (expense.$assignedFields.contains('status')) { status = expense.status; }
		if (expense.$assignedFields.contains('notes')) { notes = expense.notes; }
		if (expense.$assignedFields.contains('createdAt')) { createdAt = expense.createdAt; }
		if (expense.$assignedFields.contains('updatedAt')) { updatedAt = expense.updatedAt; }
		if (expense.$assignedFields.contains('deletedAt')) { deletedAt = expense.deletedAt; }
		if (expense.$assignedFields.contains('facilityId')) { facilityId = expense.facilityId; }
		if (expense.$assignedFields.contains('includedServiceId')) { includedServiceId = expense.includedServiceId; }
		if (expense.$assignedFields.contains('extraChargeId')) { extraChargeId = expense.extraChargeId; }
		if (expense.$assignedFields.contains('Agency')) { Agency = expense.Agency; }
		if (expense.$assignedFields.contains('Currency')) { Currency = expense.Currency; }
		if (expense.$assignedFields.contains('ExtraCharge')) { ExtraCharge = expense.ExtraCharge; }
		if (expense.$assignedFields.contains('Facility')) { Facility = expense.Facility; }
		if (expense.$assignedFields.contains('IncludedService')) { IncludedService = expense.IncludedService; }
		if (expense.$assignedFields.contains('Property')) { Property = expense.Property; }
		if (expense.$assignedFields.contains('Tenant')) { Tenant = expense.Tenant; }
		if (expense.$assignedFields.contains('Payment') && expense.Payment != null) { Payment = mergeModelLists(Payment, expense.Payment); }
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
          ? {...?serializedTypes, 'Expense'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(propertyId != null) 'propertyId': propertyId,
	if(tenantId != null) 'tenantId': tenantId,
	if(agencyId != null) 'agencyId': agencyId,
	if(type != null) 'type': type?.toJson(),
	if(amount != null) 'amount': amount,
	if(currencyId != null) 'currencyId': currencyId,
	if(dueDate != null) 'dueDate': dueDate?.toIso8601String(),
	if(paidDate != null) 'paidDate': paidDate?.toIso8601String(),
	if(status != null) 'status': status?.toJson(),
	if(notes != null) 'notes': notes,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(deletedAt != null) 'deletedAt': deletedAt?.toIso8601String(),
	if(facilityId != null) 'facilityId': facilityId,
	if(includedServiceId != null) 'includedServiceId': includedServiceId,
	if(extraChargeId != null) 'extraChargeId': extraChargeId,
	if(Agency != null && (!preventCircularSerialization || !serializedModels.contains('Agency'))) 'Agency': Agency?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(Currency != null && (!preventCircularSerialization || !serializedModels.contains('Currency'))) 'Currency': Currency?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(ExtraCharge != null && (!preventCircularSerialization || !serializedModels.contains('ExtraCharge'))) 'ExtraCharge': ExtraCharge?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(Facility != null && (!preventCircularSerialization || !serializedModels.contains('Facility'))) 'Facility': Facility?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(IncludedService != null && (!preventCircularSerialization || !serializedModels.contains('IncludedService'))) 'IncludedService': IncludedService?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(Property != null && (!preventCircularSerialization || !serializedModels.contains('Property'))) 'Property': Property?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(Tenant != null && (!preventCircularSerialization || !serializedModels.contains('Tenant'))) 'Tenant': Tenant?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(Payment != null && (!preventCircularSerialization || !serializedModels.contains('Payment'))) 'Payment': Payment?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
		if ($PaymentCount != null) '_count': { 
		if ($PaymentCount != null) 'Payment': $PaymentCount, 
		},
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is Expense &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    