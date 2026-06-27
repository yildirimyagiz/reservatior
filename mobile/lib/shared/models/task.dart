import 'package:reservatior/shared/enums/priority.dart';
import 'package:reservatior/shared/enums/task_status.dart';
import 'package:reservatior/shared/enums/task_type.dart';
import 'agency.dart';
import 'agent.dart';
import 'analytics.dart';
import 'attachment.dart';
import 'booking.dart';
import 'contact.dart';
import 'contract.dart';
import 'extra_charge.dart';
import 'included_service.dart';
import 'lease.dart';
import 'listing.dart';
import 'mention.dart';
import 'organization.dart';
import 'project.dart';
import 'property.dart';
import 'reservation.dart';
import 'user.dart';

class Task {
  final String id;
  final String orgId;
  final String? propertyId;
  final String? listingId;
  final String? leaseId;
  final String? bookingId;
  final String? contractId;
  final String? reservationId;
  final String? projectId;
  final TaskType type;
  final TaskStatus status;
  final Priority priority;
  final String title;
  final String? description;
  final DateTime? dueAt;
  final int? slaHours;
  final String? assignedToUserId;
  final String? assignedToContactId;
  final String? createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final List<Attachment> attachments;
  final Contact? assignedContact;
  final User? assignedUser;
  final Booking? booking;
  final Contract? contract;
  final Lease? lease;
  final Listing? listing;
  final Organization org;
  final Project? project;
  final Property? property;
  final Reservation? reservation;
  final List<Agent> agents;
  final List<ExtraCharge> extraCharges;
  final List<Agency> agencies;
  final List<IncludedService> includedServices;
  final List<Analytics> analytics;
  final List<Mention> mentions;

