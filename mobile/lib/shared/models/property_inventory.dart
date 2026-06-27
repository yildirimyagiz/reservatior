import 'lease.dart';
import 'organization.dart';
import 'property.dart';

class PropertyInventory {
  final String id;
  final String orgId;
  final String propertyId;
  final String? leaseId;
  final String inventoryType;
  final DateTime inventoryDate;
  final String conductedBy;
  final List<String> presentAtCheck;
  final String overallCondition;
  final bool cleaningRequired;
  final String? tenantSignature;
  final String? landlordSignature;
  final String? agentSignature;
  final String? reportUrl;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Lease? lease;
  final Organization org;
  final Property property;

  const PropertyInventory({
    required this.id,
    required this.orgId,
    required this.propertyId,
    this.leaseId,
    required this.inventoryType,
    required this.inventoryDate,
    required this.conductedBy,
    this.presentAtCheck = const [],
    required this.overallCondition,
    required this.cleaningRequired,
    this.tenantSignature,
    this.landlordSignature,
    this.agentSignature,
    this.reportUrl,
    required this.createdAt,
    required this.updatedAt,
    this.lease,
    required this.org,
    required this.property,
  });

  factory PropertyInventory.fromJson(Map<String, dynamic> json) {
    return PropertyInventory(
      id: json['id'] as String,
      orgId: json['orgId'] as String,
      propertyId: json['propertyId'] as String,
      leaseId: json['leaseId'] as String?,
      inventoryType: json['inventoryType'] as String,
      inventoryDate: DateTime.parse(json['inventoryDate'] as String),
      conductedBy: json['conductedBy'] as String,
      presentAtCheck: (json['presentAtCheck'] as List<dynamic>?)?.cast<String>() ?? [],
      overallCondition: json['overallCondition'] as String,
      cleaningRequired: json['cleaningRequired'] as bool,
      tenantSignature: json['tenantSignature'] as String?,
      landlordSignature: json['landlordSignature'] as String?,
      agentSignature: json['agentSignature'] as String?,
      reportUrl: json['reportUrl'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      lease: json['lease'] != null ? Lease.fromJson(json['lease'] as Map<String, dynamic>) : null,
      org: Organization.fromJson(json['org'] as Map<String, dynamic>),
      property: Property.fromJson(json['property'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'propertyId': propertyId,
      'leaseId': leaseId,
      'inventoryType': inventoryType,
      'inventoryDate': inventoryDate.toIso8601String(),
      'conductedBy': conductedBy,
      'presentAtCheck': presentAtCheck,
      'overallCondition': overallCondition,
      'cleaningRequired': cleaningRequired,
      'tenantSignature': tenantSignature,
      'landlordSignature': landlordSignature,
      'agentSignature': agentSignature,
      'reportUrl': reportUrl,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'lease': lease?.toJson(),
      'org': org.toJson(),
      'property': property.toJson(),
    };
  }

  PropertyInventory copyWith({
    String? id,
    String? orgId,
    String? propertyId,
    String? leaseId,
    String? inventoryType,
    DateTime? inventoryDate,
    String? conductedBy,
    List<String>? presentAtCheck,
    String? overallCondition,
    bool? cleaningRequired,
    String? tenantSignature,
    String? landlordSignature,
    String? agentSignature,
    String? reportUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
    Lease? lease,
    Organization? org,
    Property? property,
  }) {
    return PropertyInventory(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      propertyId: propertyId ?? this.propertyId,
      leaseId: leaseId ?? this.leaseId,
      inventoryType: inventoryType ?? this.inventoryType,
      inventoryDate: inventoryDate ?? this.inventoryDate,
      conductedBy: conductedBy ?? this.conductedBy,
      presentAtCheck: presentAtCheck ?? this.presentAtCheck,
      overallCondition: overallCondition ?? this.overallCondition,
      cleaningRequired: cleaningRequired ?? this.cleaningRequired,
      tenantSignature: tenantSignature ?? this.tenantSignature,
      landlordSignature: landlordSignature ?? this.landlordSignature,
      agentSignature: agentSignature ?? this.agentSignature,
      reportUrl: reportUrl ?? this.reportUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      lease: lease ?? this.lease,
      org: org ?? this.org,
      property: property ?? this.property,
    );
  }
}
