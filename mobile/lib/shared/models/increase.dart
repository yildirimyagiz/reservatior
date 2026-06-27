import 'package:reservatior/shared/enums/increase_status.dart';
import 'contract.dart';
import 'offer.dart';
import 'property.dart';
import 'tenant.dart';

class Increase {
  final String id;
  final String propertyId;
  final String tenantId;
  final String proposedBy;
  final double oldRent;
  final double newRent;
  final DateTime effectiveDate;
  final IncreaseStatus status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String? contractId;
  final Contract? contract;
  final Property property;
  final Tenant tenant;
  final Offer? offer;

  const Increase({
    required this.id,
    required this.propertyId,
    required this.tenantId,
    required this.proposedBy,
    required this.oldRent,
    required this.newRent,
    required this.effectiveDate,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.contractId,
    this.contract,
    required this.property,
    required this.tenant,
    this.offer,
  });

  factory Increase.fromJson(Map<String, dynamic> json) {
    return Increase(
      id: json['id'] as String,
      propertyId: json['propertyId'] as String,
      tenantId: json['tenantId'] as String,
      proposedBy: json['proposedBy'] as String,
      oldRent: (json['oldRent'] as num).toDouble(),
      newRent: (json['newRent'] as num).toDouble(),
      effectiveDate: DateTime.parse(json['effectiveDate'] as String),
      status: IncreaseStatus.values.firstWhere((v) => v.name == json['status']),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      contractId: json['contractId'] as String?,
      contract: json['Contract'] != null ? Contract.fromJson(json['Contract'] as Map<String, dynamic>) : null,
      property: Property.fromJson(json['Property'] as Map<String, dynamic>),
      tenant: Tenant.fromJson(json['Tenant'] as Map<String, dynamic>),
      offer: json['Offer'] != null ? Offer.fromJson(json['Offer'] as Map<String, dynamic>) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'propertyId': propertyId,
      'tenantId': tenantId,
      'proposedBy': proposedBy,
      'oldRent': oldRent,
      'newRent': newRent,
      'effectiveDate': effectiveDate.toIso8601String(),
      'status': status.name,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'contractId': contractId,
      'Contract': contract?.toJson(),
      'Property': property.toJson(),
      'Tenant': tenant.toJson(),
      'Offer': offer?.toJson(),
    };
  }

  Increase copyWith({
    String? id,
    String? propertyId,
    String? tenantId,
    String? proposedBy,
    double? oldRent,
    double? newRent,
    DateTime? effectiveDate,
    IncreaseStatus? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    String? contractId,
    Contract? contract,
    Property? property,
    Tenant? tenant,
    Offer? offer,
  }) {
    return Increase(
      id: id ?? this.id,
      propertyId: propertyId ?? this.propertyId,
      tenantId: tenantId ?? this.tenantId,
      proposedBy: proposedBy ?? this.proposedBy,
      oldRent: oldRent ?? this.oldRent,
      newRent: newRent ?? this.newRent,
      effectiveDate: effectiveDate ?? this.effectiveDate,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      contractId: contractId ?? this.contractId,
      contract: contract ?? this.contract,
      property: property ?? this.property,
      tenant: tenant ?? this.tenant,
      offer: offer ?? this.offer,
    );
  }
}
