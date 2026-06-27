import 'package:reservatior/shared/enums/facility_amenities.dart';
import 'package:reservatior/shared/enums/location_amenities.dart';
import 'agency.dart';
import 'expense.dart';
import 'extra_charge.dart';
import 'facility.dart';
import 'payment.dart';
import 'property.dart';
import 'report.dart';
import 'task.dart';
import 'user.dart';

class IncludedService {
  final String id;
  final String propertyId;
  final String name;
  final String? description;
  final double? value;
  final bool isRecurring;
  final String frequency;
  final String? icon;
  final String? logo;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final List<FacilityAmenities> facilityAmenities;
  final List<LocationAmenities> locationAmenities;
  final String? facilityId;
  final List<Agency> agencies;
  final List<Expense> expenses;
  final List<ExtraCharge> extraCharges;
  final Facility? facility;
  final List<Payment> payment;
  final List<Property> properties;
  final List<Report> reports;
  final List<Task> tasks;
  final List<User> users;
  final Property property;

  const IncludedService({
    required this.id,
    required this.propertyId,
    required this.name,
    this.description,
    this.value,
    required this.isRecurring,
    required this.frequency,
    this.icon,
    this.logo,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.facilityAmenities = const [],
    this.locationAmenities = const [],
    this.facilityId,
    this.agencies = const [],
    this.expenses = const [],
    this.extraCharges = const [],
    this.facility,
    this.payment = const [],
    this.properties = const [],
    this.reports = const [],
    this.tasks = const [],
    this.users = const [],
    required this.property,
  });

  factory IncludedService.fromJson(Map<String, dynamic> json) {
    return IncludedService(
      id: json['id'] as String,
      propertyId: json['propertyId'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      value: (json['value'] as num?)?.toDouble(),
      isRecurring: json['isRecurring'] as bool,
      frequency: json['frequency'] as String,
      icon: json['icon'] as String?,
      logo: json['logo'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      facilityAmenities: (json['facilityAmenities'] as List<dynamic>?)?.map((e) => FacilityAmenities.values.firstWhere((v) => v.name == e)).toList() ?? [],
      locationAmenities: (json['locationAmenities'] as List<dynamic>?)?.map((e) => LocationAmenities.values.firstWhere((v) => v.name == e)).toList() ?? [],
      facilityId: json['facilityId'] as String?,
      agencies: (json['agencies'] as List<dynamic>?)?.map((e) => Agency.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      expenses: (json['expenses'] as List<dynamic>?)?.map((e) => Expense.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      extraCharges: (json['extraCharges'] as List<dynamic>?)?.map((e) => ExtraCharge.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      facility: json['Facility'] != null ? Facility.fromJson(json['Facility'] as Map<String, dynamic>) : null,
      payment: (json['Payment'] as List<dynamic>?)?.map((e) => Payment.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      properties: (json['properties'] as List<dynamic>?)?.map((e) => Property.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      reports: (json['reports'] as List<dynamic>?)?.map((e) => Report.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      tasks: (json['tasks'] as List<dynamic>?)?.map((e) => Task.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      users: (json['users'] as List<dynamic>?)?.map((e) => User.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      property: Property.fromJson(json['Property'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'propertyId': propertyId,
      'name': name,
      'description': description,
      'value': value,
      'isRecurring': isRecurring,
      'frequency': frequency,
      'icon': icon,
      'logo': logo,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'facilityAmenities': facilityAmenities.map((e) => e.name).toList(),
      'locationAmenities': locationAmenities.map((e) => e.name).toList(),
      'facilityId': facilityId,
      'agencies': agencies.map((e) => e.toJson()).toList(),
      'expenses': expenses.map((e) => e.toJson()).toList(),
      'extraCharges': extraCharges.map((e) => e.toJson()).toList(),
      'Facility': facility?.toJson(),
      'Payment': payment.map((e) => e.toJson()).toList(),
      'properties': properties.map((e) => e.toJson()).toList(),
      'reports': reports.map((e) => e.toJson()).toList(),
      'tasks': tasks.map((e) => e.toJson()).toList(),
      'users': users.map((e) => e.toJson()).toList(),
      'Property': property.toJson(),
    };
  }

  IncludedService copyWith({
    String? id,
    String? propertyId,
    String? name,
    String? description,
    double? value,
    bool? isRecurring,
    String? frequency,
    String? icon,
    String? logo,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    List<FacilityAmenities>? facilityAmenities,
    List<LocationAmenities>? locationAmenities,
    String? facilityId,
    List<Agency>? agencies,
    List<Expense>? expenses,
    List<ExtraCharge>? extraCharges,
    Facility? facility,
    List<Payment>? payment,
    List<Property>? properties,
    List<Report>? reports,
    List<Task>? tasks,
    List<User>? users,
    Property? property,
  }) {
    return IncludedService(
      id: id ?? this.id,
      propertyId: propertyId ?? this.propertyId,
      name: name ?? this.name,
      description: description ?? this.description,
      value: value ?? this.value,
      isRecurring: isRecurring ?? this.isRecurring,
      frequency: frequency ?? this.frequency,
      icon: icon ?? this.icon,
      logo: logo ?? this.logo,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      facilityAmenities: facilityAmenities ?? this.facilityAmenities,
      locationAmenities: locationAmenities ?? this.locationAmenities,
      facilityId: facilityId ?? this.facilityId,
      agencies: agencies ?? this.agencies,
      expenses: expenses ?? this.expenses,
      extraCharges: extraCharges ?? this.extraCharges,
      facility: facility ?? this.facility,
      payment: payment ?? this.payment,
      properties: properties ?? this.properties,
      reports: reports ?? this.reports,
      tasks: tasks ?? this.tasks,
      users: users ?? this.users,
      property: property ?? this.property,
    );
  }
}
