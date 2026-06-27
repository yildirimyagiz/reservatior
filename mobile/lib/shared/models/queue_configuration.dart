import 'organization.dart';

class QueueConfiguration {
  final String id;
  final String? orgId;
  final String queueName;
  final String? exchangeName;
  final String? routingKey;
  final String messageType;
  final String handlerClas;
  final int maxConcurrency;
  final String? deadLetterQueue;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Organization? org;

  const QueueConfiguration({
    required this.id,
    this.orgId,
    required this.queueName,
    this.exchangeName,
    this.routingKey,
    required this.messageType,
    required this.handlerClas,
    required this.maxConcurrency,
    this.deadLetterQueue,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    this.org,
  });

  factory QueueConfiguration.fromJson(Map<String, dynamic> json) {
    return QueueConfiguration(
      id: json['id'] as String,
      orgId: json['orgId'] as String?,
      queueName: json['queueName'] as String,
      exchangeName: json['exchangeName'] as String?,
      routingKey: json['routingKey'] as String?,
      messageType: json['messageType'] as String,
      handlerClas: json['HandlerClas'] as String,
      maxConcurrency: json['maxConcurrency'] as int,
      deadLetterQueue: json['deadLetterQueue'] as String?,
      isActive: json['isActive'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      org: json['org'] != null ? Organization.fromJson(json['org'] as Map<String, dynamic>) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'queueName': queueName,
      'exchangeName': exchangeName,
      'routingKey': routingKey,
      'messageType': messageType,
      'HandlerClas': handlerClas,
      'maxConcurrency': maxConcurrency,
      'deadLetterQueue': deadLetterQueue,
      'isActive': isActive,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'org': org?.toJson(),
    };
  }

  QueueConfiguration copyWith({
    String? id,
    String? orgId,
    String? queueName,
    String? exchangeName,
    String? routingKey,
    String? messageType,
    String? handlerClas,
    int? maxConcurrency,
    String? deadLetterQueue,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
    Organization? org,
  }) {
    return QueueConfiguration(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      queueName: queueName ?? this.queueName,
      exchangeName: exchangeName ?? this.exchangeName,
      routingKey: routingKey ?? this.routingKey,
      messageType: messageType ?? this.messageType,
      handlerClas: handlerClas ?? this.handlerClas,
      maxConcurrency: maxConcurrency ?? this.maxConcurrency,
      deadLetterQueue: deadLetterQueue ?? this.deadLetterQueue,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      org: org ?? this.org,
    );
  }
}
