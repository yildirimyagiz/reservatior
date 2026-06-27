import 'package:reservatior/shared/enums/payment_status.dart';
import 'contract.dart';
import 'expense.dart';
import 'increase.dart';
import 'lease.dart';
import 'maintenance_work_order.dart';
import 'notification.dart';
import 'payment.dart';
import 'property.dart';
import 'report.dart';
import 'user.dart';

class Tenant {
  final String id;
  final String userId;
  final String firstName;
  final String lastName;
  final String email;
  final String? phoneNumber;
  final DateTime leaseStartDate;
  final DateTime leaseEndDate;
  final PaymentStatus paymentStatus;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String propertyId;
  final bool isActive;
  final List<Contract> contracts;
  final List<Expense> expenses;
  final List<Increase> increases;
  final List<Notification> notifications;
  final List<Payment> payments;
  final List<Report> reports;
  final List<Lease> leases;
  final List<MaintenanceWorkOrder> maintenanceWorkOrders;
  final Property property;
  final User user;

  const Tenant({
    required this.id,
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.phoneNumber,
    required this.leaseStartDate,
    required this.leaseEndDate,
    required this.paymentStatus,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.propertyId,
    required this.isActive,
    this.contracts = const [],
    this.expenses = const [],
    this.increases = const [],
    this.notifications = const [],
    this.payments = const [],
    this.reports = const [],
    this.leases = const [],
    this.maintenanceWorkOrders = const [],
    required this.property,
    required this.user,
  });

  factory Tenant.fromJson(Map<String, dynamic> json) {
    return Tenant(
      id: json['id'] as String,
      userId: json['userId'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String?,
      leaseStartDate: DateTime.parse(json['leaseStartDate'] as String),
      leaseEndDate: DateTime.parse(json['leaseEndDate'] as String),
      paymentStatus: PaymentStatus.values.firstWhere((v) => v.name == json['paymentStatus']),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      propertyId: json['propertyId'] as String,
      isActive: json['isActive'] as bool,
      contracts: (json['Contract'] as List<dynamic>?)?.map((e) => Contract.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      expenses: (json['Expense'] as List<dynamic>?)?.map((e) => Expense.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      increases: (json['Increase'] as List<dynamic>?)?.map((e) => Increase.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      notifications: (json['Notification'] as List<dynamic>?)?.map((e) => Notification.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      payments: (json['Payment'] as List<dynamic>?)?.map((e) => Payment.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      reports: (json['Report'] as List<dynamic>?)?.map((e) => Report.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      leases: (json['Lease'] as List<dynamic>?)?.map((e) => Lease.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      maintenanceWorkOrders: (json['MaintenanceWorkOrder'] as List<dynamic>?)?.map((e) => MaintenanceWorkOrder.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      property: Property.fromJson(json['Property'] as Map<String, dynamic>),
      user: User.fromJson(json['User'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phoneNumber': phoneNumber,
      'leaseStartDate': leaseStartDate.toIso8601String(),
      'leaseEndDate': leaseEndDate.toIso8601String(),
      'paymentStatus': paymentStatus.name,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'propertyId': propertyId,
      'isActive': isActive,
      'Contract': contracts.map((e) => e.toJson()).toList(),
      'Expense': expenses.map((e) => e.toJson()).toList(),
      'Increase': increases.map((e) => e.toJson()).toList(),
      'Notification': notifications.map((e) => e.toJson()).toList(),
      'Payment': payments.map((e) => e.toJson()).toList(),
      'Report': reports.map((e) => e.toJson()).toList(),
      'Lease': leases.map((e) => e.toJson()).toList(),
      'MaintenanceWorkOrder': maintenanceWorkOrders.map((e) => e.toJson()).toList(),
      'Property': property.toJson(),
      'User': user.toJson(),
    };
  }

  Tenant copyWith({
    String? id,
    String? userId,
    String? firstName,
    String? lastName,
    String? email,
    String? phoneNumber,
    DateTime? leaseStartDate,
    DateTime? leaseEndDate,
    PaymentStatus? paymentStatus,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    String? propertyId,
    bool? isActive,
    List<Contract>? contracts,
    List<Expense>? expenses,
    List<Increase>? increases,
    List<Notification>? notifications,
    List<Payment>? payments,
    List<Report>? reports,
    List<Lease>? leases,
    List<MaintenanceWorkOrder>? maintenanceWorkOrders,
    Property? property,
    User? user,
  }) {
    return Tenant(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      leaseStartDate: leaseStartDate ?? this.leaseStartDate,
      leaseEndDate: leaseEndDate ?? this.leaseEndDate,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      propertyId: propertyId ?? this.propertyId,
      isActive: isActive ?? this.isActive,
      contracts: contracts ?? this.contracts,
      expenses: expenses ?? this.expenses,
      increases: increases ?? this.increases,
      notifications: notifications ?? this.notifications,
      payments: payments ?? this.payments,
      reports: reports ?? this.reports,
      leases: leases ?? this.leases,
      maintenanceWorkOrders: maintenanceWorkOrders ?? this.maintenanceWorkOrders,
      property: property ?? this.property,
      user: user ?? this.user,
    );
  }
}