  const Task({
    required this.id,
    required this.orgId,
    this.propertyId,
    this.listingId,
    this.leaseId,
    this.bookingId,
    this.contractId,
    this.reservationId,
    this.projectId,
    required this.type,
    required this.status,
    required this.priority,
    required this.title,
    this.description,
    this.dueAt,
    this.slaHours,
    this.assignedToUserId,
    this.assignedToContactId,
    this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.attachments = const [],
    this.assignedContact,
    this.assignedUser,
    this.booking,
    this.contract,
    this.lease,
    this.listing,
    required this.org,
    this.project,
    this.property,
    this.reservation,
    this.agents = const [],
    this.extraCharges = const [],
    this.agencies = const [],
    this.includedServices = const [],
    this.analytics = const [],
    this.mentions = const [],
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'] as String,
      orgId: json['orgId'] as String,
      propertyId: json['propertyId'] as String?,
      listingId: json['listingId'] as String?,
      leaseId: json['leaseId'] as String?,
      bookingId: json['bookingId'] as String?,
      contractId: json['contractId'] as String?,
      reservationId: json['reservationId'] as String?,
      projectId: json['projectId'] as String?,
      type: TaskType.values.firstWhere((v) => v.name == json['type']),
      status: TaskStatus.values.firstWhere((v) => v.name == json['status']),
      priority: Priority.values.firstWhere((v) => v.name == json['priority']),
      title: json['title'] as String,
      description: json['description'] as String?,
      dueAt: json['dueAt'] != null ? DateTime.parse(json['dueAt'] as String) : null,
      slaHours: json['slaHours'] as int?,
      assignedToUserId: json['assignedToUserId'] as String?,
      assignedToContactId: json['assignedToContactId'] as String?,
      createdBy: json['createdBy'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      attachments: (json['attachments'] as List<dynamic>?)?.map((e) => Attachment.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      assignedContact: json['assignedContact'] != null ? Contact.fromJson(json['assignedContact'] as Map<String, dynamic>) : null,
      assignedUser: json['assignedUser'] != null ? User.fromJson(json['assignedUser'] as Map<String, dynamic>) : null,
      booking: json['booking'] != null ? Booking.fromJson(json['booking'] as Map<String, dynamic>) : null,
      contract: json['contract'] != null ? Contract.fromJson(json['contract'] as Map<String, dynamic>) : null,
      lease: json['lease'] != null ? Lease.fromJson(json['lease'] as Map<String, dynamic>) : null,
      listing: json['listing'] != null ? Listing.fromJson(json['listing'] as Map<String, dynamic>) : null,
      org: Organization.fromJson(json['org'] as Map<String, dynamic>),
      project: json['project'] != null ? Project.fromJson(json['project'] as Map<String, dynamic>) : null,
      property: json['property'] != null ? Property.fromJson(json['property'] as Map<String, dynamic>) : null,
      reservation: json['reservation'] != null ? Reservation.fromJson(json['reservation'] as Map<String, dynamic>) : null,
      agents: (json['agents'] as List<dynamic>?)?.map((e) => Agent.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      extraCharges: (json['extraCharges'] as List<dynamic>?)?.map((e) => ExtraCharge.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      agencies: (json['agencies'] as List<dynamic>?)?.map((e) => Agency.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      includedServices: (json['includedServices'] as List<dynamic>?)?.map((e) => IncludedService.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      analytics: (json['analytics'] as List<dynamic>?)?.map((e) => Analytics.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      mentions: (json['mentions'] as List<dynamic>?)?.map((e) => Mention.fromJson(e as Map<String, dynamic>)).toList() ?? [],
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
      'contractId': contractId,
      'reservationId': reservationId,
      'projectId': projectId,
      'type': type.name,
      'status': status.name,
      'priority': priority.name,
      'title': title,
      'description': description,
      'dueAt': dueAt?.toIso8601String(),
      'slaHours': slaHours,
      'assignedToUserId': assignedToUserId,
      'assignedToContactId': assignedToContactId,
      'createdBy': createdBy,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'attachments': attachments.map((e) => e.toJson()).toList(),
      'assignedContact': assignedContact?.toJson(),
      'assignedUser': assignedUser?.toJson(),
      'booking': booking?.toJson(),
      'contract': contract?.toJson(),
      'lease': lease?.toJson(),
      'listing': listing?.toJson(),
      'org': org.toJson(),
      'project': project?.toJson(),
      'property': property?.toJson(),
      'reservation': reservation?.toJson(),
      'agents': agents.map((e) => e.toJson()).toList(),
      'extraCharges': extraCharges.map((e) => e.toJson()).toList(),
      'agencies': agencies.map((e) => e.toJson()).toList(),
      'includedServices': includedServices.map((e) => e.toJson()).toList(),
      'analytics': analytics.map((e) => e.toJson()).toList(),
      'mentions': mentions.map((e) => e.toJson()).toList(),
    };
  }

  Task copyWith({
    String? id,
    String? orgId,
    String? propertyId,
    String? listingId,
    String? leaseId,
    String? bookingId,
    String? contractId,
    String? reservationId,
    String? projectId,
    TaskType? type,
    TaskStatus? status,
    Priority? priority,
    String? title,
    String? description,
    DateTime? dueAt,
    int? slaHours,
    String? assignedToUserId,
    String? assignedToContactId,
    String? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    List<Attachment>? attachments,
    Contact? assignedContact,
    User? assignedUser,
    Booking? booking,
    Contract? contract,
    Lease? lease,
    Listing? listing,
    Organization? org,
    Project? project,
    Property? property,
    Reservation? reservation,
    List<Agent>? agents,
    List<ExtraCharge>? extraCharges,
    List<Agency>? agencies,
    List<IncludedService>? includedServices,
    List<Analytics>? analytics,
    List<Mention>? mentions,
  }) {
    return Task(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      propertyId: propertyId ?? this.propertyId,
      listingId: listingId ?? this.listingId,
      leaseId: leaseId ?? this.leaseId,
      bookingId: bookingId ?? this.bookingId,
      contractId: contractId ?? this.contractId,
      reservationId: reservationId ?? this.reservationId,
      projectId: projectId ?? this.projectId,
      type: type ?? this.type,
      status: status ?? this.status,
      priority: priority ?? this.priority,
      title: title ?? this.title,
      description: description ?? this.description,
      dueAt: dueAt ?? this.dueAt,
      slaHours: slaHours ?? this.slaHours,
      assignedToUserId: assignedToUserId ?? this.assignedToUserId,
      assignedToContactId: assignedToContactId ?? this.assignedToContactId,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      attachments: attachments ?? this.attachments,
      assignedContact: assignedContact ?? this.assignedContact,
      assignedUser: assignedUser ?? this.assignedUser,
      booking: booking ?? this.booking,
      contract: contract ?? this.contract,
      lease: lease ?? this.lease,
      listing: listing ?? this.listing,
      org: org ?? this.org,
      project: project ?? this.project,
      property: property ?? this.property,
      reservation: reservation ?? this.reservation,
      agents: agents ?? this.agents,
      extraCharges: extraCharges ?? this.extraCharges,
      agencies: agencies ?? this.agencies,
      includedServices: includedServices ?? this.includedServices,
      analytics: analytics ?? this.analytics,
      mentions: mentions ?? this.mentions,
    );
  }
}
