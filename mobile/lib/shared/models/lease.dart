import 'package:reservatior/shared/enums/lease_status.dart';
import 'contact.dart';
import 'contract.dart';
import 'deposit_protection.dart';
import 'financial_record.dart';
import 'immigration_status_check.dart';
import 'lease_renewal.dart';
import 'listing.dart';
import 'organization.dart';
import 'payment.dart';
import 'property_inventory.dart';
import 'rent_arrears.dart';
import 'rent_schedule.dart';
import 'right_to_rent_check.dart';
import 'security_deposit_protection.dart';
import 'task.dart';
import 'tenant.dart';

class Lease {
  final String id;
  final String orgId;
  final String listingId;
  final String tenantId;
  final LeaseStatus status;
  final DateTime startDate;
  final DateTime endDate;
  final double rent;
  final String currency;
  final double? deposit;
  final int? rentDueDay;
  final String? notes;
  final bool isActive;
  final String? createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final List<Contract> contracts;
  final DepositProtection? depositProtection;
  final List<FinancialRecord> financialRecords;
  final ImmigrationStatusCheck? immigrationStatusCheck;
  final Listing listing;
  final Organization org;
  final Tenant tenant;
  final List<LeaseRenewal> renewals;
  final List<PropertyInventory> inventories;
  final List<RentArrears> rentArrears;
  final List<RentSchedule> rentSchedules;
  final List<RightToRentCheck> rightToRentChecks;
  final SecurityDepositProtection? securityDepositProtection;
  final List<Task> tasks;
  final List<Contact> contact;
  final List<Payment> payment;

  const Lease({
    required this.id,
    required this.orgId,
    required this.listingId,
    required this.tenantId,
    required this.status,
    required this.startDate,
    required this.endDate,
    required this.rent,
    required this.currency,
    this.deposit,
    this.rentDueDay,
    this.notes,
    required this.isActive,
    this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.contracts = const [],
    this.depositProtection,
    this.financialRecords = const [],
    this.immigrationStatusCheck,
    required this.listing,
    required this.org,
    required this.tenant,
    this.renewals = const [],
    this.inventories = const [],
    this.rentArrears = const [],
    this.rentSchedules = const [],
    this.rightToRentChecks = const [],
    this.securityDepositProtection,
    this.tasks = const [],
    this.contact = const [],
    this.payment = const [],
  });

