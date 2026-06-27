import 'organization.dart';
import 'webhook.dart';

class WebhookDelivery {
  final String id;
  final String orgId;
  final String webhookId;
  final String eventType;
  final int? statusCode;
  final DateTime? deliveredAt;
  final String? error;
  final DateTime createdAt;
  final Organization org;
  final Webhook webhook;

  const WebhookDelivery({
    required this.id,
    required this.orgId,
    required this.webhookId,
    required this.eventType,
    this.statusCode,
    this.deliveredAt,
    this.error,
    required this.createdAt,
    required this.org,
    required this.webhook,
  });

  factory WebhookDelivery.fromJson(Map<String, dynamic> json) {
    return WebhookDelivery(
      id: json['id'] as String,
      orgId: json['orgId'] as String,
      webhookId: json['webhookId'] as String,
      eventType: json['eventType'] as String,
      statusCode: json['statusCode'] as int?,
      deliveredAt: json['deliveredAt'] != null ? DateTime.parse(json['deliveredAt'] as String) : null,
      error: json['error'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      org: Organization.fromJson(json['org'] as Map<String, dynamic>),
      webhook: Webhook.fromJson(json['webhook'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'webhookId': webhookId,
      'eventType': eventType,
      'statusCode': statusCode,
      'deliveredAt': deliveredAt?.toIso8601String(),
      'error': error,
      'createdAt': createdAt.toIso8601String(),
      'org': org.toJson(),
      'webhook': webhook.toJson(),
    };
  }

  WebhookDelivery copyWith({
    String? id,
    String? orgId,
    String? webhookId,
    String? eventType,
    int? statusCode,
    DateTime? deliveredAt,
    String? error,
    DateTime? createdAt,
    Organization? org,
    Webhook? webhook,
  }) {
    return WebhookDelivery(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      webhookId: webhookId ?? this.webhookId,
      eventType: eventType ?? this.eventType,
      statusCode: statusCode ?? this.statusCode,
      deliveredAt: deliveredAt ?? this.deliveredAt,
      error: error ?? this.error,
      createdAt: createdAt ?? this.createdAt,
      org: org ?? this.org,
      webhook: webhook ?? this.webhook,
    );
  }
}
