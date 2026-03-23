
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'payment_status.dart';
import 'commission_rule.dart';
import 'currency.dart';
import 'expense.dart';
import 'extra_charge.dart';
import 'included_service.dart';
import 'lease.dart';
import 'property.dart';
import 'reservation.dart';
import 'subscription.dart';
import 'tenant.dart';


class Payment implements PrismaModel<String, Payment> , Id<String> {
    @override
String? id;
	String? tenantId;
	String? leaseId;
	double? amount;
	String? type;
	String? currencyId;
	DateTime? paymentDate;
	DateTime? dueDate;
	PaymentStatus? status;
	String? paymentMethod;
	String? reference;
	String? notes;
	DateTime? createdAt;
	DateTime? updatedAt;
	DateTime? deletedAt;
	String? stripePaymentIntentId;
	String? stripePaymentMethodId;
	String? stripeClientSecret;
	String? stripeStatus;
	String? stripeError;
	String? propertyId;
	String? expenseId;
	String? reservationId;
	String? subscriptionId;
	String? commissionRuleId;
	String? includedServiceId;
	String? extraChargeId;
	CommissionRule? CommissionRule;
	Currency? Currency;
	Expense? Expense;
	ExtraCharge? ExtraCharge;
	IncludedService? IncludedService;
	Lease? Lease;
	Property? Property;
	Reservation? Reservation;
	Subscription? Subscription;
	Tenant? Tenant;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    Payment({ this.id,
	 this.tenantId,
	 this.leaseId,
	 this.amount,
	 this.type = "rent",
	 this.currencyId,
	 this.paymentDate,
	 this.dueDate,
	 this.status = PaymentStatus.UNPAID,
	 this.paymentMethod,
	 this.reference,
	 this.notes,
	 this.createdAt,
	 this.updatedAt,
	 this.deletedAt,
	 this.stripePaymentIntentId,
	 this.stripePaymentMethodId,
	 this.stripeClientSecret,
	 this.stripeStatus,
	 this.stripeError,
	 this.propertyId,
	 this.expenseId,
	 this.reservationId,
	 this.subscriptionId,
	 this.commissionRuleId,
	 this.includedServiceId,
	 this.extraChargeId,
	 this.CommissionRule,
	 this.Currency,
	 this.Expense,
	 this.ExtraCharge,
	 this.IncludedService,
	 this.Lease,
	 this.Property,
	 this.Reservation,
	 this.Subscription,
	 this.Tenant,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<Payment, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"tenantId": (m) => m.tenantId,

	"leaseId": (m) => m.leaseId,

	"amount": (m) => m.amount,

	"type": (m) => m.type,

	"currencyId": (m) => m.currencyId,

	"paymentDate": (m) => m.paymentDate,

	"dueDate": (m) => m.dueDate,

	"status": (m) => m.status,

	"paymentMethod": (m) => m.paymentMethod,

	"reference": (m) => m.reference,

	"notes": (m) => m.notes,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"deletedAt": (m) => m.deletedAt,

	"stripePaymentIntentId": (m) => m.stripePaymentIntentId,

	"stripePaymentMethodId": (m) => m.stripePaymentMethodId,

	"stripeClientSecret": (m) => m.stripeClientSecret,

	"stripeStatus": (m) => m.stripeStatus,

	"stripeError": (m) => m.stripeError,

	"propertyId": (m) => m.propertyId,

	"expenseId": (m) => m.expenseId,

	"reservationId": (m) => m.reservationId,

	"subscriptionId": (m) => m.subscriptionId,

	"commissionRuleId": (m) => m.commissionRuleId,

	"includedServiceId": (m) => m.includedServiceId,

	"extraChargeId": (m) => m.extraChargeId,

	"CommissionRule": (m) => m.CommissionRule,

	"Currency": (m) => m.Currency,

	"Expense": (m) => m.Expense,

	"ExtraCharge": (m) => m.ExtraCharge,

	"IncludedService": (m) => m.IncludedService,

	"Lease": (m) => m.Lease,

	"Property": (m) => m.Property,

	"Reservation": (m) => m.Reservation,

	"Subscription": (m) => m.Subscription,

	"Tenant": (m) => m.Tenant,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(Payment) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in Payment');
    }
    return propFunction as V? Function(Payment);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory Payment.fromJson(JsonMap json) =>
      Payment(
        id: json['id'] as String?,
	tenantId: json['tenantId'] as String?,
	leaseId: json['leaseId'] as String?,
	amount: json['amount']?.toDouble(),
	type: json['type'] as String?,
	currencyId: json['currencyId'] as String?,
	paymentDate: json['paymentDate'] != null ? DateTime.parse(json['paymentDate']) : null,
	dueDate: json['dueDate'] != null ? DateTime.parse(json['dueDate']) : null,
	status: json['status'] != null ? PaymentStatus.fromJson(json['status']) : null,
	paymentMethod: json['paymentMethod'] as String?,
	reference: json['reference'] as String?,
	notes: json['notes'] as String?,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
	stripePaymentIntentId: json['stripePaymentIntentId'] as String?,
	stripePaymentMethodId: json['stripePaymentMethodId'] as String?,
	stripeClientSecret: json['stripeClientSecret'] as String?,
	stripeStatus: json['stripeStatus'] as String?,
	stripeError: json['stripeError'] as String?,
	propertyId: json['propertyId'] as String?,
	expenseId: json['expenseId'] as String?,
	reservationId: json['reservationId'] as String?,
	subscriptionId: json['subscriptionId'] as String?,
	commissionRuleId: json['commissionRuleId'] as String?,
	includedServiceId: json['includedServiceId'] as String?,
	extraChargeId: json['extraChargeId'] as String?,
	CommissionRule: json['CommissionRule'] != null ? CommissionRule.fromJson(json['CommissionRule'] as JsonMap) : null,
	Currency: json['Currency'] != null ? Currency.fromJson(json['Currency'] as JsonMap) : null,
	Expense: json['Expense'] != null ? Expense.fromJson(json['Expense'] as JsonMap) : null,
	ExtraCharge: json['ExtraCharge'] != null ? ExtraCharge.fromJson(json['ExtraCharge'] as JsonMap) : null,
	IncludedService: json['IncludedService'] != null ? IncludedService.fromJson(json['IncludedService'] as JsonMap) : null,
	Lease: json['Lease'] != null ? Lease.fromJson(json['Lease'] as JsonMap) : null,
	Property: json['Property'] != null ? Property.fromJson(json['Property'] as JsonMap) : null,
	Reservation: json['Reservation'] != null ? Reservation.fromJson(json['Reservation'] as JsonMap) : null,
	Subscription: json['Subscription'] != null ? Subscription.fromJson(json['Subscription'] as JsonMap) : null,
	Tenant: json['Tenant'] != null ? Tenant.fromJson(json['Tenant'] as JsonMap) : null,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    Payment copyWith({
        Value<String?>? id,
		Value<String?>? tenantId,
		Value<String?>? leaseId,
		Value<double?>? amount,
		Value<String?>? type,
		Value<String?>? currencyId,
		Value<DateTime?>? paymentDate,
		Value<DateTime?>? dueDate,
		Value<PaymentStatus?>? status,
		Value<String?>? paymentMethod,
		Value<String?>? reference,
		Value<String?>? notes,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<DateTime?>? deletedAt,
		Value<String?>? stripePaymentIntentId,
		Value<String?>? stripePaymentMethodId,
		Value<String?>? stripeClientSecret,
		Value<String?>? stripeStatus,
		Value<String?>? stripeError,
		Value<String?>? propertyId,
		Value<String?>? expenseId,
		Value<String?>? reservationId,
		Value<String?>? subscriptionId,
		Value<String?>? commissionRuleId,
		Value<String?>? includedServiceId,
		Value<String?>? extraChargeId,
		Value<CommissionRule?>? CommissionRule,
		Value<Currency?>? Currency,
		Value<Expense?>? Expense,
		Value<ExtraCharge?>? ExtraCharge,
		Value<IncludedService?>? IncludedService,
		Value<Lease?>? Lease,
		Value<Property?>? Property,
		Value<Reservation?>? Reservation,
		Value<Subscription?>? Subscription,
		Value<Tenant?>? Tenant,
        }) {
        return Payment(
            id: id != null ? id.value : this.id,
		tenantId: tenantId != null ? tenantId.value : this.tenantId,
		leaseId: leaseId != null ? leaseId.value : this.leaseId,
		amount: amount != null ? amount.value : this.amount,
		type: type != null ? type.value : this.type,
		currencyId: currencyId != null ? currencyId.value : this.currencyId,
		paymentDate: paymentDate != null ? paymentDate.value : this.paymentDate,
		dueDate: dueDate != null ? dueDate.value : this.dueDate,
		status: status != null ? status.value : this.status,
		paymentMethod: paymentMethod != null ? paymentMethod.value : this.paymentMethod,
		reference: reference != null ? reference.value : this.reference,
		notes: notes != null ? notes.value : this.notes,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		deletedAt: deletedAt != null ? deletedAt.value : this.deletedAt,
		stripePaymentIntentId: stripePaymentIntentId != null ? stripePaymentIntentId.value : this.stripePaymentIntentId,
		stripePaymentMethodId: stripePaymentMethodId != null ? stripePaymentMethodId.value : this.stripePaymentMethodId,
		stripeClientSecret: stripeClientSecret != null ? stripeClientSecret.value : this.stripeClientSecret,
		stripeStatus: stripeStatus != null ? stripeStatus.value : this.stripeStatus,
		stripeError: stripeError != null ? stripeError.value : this.stripeError,
		propertyId: propertyId != null ? propertyId.value : this.propertyId,
		expenseId: expenseId != null ? expenseId.value : this.expenseId,
		reservationId: reservationId != null ? reservationId.value : this.reservationId,
		subscriptionId: subscriptionId != null ? subscriptionId.value : this.subscriptionId,
		commissionRuleId: commissionRuleId != null ? commissionRuleId.value : this.commissionRuleId,
		includedServiceId: includedServiceId != null ? includedServiceId.value : this.includedServiceId,
		extraChargeId: extraChargeId != null ? extraChargeId.value : this.extraChargeId,
		CommissionRule: CommissionRule != null ? CommissionRule.value : this.CommissionRule,
		Currency: Currency != null ? Currency.value : this.Currency,
		Expense: Expense != null ? Expense.value : this.Expense,
		ExtraCharge: ExtraCharge != null ? ExtraCharge.value : this.ExtraCharge,
		IncludedService: IncludedService != null ? IncludedService.value : this.IncludedService,
		Lease: Lease != null ? Lease.value : this.Lease,
		Property: Property != null ? Property.value : this.Property,
		Reservation: Reservation != null ? Reservation.value : this.Reservation,
		Subscription: Subscription != null ? Subscription.value : this.Subscription,
		Tenant: Tenant != null ? Tenant.value : this.Tenant
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    Payment copyWithInstanceValues(Payment payment) {
        return Payment(
            id: payment.id ?? id,
		tenantId: payment.tenantId ?? tenantId,
		leaseId: payment.leaseId ?? leaseId,
		amount: payment.amount ?? amount,
		type: payment.type ?? type,
		currencyId: payment.currencyId ?? currencyId,
		paymentDate: payment.paymentDate ?? paymentDate,
		dueDate: payment.dueDate ?? dueDate,
		status: payment.status ?? status,
		paymentMethod: payment.paymentMethod ?? paymentMethod,
		reference: payment.reference ?? reference,
		notes: payment.notes ?? notes,
		createdAt: payment.createdAt ?? createdAt,
		updatedAt: payment.updatedAt ?? updatedAt,
		deletedAt: payment.deletedAt ?? deletedAt,
		stripePaymentIntentId: payment.stripePaymentIntentId ?? stripePaymentIntentId,
		stripePaymentMethodId: payment.stripePaymentMethodId ?? stripePaymentMethodId,
		stripeClientSecret: payment.stripeClientSecret ?? stripeClientSecret,
		stripeStatus: payment.stripeStatus ?? stripeStatus,
		stripeError: payment.stripeError ?? stripeError,
		propertyId: payment.propertyId ?? propertyId,
		expenseId: payment.expenseId ?? expenseId,
		reservationId: payment.reservationId ?? reservationId,
		subscriptionId: payment.subscriptionId ?? subscriptionId,
		commissionRuleId: payment.commissionRuleId ?? commissionRuleId,
		includedServiceId: payment.includedServiceId ?? includedServiceId,
		extraChargeId: payment.extraChargeId ?? extraChargeId,
		CommissionRule: payment.CommissionRule ?? CommissionRule,
		Currency: payment.Currency ?? Currency,
		Expense: payment.Expense ?? Expense,
		ExtraCharge: payment.ExtraCharge ?? ExtraCharge,
		IncludedService: payment.IncludedService ?? IncludedService,
		Lease: payment.Lease ?? Lease,
		Property: payment.Property ?? Property,
		Reservation: payment.Reservation ?? Reservation,
		Subscription: payment.Subscription ?? Subscription,
		Tenant: payment.Tenant ?? Tenant
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    Payment mergeWithInstanceValues(Payment payment) {
        return Payment(
            id: payment.$assignedFields.contains('id') ? payment.id : id,
		tenantId: payment.$assignedFields.contains('tenantId') ? payment.tenantId : tenantId,
		leaseId: payment.$assignedFields.contains('leaseId') ? payment.leaseId : leaseId,
		amount: payment.$assignedFields.contains('amount') ? payment.amount : amount,
		type: payment.$assignedFields.contains('type') ? payment.type : type,
		currencyId: payment.$assignedFields.contains('currencyId') ? payment.currencyId : currencyId,
		paymentDate: payment.$assignedFields.contains('paymentDate') ? payment.paymentDate : paymentDate,
		dueDate: payment.$assignedFields.contains('dueDate') ? payment.dueDate : dueDate,
		status: payment.$assignedFields.contains('status') ? payment.status : status,
		paymentMethod: payment.$assignedFields.contains('paymentMethod') ? payment.paymentMethod : paymentMethod,
		reference: payment.$assignedFields.contains('reference') ? payment.reference : reference,
		notes: payment.$assignedFields.contains('notes') ? payment.notes : notes,
		createdAt: payment.$assignedFields.contains('createdAt') ? payment.createdAt : createdAt,
		updatedAt: payment.$assignedFields.contains('updatedAt') ? payment.updatedAt : updatedAt,
		deletedAt: payment.$assignedFields.contains('deletedAt') ? payment.deletedAt : deletedAt,
		stripePaymentIntentId: payment.$assignedFields.contains('stripePaymentIntentId') ? payment.stripePaymentIntentId : stripePaymentIntentId,
		stripePaymentMethodId: payment.$assignedFields.contains('stripePaymentMethodId') ? payment.stripePaymentMethodId : stripePaymentMethodId,
		stripeClientSecret: payment.$assignedFields.contains('stripeClientSecret') ? payment.stripeClientSecret : stripeClientSecret,
		stripeStatus: payment.$assignedFields.contains('stripeStatus') ? payment.stripeStatus : stripeStatus,
		stripeError: payment.$assignedFields.contains('stripeError') ? payment.stripeError : stripeError,
		propertyId: payment.$assignedFields.contains('propertyId') ? payment.propertyId : propertyId,
		expenseId: payment.$assignedFields.contains('expenseId') ? payment.expenseId : expenseId,
		reservationId: payment.$assignedFields.contains('reservationId') ? payment.reservationId : reservationId,
		subscriptionId: payment.$assignedFields.contains('subscriptionId') ? payment.subscriptionId : subscriptionId,
		commissionRuleId: payment.$assignedFields.contains('commissionRuleId') ? payment.commissionRuleId : commissionRuleId,
		includedServiceId: payment.$assignedFields.contains('includedServiceId') ? payment.includedServiceId : includedServiceId,
		extraChargeId: payment.$assignedFields.contains('extraChargeId') ? payment.extraChargeId : extraChargeId,
		CommissionRule: payment.$assignedFields.contains('CommissionRule') ? payment.CommissionRule : CommissionRule,
		Currency: payment.$assignedFields.contains('Currency') ? payment.Currency : Currency,
		Expense: payment.$assignedFields.contains('Expense') ? payment.Expense : Expense,
		ExtraCharge: payment.$assignedFields.contains('ExtraCharge') ? payment.ExtraCharge : ExtraCharge,
		IncludedService: payment.$assignedFields.contains('IncludedService') ? payment.IncludedService : IncludedService,
		Lease: payment.$assignedFields.contains('Lease') ? payment.Lease : Lease,
		Property: payment.$assignedFields.contains('Property') ? payment.Property : Property,
		Reservation: payment.$assignedFields.contains('Reservation') ? payment.Reservation : Reservation,
		Subscription: payment.$assignedFields.contains('Subscription') ? payment.Subscription : Subscription,
		Tenant: payment.$assignedFields.contains('Tenant') ? payment.Tenant : Tenant
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    Payment updateWithInstanceValues(Payment payment) {
        if (payment.$assignedFields.contains('id')) { id = payment.id; }
		if (payment.$assignedFields.contains('tenantId')) { tenantId = payment.tenantId; }
		if (payment.$assignedFields.contains('leaseId')) { leaseId = payment.leaseId; }
		if (payment.$assignedFields.contains('amount')) { amount = payment.amount; }
		if (payment.$assignedFields.contains('type')) { type = payment.type; }
		if (payment.$assignedFields.contains('currencyId')) { currencyId = payment.currencyId; }
		if (payment.$assignedFields.contains('paymentDate')) { paymentDate = payment.paymentDate; }
		if (payment.$assignedFields.contains('dueDate')) { dueDate = payment.dueDate; }
		if (payment.$assignedFields.contains('status')) { status = payment.status; }
		if (payment.$assignedFields.contains('paymentMethod')) { paymentMethod = payment.paymentMethod; }
		if (payment.$assignedFields.contains('reference')) { reference = payment.reference; }
		if (payment.$assignedFields.contains('notes')) { notes = payment.notes; }
		if (payment.$assignedFields.contains('createdAt')) { createdAt = payment.createdAt; }
		if (payment.$assignedFields.contains('updatedAt')) { updatedAt = payment.updatedAt; }
		if (payment.$assignedFields.contains('deletedAt')) { deletedAt = payment.deletedAt; }
		if (payment.$assignedFields.contains('stripePaymentIntentId')) { stripePaymentIntentId = payment.stripePaymentIntentId; }
		if (payment.$assignedFields.contains('stripePaymentMethodId')) { stripePaymentMethodId = payment.stripePaymentMethodId; }
		if (payment.$assignedFields.contains('stripeClientSecret')) { stripeClientSecret = payment.stripeClientSecret; }
		if (payment.$assignedFields.contains('stripeStatus')) { stripeStatus = payment.stripeStatus; }
		if (payment.$assignedFields.contains('stripeError')) { stripeError = payment.stripeError; }
		if (payment.$assignedFields.contains('propertyId')) { propertyId = payment.propertyId; }
		if (payment.$assignedFields.contains('expenseId')) { expenseId = payment.expenseId; }
		if (payment.$assignedFields.contains('reservationId')) { reservationId = payment.reservationId; }
		if (payment.$assignedFields.contains('subscriptionId')) { subscriptionId = payment.subscriptionId; }
		if (payment.$assignedFields.contains('commissionRuleId')) { commissionRuleId = payment.commissionRuleId; }
		if (payment.$assignedFields.contains('includedServiceId')) { includedServiceId = payment.includedServiceId; }
		if (payment.$assignedFields.contains('extraChargeId')) { extraChargeId = payment.extraChargeId; }
		if (payment.$assignedFields.contains('CommissionRule')) { CommissionRule = payment.CommissionRule; }
		if (payment.$assignedFields.contains('Currency')) { Currency = payment.Currency; }
		if (payment.$assignedFields.contains('Expense')) { Expense = payment.Expense; }
		if (payment.$assignedFields.contains('ExtraCharge')) { ExtraCharge = payment.ExtraCharge; }
		if (payment.$assignedFields.contains('IncludedService')) { IncludedService = payment.IncludedService; }
		if (payment.$assignedFields.contains('Lease')) { Lease = payment.Lease; }
		if (payment.$assignedFields.contains('Property')) { Property = payment.Property; }
		if (payment.$assignedFields.contains('Reservation')) { Reservation = payment.Reservation; }
		if (payment.$assignedFields.contains('Subscription')) { Subscription = payment.Subscription; }
		if (payment.$assignedFields.contains('Tenant')) { Tenant = payment.Tenant; }
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
          ? {...?serializedTypes, 'Payment'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(tenantId != null) 'tenantId': tenantId,
	if(leaseId != null) 'leaseId': leaseId,
	if(amount != null) 'amount': amount,
	if(type != null) 'type': type,
	if(currencyId != null) 'currencyId': currencyId,
	if(paymentDate != null) 'paymentDate': paymentDate?.toIso8601String(),
	if(dueDate != null) 'dueDate': dueDate?.toIso8601String(),
	if(status != null) 'status': status?.toJson(),
	if(paymentMethod != null) 'paymentMethod': paymentMethod,
	if(reference != null) 'reference': reference,
	if(notes != null) 'notes': notes,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(deletedAt != null) 'deletedAt': deletedAt?.toIso8601String(),
	if(stripePaymentIntentId != null) 'stripePaymentIntentId': stripePaymentIntentId,
	if(stripePaymentMethodId != null) 'stripePaymentMethodId': stripePaymentMethodId,
	if(stripeClientSecret != null) 'stripeClientSecret': stripeClientSecret,
	if(stripeStatus != null) 'stripeStatus': stripeStatus,
	if(stripeError != null) 'stripeError': stripeError,
	if(propertyId != null) 'propertyId': propertyId,
	if(expenseId != null) 'expenseId': expenseId,
	if(reservationId != null) 'reservationId': reservationId,
	if(subscriptionId != null) 'subscriptionId': subscriptionId,
	if(commissionRuleId != null) 'commissionRuleId': commissionRuleId,
	if(includedServiceId != null) 'includedServiceId': includedServiceId,
	if(extraChargeId != null) 'extraChargeId': extraChargeId,
	if(CommissionRule != null && (!preventCircularSerialization || !serializedModels.contains('CommissionRule'))) 'CommissionRule': CommissionRule?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(Currency != null && (!preventCircularSerialization || !serializedModels.contains('Currency'))) 'Currency': Currency?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(Expense != null && (!preventCircularSerialization || !serializedModels.contains('Expense'))) 'Expense': Expense?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(ExtraCharge != null && (!preventCircularSerialization || !serializedModels.contains('ExtraCharge'))) 'ExtraCharge': ExtraCharge?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(IncludedService != null && (!preventCircularSerialization || !serializedModels.contains('IncludedService'))) 'IncludedService': IncludedService?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(Lease != null && (!preventCircularSerialization || !serializedModels.contains('Lease'))) 'Lease': Lease?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(Property != null && (!preventCircularSerialization || !serializedModels.contains('Property'))) 'Property': Property?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(Reservation != null && (!preventCircularSerialization || !serializedModels.contains('Reservation'))) 'Reservation': Reservation?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(Subscription != null && (!preventCircularSerialization || !serializedModels.contains('Subscription'))) 'Subscription': Subscription?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(Tenant != null && (!preventCircularSerialization || !serializedModels.contains('Tenant'))) 'Tenant': Tenant?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is Payment &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    