import 'contact.dart';
import 'event.dart';
import 'organization.dart';
import 'user.dart';

class EventAttendee {
  final String id;
  final String orgId;
  final String eventId;
  final String? contactId;
  final String? userId;
  final String rsvpStatus;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final Contact? contact;
  final Event event;
  final Organization org;
  final User? user;

  const EventAttendee({
    required this.id,
    required this.orgId,
    required this.eventId,
    this.contactId,
    this.userId,
    required this.rsvpStatus,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.contact,
    required this.event,
    required this.org,
    this.user,
  });

  factory EventAttendee.fromJson(Map<String, dynamic> json) {
    return EventAttendee(
      id: json['id'] as String,
      orgId: json['orgId'] as String,
      eventId: json['eventId'] as String,
      contactId: json['contactId'] as String?,
      userId: json['userId'] as String?,
      rsvpStatus: json['rsvpStatus'] as String,
      notes: json['notes'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      contact: json['contact'] != null ? Contact.fromJson(json['contact'] as Map<String, dynamic>) : null,
      event: Event.fromJson(json['event'] as Map<String, dynamic>),
      org: Organization.fromJson(json['org'] as Map<String, dynamic>),
      user: json['user'] != null ? User.fromJson(json['user'] as Map<String, dynamic>) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'eventId': eventId,
      'contactId': contactId,
      'userId': userId,
      'rsvpStatus': rsvpStatus,
      'notes': notes,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'contact': contact?.toJson(),
      'event': event.toJson(),
      'org': org.toJson(),
      'user': user?.toJson(),
    };
  }

  EventAttendee copyWith({
    String? id,
    String? orgId,
    String? eventId,
    String? contactId,
    String? userId,
    String? rsvpStatus,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    Contact? contact,
    Event? event,
    Organization? org,
    User? user,
  }) {
    return EventAttendee(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      eventId: eventId ?? this.eventId,
      contactId: contactId ?? this.contactId,
      userId: userId ?? this.userId,
      rsvpStatus: rsvpStatus ?? this.rsvpStatus,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      contact: contact ?? this.contact,
      event: event ?? this.event,
      org: org ?? this.org,
      user: user ?? this.user,
    );
  }
}
