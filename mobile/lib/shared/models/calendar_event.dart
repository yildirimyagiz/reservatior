import 'organization.dart';
import 'user.dart';

class CalendarEvent {
  final String id;
  final String orgId;
  final String userId;
  final String? externalId;
  final String? externalSource;
  final String title;
  final String? description;
  final DateTime startDate;
  final DateTime endDate;
  final String timezone;
  final String? location;
  final bool isAllDay;
  final DateTime? lastSyncedAt;
  final String syncStatus;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final Organization org;
  final User user;

  const CalendarEvent({
    required this.id,
    required this.orgId,
    required this.userId,
    this.externalId,
    this.externalSource,
    required this.title,
    this.description,
    required this.startDate,
    required this.endDate,
    required this.timezone,
    this.location,
    required this.isAllDay,
    this.lastSyncedAt,
    required this.syncStatus,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.org,
    required this.user,
  });

  factory CalendarEvent.fromJson(Map<String, dynamic> json) {
    return CalendarEvent(
      id: json['id'] as String,
      orgId: json['orgId'] as String,
      userId: json['userId'] as String,
      externalId: json['externalId'] as String?,
      externalSource: json['externalSource'] as String?,
      title: json['title'] as String,
      description: json['description'] as String?,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      timezone: json['timezone'] as String,
      location: json['location'] as String?,
      isAllDay: json['isAllDay'] as bool,
      lastSyncedAt: json['lastSyncedAt'] != null ? DateTime.parse(json['lastSyncedAt'] as String) : null,
      syncStatus: json['syncStatus'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      org: Organization.fromJson(json['org'] as Map<String, dynamic>),
      user: User.fromJson(json['user'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'userId': userId,
      'externalId': externalId,
      'externalSource': externalSource,
      'title': title,
      'description': description,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'timezone': timezone,
      'location': location,
      'isAllDay': isAllDay,
      'lastSyncedAt': lastSyncedAt?.toIso8601String(),
      'syncStatus': syncStatus,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'org': org.toJson(),
      'user': user.toJson(),
    };
  }

  CalendarEvent copyWith({
    String? id,
    String? orgId,
    String? userId,
    String? externalId,
    String? externalSource,
    String? title,
    String? description,
    DateTime? startDate,
    DateTime? endDate,
    String? timezone,
    String? location,
    bool? isAllDay,
    DateTime? lastSyncedAt,
    String? syncStatus,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    Organization? org,
    User? user,
  }) {
    return CalendarEvent(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      userId: userId ?? this.userId,
      externalId: externalId ?? this.externalId,
      externalSource: externalSource ?? this.externalSource,
      title: title ?? this.title,
      description: description ?? this.description,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      timezone: timezone ?? this.timezone,
      location: location ?? this.location,
      isAllDay: isAllDay ?? this.isAllDay,
      lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
      syncStatus: syncStatus ?? this.syncStatus,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      org: org ?? this.org,
      user: user ?? this.user,
    );
  }
}
