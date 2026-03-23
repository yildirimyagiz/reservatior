
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'payment_status.dart';
import 'contract.dart';
import 'expense.dart';
import 'increase.dart';
import 'notification.dart';
import 'payment.dart';
import 'report.dart';
import 'lease.dart';
import 'maintenance_work_order.dart';
import 'property.dart';
import 'user.dart';


class Tenant implements PrismaModel<String, Tenant> , Id<String> {
    @override
String? id;
	String? userId;
	String? firstName;
	String? lastName;
	String? email;
	String? phoneNumber;
	DateTime? leaseStartDate;
	DateTime? leaseEndDate;
	PaymentStatus? paymentStatus;
	DateTime? createdAt;
	DateTime? updatedAt;
	DateTime? deletedAt;
	String? propertyId;
	bool? isActive;
	List<Contract>? Contract;
	List<Expense>? Expense;
	List<Increase>? Increase;
	List<Notification>? Notification;
	List<Payment>? Payment;
	List<Report>? Report;
	List<Lease>? Lease;
	List<MaintenanceWorkOrder>? MaintenanceWorkOrder;
	Property? Property;
	User? User;
	int? $ContractCount;
	int? $ExpenseCount;
	int? $IncreaseCount;
	int? $NotificationCount;
	int? $PaymentCount;
	int? $ReportCount;
	int? $LeaseCount;
	int? $MaintenanceWorkOrderCount;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    Tenant({ this.id,
	 this.userId,
	 this.firstName,
	 this.lastName,
	 this.email,
	 this.phoneNumber,
	 this.leaseStartDate,
	 this.leaseEndDate,
	 this.paymentStatus = PaymentStatus.PAID,
	 this.createdAt,
	 this.updatedAt,
	 this.deletedAt,
	 this.propertyId,
	 this.isActive = true,
	 this.Contract,
	 this.Expense,
	 this.Increase,
	 this.Notification,
	 this.Payment,
	 this.Report,
	 this.Lease,
	 this.MaintenanceWorkOrder,
	 this.Property,
	 this.User,
	this.$ContractCount,
	this.$ExpenseCount,
	this.$IncreaseCount,
	this.$NotificationCount,
	this.$PaymentCount,
	this.$ReportCount,
	this.$LeaseCount,
	this.$MaintenanceWorkOrderCount,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<Tenant, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"userId": (m) => m.userId,

	"firstName": (m) => m.firstName,

	"lastName": (m) => m.lastName,

	"email": (m) => m.email,

	"phoneNumber": (m) => m.phoneNumber,

	"leaseStartDate": (m) => m.leaseStartDate,

	"leaseEndDate": (m) => m.leaseEndDate,

	"paymentStatus": (m) => m.paymentStatus,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"deletedAt": (m) => m.deletedAt,

	"propertyId": (m) => m.propertyId,

	"isActive": (m) => m.isActive,

	"Contract": (m) => m.Contract,

	"Expense": (m) => m.Expense,

	"Increase": (m) => m.Increase,

	"Notification": (m) => m.Notification,

	"Payment": (m) => m.Payment,

	"Report": (m) => m.Report,

	"Lease": (m) => m.Lease,

	"MaintenanceWorkOrder": (m) => m.MaintenanceWorkOrder,

	"Property": (m) => m.Property,

	"User": (m) => m.User,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(Tenant) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in Tenant');
    }
    return propFunction as V? Function(Tenant);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory Tenant.fromJson(JsonMap json) =>
      Tenant(
        id: json['id'] as String?,
	userId: json['userId'] as String?,
	firstName: json['firstName'] as String?,
	lastName: json['lastName'] as String?,
	email: json['email'] as String?,
	phoneNumber: json['phoneNumber'] as String?,
	leaseStartDate: json['leaseStartDate'] != null ? DateTime.parse(json['leaseStartDate']) : null,
	leaseEndDate: json['leaseEndDate'] != null ? DateTime.parse(json['leaseEndDate']) : null,
	paymentStatus: json['paymentStatus'] != null ? PaymentStatus.fromJson(json['paymentStatus']) : null,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
	propertyId: json['propertyId'] as String?,
	isActive: json['isActive'] as bool?,
	Contract: json['Contract'] != null ? createModels<Contract>((json['Contract'] as List).cast<JsonMap>(), Contract.fromJson) : null,
	Expense: json['Expense'] != null ? createModels<Expense>((json['Expense'] as List).cast<JsonMap>(), Expense.fromJson) : null,
	Increase: json['Increase'] != null ? createModels<Increase>((json['Increase'] as List).cast<JsonMap>(), Increase.fromJson) : null,
	Notification: json['Notification'] != null ? createModels<Notification>((json['Notification'] as List).cast<JsonMap>(), Notification.fromJson) : null,
	Payment: json['Payment'] != null ? createModels<Payment>((json['Payment'] as List).cast<JsonMap>(), Payment.fromJson) : null,
	Report: json['Report'] != null ? createModels<Report>((json['Report'] as List).cast<JsonMap>(), Report.fromJson) : null,
	Lease: json['Lease'] != null ? createModels<Lease>((json['Lease'] as List).cast<JsonMap>(), Lease.fromJson) : null,
	MaintenanceWorkOrder: json['MaintenanceWorkOrder'] != null ? createModels<MaintenanceWorkOrder>((json['MaintenanceWorkOrder'] as List).cast<JsonMap>(), MaintenanceWorkOrder.fromJson) : null,
	Property: json['Property'] != null ? Property.fromJson(json['Property'] as JsonMap) : null,
	User: json['User'] != null ? User.fromJson(json['User'] as JsonMap) : null,
	$ContractCount: json['_count']?['Contract'] as int?,
	$ExpenseCount: json['_count']?['Expense'] as int?,
	$IncreaseCount: json['_count']?['Increase'] as int?,
	$NotificationCount: json['_count']?['Notification'] as int?,
	$PaymentCount: json['_count']?['Payment'] as int?,
	$ReportCount: json['_count']?['Report'] as int?,
	$LeaseCount: json['_count']?['Lease'] as int?,
	$MaintenanceWorkOrderCount: json['_count']?['MaintenanceWorkOrder'] as int?,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    Tenant copyWith({
        Value<String?>? id,
		Value<String?>? userId,
		Value<String?>? firstName,
		Value<String?>? lastName,
		Value<String?>? email,
		Value<String?>? phoneNumber,
		Value<DateTime?>? leaseStartDate,
		Value<DateTime?>? leaseEndDate,
		Value<PaymentStatus?>? paymentStatus,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<DateTime?>? deletedAt,
		Value<String?>? propertyId,
		Value<bool?>? isActive,
		Value<List<Contract>?>? Contract,
		Value<List<Expense>?>? Expense,
		Value<List<Increase>?>? Increase,
		Value<List<Notification>?>? Notification,
		Value<List<Payment>?>? Payment,
		Value<List<Report>?>? Report,
		Value<List<Lease>?>? Lease,
		Value<List<MaintenanceWorkOrder>?>? MaintenanceWorkOrder,
		Value<Property?>? Property,
		Value<User?>? User,
		int? $ContractCount,
		int? $ExpenseCount,
		int? $IncreaseCount,
		int? $NotificationCount,
		int? $PaymentCount,
		int? $ReportCount,
		int? $LeaseCount,
		int? $MaintenanceWorkOrderCount,
        }) {
        return Tenant(
            id: id != null ? id.value : this.id,
		userId: userId != null ? userId.value : this.userId,
		firstName: firstName != null ? firstName.value : this.firstName,
		lastName: lastName != null ? lastName.value : this.lastName,
		email: email != null ? email.value : this.email,
		phoneNumber: phoneNumber != null ? phoneNumber.value : this.phoneNumber,
		leaseStartDate: leaseStartDate != null ? leaseStartDate.value : this.leaseStartDate,
		leaseEndDate: leaseEndDate != null ? leaseEndDate.value : this.leaseEndDate,
		paymentStatus: paymentStatus != null ? paymentStatus.value : this.paymentStatus,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		deletedAt: deletedAt != null ? deletedAt.value : this.deletedAt,
		propertyId: propertyId != null ? propertyId.value : this.propertyId,
		isActive: isActive != null ? isActive.value : this.isActive,
		Contract: Contract != null ? Contract.value : this.Contract,
		Expense: Expense != null ? Expense.value : this.Expense,
		Increase: Increase != null ? Increase.value : this.Increase,
		Notification: Notification != null ? Notification.value : this.Notification,
		Payment: Payment != null ? Payment.value : this.Payment,
		Report: Report != null ? Report.value : this.Report,
		Lease: Lease != null ? Lease.value : this.Lease,
		MaintenanceWorkOrder: MaintenanceWorkOrder != null ? MaintenanceWorkOrder.value : this.MaintenanceWorkOrder,
		Property: Property != null ? Property.value : this.Property,
		User: User != null ? User.value : this.User,
		$ContractCount: $ContractCount ?? this.$ContractCount,
		$ExpenseCount: $ExpenseCount ?? this.$ExpenseCount,
		$IncreaseCount: $IncreaseCount ?? this.$IncreaseCount,
		$NotificationCount: $NotificationCount ?? this.$NotificationCount,
		$PaymentCount: $PaymentCount ?? this.$PaymentCount,
		$ReportCount: $ReportCount ?? this.$ReportCount,
		$LeaseCount: $LeaseCount ?? this.$LeaseCount,
		$MaintenanceWorkOrderCount: $MaintenanceWorkOrderCount ?? this.$MaintenanceWorkOrderCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    Tenant copyWithInstanceValues(Tenant tenant) {
        return Tenant(
            id: tenant.id ?? id,
		userId: tenant.userId ?? userId,
		firstName: tenant.firstName ?? firstName,
		lastName: tenant.lastName ?? lastName,
		email: tenant.email ?? email,
		phoneNumber: tenant.phoneNumber ?? phoneNumber,
		leaseStartDate: tenant.leaseStartDate ?? leaseStartDate,
		leaseEndDate: tenant.leaseEndDate ?? leaseEndDate,
		paymentStatus: tenant.paymentStatus ?? paymentStatus,
		createdAt: tenant.createdAt ?? createdAt,
		updatedAt: tenant.updatedAt ?? updatedAt,
		deletedAt: tenant.deletedAt ?? deletedAt,
		propertyId: tenant.propertyId ?? propertyId,
		isActive: tenant.isActive ?? isActive,
		Contract: tenant.Contract ?? Contract,
		Expense: tenant.Expense ?? Expense,
		Increase: tenant.Increase ?? Increase,
		Notification: tenant.Notification ?? Notification,
		Payment: tenant.Payment ?? Payment,
		Report: tenant.Report ?? Report,
		Lease: tenant.Lease ?? Lease,
		MaintenanceWorkOrder: tenant.MaintenanceWorkOrder ?? MaintenanceWorkOrder,
		Property: tenant.Property ?? Property,
		User: tenant.User ?? User,
		$ContractCount: tenant.$ContractCount ?? $ContractCount,
		$ExpenseCount: tenant.$ExpenseCount ?? $ExpenseCount,
		$IncreaseCount: tenant.$IncreaseCount ?? $IncreaseCount,
		$NotificationCount: tenant.$NotificationCount ?? $NotificationCount,
		$PaymentCount: tenant.$PaymentCount ?? $PaymentCount,
		$ReportCount: tenant.$ReportCount ?? $ReportCount,
		$LeaseCount: tenant.$LeaseCount ?? $LeaseCount,
		$MaintenanceWorkOrderCount: tenant.$MaintenanceWorkOrderCount ?? $MaintenanceWorkOrderCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    Tenant mergeWithInstanceValues(Tenant tenant) {
        return Tenant(
            id: tenant.$assignedFields.contains('id') ? tenant.id : id,
		userId: tenant.$assignedFields.contains('userId') ? tenant.userId : userId,
		firstName: tenant.$assignedFields.contains('firstName') ? tenant.firstName : firstName,
		lastName: tenant.$assignedFields.contains('lastName') ? tenant.lastName : lastName,
		email: tenant.$assignedFields.contains('email') ? tenant.email : email,
		phoneNumber: tenant.$assignedFields.contains('phoneNumber') ? tenant.phoneNumber : phoneNumber,
		leaseStartDate: tenant.$assignedFields.contains('leaseStartDate') ? tenant.leaseStartDate : leaseStartDate,
		leaseEndDate: tenant.$assignedFields.contains('leaseEndDate') ? tenant.leaseEndDate : leaseEndDate,
		paymentStatus: tenant.$assignedFields.contains('paymentStatus') ? tenant.paymentStatus : paymentStatus,
		createdAt: tenant.$assignedFields.contains('createdAt') ? tenant.createdAt : createdAt,
		updatedAt: tenant.$assignedFields.contains('updatedAt') ? tenant.updatedAt : updatedAt,
		deletedAt: tenant.$assignedFields.contains('deletedAt') ? tenant.deletedAt : deletedAt,
		propertyId: tenant.$assignedFields.contains('propertyId') ? tenant.propertyId : propertyId,
		isActive: tenant.$assignedFields.contains('isActive') ? tenant.isActive : isActive,
		Contract: (tenant.$assignedFields.contains('Contract') && tenant.Contract != null) ? mergeModelLists(Contract, tenant.Contract) : Contract,
		Expense: (tenant.$assignedFields.contains('Expense') && tenant.Expense != null) ? mergeModelLists(Expense, tenant.Expense) : Expense,
		Increase: (tenant.$assignedFields.contains('Increase') && tenant.Increase != null) ? mergeModelLists(Increase, tenant.Increase) : Increase,
		Notification: (tenant.$assignedFields.contains('Notification') && tenant.Notification != null) ? mergeModelLists(Notification, tenant.Notification) : Notification,
		Payment: (tenant.$assignedFields.contains('Payment') && tenant.Payment != null) ? mergeModelLists(Payment, tenant.Payment) : Payment,
		Report: (tenant.$assignedFields.contains('Report') && tenant.Report != null) ? mergeModelLists(Report, tenant.Report) : Report,
		Lease: (tenant.$assignedFields.contains('Lease') && tenant.Lease != null) ? mergeModelLists(Lease, tenant.Lease) : Lease,
		MaintenanceWorkOrder: (tenant.$assignedFields.contains('MaintenanceWorkOrder') && tenant.MaintenanceWorkOrder != null) ? mergeModelLists(MaintenanceWorkOrder, tenant.MaintenanceWorkOrder) : MaintenanceWorkOrder,
		Property: tenant.$assignedFields.contains('Property') ? tenant.Property : Property,
		User: tenant.$assignedFields.contains('User') ? tenant.User : User,
		$ContractCount: tenant.$ContractCount ?? $ContractCount,
		$ExpenseCount: tenant.$ExpenseCount ?? $ExpenseCount,
		$IncreaseCount: tenant.$IncreaseCount ?? $IncreaseCount,
		$NotificationCount: tenant.$NotificationCount ?? $NotificationCount,
		$PaymentCount: tenant.$PaymentCount ?? $PaymentCount,
		$ReportCount: tenant.$ReportCount ?? $ReportCount,
		$LeaseCount: tenant.$LeaseCount ?? $LeaseCount,
		$MaintenanceWorkOrderCount: tenant.$MaintenanceWorkOrderCount ?? $MaintenanceWorkOrderCount
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    Tenant updateWithInstanceValues(Tenant tenant) {
        if (tenant.$assignedFields.contains('id')) { id = tenant.id; }
		if (tenant.$assignedFields.contains('userId')) { userId = tenant.userId; }
		if (tenant.$assignedFields.contains('firstName')) { firstName = tenant.firstName; }
		if (tenant.$assignedFields.contains('lastName')) { lastName = tenant.lastName; }
		if (tenant.$assignedFields.contains('email')) { email = tenant.email; }
		if (tenant.$assignedFields.contains('phoneNumber')) { phoneNumber = tenant.phoneNumber; }
		if (tenant.$assignedFields.contains('leaseStartDate')) { leaseStartDate = tenant.leaseStartDate; }
		if (tenant.$assignedFields.contains('leaseEndDate')) { leaseEndDate = tenant.leaseEndDate; }
		if (tenant.$assignedFields.contains('paymentStatus')) { paymentStatus = tenant.paymentStatus; }
		if (tenant.$assignedFields.contains('createdAt')) { createdAt = tenant.createdAt; }
		if (tenant.$assignedFields.contains('updatedAt')) { updatedAt = tenant.updatedAt; }
		if (tenant.$assignedFields.contains('deletedAt')) { deletedAt = tenant.deletedAt; }
		if (tenant.$assignedFields.contains('propertyId')) { propertyId = tenant.propertyId; }
		if (tenant.$assignedFields.contains('isActive')) { isActive = tenant.isActive; }
		if (tenant.$assignedFields.contains('Contract') && tenant.Contract != null) { Contract = mergeModelLists(Contract, tenant.Contract); }
		if (tenant.$assignedFields.contains('Expense') && tenant.Expense != null) { Expense = mergeModelLists(Expense, tenant.Expense); }
		if (tenant.$assignedFields.contains('Increase') && tenant.Increase != null) { Increase = mergeModelLists(Increase, tenant.Increase); }
		if (tenant.$assignedFields.contains('Notification') && tenant.Notification != null) { Notification = mergeModelLists(Notification, tenant.Notification); }
		if (tenant.$assignedFields.contains('Payment') && tenant.Payment != null) { Payment = mergeModelLists(Payment, tenant.Payment); }
		if (tenant.$assignedFields.contains('Report') && tenant.Report != null) { Report = mergeModelLists(Report, tenant.Report); }
		if (tenant.$assignedFields.contains('Lease') && tenant.Lease != null) { Lease = mergeModelLists(Lease, tenant.Lease); }
		if (tenant.$assignedFields.contains('MaintenanceWorkOrder') && tenant.MaintenanceWorkOrder != null) { MaintenanceWorkOrder = mergeModelLists(MaintenanceWorkOrder, tenant.MaintenanceWorkOrder); }
		if (tenant.$assignedFields.contains('Property')) { Property = tenant.Property; }
		if (tenant.$assignedFields.contains('User')) { User = tenant.User; }
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
          ? {...?serializedTypes, 'Tenant'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(userId != null) 'userId': userId,
	if(firstName != null) 'firstName': firstName,
	if(lastName != null) 'lastName': lastName,
	if(email != null) 'email': email,
	if(phoneNumber != null) 'phoneNumber': phoneNumber,
	if(leaseStartDate != null) 'leaseStartDate': leaseStartDate?.toIso8601String(),
	if(leaseEndDate != null) 'leaseEndDate': leaseEndDate?.toIso8601String(),
	if(paymentStatus != null) 'paymentStatus': paymentStatus?.toJson(),
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(deletedAt != null) 'deletedAt': deletedAt?.toIso8601String(),
	if(propertyId != null) 'propertyId': propertyId,
	if(isActive != null) 'isActive': isActive,
	if(Contract != null && (!preventCircularSerialization || !serializedModels.contains('Contract'))) 'Contract': Contract?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(Expense != null && (!preventCircularSerialization || !serializedModels.contains('Expense'))) 'Expense': Expense?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(Increase != null && (!preventCircularSerialization || !serializedModels.contains('Increase'))) 'Increase': Increase?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(Notification != null && (!preventCircularSerialization || !serializedModels.contains('Notification'))) 'Notification': Notification?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(Payment != null && (!preventCircularSerialization || !serializedModels.contains('Payment'))) 'Payment': Payment?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(Report != null && (!preventCircularSerialization || !serializedModels.contains('Report'))) 'Report': Report?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(Lease != null && (!preventCircularSerialization || !serializedModels.contains('Lease'))) 'Lease': Lease?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(MaintenanceWorkOrder != null && (!preventCircularSerialization || !serializedModels.contains('MaintenanceWorkOrder'))) 'MaintenanceWorkOrder': MaintenanceWorkOrder?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(Property != null && (!preventCircularSerialization || !serializedModels.contains('Property'))) 'Property': Property?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(User != null && (!preventCircularSerialization || !serializedModels.contains('User'))) 'User': User?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
		if ($ContractCount != null || $ExpenseCount != null || $IncreaseCount != null || $NotificationCount != null || $PaymentCount != null || $ReportCount != null || $LeaseCount != null || $MaintenanceWorkOrderCount != null) '_count': { 
		if ($ContractCount != null) 'Contract': $ContractCount, 
		if ($ExpenseCount != null) 'Expense': $ExpenseCount, 
		if ($IncreaseCount != null) 'Increase': $IncreaseCount, 
		if ($NotificationCount != null) 'Notification': $NotificationCount, 
		if ($PaymentCount != null) 'Payment': $PaymentCount, 
		if ($ReportCount != null) 'Report': $ReportCount, 
		if ($LeaseCount != null) 'Lease': $LeaseCount, 
		if ($MaintenanceWorkOrderCount != null) 'MaintenanceWorkOrder': $MaintenanceWorkOrderCount, 
		},
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is Tenant &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    