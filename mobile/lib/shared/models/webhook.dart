import 'organization.dart';
import 'webhook_delivery.dart';

class Webhook {
  final String id;
  final String orgId;
  final String name;
  final String? description;
  final String url;
  final String secret;
  final List<String> events;
  final bool isActive;
  final DateTime? lastTriggeredAt;
  final int failureCount;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final Organization org;
  final List<WebhookDelivery> deliveries;

  const Webhook({
    required this.id,
    required this.orgId,
    required this.name,
    this.description,
    required this.url,
    required this.secret,
    this.events = const [],
    required this.isActive,
    this.lastTriggeredAt,
    required this.failureCount,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.org,
    this.deliveries = const [],
  });

  factory Webhook.fromJson(Map<String, dynamic> json) {
    return Webhook(
      id: json['id'] as String,
      orgId: json['orgId'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      url: json['url'] as String,
      secret: json['secret'] as String,
      events: (json['events'] as List<dynamic>?)?.cast<String>() ?? [],
      isActive: json['isActive'] as bool,
      lastTriggeredAt: json['lastTriggeredAt'] != null ? DateTime.parse(json['lastTriggeredAt'] as String) : null,
      failureCount: json['failureCount'] as int,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      org: Organization.fromJson(json['org'] as Map<String, dynamic>),
      deliveries: (json['deliveries'] as List<dynamic>?)?.map((e) => WebhookDelivery.fromJson(e as Map<String, dynamic>)).toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'name': name,
      'description': description,
      'url': url,
      'secret': secret,
      'events': events,
      'isActive': isActive,
      'lastTriggeredAt': lastTriggeredAt?.toIso8601String(),
      'failureCount': failureCount,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'org': org.toJson(),
      'deliveries': deliveries.map((e) => e.toJson()).toList(),
    };
  }

  Webhook copyWith({
    String? id,
    String? orgId,
    String? name,
    String? description,
    String? url,
    String? secret,
    List<String>? events,
    bool? isActive,
    DateTime? lastTriggeredAt,
    int? failureCount,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    Organization? org,
    List<WebhookDelivery>? deliveries,
  }) {
    return Webhook(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      name: name ?? this.name,
      description: description ?? this.description,
      url: url ?? this.url,
      secret: secret ?? this.secret,
      events: events ?? this.events,
      isActive: isActive ?? this.isActive,
      lastTriggeredAt: lastTriggeredAt ?? this.lastTriggeredAt,
      failureCount: failureCount ?? this.failureCount,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      org: org ?? this.org,
      deliveries: deliveries ?? this.deliveries,
    );
  }
}