  factory Lease.fromJson(Map<String, dynamic> json) {
    return Lease(
      id: json['id'] as String,
      orgId: json['orgId'] as String,
      listingId: json['listingId'] as String,
      tenantId: json['tenantId'] as String,
      status: LeaseStatus.values.firstWhere((v) => v.name == json['status']),
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      rent: (json['rent'] as num).toDouble(),
      currency: json['currency'] as String,
      deposit: (json['deposit'] as num?)?.toDouble(),
      rentDueDay: json['rentDueDay'] as int?,
      notes: json['notes'] as String?,
      isActive: json['isActive'] as bool,
      createdBy: json['createdBy'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      contracts: (json['contracts'] as List<dynamic>?)?.map((e) => Contract.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      depositProtection: json['depositProtection'] != null ? DepositProtection.fromJson(json['depositProtection'] as Map<String, dynamic>) : null,
      financialRecords: (json['financialRecords'] as List<dynamic>?)?.map((e) => FinancialRecord.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      immigrationStatusCheck: json['immigrationStatusCheck'] != null ? ImmigrationStatusCheck.fromJson(json['immigrationStatusCheck'] as Map<String, dynamic>) : null,
      listing: Listing.fromJson(json['listing'] as Map<String, dynamic>),
      org: Organization.fromJson(json['org'] as Map<String, dynamic>),
      tenant: Tenant.fromJson(json['tenant'] as Map<String, dynamic>),
      renewals: (json['renewals'] as List<dynamic>?)?.map((e) => LeaseRenewal.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      inventories: (json['inventories'] as List<dynamic>?)?.map((e) => PropertyInventory.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      rentArrears: (json['rentArrears'] as List<dynamic>?)?.map((e) => RentArrears.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      rentSchedules: (json['rentSchedules'] as List<dynamic>?)?.map((e) => RentSchedule.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      rightToRentChecks: (json['rightToRentChecks'] as List<dynamic>?)?.map((e) => RightToRentCheck.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      securityDepositProtection: json['securityDepositProtection'] != null ? SecurityDepositProtection.fromJson(json['securityDepositProtection'] as Map<String, dynamic>) : null,
      tasks: (json['tasks'] as List<dynamic>?)?.map((e) => Task.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      contact: (json['Contact'] as List<dynamic>?)?.map((e) => Contact.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      payment: (json['Payment'] as List<dynamic>?)?.map((e) => Payment.fromJson(e as Map<String, dynamic>)).toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'listingId': listingId,
      'tenantId': tenantId,
      'status': status.name,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'rent': rent,
      'currency': currency,
      'deposit': deposit,
      'rentDueDay': rentDueDay,
      'notes': notes,
      'isActive': isActive,
      'createdBy': createdBy,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'contracts': contracts.map((e) => e.toJson()).toList(),
      'depositProtection': depositProtection?.toJson(),
      'financialRecords': financialRecords.map((e) => e.toJson()).toList(),
      'immigrationStatusCheck': immigrationStatusCheck?.toJson(),
      'listing': listing.toJson(),
      'org': org.toJson(),
      'tenant': tenant.toJson(),
      'renewals': renewals.map((e) => e.toJson()).toList(),
      'inventories': inventories.map((e) => e.toJson()).toList(),
      'rentArrears': rentArrears.map((e) => e.toJson()).toList(),
      'rentSchedules': rentSchedules.map((e) => e.toJson()).toList(),
      'rightToRentChecks': rightToRentChecks.map((e) => e.toJson()).toList(),
      'securityDepositProtection': securityDepositProtection?.toJson(),
      'tasks': tasks.map((e) => e.toJson()).toList(),
      'Contact': contact.map((e) => e.toJson()).toList(),
      'Payment': payment.map((e) => e.toJson()).toList(),
    };
  }

  Lease copyWith({
    String? id,
    String? orgId,
    String? listingId,
    String? tenantId,
    LeaseStatus? status,
    DateTime? startDate,
    DateTime? endDate,
    double? rent,
    String? currency,
    double? deposit,
    int? rentDueDay,
    String? notes,
    bool? isActive,
    String? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    List<Contract>? contracts,
    DepositProtection? depositProtection,
    List<FinancialRecord>? financialRecords,
    ImmigrationStatusCheck? immigrationStatusCheck,
    Listing? listing,
    Organization? org,
    Tenant? tenant,
    List<LeaseRenewal>? renewals,
    List<PropertyInventory>? inventories,
    List<RentArrears>? rentArrears,
    List<RentSchedule>? rentSchedules,
    List<RightToRentCheck>? rightToRentChecks,
    SecurityDepositProtection? securityDepositProtection,
    List<Task>? tasks,
    List<Contact>? contact,
    List<Payment>? payment,
  }) {
    return Lease(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      listingId: listingId ?? this.listingId,
      tenantId: tenantId ?? this.tenantId,
      status: status ?? this.status,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      rent: rent ?? this.rent,
      currency: currency ?? this.currency,
      deposit: deposit ?? this.deposit,
      rentDueDay: rentDueDay ?? this.rentDueDay,
      notes: notes ?? this.notes,
      isActive: isActive ?? this.isActive,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      contracts: contracts ?? this.contracts,
      depositProtection: depositProtection ?? this.depositProtection,
      financialRecords: financialRecords ?? this.financialRecords,
      immigrationStatusCheck: immigrationStatusCheck ?? this.immigrationStatusCheck,
      listing: listing ?? this.listing,
      org: org ?? this.org,
      tenant: tenant ?? this.tenant,
      renewals: renewals ?? this.renewals,
      inventories: inventories ?? this.inventories,
      rentArrears: rentArrears ?? this.rentArrears,
      rentSchedules: rentSchedules ?? this.rentSchedules,
      rightToRentChecks: rightToRentChecks ?? this.rightToRentChecks,
      securityDepositProtection: securityDepositProtection ?? this.securityDepositProtection,
      tasks: tasks ?? this.tasks,
      contact: contact ?? this.contact,
      payment: payment ?? this.payment,
    );
  }
}
