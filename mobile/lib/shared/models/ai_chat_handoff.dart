import 'ai_chatbot_session.dart';
import 'organization.dart';

class AiChatHandoff {
  final String id;
  final String? orgId;
  final String sessionId;
  final String handoffReason;
  final String handoffTo;
  final DateTime handoffAt;
  final DateTime? resolvedAt;
  final String? resolvedBy;
  final String? notes;
  final DateTime? deletedAt;
  final AiChatbotSession session;
  final Organization? org;

  const AiChatHandoff({
    required this.id,
    this.orgId,
    required this.sessionId,
    required this.handoffReason,
    required this.handoffTo,
    required this.handoffAt,
    this.resolvedAt,
    this.resolvedBy,
    this.notes,
    this.deletedAt,
    required this.session,
    this.org,
  });

  factory AiChatHandoff.fromJson(Map<String, dynamic> json) {
    return AiChatHandoff(
      id: json['id'] as String,
      orgId: json['orgId'] as String?,
      sessionId: json['sessionId'] as String,
      handoffReason: json['handoffReason'] as String,
      handoffTo: json['handoffTo'] as String,
      handoffAt: DateTime.parse(json['handoffAt'] as String),
      resolvedAt: json['resolvedAt'] != null ? DateTime.parse(json['resolvedAt'] as String) : null,
      resolvedBy: json['resolvedBy'] as String?,
      notes: json['notes'] as String?,
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      session: AiChatbotSession.fromJson(json['session'] as Map<String, dynamic>),
      org: json['org'] != null ? Organization.fromJson(json['org'] as Map<String, dynamic>) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'sessionId': sessionId,
      'handoffReason': handoffReason,
      'handoffTo': handoffTo,
      'handoffAt': handoffAt.toIso8601String(),
      'resolvedAt': resolvedAt?.toIso8601String(),
      'resolvedBy': resolvedBy,
      'notes': notes,
      'deletedAt': deletedAt?.toIso8601String(),
      'session': session.toJson(),
      'org': org?.toJson(),
    };
  }

  AiChatHandoff copyWith({
    String? id,
    String? orgId,
    String? sessionId,
    String? handoffReason,
    String? handoffTo,
    DateTime? handoffAt,
    DateTime? resolvedAt,
    String? resolvedBy,
    String? notes,
    DateTime? deletedAt,
    AiChatbotSession? session,
    Organization? org,
  }) {
    return AiChatHandoff(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      sessionId: sessionId ?? this.sessionId,
      handoffReason: handoffReason ?? this.handoffReason,
      handoffTo: handoffTo ?? this.handoffTo,
      handoffAt: handoffAt ?? this.handoffAt,
      resolvedAt: resolvedAt ?? this.resolvedAt,
      resolvedBy: resolvedBy ?? this.resolvedBy,
      notes: notes ?? this.notes,
      deletedAt: deletedAt ?? this.deletedAt,
      session: session ?? this.session,
      org: org ?? this.org,
    );
  }
}
