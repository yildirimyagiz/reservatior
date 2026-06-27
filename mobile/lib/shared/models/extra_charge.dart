import 'package:reservatior/shared/enums/facility_amenities.dart';
import 'package:reservatior/shared/enums/location_amenities.dart';
import 'agency.dart';
import 'expense.dart';
import 'facility.dart';
import 'included_service.dart';
import 'payment.dart';
import 'property.dart';
import 'report.dart';
import 'reservation.dart';
import 'task.dart';
import 'user.dart';

class ExtraCharge {
  final String id;
  final String reservationId;
  final String name;
  final String? description;
  final double amount;
  final String chargeType;
  final bool isPaid;
  final String? icon;
  final String? logo;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final List<FacilityAmenities> facilityAmenities;
  final List<LocationAmenities> locationAmenities;
  final String? facilityId;
  final String? includedServiceId;
  final List<Agency> agencies;
  final List<Expense> expenses;
  final Facility? facility;
  final IncludedService? includedService;
  final List<Payment> payment;
  final List<Property> properties;
  final List<Report> reports;
  final List<Task> tasks;
  final List<User> users;
  final Reservation reservation;

  const ExtraCharge({
    required this.id,
    required this.reservationId,
    required this.name,
    this.description,
    required this.amount,
    required this.chargeType,
    required this.isPaid,
    this.icon,
    this.logo,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.facilityAmenities = const [],
    this.locationAmenities = const [],
    this.facilityId,
    this.includedServiceId,
    this.agencies = const [],
    this.expenses = const [],
    this.facility,
    this.includedService,
    this.payment = const [],
    this.properties = const [],
    this.reports = const [],
    this.tasks = const [],
    this.users = const [],
    required this.reservation,
  });

  factory ExtraCharge.fromJson(Map<String, dynamic> json) {
    return ExtraCharge(
      id: json['id'] as String,
      reservationId: json['reservationId'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      amount: (json['amount'] as num).toDouble(),
      chargeType: json['chargeType'] as String,
      isPaid: json['isPaid'] as bool,
      icon: json['icon'] as String?,
      logo: json['logo'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      facilityAmenities: (json['facilityAmenities'] as List<dynamic>?)?.map((e) => FacilityAmenities.values.firstWhere((v) => v.name == e)).toList() ?? [],
      locationAmenities: (json['locationAmenities'] as List<dynamic>?)?.map((e) => LocationAmenities.values.firstWhere((v) => v.name == e)).toList() ?? [],
      facilityId: json['facilityId'] as String?,
      includedServiceId: json['includedServiceId'] as String?,
      agencies: (json['agencies'] as List<dynamic>?)?.map((e) => Agency.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      expenses: (json['expenses'] as List<dynamic>?)?.map((e) => Expense.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      facility: json['Facility'] != null ? Facility.fromJson(json['Facility'] as Map<String, dynamic>) : null,
      includedService: json['IncludedService'] != null ? IncludedService.fromJson(json['IncludedService'] as Map<String, dynamic>) : null,
      payment: (json['Payment'] as List<dynamic>?)?.map((e) => Payment.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      properties: (json['properties'] as List<dynamic>?)?.map((e) => Property.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      reports: (json['reports'] as List<dynamic>?)?.map((e) => Report.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      tasks: (json['tasks'] as List<dynamic>?)?.map((e) => Task.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      users: (json['users'] as List<dynamic>?)?.map((e) => User.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      reservation: Reservation.fromJson(json['Reservation'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'reservationId': reservationId,
      'name': name,
      'description': description,
      'amount': amount,
      'chargeType': chargeType,
      'isPaid': isPaid,
      'icon': icon,
      'logo': logo,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'facilityAmenities': facilityAmenities.map((e) => e.name).toList(),
      'locationAmenities': locationAmenities.map((e) => e.name).toList(),
      'facilityId': facilityId,
      'includedServiceId': includedServiceId,
      'agencies': agencies.map((e) => e.toJson()).toList(),
      'expenses': expenses.map((e) => e.toJson()).toList(),
      'Facility': facility?.toJson(),
      'IncludedService': includedService?.toJson(),
      'Payment': payment.map((e) => e.toJson()).toList(),
      'properties': properties.map((e) => e.toJson()).toList(),
      'reports': reports.map((e) => e.toJson()).toList(),
      'tasks': tasks.map((e) => e.toJson()).toList(),
      'users': users.map((e) => e.toJson()).toList(),
      'Reservation': reservation.toJson(),
    };
  }

  ExtraCharge copyWith({
    String? id,
    String? reservationId,
    String? name,
    String? description,
    double? amount,
    String? chargeType,
    bool? isPaid,
    String? icon,
    String? logo,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    List<FacilityAmenities>? facilityAmenities,
    List<LocationAmenities>? locationAmenities,
    String? facilityId,
    String? includedServiceId,
    List<Agency>? agencies,
    List<Expense>? expenses,
    Facility? facility,
    IncludedService? includedService,
    List<Payment>? payment,
    List<Property>? properties,
    List<Report>? reports,
    List<Task>? tasks,
    List<User>? users,
    Reservation? reservation,
  }) {
    return ExtraCharge(
      id: id ?? this.id,
      reservationId: reservationId ?? this.reservationId,
      name: name ?? this.name,
      description: description ?? this.description,
      amount: amount ?? this.amount,
      chargeType: chargeType ?? this.chargeType,
      isPaid: isPaid ?? this.isPaid,
      icon: icon ?? this.icon,
      logo: logo ?? this.logo,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      facilityAmenities: facilityAmenities ?? this.facilityAmenities,
      locationAmenities: locationAmenities ?? this.locationAmenities,
      facilityId: facilityId ?? this.facilityId,
      includedServiceId: includedServiceId ?? this.includedServiceId,
      agencies: agencies ?? this.agencies,
      expenses: expenses ?? this.expenses,
      facility: facility ?? this.facility,
      includedService: includedService ?? this.includedService,
      payment: payment ?? this.payment,
      properties: properties ?? this.properties,
      reports: reports ?? this.reports,
      tasks: tasks ?? this.tasks,
      users: users ?? this.users,
      reservation: reservation ?? this.reservation,
    );
  }
}
