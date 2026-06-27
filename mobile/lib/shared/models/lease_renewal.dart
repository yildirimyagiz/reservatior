import 'package:reservatior/shared/enums/renewal_status.dart';
import 'lease.dart';
import 'listing.dart';
import 'organization.dart';

class LeaseRenewal {
  final String id;
  final String leaseId;
  final RenewalStatus status;
  final double? proposedRent;
  final DateTime renewalDate;
  final DateTime? responseDeadline;
  final String? organizationId;
  final String? listingId;
  final Lease lease;
  final Listing? listing;
  final Organization? organization;

  const LeaseRenewal({
    required this.id,
    required this.leaseId,
    required this.status,
    this.proposedRent,
    required this.renewalDate,
    this.responseDeadline,
    this.organizationId,
    this.listingId,
    required this.lease,
    this.listing,
    this.organization,
  });

  factory LeaseRenewal.fromJson(Map<String, dynamic> json) {
    return LeaseRenewal(
      id: json['id'] as String,
      leaseId: json['leaseId'] as String,
      status: RenewalStatus.values.firstWhere((v) => v.name == json['status']),
      proposedRent: (json['proposedRent'] as num?)?.toDouble(),
      renewalDate: DateTime.parse(json['renewalDate'] as String),
      responseDeadline: json['responseDeadline'] != null ? DateTime.parse(json['responseDeadline'] as String) : null,
      organizationId: json['organizationId'] as String?,
      listingId: json['listingId'] as String?,
      lease: Lease.fromJson(json['lease'] as Map<String, dynamic>),
      listing: json['listing'] != null ? Listing.fromJson(json['listing'] as Map<String, dynamic>) : null,
      organization: json['organization'] != null ? Organization.fromJson(json['organization'] as Map<String, dynamic>) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'leaseId': leaseId,
      'status': status.name,
      'proposedRent': proposedRent,
      'renewalDate': renewalDate.toIso8601String(),
      'responseDeadline': responseDeadline?.toIso8601String(),
      'organizationId': organizationId,
      'listingId': listingId,
      'lease': lease.toJson(),
      'listing': listing?.toJson(),
      'organization': organization?.toJson(),
    };
  }

  LeaseRenewal copyWith({
    String? id,
    String? leaseId,
    RenewalStatus? status,
    double? proposedRent,
    DateTime? renewalDate,
    DateTime? responseDeadline,
    String? organizationId,
    String? listingId,
    Lease? lease,
    Listing? listing,
    Organization? organization,
  }) {
    return LeaseRenewal(
      id: id ?? this.id,
      leaseId: leaseId ?? this.leaseId,
      status: status ?? this.status,
      proposedRent: proposedRent ?? this.proposedRent,
      renewalDate: renewalDate ?? this.renewalDate,
      responseDeadline: responseDeadline ?? this.responseDeadline,
      organizationId: organizationId ?? this.organizationId,
      listingId: listingId ?? this.listingId,
      lease: lease ?? this.lease,
      listing: listing ?? this.listing,
      organization: organization ?? this.organization,
    );
  }
}
