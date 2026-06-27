import 'package:reservatior/shared/enums/listing_status.dart';
import 'listing.dart';
import 'organization.dart';

class ListingStatusHistory {
  final String id;
  final String orgId;
  final String listingId;
  final ListingStatus status;
  final DateTime fromDate;
  final DateTime? toDate;
  final String? reason;
  final String? createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final Listing listing;
  final Organization org;

  const ListingStatusHistory({
    required this.id,
    required this.orgId,
    required this.listingId,
    required this.status,
    required this.fromDate,
    this.toDate,
    this.reason,
    this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.listing,
    required this.org,
  });

  factory ListingStatusHistory.fromJson(Map<String, dynamic> json) {
    return ListingStatusHistory(
      id: json['id'] as String,
      orgId: json['orgId'] as String,
      listingId: json['listingId'] as String,
      status: ListingStatus.values.firstWhere((v) => v.name == json['status']),
      fromDate: DateTime.parse(json['fromDate'] as String),
      toDate: json['toDate'] != null ? DateTime.parse(json['toDate'] as String) : null,
      reason: json['reason'] as String?,
      createdBy: json['createdBy'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      listing: Listing.fromJson(json['listing'] as Map<String, dynamic>),
      org: Organization.fromJson(json['org'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'listingId': listingId,
      'status': status.name,
      'fromDate': fromDate.toIso8601String(),
      'toDate': toDate?.toIso8601String(),
      'reason': reason,
      'createdBy': createdBy,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'listing': listing.toJson(),
      'org': org.toJson(),
    };
  }

  ListingStatusHistory copyWith({
    String? id,
    String? orgId,
    String? listingId,
    ListingStatus? status,
    DateTime? fromDate,
    DateTime? toDate,
    String? reason,
    String? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    Listing? listing,
    Organization? org,
  }) {
    return ListingStatusHistory(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      listingId: listingId ?? this.listingId,
      status: status ?? this.status,
      fromDate: fromDate ?? this.fromDate,
      toDate: toDate ?? this.toDate,
      reason: reason ?? this.reason,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      listing: listing ?? this.listing,
      org: org ?? this.org,
    );
  }
}
