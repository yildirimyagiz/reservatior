import 'contact.dart';
import 'listing.dart';
import 'organization.dart';
import 'property.dart';
import 'user.dart';

class Appointment {
  final String id;
  final String orgId;
  final String? propertyId;
  final String? listingId;
  final String? contactId;
  final String title;
  final String? description;
  final String appointmentType;
  final DateTime startDate;
  final DateTime endDate;
  final String timezone;
  final String status;
  final String? location;
  final String? assignedToUserId;
  final String? assignedToContactId;
  final String? notes;
  final String? createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final Contact? assignedContact;
  final User? assignedUser;
  final Contact? contact;
  final Listing? listing;
  final Organization org;
  final Property? property;

  const Appointment({
    required this.id,
    required this.orgId,
    this.propertyId,
    this.listingId,
    this.contactId,
    required this.title,
    this.description,
    required this.appointmentType,
    required this.startDate,
    required this.endDate,
    required this.timezone,
    required this.status,
    this.location,
    this.assignedToUserId,
    this.assignedToContactId,
    this.notes,
    this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.assignedContact,
    this.assignedUser,
    this.contact,
    this.listing,
    required this.org,
    this.property,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id: json['id'] as String,
      orgId: json['orgId'] as String,
      propertyId: json['propertyId'] as String?,
      listingId: json['listingId'] as String?,
      contactId: json['contactId'] as String?,
      title: json['title'] as String,
      description: json['description'] as String?,
      appointmentType: json['appointmentType'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      timezone: json['timezone'] as String,
      status: json['status'] as String,
      location: json['location'] as String?,
      assignedToUserId: json['assignedToUserId'] as String?,
      assignedToContactId: json['assignedToContactId'] as String?,
      notes: json['notes'] as String?,
      createdBy: json['createdBy'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      assignedContact: json['assignedContact'] != null ? Contact.fromJson(json['assignedContact'] as Map<String, dynamic>) : null,
      assignedUser: json['assignedUser'] != null ? User.fromJson(json['assignedUser'] as Map<String, dynamic>) : null,
      contact: json['contact'] != null ? Contact.fromJson(json['contact'] as Map<String, dynamic>) : null,
      listing: json['listing'] != null ? Listing.fromJson(json['listing'] as Map<String, dynamic>) : null,
      org: Organization.fromJson(json['org'] as Map<String, dynamic>),
      property: json['property'] != null ? Property.fromJson(json['property'] as Map<String, dynamic>) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'propertyId': propertyId,
      'listingId': listingId,
      'contactId': contactId,
      'title': title,
      'description': description,
      'appointmentType': appointmentType,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'timezone': timezone,
      'status': status,
      'location': location,
      'assignedToUserId': assignedToUserId,
      'assignedToContactId': assignedToContactId,
      'notes': notes,
      'createdBy': createdBy,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'assignedContact': assignedContact?.toJson(),
      'assignedUser': assignedUser?.toJson(),
      'contact': contact?.toJson(),
      'listing': listing?.toJson(),
      'org': org.toJson(),
      'property': property?.toJson(),
    };
  }

  Appointment copyWith({
    String? id,
    String? orgId,
    String? propertyId,
    String? listingId,
    String? contactId,
    String? title,
    String? description,
    String? appointmentType,
    DateTime? startDate,
    DateTime? endDate,
    String? timezone,
    String? status,
    String? location,
    String? assignedToUserId,
    String? assignedToContactId,
    String? notes,
    String? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    Contact? assignedContact,
    User? assignedUser,
    Contact? contact,
    Listing? listing,
    Organization? org,
    Property? property,
  }) {
    return Appointment(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      propertyId: propertyId ?? this.propertyId,
      listingId: listingId ?? this.listingId,
      contactId: contactId ?? this.contactId,
      title: title ?? this.title,
      description: description ?? this.description,
      appointmentType: appointmentType ?? this.appointmentType,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      timezone: timezone ?? this.timezone,
      status: status ?? this.status,
      location: location ?? this.location,
      assignedToUserId: assignedToUserId ?? this.assignedToUserId,
      assignedToContactId: assignedToContactId ?? this.assignedToContactId,
      notes: notes ?? this.notes,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      assignedContact: assignedContact ?? this.assignedContact,
      assignedUser: assignedUser ?? this.assignedUser,
      contact: contact ?? this.contact,
      listing: listing ?? this.listing,
      org: org ?? this.org,
      property: property ?? this.property,
    );
  }
}
