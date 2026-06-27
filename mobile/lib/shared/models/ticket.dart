import 'package:reservatior/shared/enums/ticket_status.dart';
import 'communication_log.dart';
import 'user.dart';

class Ticket {
  final String id;
  final String cuid;
  final String subject;
  final String? description;
  final TicketStatus status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? closedAt;
  final DateTime? deletedAt;
  final String userId;
  final String? agentId;
  final List<CommunicationLog> communicationLogs;
  final User? agent;
  final User user;

  const Ticket({
    required this.id,
    required this.cuid,
    required this.subject,
    this.description,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.closedAt,
    this.deletedAt,
    required this.userId,
    this.agentId,
    this.communicationLogs = const [],
    this.agent,
    required this.user,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      id: json['id'] as String,
      cuid: json['cuid'] as String,
      subject: json['subject'] as String,
      description: json['description'] as String?,
      status: TicketStatus.values.firstWhere((v) => v.name == json['status']),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      closedAt: json['closedAt'] != null ? DateTime.parse(json['closedAt'] as String) : null,
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      userId: json['userId'] as String,
      agentId: json['agentId'] as String?,
      communicationLogs: (json['CommunicationLogs'] as List<dynamic>?)?.map((e) => CommunicationLog.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      agent: json['Agent'] != null ? User.fromJson(json['Agent'] as Map<String, dynamic>) : null,
      user: User.fromJson(json['User'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cuid': cuid,
      'subject': subject,
      'description': description,
      'status': status.name,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'closedAt': closedAt?.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'userId': userId,
      'agentId': agentId,
      'CommunicationLogs': communicationLogs.map((e) => e.toJson()).toList(),
      'Agent': agent?.toJson(),
      'User': user.toJson(),
    };
  }

  Ticket copyWith({
    String? id,
    String? cuid,
    String? subject,
    String? description,
    TicketStatus? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? closedAt,
    DateTime? deletedAt,
    String? userId,
    String? agentId,
    List<CommunicationLog>? communicationLogs,
    User? agent,
    User? user,
  }) {
    return Ticket(
      id: id ?? this.id,
      cuid: cuid ?? this.cuid,
      subject: subject ?? this.subject,
      description: description ?? this.description,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      closedAt: closedAt ?? this.closedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      userId: userId ?? this.userId,
      agentId: agentId ?? this.agentId,
      communicationLogs: communicationLogs ?? this.communicationLogs,
      agent: agent ?? this.agent,
      user: user ?? this.user,
    );
  }
}
