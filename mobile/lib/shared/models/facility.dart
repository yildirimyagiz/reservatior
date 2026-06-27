import 'agency.dart';
import 'expense.dart';
import 'extra_charge.dart';
import 'facility_block.dart';
import 'included_service.dart';
import 'organization.dart';
import 'property.dart';
import 'shared_amenity.dart';

class Facility {
  final String id;
  final String orgId;
  final String propertyId;
  final String name;
  final double? feeAmount;
  final String? feeCurrency;
  final String? notes;
  final String? createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final Organization org;
  final Property property;
  final List<Agency> agencies;
  final List<Expense> expenses;
  final List<ExtraCharge> extraCharges;
  final List<FacilityBlock> facilityBlocks;
  final List<IncludedService> includedServices;
  final List<SharedAmenity> sharedAmenities;

  const Facility({
    required this.id,
    required this.orgId,
    required this.propertyId,
    required this.name,
    this.feeAmount,
    this.feeCurrency,
    this.notes,
    this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.org,
    required this.property,
    this.agencies = const [],
    this.expenses = const [],
    this.extraCharges = const [],
    this.facilityBlocks = const [],
    this.includedServices = const [],
    this.sharedAmenities = const [],
  });

  factory Facility.fromJson(Map<String, dynamic> json) {
    return Facility(
      id: json['id'] as String,
      orgId: json['orgId'] as String,
      propertyId: json['propertyId'] as String,
      name: json['name'] as String,
      feeAmount: (json['feeAmount'] as num?)?.toDouble(),
      feeCurrency: json['feeCurrency'] as String?,
      notes: json['notes'] as String?,
      createdBy: json['createdBy'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      org: Organization.fromJson(json['org'] as Map<String, dynamic>),
      property: Property.fromJson(json['property'] as Map<String, dynamic>),
      agencies: (json['agencies'] as List<dynamic>?)?.map((e) => Agency.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      expenses: (json['expenses'] as List<dynamic>?)?.map((e) => Expense.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      extraCharges: (json['extraCharges'] as List<dynamic>?)?.map((e) => ExtraCharge.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      facilityBlocks: (json['facilityBlocks'] as List<dynamic>?)?.map((e) => FacilityBlock.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      includedServices: (json['includedServices'] as List<dynamic>?)?.map((e) => IncludedService.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      sharedAmenities: (json['sharedAmenities'] as List<dynamic>?)?.map((e) => SharedAmenity.fromJson(e as Map<String, dynamic>)).toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'propertyId': propertyId,
      'name': name,
      'feeAmount': feeAmount,
      'feeCurrency': feeCurrency,
      'notes': notes,
      'createdBy': createdBy,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'org': org.toJson(),
      'property': property.toJson(),
      'agencies': agencies.map((e) => e.toJson()).toList(),
      'expenses': expenses.map((e) => e.toJson()).toList(),
      'extraCharges': extraCharges.map((e) => e.toJson()).toList(),
      'facilityBlocks': facilityBlocks.map((e) => e.toJson()).toList(),
      'includedServices': includedServices.map((e) => e.toJson()).toList(),
      'sharedAmenities': sharedAmenities.map((e) => e.toJson()).toList(),
    };
  }

  Facility copyWith({
    String? id,
    String? orgId,
    String? propertyId,
    String? name,
    double? feeAmount,
    String? feeCurrency,
    String? notes,
    String? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    Organization? org,
    Property? property,
    List<Agency>? agencies,
    List<Expense>? expenses,
    List<ExtraCharge>? extraCharges,
    List<FacilityBlock>? facilityBlocks,
    List<IncludedService>? includedServices,
    List<SharedAmenity>? sharedAmenities,
  }) {
    return Facility(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      propertyId: propertyId ?? this.propertyId,
      name: name ?? this.name,
      feeAmount: feeAmount ?? this.feeAmount,
      feeCurrency: feeCurrency ?? this.feeCurrency,
      notes: notes ?? this.notes,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      org: org ?? this.org,
      property: property ?? this.property,
      agencies: agencies ?? this.agencies,
      expenses: expenses ?? this.expenses,
      extraCharges: extraCharges ?? this.extraCharges,
      facilityBlocks: facilityBlocks ?? this.facilityBlocks,
      includedServices: includedServices ?? this.includedServices,
      sharedAmenities: sharedAmenities ?? this.sharedAmenities,
    );
  }
}
