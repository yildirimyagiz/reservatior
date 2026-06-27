import 'package:reservatior/shared/enums/maintenance_block_type.dart';
import 'listing.dart';
import 'organization.dart';
import 'property.dart';

class MaintenanceBlock {
  final String id;
  final String orgId;
  final String propertyId;
  final String? listingId;
  final MaintenanceBlockType type;
  final DateTime startDate;
  final DateTime endDate;
  final String? reason;
  final String? createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final Listing? listing;
  final Organization org;
  final Property property;

  const MaintenanceBlock({
    required this.id,
    required this.orgId,
    required this.propertyId,
    this.listingId,
    required this.type,
    required this.startDate,
    required this.endDate,
    this.reason,
    this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.listing,
    required this.org,
    required this.property,
  });

  factory MaintenanceBlock.fromJson(Map<String, dynamic> json) {
    return MaintenanceBlock(
      id: json['id'] as String,
      orgId: json['orgId'] as String,
      propertyId: json['propertyId'] as String,
      listingId: json['listingId'] as String?,
      type: (() {
        final valUpper = json['type']?.toString().toUpperCase() ?? '';
        return MaintenanceBlockType.values.firstWhere(
          (v) => v.name.toUpperCase() == valUpper,
          orElse: () => MaintenanceBlockType.MAINTENANCE,
        );
      })(),
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      reason: json['reason'] as String?,
      createdBy: json['createdBy'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      listing: json['listing'] != null ? Listing.fromJson(json['listing'] as Map<String, dynamic>) : null,
      org: Organization.fromJson(json['org'] as Map<String, dynamic>),
      property: Property.fromJson(json['property'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'propertyId': propertyId,
      'listingId': listingId,
      'type': type.name,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'reason': reason,
      'createdBy': createdBy,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'listing': listing?.toJson(),
      'org': org.toJson(),
      'property': property.toJson(),
    };
  }

  MaintenanceBlock copyWith({
    String? id,
    String? orgId,
    String? propertyId,
    String? listingId,
    MaintenanceBlockType? type,
    DateTime? startDate,
    DateTime? endDate,
    String? reason,
    String? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    Listing? listing,
    Organization? org,
    Property? property,
  }) {
    return MaintenanceBlock(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      propertyId: propertyId ?? this.propertyId,
      listingId: listingId ?? this.listingId,
      type: type ?? this.type,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      reason: reason ?? this.reason,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      listing: listing ?? this.listing,
      org: org ?? this.org,
      property: property ?? this.property,
    );
  }
}
