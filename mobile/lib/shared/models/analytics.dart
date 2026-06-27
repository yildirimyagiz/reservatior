import 'package:reservatior/shared/enums/analytics_type.dart';
import 'tax_record.dart';
import 'user.dart';

class Analytics {
  final String id;
  final String entityId;
  final String entityType;
  final AnalyticsType type;
  final DateTime timestamp;
  final DateTime? deletedAt;
  final String? propertyId;
  final String? userId;
  final String? agentId;
  final String? agencyId;
  final String? reservationId;
  final String? taskId;
  final String? taxRecordId;
  final dynamic agency;
  final dynamic agent;
  final dynamic property;
  final dynamic reservation;
  final dynamic task;
  final TaxRecord? taxRecord;
  final User? user;

  const Analytics({
    required this.id,
    required this.entityId,
    required this.entityType,
    required this.type,
    required this.timestamp,
    this.deletedAt,
    this.propertyId,
    this.userId,
    this.agentId,
    this.agencyId,
    this.reservationId,
    this.taskId,
    this.taxRecordId,
    required this.agency,
    required this.agent,
    required this.property,
    required this.reservation,
    required this.task,
    this.taxRecord,
    this.user,
  });

  factory Analytics.fromJson(Map<String, dynamic> json) {
    return Analytics(
      id: json['id'] as String,
      entityId: json['entityId'] as String,
      entityType: json['entityType'] as String,
      type: AnalyticsType.values.firstWhere((v) => v.name == json['type']),
      timestamp: DateTime.parse(json['timestamp'] as String),
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      propertyId: json['propertyId'] as String?,
      userId: json['userId'] as String?,
      agentId: json['agentId'] as String?,
      agencyId: json['agencyId'] as String?,
      reservationId: json['reservationId'] as String?,
      taskId: json['taskId'] as String?,
      taxRecordId: json['taxRecordId'] as String?,
      agency: json['agency'] as dynamic,
      agent: json['agent'] as dynamic,
      property: json['property'] as dynamic,
      reservation: json['reservation'] as dynamic,
      task: json['task'] as dynamic,
      taxRecord: json['taxRecord'] != null ? TaxRecord.fromJson(json['taxRecord'] as Map<String, dynamic>) : null,
      user: json['user'] != null ? User.fromJson(json['user'] as Map<String, dynamic>) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'entityId': entityId,
      'entityType': entityType,
      'type': type.name,
      'timestamp': timestamp.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'propertyId': propertyId,
      'userId': userId,
      'agentId': agentId,
      'agencyId': agencyId,
      'reservationId': reservationId,
      'taskId': taskId,
      'taxRecordId': taxRecordId,
      'agency': agency,
      'agent': agent,
      'property': property,
      'reservation': reservation,
      'task': task,
      'taxRecord': taxRecord?.toJson(),
      'user': user?.toJson(),
    };
  }

  Analytics copyWith({
    String? id,
    String? entityId,
    String? entityType,
    AnalyticsType? type,
    DateTime? timestamp,
    DateTime? deletedAt,
    String? propertyId,
    String? userId,
    String? agentId,
    String? agencyId,
    String? reservationId,
    String? taskId,
    String? taxRecordId,
    dynamic agency,
    dynamic agent,
    dynamic property,
    dynamic reservation,
    dynamic task,
    TaxRecord? taxRecord,
    User? user,
  }) {
    return Analytics(
      id: id ?? this.id,
      entityId: entityId ?? this.entityId,
      entityType: entityType ?? this.entityType,
      type: type ?? this.type,
      timestamp: timestamp ?? this.timestamp,
      deletedAt: deletedAt ?? this.deletedAt,
      propertyId: propertyId ?? this.propertyId,
      userId: userId ?? this.userId,
      agentId: agentId ?? this.agentId,
      agencyId: agencyId ?? this.agencyId,
      reservationId: reservationId ?? this.reservationId,
      taskId: taskId ?? this.taskId,
      taxRecordId: taxRecordId ?? this.taxRecordId,
      agency: agency ?? this.agency,
      agent: agent ?? this.agent,
      property: property ?? this.property,
      reservation: reservation ?? this.reservation,
      task: task ?? this.task,
      taxRecord: taxRecord ?? this.taxRecord,
      user: user ?? this.user,
    );
  }
}
