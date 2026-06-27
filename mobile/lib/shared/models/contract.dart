import 'package:reservatior/shared/enums/contract_status.dart';
import 'package:reservatior/shared/enums/contract_type.dart';
import 'agency.dart';
import 'booking.dart';
import 'contract_version.dart';
import 'document.dart';
import 'increase.dart';
import 'lease.dart';
import 'listing.dart';
import 'organization.dart';
import 'property.dart';
import 'signature_request.dart';
import 'task.dart';
import 'tenant.dart';

class Contract {
  final String id;
  final String orgId;
  final String? propertyId;
  final String? listingId;
  final String? leaseId;
  final String? bookingId;
  final ContractType type;
  final ContractStatus status;
  final String? title;
  final DateTime? effectiveFrom;
  final DateTime? effectiveTo;
  final DateTime? nextRenewalAt;
  final int? renewalNoticeDays;
  final String? createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final Booking? booking;
  final Lease? lease;
  final Listing? listing;
  final Organization org;
  final Property? property;
  final List<ContractVersion> versions;
  final List<Document> generalDocuments;
  final List<SignatureRequest> signatureRequests;
  final List<Task> tasks;
  final List<Agency> agencies;
  final List<Tenant> tenants;
  final List<Increase> increases;

  const Contract({
    required this.id,
    required this.orgId,
    this.propertyId,
    this.listingId,
    this.leaseId,
    this.bookingId,
    required this.type,
    required this.status,
    this.title,
    this.effectiveFrom,
    this.effectiveTo,
    this.nextRenewalAt,
    this.renewalNoticeDays,
    this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.booking,
    this.lease,
    this.listing,
    required this.org,
    this.property,
    this.versions = const [],
    this.generalDocuments = const [],
    this.signatureRequests = const [],
    this.tasks = const [],
    this.agencies = const [],
    this.tenants = const [],
    this.increases = const [],
  });

  factory Contract.fromJson(Map<String, dynamic> json) {
    return Contract(
      id: json['id'] as String,
      orgId: json['orgId'] as String,
      propertyId: json['propertyId'] as String?,
      listingId: json['listingId'] as String?,
      leaseId: json['leaseId'] as String?,
      bookingId: json['bookingId'] as String?,
      type: ContractType.values.firstWhere((v) => v.name == json['type']),
      status: ContractStatus.values.firstWhere((v) => v.name == json['status']),
      title: json['title'] as String?,
      effectiveFrom: json['effectiveFrom'] != null ? DateTime.parse(json['effectiveFrom'] as String) : null,
      effectiveTo: json['effectiveTo'] != null ? DateTime.parse(json['effectiveTo'] as String) : null,
      nextRenewalAt: json['nextRenewalAt'] != null ? DateTime.parse(json['nextRenewalAt'] as String) : null,
      renewalNoticeDays: json['renewalNoticeDays'] as int?,
      createdBy: json['createdBy'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      booking: json['booking'] != null ? Booking.fromJson(json['booking'] as Map<String, dynamic>) : null,
      lease: json['lease'] != null ? Lease.fromJson(json['lease'] as Map<String, dynamic>) : null,
      listing: json['listing'] != null ? Listing.fromJson(json['listing'] as Map<String, dynamic>) : null,
      org: Organization.fromJson(json['org'] as Map<String, dynamic>),
      property: json['property'] != null ? Property.fromJson(json['property'] as Map<String, dynamic>) : null,
      versions: (json['versions'] as List<dynamic>?)?.map((e) => ContractVersion.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      generalDocuments: (json['generalDocuments'] as List<dynamic>?)?.map((e) => Document.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      signatureRequests: (json['signatureRequests'] as List<dynamic>?)?.map((e) => SignatureRequest.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      tasks: (json['tasks'] as List<dynamic>?)?.map((e) => Task.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      agencies: (json['agencies'] as List<dynamic>?)?.map((e) => Agency.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      tenants: (json['tenants'] as List<dynamic>?)?.map((e) => Tenant.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      increases: (json['increases'] as List<dynamic>?)?.map((e) => Increase.fromJson(e as Map<String, dynamic>)).toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'propertyId': propertyId,
      'listingId': listingId,
      'leaseId': leaseId,
      'bookingId': bookingId,
      'type': type.name,
      'status': status.name,
      'title': title,
      'effectiveFrom': effectiveFrom?.toIso8601String(),
      'effectiveTo': effectiveTo?.toIso8601String(),
      'nextRenewalAt': nextRenewalAt?.toIso8601String(),
      'renewalNoticeDays': renewalNoticeDays,
      'createdBy': createdBy,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'booking': booking?.toJson(),
      'lease': lease?.toJson(),
      'listing': listing?.toJson(),
      'org': org.toJson(),
      'property': property?.toJson(),
      'versions': versions.map((e) => e.toJson()).toList(),
      'generalDocuments': generalDocuments.map((e) => e.toJson()).toList(),
      'signatureRequests': signatureRequests.map((e) => e.toJson()).toList(),
      'tasks': tasks.map((e) => e.toJson()).toList(),
      'agencies': agencies.map((e) => e.toJson()).toList(),
      'tenants': tenants.map((e) => e.toJson()).toList(),
      'increases': increases.map((e) => e.toJson()).toList(),
    };
  }

  Contract copyWith({
    String? id,
    String? orgId,
    String? propertyId,
    String? listingId,
    String? leaseId,
    String? bookingId,
    ContractType? type,
    ContractStatus? status,
    String? title,
    DateTime? effectiveFrom,
    DateTime? effectiveTo,
    DateTime? nextRenewalAt,
    int? renewalNoticeDays,
    String? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    Booking? booking,
    Lease? lease,
    Listing? listing,
    Organization? org,
    Property? property,
    List<ContractVersion>? versions,
    List<Document>? generalDocuments,
    List<SignatureRequest>? signatureRequests,
    List<Task>? tasks,
    List<Agency>? agencies,
    List<Tenant>? tenants,
    List<Increase>? increases,
  }) {
    return Contract(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      propertyId: propertyId ?? this.propertyId,
      listingId: listingId ?? this.listingId,
      leaseId: leaseId ?? this.leaseId,
      bookingId: bookingId ?? this.bookingId,
      type: type ?? this.type,
      status: status ?? this.status,
      title: title ?? this.title,
      effectiveFrom: effectiveFrom ?? this.effectiveFrom,
      effectiveTo: effectiveTo ?? this.effectiveTo,
      nextRenewalAt: nextRenewalAt ?? this.nextRenewalAt,
      renewalNoticeDays: renewalNoticeDays ?? this.renewalNoticeDays,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      booking: booking ?? this.booking,
      lease: lease ?? this.lease,
      listing: listing ?? this.listing,
      org: org ?? this.org,
      property: property ?? this.property,
      versions: versions ?? this.versions,
      generalDocuments: generalDocuments ?? this.generalDocuments,
      signatureRequests: signatureRequests ?? this.signatureRequests,
      tasks: tasks ?? this.tasks,
      agencies: agencies ?? this.agencies,
      tenants: tenants ?? this.tenants,
      increases: increases ?? this.increases,
    );
  }
}
