import 'event_attendee.dart';
import 'organization.dart';
import 'property.dart';

class Event {
  final String id;
  final String orgId;
  final String propertyId;
  final String name;
  final String? description;
  final String eventType;
  final DateTime startDate;
  final DateTime endDate;
  final int? maxAttendees;
  final bool isPublic;
  final String status;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final Organization org;
  final Property property;
  final List<EventAttendee> attendees;

  const Event({
    required this.id,
    required this.orgId,
    required this.propertyId,
    required this.name,
    this.description,
    required this.eventType,
    required this.startDate,
    required this.endDate,
    this.maxAttendees,
    required this.isPublic,
    required this.status,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.org,
    required this.property,
    this.attendees = const [],
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'] as String,
      orgId: json['orgId'] as String,
      propertyId: json['propertyId'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      eventType: json['eventType'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      maxAttendees: json['maxAttendees'] as int?,
      isPublic: json['isPublic'] as bool,
      status: json['status'] as String,
      isActive: json['isActive'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      org: Organization.fromJson(json['org'] as Map<String, dynamic>),
      property: Property.fromJson(json['property'] as Map<String, dynamic>),
      attendees: (json['attendees'] as List<dynamic>?)?.map((e) => EventAttendee.fromJson(e as Map<String, dynamic>)).toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'propertyId': propertyId,
      'name': name,
      'description': description,
      'eventType': eventType,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'maxAttendees': maxAttendees,
      'isPublic': isPublic,
      'status': status,
      'isActive': isActive,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'org': org.toJson(),
      'property': property.toJson(),
      'attendees': attendees.map((e) => e.toJson()).toList(),
    };
  }

  Event copyWith({
    String? id,
    String? orgId,
    String? propertyId,
    String? name,
    String? description,
    String? eventType,
    DateTime? startDate,
    DateTime? endDate,
    int? maxAttendees,
    bool? isPublic,
    String? status,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    Organization? org,
    Property? property,
    List<EventAttendee>? attendees,
  }) {
    return Event(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      propertyId: propertyId ?? this.propertyId,
      name: name ?? this.name,
      description: description ?? this.description,
      eventType: eventType ?? this.eventType,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      maxAttendees: maxAttendees ?? this.maxAttendees,
      isPublic: isPublic ?? this.isPublic,
      status: status ?? this.status,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      org: org ?? this.org,
      property: property ?? this.property,
      attendees: attendees ?? this.attendees,
    );
  }
}
