import 'ai_chat_handoff.dart';
import 'ai_chat_message.dart';
import 'organization.dart';

class AiChatbotSession {
  final String id;
  final String? orgId;
  final String? userId;
  final String? contactId;
  final String sessionId;
  final String? intent;
  final double? confidence;
  final String status;
  final String? transferredTo;
  final DateTime startedAt;
  final DateTime lastActivityAt;
  final DateTime? endedAt;
  final int? satisfaction;
  final DateTime createdAt;
  final Organization? org;
  final List<AiChatMessage> messages;
  final List<AiChatHandoff> handoffs;

  const AiChatbotSession({
    required this.id,
    this.orgId,
    this.userId,
    this.contactId,
    required this.sessionId,
    this.intent,
    this.confidence,
    required this.status,
    this.transferredTo,
    required this.startedAt,
    required this.lastActivityAt,
    this.endedAt,
    this.satisfaction,
    required this.createdAt,
    this.org,
    this.messages = const [],
    this.handoffs = const [],
  });

  factory AiChatbotSession.fromJson(Map<String, dynamic> json) {
    return AiChatbotSession(
      id: json['id'] as String,
      orgId: json['orgId'] as String?,
      userId: json['userId'] as String?,
      contactId: json['contactId'] as String?,
      sessionId: json['sessionId'] as String,
      intent: json['intent'] as String?,
      confidence: (json['confidence'] as num?)?.toDouble(),
      status: json['status'] as String,
      transferredTo: json['transferredTo'] as String?,
      startedAt: DateTime.parse(json['startedAt'] as String),
      lastActivityAt: DateTime.parse(json['lastActivityAt'] as String),
      endedAt: json['endedAt'] != null ? DateTime.parse(json['endedAt'] as String) : null,
      satisfaction: json['satisfaction'] as int?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      org: json['org'] != null ? Organization.fromJson(json['org'] as Map<String, dynamic>) : null,
      messages: (json['messages'] as List<dynamic>?)?.map((e) => AiChatMessage.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      handoffs: (json['handoffs'] as List<dynamic>?)?.map((e) => AiChatHandoff.fromJson(e as Map<String, dynamic>)).toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'userId': userId,
      'contactId': contactId,
      'sessionId': sessionId,
      'intent': intent,
      'confidence': confidence,
      'status': status,
      'transferredTo': transferredTo,
      'startedAt': startedAt.toIso8601String(),
      'lastActivityAt': lastActivityAt.toIso8601String(),
      'endedAt': endedAt?.toIso8601String(),
      'satisfaction': satisfaction,
      'createdAt': createdAt.toIso8601String(),
      'org': org?.toJson(),
      'messages': messages.map((e) => e.toJson()).toList(),
      'handoffs': handoffs.map((e) => e.toJson()).toList(),
    };
  }

  AiChatbotSession copyWith({
    String? id,
    String? orgId,
    String? userId,
    String? contactId,
    String? sessionId,
    String? intent,
    double? confidence,
    String? status,
    String? transferredTo,
    DateTime? startedAt,
    DateTime? lastActivityAt,
    DateTime? endedAt,
    int? satisfaction,
    DateTime? createdAt,
    Organization? org,
    List<AiChatMessage>? messages,
    List<AiChatHandoff>? handoffs,
  }) {
    return AiChatbotSession(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      userId: userId ?? this.userId,
      contactId: contactId ?? this.contactId,
      sessionId: sessionId ?? this.sessionId,
      intent: intent ?? this.intent,
      confidence: confidence ?? this.confidence,
      status: status ?? this.status,
      transferredTo: transferredTo ?? this.transferredTo,
      startedAt: startedAt ?? this.startedAt,
      lastActivityAt: lastActivityAt ?? this.lastActivityAt,
      endedAt: endedAt ?? this.endedAt,
      satisfaction: satisfaction ?? this.satisfaction,
      createdAt: createdAt ?? this.createdAt,
      org: org ?? this.org,
      messages: messages ?? this.messages,
      handoffs: handoffs ?? this.handoffs,
    );
  }
}
