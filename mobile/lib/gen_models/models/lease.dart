
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'lease_status.dart';
import 'contract.dart';
import 'deposit_protection.dart';
import 'financial_record.dart';
import 'immigration_status_check.dart';
import 'listing.dart';
import 'organization.dart';
import 'tenant.dart';
import 'lease_renewal.dart';
import 'property_inventory.dart';
import 'rent_arrears.dart';
import 'rent_schedule.dart';
import 'right_to_rent_check.dart';
import 'security_deposit_protection.dart';
import 'task.dart';
import 'contact.dart';
import 'payment.dart';


class Lease implements PrismaModel<String, Lease> , Id<String> {
    @override
String? id;
	String? orgId;
	String? listingId;
	String? tenantId;
	LeaseStatus? status;
	DateTime? startDate;
	DateTime? endDate;
	double? rent;
	String? currency;
	double? deposit;
	int? rentDueDay;
	String? notes;
	bool? isActive;
	String? createdBy;
	DateTime? createdAt;
	DateTime? updatedAt;
	DateTime? deletedAt;
	List<Contract>? contracts;
	DepositProtection? depositProtection;
	List<FinancialRecord>? financialRecords;
	ImmigrationStatusCheck? immigrationStatusCheck;
	Listing? listing;
	Organization? org;
	Tenant? tenant;
	List<LeaseRenewal>? renewals;
	List<PropertyInventory>? inventories;
	List<RentArrears>? rentArrears;
	List<RentSchedule>? rentSchedules;
	List<RightToRentCheck>? rightToRentChecks;
	SecurityDepositProtection? securityDepositProtection;
	List<Task>? tasks;
	List<Contact>? Contact;
	List<Payment>? Payment;
	int? $contractsCount;
	int? $financialRecordsCount;
	int? $renewalsCount;
	int? $inventoriesCount;
	int? $rentArrearsCount;
	int? $rentSchedulesCount;
	int? $rightToRentChecksCount;
	int? $tasksCount;
	int? $ContactCount;
	int? $PaymentCount;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    Lease({ this.id,
	 this.orgId,
	 this.listingId,
	 this.tenantId,
	 this.status = LeaseStatus.DRAFT,
	 this.startDate,
	 this.endDate,
	 this.rent,
	 this.currency,
	 this.deposit,
	 this.rentDueDay,
	 this.notes,
	 this.isActive = true,
	 this.createdBy,
	 this.createdAt,
	 this.updatedAt,
	 this.deletedAt,
	 this.contracts,
	 this.depositProtection,
	 this.financialRecords,
	 this.immigrationStatusCheck,
	 this.listing,
	 this.org,
	 this.tenant,
	 this.renewals,
	 this.inventories,
	 this.rentArrears,
	 this.rentSchedules,
	 this.rightToRentChecks,
	 this.securityDepositProtection,
	 this.tasks,
	 this.Contact,
	 this.Payment,
	this.$contractsCount,
	this.$financialRecordsCount,
	this.$renewalsCount,
	this.$inventoriesCount,
	this.$rentArrearsCount,
	this.$rentSchedulesCount,
	this.$rightToRentChecksCount,
	this.$tasksCount,
	this.$ContactCount,
	this.$PaymentCount,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<Lease, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"orgId": (m) => m.orgId,

	"listingId": (m) => m.listingId,

	"tenantId": (m) => m.tenantId,

	"status": (m) => m.status,

	"startDate": (m) => m.startDate,

	"endDate": (m) => m.endDate,

	"rent": (m) => m.rent,

	"currency": (m) => m.currency,

	"deposit": (m) => m.deposit,

	"rentDueDay": (m) => m.rentDueDay,

	"notes": (m) => m.notes,

	"isActive": (m) => m.isActive,

	"createdBy": (m) => m.createdBy,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"deletedAt": (m) => m.deletedAt,

	"contracts": (m) => m.contracts,

	"depositProtection": (m) => m.depositProtection,

	"financialRecords": (m) => m.financialRecords,

	"immigrationStatusCheck": (m) => m.immigrationStatusCheck,

	"listing": (m) => m.listing,

	"org": (m) => m.org,

	"tenant": (m) => m.tenant,

	"renewals": (m) => m.renewals,

	"inventories": (m) => m.inventories,

	"rentArrears": (m) => m.rentArrears,

	"rentSchedules": (m) => m.rentSchedules,

	"rightToRentChecks": (m) => m.rightToRentChecks,

	"securityDepositProtection": (m) => m.securityDepositProtection,

	"tasks": (m) => m.tasks,

	"Contact": (m) => m.Contact,

	"Payment": (m) => m.Payment,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(Lease) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in Lease');
    }
    return propFunction as V? Function(Lease);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory Lease.fromJson(JsonMap json) =>
      Lease(
        id: json['id'] as String?,
	orgId: json['orgId'] as String?,
	listingId: json['listingId'] as String?,
	tenantId: json['tenantId'] as String?,
	status: json['status'] != null ? LeaseStatus.fromJson(json['status']) : null,
	startDate: json['startDate'] != null ? DateTime.parse(json['startDate']) : null,
	endDate: json['endDate'] != null ? DateTime.parse(json['endDate']) : null,
	rent: json['rent'] as double?,
	currency: json['currency'] as String?,
	deposit: json['deposit'] as double?,
	rentDueDay: int.tryParse(json['rentDueDay'].toString()),
	notes: json['notes'] as String?,
	isActive: json['isActive'] as bool?,
	createdBy: json['createdBy'] as String?,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
	contracts: json['contracts'] != null ? createModels<Contract>((json['contracts'] as List).cast<JsonMap>(), Contract.fromJson) : null,
	depositProtection: json['depositProtection'] != null ? DepositProtection.fromJson(json['depositProtection'] as JsonMap) : null,
	financialRecords: json['financialRecords'] != null ? createModels<FinancialRecord>((json['financialRecords'] as List).cast<JsonMap>(), FinancialRecord.fromJson) : null,
	immigrationStatusCheck: json['immigrationStatusCheck'] != null ? ImmigrationStatusCheck.fromJson(json['immigrationStatusCheck'] as JsonMap) : null,
	listing: json['listing'] != null ? Listing.fromJson(json['listing'] as JsonMap) : null,
	org: json['org'] != null ? Organization.fromJson(json['org'] as JsonMap) : null,
	tenant: json['tenant'] != null ? Tenant.fromJson(json['tenant'] as JsonMap) : null,
	renewals: json['renewals'] != null ? createModels<LeaseRenewal>((json['renewals'] as List).cast<JsonMap>(), LeaseRenewal.fromJson) : null,
	inventories: json['inventories'] != null ? createModels<PropertyInventory>((json['inventories'] as List).cast<JsonMap>(), PropertyInventory.fromJson) : null,
	rentArrears: json['rentArrears'] != null ? createModels<RentArrears>((json['rentArrears'] as List).cast<JsonMap>(), RentArrears.fromJson) : null,
	rentSchedules: json['rentSchedules'] != null ? createModels<RentSchedule>((json['rentSchedules'] as List).cast<JsonMap>(), RentSchedule.fromJson) : null,
	rightToRentChecks: json['rightToRentChecks'] != null ? createModels<RightToRentCheck>((json['rightToRentChecks'] as List).cast<JsonMap>(), RightToRentCheck.fromJson) : null,
	securityDepositProtection: json['securityDepositProtection'] != null ? SecurityDepositProtection.fromJson(json['securityDepositProtection'] as JsonMap) : null,
	tasks: json['tasks'] != null ? createModels<Task>((json['tasks'] as List).cast<JsonMap>(), Task.fromJson) : null,
	Contact: json['Contact'] != null ? createModels<Contact>((json['Contact'] as List).cast<JsonMap>(), Contact.fromJson) : null,
	Payment: json['Payment'] != null ? createModels<Payment>((json['Payment'] as List).cast<JsonMap>(), Payment.fromJson) : null,
	$contractsCount: json['_count']?['contracts'] as int?,
	$financialRecordsCount: json['_count']?['financialRecords'] as int?,
	$renewalsCount: json['_count']?['renewals'] as int?,
	$inventoriesCount: json['_count']?['inventories'] as int?,
	$rentArrearsCount: json['_count']?['rentArrears'] as int?,
	$rentSchedulesCount: json['_count']?['rentSchedules'] as int?,
	$rightToRentChecksCount: json['_count']?['rightToRentChecks'] as int?,
	$tasksCount: json['_count']?['tasks'] as int?,
	$ContactCount: json['_count']?['Contact'] as int?,
	$PaymentCount: json['_count']?['Payment'] as int?,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    Lease copyWith({
        Value<String?>? id,
		Value<String?>? orgId,
		Value<String?>? listingId,
		Value<String?>? tenantId,
		Value<LeaseStatus?>? status,
		Value<DateTime?>? startDate,
		Value<DateTime?>? endDate,
		Value<double?>? rent,
		Value<String?>? currency,
		Value<double?>? deposit,
		Value<int?>? rentDueDay,
		Value<String?>? notes,
		Value<bool?>? isActive,
		Value<String?>? createdBy,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<DateTime?>? deletedAt,
		Value<List<Contract>?>? contracts,
		Value<DepositProtection?>? depositProtection,
		Value<List<FinancialRecord>?>? financialRecords,
		Value<ImmigrationStatusCheck?>? immigrationStatusCheck,
		Value<Listing?>? listing,
		Value<Organization?>? org,
		Value<Tenant?>? tenant,
		Value<List<LeaseRenewal>?>? renewals,
		Value<List<PropertyInventory>?>? inventories,
		Value<List<RentArrears>?>? rentArrears,
		Value<List<RentSchedule>?>? rentSchedules,
		Value<List<RightToRentCheck>?>? rightToRentChecks,
		Value<SecurityDepositProtection?>? securityDepositProtection,
		Value<List<Task>?>? tasks,
		Value<List<Contact>?>? Contact,
		Value<List<Payment>?>? Payment,
		int? $contractsCount,
		int? $financialRecordsCount,
		int? $renewalsCount,
		int? $inventoriesCount,
		int? $rentArrearsCount,
		int? $rentSchedulesCount,
		int? $rightToRentChecksCount,
		int? $tasksCount,
		int? $ContactCount,
		int? $PaymentCount,
        }) {
        return Lease(
            id: id != null ? id.value : this.id,
		orgId: orgId != null ? orgId.value : this.orgId,
		listingId: listingId != null ? listingId.value : this.listingId,
		tenantId: tenantId != null ? tenantId.value : this.tenantId,
		status: status != null ? status.value : this.status,
		startDate: startDate != null ? startDate.value : this.startDate,
		endDate: endDate != null ? endDate.value : this.endDate,
		rent: rent != null ? rent.value : this.rent,
		currency: currency != null ? currency.value : this.currency,
		deposit: deposit != null ? deposit.value : this.deposit,
		rentDueDay: rentDueDay != null ? rentDueDay.value : this.rentDueDay,
		notes: notes != null ? notes.value : this.notes,
		isActive: isActive != null ? isActive.value : this.isActive,
		createdBy: createdBy != null ? createdBy.value : this.createdBy,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		deletedAt: deletedAt != null ? deletedAt.value : this.deletedAt,
		contracts: contracts != null ? contracts.value : this.contracts,
		depositProtection: depositProtection != null ? depositProtection.value : this.depositProtection,
		financialRecords: financialRecords != null ? financialRecords.value : this.financialRecords,
		immigrationStatusCheck: immigrationStatusCheck != null ? immigrationStatusCheck.value : this.immigrationStatusCheck,
		listing: listing != null ? listing.value : this.listing,
		org: org != null ? org.value : this.org,
		tenant: tenant != null ? tenant.value : this.tenant,
		renewals: renewals != null ? renewals.value : this.renewals,
		inventories: inventories != null ? inventories.value : this.inventories,
		rentArrears: rentArrears != null ? rentArrears.value : this.rentArrears,
		rentSchedules: rentSchedules != null ? rentSchedules.value : this.rentSchedules,
		rightToRentChecks: rightToRentChecks != null ? rightToRentChecks.value : this.rightToRentChecks,
		securityDepositProtection: securityDepositProtection != null ? securityDepositProtection.value : this.securityDepositProtection,
		tasks: tasks != null ? tasks.value : this.tasks,
		Contact: Contact != null ? Contact.value : this.Contact,
		Payment: Payment != null ? Payment.value : this.Payment,
		$contractsCount: $contractsCount ?? this.$contractsCount,
		$financialRecordsCount: $financialRecordsCount ?? this.$financialRecordsCount,
		$renewalsCount: $renewalsCount ?? this.$renewalsCount,
		$inventoriesCount: $inventoriesCount ?? this.$inventoriesCount,
		$rentArrearsCount: $rentArrearsCount ?? this.$rentArrearsCount,
		$rentSchedulesCount: $rentSchedulesCount ?? this.$rentSchedulesCount,
		$rightToRentChecksCount: $rightToRentChecksCount ?? this.$rightToRentChecksCount,
		$tasksCount: $tasksCount ?? this.$tasksCount,
		$ContactCount: $ContactCount ?? this.$ContactCount,
		$PaymentCount: $PaymentCount ?? this.$PaymentCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    Lease copyWithInstanceValues(Lease lease) {
        return Lease(
            id: lease.id ?? id,
		orgId: lease.orgId ?? orgId,
		listingId: lease.listingId ?? listingId,
		tenantId: lease.tenantId ?? tenantId,
		status: lease.status ?? status,
		startDate: lease.startDate ?? startDate,
		endDate: lease.endDate ?? endDate,
		rent: lease.rent ?? rent,
		currency: lease.currency ?? currency,
		deposit: lease.deposit ?? deposit,
		rentDueDay: lease.rentDueDay ?? rentDueDay,
		notes: lease.notes ?? notes,
		isActive: lease.isActive ?? isActive,
		createdBy: lease.createdBy ?? createdBy,
		createdAt: lease.createdAt ?? createdAt,
		updatedAt: lease.updatedAt ?? updatedAt,
		deletedAt: lease.deletedAt ?? deletedAt,
		contracts: lease.contracts ?? contracts,
		depositProtection: lease.depositProtection ?? depositProtection,
		financialRecords: lease.financialRecords ?? financialRecords,
		immigrationStatusCheck: lease.immigrationStatusCheck ?? immigrationStatusCheck,
		listing: lease.listing ?? listing,
		org: lease.org ?? org,
		tenant: lease.tenant ?? tenant,
		renewals: lease.renewals ?? renewals,
		inventories: lease.inventories ?? inventories,
		rentArrears: lease.rentArrears ?? rentArrears,
		rentSchedules: lease.rentSchedules ?? rentSchedules,
		rightToRentChecks: lease.rightToRentChecks ?? rightToRentChecks,
		securityDepositProtection: lease.securityDepositProtection ?? securityDepositProtection,
		tasks: lease.tasks ?? tasks,
		Contact: lease.Contact ?? Contact,
		Payment: lease.Payment ?? Payment,
		$contractsCount: lease.$contractsCount ?? $contractsCount,
		$financialRecordsCount: lease.$financialRecordsCount ?? $financialRecordsCount,
		$renewalsCount: lease.$renewalsCount ?? $renewalsCount,
		$inventoriesCount: lease.$inventoriesCount ?? $inventoriesCount,
		$rentArrearsCount: lease.$rentArrearsCount ?? $rentArrearsCount,
		$rentSchedulesCount: lease.$rentSchedulesCount ?? $rentSchedulesCount,
		$rightToRentChecksCount: lease.$rightToRentChecksCount ?? $rightToRentChecksCount,
		$tasksCount: lease.$tasksCount ?? $tasksCount,
		$ContactCount: lease.$ContactCount ?? $ContactCount,
		$PaymentCount: lease.$PaymentCount ?? $PaymentCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    Lease mergeWithInstanceValues(Lease lease) {
        return Lease(
            id: lease.$assignedFields.contains('id') ? lease.id : id,
		orgId: lease.$assignedFields.contains('orgId') ? lease.orgId : orgId,
		listingId: lease.$assignedFields.contains('listingId') ? lease.listingId : listingId,
		tenantId: lease.$assignedFields.contains('tenantId') ? lease.tenantId : tenantId,
		status: lease.$assignedFields.contains('status') ? lease.status : status,
		startDate: lease.$assignedFields.contains('startDate') ? lease.startDate : startDate,
		endDate: lease.$assignedFields.contains('endDate') ? lease.endDate : endDate,
		rent: lease.$assignedFields.contains('rent') ? lease.rent : rent,
		currency: lease.$assignedFields.contains('currency') ? lease.currency : currency,
		deposit: lease.$assignedFields.contains('deposit') ? lease.deposit : deposit,
		rentDueDay: lease.$assignedFields.contains('rentDueDay') ? lease.rentDueDay : rentDueDay,
		notes: lease.$assignedFields.contains('notes') ? lease.notes : notes,
		isActive: lease.$assignedFields.contains('isActive') ? lease.isActive : isActive,
		createdBy: lease.$assignedFields.contains('createdBy') ? lease.createdBy : createdBy,
		createdAt: lease.$assignedFields.contains('createdAt') ? lease.createdAt : createdAt,
		updatedAt: lease.$assignedFields.contains('updatedAt') ? lease.updatedAt : updatedAt,
		deletedAt: lease.$assignedFields.contains('deletedAt') ? lease.deletedAt : deletedAt,
		contracts: (lease.$assignedFields.contains('contracts') && lease.contracts != null) ? mergeModelLists(contracts, lease.contracts) : contracts,
		depositProtection: lease.$assignedFields.contains('depositProtection') ? lease.depositProtection : depositProtection,
		financialRecords: (lease.$assignedFields.contains('financialRecords') && lease.financialRecords != null) ? mergeModelLists(financialRecords, lease.financialRecords) : financialRecords,
		immigrationStatusCheck: lease.$assignedFields.contains('immigrationStatusCheck') ? lease.immigrationStatusCheck : immigrationStatusCheck,
		listing: lease.$assignedFields.contains('listing') ? lease.listing : listing,
		org: lease.$assignedFields.contains('org') ? lease.org : org,
		tenant: lease.$assignedFields.contains('tenant') ? lease.tenant : tenant,
		renewals: (lease.$assignedFields.contains('renewals') && lease.renewals != null) ? mergeModelLists(renewals, lease.renewals) : renewals,
		inventories: (lease.$assignedFields.contains('inventories') && lease.inventories != null) ? mergeModelLists(inventories, lease.inventories) : inventories,
		rentArrears: (lease.$assignedFields.contains('rentArrears') && lease.rentArrears != null) ? mergeModelLists(rentArrears, lease.rentArrears) : rentArrears,
		rentSchedules: (lease.$assignedFields.contains('rentSchedules') && lease.rentSchedules != null) ? mergeModelLists(rentSchedules, lease.rentSchedules) : rentSchedules,
		rightToRentChecks: (lease.$assignedFields.contains('rightToRentChecks') && lease.rightToRentChecks != null) ? mergeModelLists(rightToRentChecks, lease.rightToRentChecks) : rightToRentChecks,
		securityDepositProtection: lease.$assignedFields.contains('securityDepositProtection') ? lease.securityDepositProtection : securityDepositProtection,
		tasks: (lease.$assignedFields.contains('tasks') && lease.tasks != null) ? mergeModelLists(tasks, lease.tasks) : tasks,
		Contact: (lease.$assignedFields.contains('Contact') && lease.Contact != null) ? mergeModelLists(Contact, lease.Contact) : Contact,
		Payment: (lease.$assignedFields.contains('Payment') && lease.Payment != null) ? mergeModelLists(Payment, lease.Payment) : Payment,
		$contractsCount: lease.$contractsCount ?? $contractsCount,
		$financialRecordsCount: lease.$financialRecordsCount ?? $financialRecordsCount,
		$renewalsCount: lease.$renewalsCount ?? $renewalsCount,
		$inventoriesCount: lease.$inventoriesCount ?? $inventoriesCount,
		$rentArrearsCount: lease.$rentArrearsCount ?? $rentArrearsCount,
		$rentSchedulesCount: lease.$rentSchedulesCount ?? $rentSchedulesCount,
		$rightToRentChecksCount: lease.$rightToRentChecksCount ?? $rightToRentChecksCount,
		$tasksCount: lease.$tasksCount ?? $tasksCount,
		$ContactCount: lease.$ContactCount ?? $ContactCount,
		$PaymentCount: lease.$PaymentCount ?? $PaymentCount
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    Lease updateWithInstanceValues(Lease lease) {
        if (lease.$assignedFields.contains('id')) { id = lease.id; }
		if (lease.$assignedFields.contains('orgId')) { orgId = lease.orgId; }
		if (lease.$assignedFields.contains('listingId')) { listingId = lease.listingId; }
		if (lease.$assignedFields.contains('tenantId')) { tenantId = lease.tenantId; }
		if (lease.$assignedFields.contains('status')) { status = lease.status; }
		if (lease.$assignedFields.contains('startDate')) { startDate = lease.startDate; }
		if (lease.$assignedFields.contains('endDate')) { endDate = lease.endDate; }
		if (lease.$assignedFields.contains('rent')) { rent = lease.rent; }
		if (lease.$assignedFields.contains('currency')) { currency = lease.currency; }
		if (lease.$assignedFields.contains('deposit')) { deposit = lease.deposit; }
		if (lease.$assignedFields.contains('rentDueDay')) { rentDueDay = lease.rentDueDay; }
		if (lease.$assignedFields.contains('notes')) { notes = lease.notes; }
		if (lease.$assignedFields.contains('isActive')) { isActive = lease.isActive; }
		if (lease.$assignedFields.contains('createdBy')) { createdBy = lease.createdBy; }
		if (lease.$assignedFields.contains('createdAt')) { createdAt = lease.createdAt; }
		if (lease.$assignedFields.contains('updatedAt')) { updatedAt = lease.updatedAt; }
		if (lease.$assignedFields.contains('deletedAt')) { deletedAt = lease.deletedAt; }
		if (lease.$assignedFields.contains('contracts') && lease.contracts != null) { contracts = mergeModelLists(contracts, lease.contracts); }
		if (lease.$assignedFields.contains('depositProtection')) { depositProtection = lease.depositProtection; }
		if (lease.$assignedFields.contains('financialRecords') && lease.financialRecords != null) { financialRecords = mergeModelLists(financialRecords, lease.financialRecords); }
		if (lease.$assignedFields.contains('immigrationStatusCheck')) { immigrationStatusCheck = lease.immigrationStatusCheck; }
		if (lease.$assignedFields.contains('listing')) { listing = lease.listing; }
		if (lease.$assignedFields.contains('org')) { org = lease.org; }
		if (lease.$assignedFields.contains('tenant')) { tenant = lease.tenant; }
		if (lease.$assignedFields.contains('renewals') && lease.renewals != null) { renewals = mergeModelLists(renewals, lease.renewals); }
		if (lease.$assignedFields.contains('inventories') && lease.inventories != null) { inventories = mergeModelLists(inventories, lease.inventories); }
		if (lease.$assignedFields.contains('rentArrears') && lease.rentArrears != null) { rentArrears = mergeModelLists(rentArrears, lease.rentArrears); }
		if (lease.$assignedFields.contains('rentSchedules') && lease.rentSchedules != null) { rentSchedules = mergeModelLists(rentSchedules, lease.rentSchedules); }
		if (lease.$assignedFields.contains('rightToRentChecks') && lease.rightToRentChecks != null) { rightToRentChecks = mergeModelLists(rightToRentChecks, lease.rightToRentChecks); }
		if (lease.$assignedFields.contains('securityDepositProtection')) { securityDepositProtection = lease.securityDepositProtection; }
		if (lease.$assignedFields.contains('tasks') && lease.tasks != null) { tasks = mergeModelLists(tasks, lease.tasks); }
		if (lease.$assignedFields.contains('Contact') && lease.Contact != null) { Contact = mergeModelLists(Contact, lease.Contact); }
		if (lease.$assignedFields.contains('Payment') && lease.Payment != null) { Payment = mergeModelLists(Payment, lease.Payment); }
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
          ? {...?serializedTypes, 'Lease'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(orgId != null) 'orgId': orgId,
	if(listingId != null) 'listingId': listingId,
	if(tenantId != null) 'tenantId': tenantId,
	if(status != null) 'status': status?.toJson(),
	if(startDate != null) 'startDate': startDate?.toIso8601String(),
	if(endDate != null) 'endDate': endDate?.toIso8601String(),
	if(rent != null) 'rent': rent,
	if(currency != null) 'currency': currency,
	if(deposit != null) 'deposit': deposit,
	if(rentDueDay != null) 'rentDueDay': rentDueDay,
	if(notes != null) 'notes': notes,
	if(isActive != null) 'isActive': isActive,
	if(createdBy != null) 'createdBy': createdBy,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(deletedAt != null) 'deletedAt': deletedAt?.toIso8601String(),
	if(contracts != null && (!preventCircularSerialization || !serializedModels.contains('Contract'))) 'contracts': contracts?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(depositProtection != null && (!preventCircularSerialization || !serializedModels.contains('DepositProtection'))) 'depositProtection': depositProtection?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(financialRecords != null && (!preventCircularSerialization || !serializedModels.contains('FinancialRecord'))) 'financialRecords': financialRecords?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(immigrationStatusCheck != null && (!preventCircularSerialization || !serializedModels.contains('ImmigrationStatusCheck'))) 'immigrationStatusCheck': immigrationStatusCheck?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(listing != null && (!preventCircularSerialization || !serializedModels.contains('Listing'))) 'listing': listing?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(org != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'org': org?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(tenant != null && (!preventCircularSerialization || !serializedModels.contains('Tenant'))) 'tenant': tenant?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(renewals != null && (!preventCircularSerialization || !serializedModels.contains('LeaseRenewal'))) 'renewals': renewals?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(inventories != null && (!preventCircularSerialization || !serializedModels.contains('PropertyInventory'))) 'inventories': inventories?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(rentArrears != null && (!preventCircularSerialization || !serializedModels.contains('RentArrears'))) 'rentArrears': rentArrears?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(rentSchedules != null && (!preventCircularSerialization || !serializedModels.contains('RentSchedule'))) 'rentSchedules': rentSchedules?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(rightToRentChecks != null && (!preventCircularSerialization || !serializedModels.contains('RightToRentCheck'))) 'rightToRentChecks': rightToRentChecks?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(securityDepositProtection != null && (!preventCircularSerialization || !serializedModels.contains('SecurityDepositProtection'))) 'securityDepositProtection': securityDepositProtection?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(tasks != null && (!preventCircularSerialization || !serializedModels.contains('Task'))) 'tasks': tasks?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(Contact != null && (!preventCircularSerialization || !serializedModels.contains('Contact'))) 'Contact': Contact?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(Payment != null && (!preventCircularSerialization || !serializedModels.contains('Payment'))) 'Payment': Payment?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
		if ($contractsCount != null || $financialRecordsCount != null || $renewalsCount != null || $inventoriesCount != null || $rentArrearsCount != null || $rentSchedulesCount != null || $rightToRentChecksCount != null || $tasksCount != null || $ContactCount != null || $PaymentCount != null) '_count': { 
		if ($contractsCount != null) 'contracts': $contractsCount, 
		if ($financialRecordsCount != null) 'financialRecords': $financialRecordsCount, 
		if ($renewalsCount != null) 'renewals': $renewalsCount, 
		if ($inventoriesCount != null) 'inventories': $inventoriesCount, 
		if ($rentArrearsCount != null) 'rentArrears': $rentArrearsCount, 
		if ($rentSchedulesCount != null) 'rentSchedules': $rentSchedulesCount, 
		if ($rightToRentChecksCount != null) 'rightToRentChecks': $rightToRentChecksCount, 
		if ($tasksCount != null) 'tasks': $tasksCount, 
		if ($ContactCount != null) 'Contact': $ContactCount, 
		if ($PaymentCount != null) 'Payment': $PaymentCount, 
		},
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is Lease &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    