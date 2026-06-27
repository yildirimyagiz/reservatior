import 'package:reservatior/shared/enums/enums.dart';
import 'user.dart';

class AiChatMessage {
  final String id;
  final String sessionId;
  final AIChatRole role;
  final String content;
  final Map<String, dynamic>? metadata;
  final AIChatModuleType? moduleType;
  final String? moduleId;
  final DateTime createdAt;
  final User? user;

  // Additional metadata fields for analytics/tracking
  final String? listingId;
  final String? reservationId;
  final String? contentHash;
  final String? redactedContent;
  final bool? piiDetected;
  final String? language;
  final bool? isAI;
  final String? escalationTag;
  final String? escalationTopic;
  final bool? paymentAgreed;
  final bool? securityFlag;
  final String? securityReason;
  final int? tokenCount;
  final int? processingMs;

  const AiChatMessage({
    required this.id,
    required this.sessionId,
    required this.role,
    required this.content,
    this.metadata,
    this.moduleType,
    this.moduleId,
    required this.createdAt,
    this.user,
    this.listingId,
    this.reservationId,
    this.contentHash,
    this.redactedContent,
    this.piiDetected,
    this.language,
    this.isAI,
    this.escalationTag,
    this.escalationTopic,
    this.paymentAgreed,
    this.securityFlag,
    this.securityReason,
    this.tokenCount,
    this.processingMs,
  });

  factory AiChatMessage.fromJson(Map<String, dynamic> json) {
    return AiChatMessage(
      id: json['id'] as String,
      sessionId: json['sessionId'] as String,
      role: AIChatRole.values.firstWhere((e) => e.toString().split('.').last == json['role']),
      content: json['content'] as String,
      metadata: json['metadata'] as Map<String, dynamic>?,
      moduleType: json['moduleType'] != null 
          ? AIChatModuleType.values.firstWhere((e) => e.toString().split('.').last == json['moduleType'])
          : null,
      moduleId: json['moduleId'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      user: json['user'] != null ? User.fromJson(json['user'] as Map<String, dynamic>) : null,
      listingId: json['listingId'] as String?,
      reservationId: json['reservationId'] as String?,
      contentHash: json['contentHash'] as String?,
      redactedContent: json['redactedContent'] as String?,
      piiDetected: json['piiDetected'] as bool?,
      language: json['language'] as String?,
      isAI: json['isAI'] as bool?,
      escalationTag: json['escalationTag'] as String?,
      escalationTopic: json['escalationTopic'] as String?,
      paymentAgreed: json['paymentAgreed'] as bool?,
      securityFlag: json['securityFlag'] as bool?,
      securityReason: json['securityReason'] as String?,
      tokenCount: json['tokenCount'] as int?,
      processingMs: json['processingMs'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sessionId': sessionId,
      'role': role.toString().split('.').last,
      'content': content,
      'metadata': metadata,
      'moduleType': moduleType?.toString().split('.').last,
      'moduleId': moduleId,
      'createdAt': createdAt.toIso8601String(),
      'user': user?.toJson(),
      'listingId': listingId,
      'reservationId': reservationId,
      'contentHash': contentHash,
      'redactedContent': redactedContent,
      'piiDetected': piiDetected,
      'language': language,
      'isAI': isAI,
      'escalationTag': escalationTag,
      'escalationTopic': escalationTopic,
      'paymentAgreed': paymentAgreed,
      'securityFlag': securityFlag,
      'securityReason': securityReason,
      'tokenCount': tokenCount,
      'processingMs': processingMs,
    };
  }
}
