import 'organization.dart';

class QueueMessage {
  final String id;
  final String? orgId;
  final String messageId;
  final String queueName;
  final String? exchangeName;
  final String? routingKey;
  final String messageType;
  final String status;
  final int priority;
  final int retryCount;
  final int maxRetries;
  final DateTime? nextRetryAt;
  final DateTime? processedAt;
  final DateTime? completedAt;
  final DateTime? failedAt;
  final String? errorMessage;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Organization? org;

  const QueueMessage({
    required this.id,
    this.orgId,
    required this.messageId,
    required this.queueName,
    this.exchangeName,
    this.routingKey,
    required this.messageType,
    required this.status,
    required this.priority,
    required this.retryCount,
    required this.maxRetries,
    this.nextRetryAt,
    this.processedAt,
    this.completedAt,
    this.failedAt,
    this.errorMessage,
    required this.createdAt,
    required this.updatedAt,
    this.org,
  });

  factory QueueMessage.fromJson(Map<String, dynamic> json) {
    return QueueMessage(
      id: json['id'] as String,
      orgId: json['orgId'] as String?,
      messageId: json['messageId'] as String,
      queueName: json['queueName'] as String,
      exchangeName: json['exchangeName'] as String?,
      routingKey: json['routingKey'] as String?,
      messageType: json['messageType'] as String,
      status: json['status'] as String,
      priority: json['priority'] as int,
      retryCount: json['retryCount'] as int,
      maxRetries: json['maxRetries'] as int,
      nextRetryAt: json['nextRetryAt'] != null ? DateTime.parse(json['nextRetryAt'] as String) : null,
      processedAt: json['processedAt'] != null ? DateTime.parse(json['processedAt'] as String) : null,
      completedAt: json['completedAt'] != null ? DateTime.parse(json['completedAt'] as String) : null,
      failedAt: json['failedAt'] != null ? DateTime.parse(json['failedAt'] as String) : null,
      errorMessage: json['errorMessage'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      org: json['org'] != null ? Organization.fromJson(json['org'] as Map<String, dynamic>) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'messageId': messageId,
      'queueName': queueName,
      'exchangeName': exchangeName,
      'routingKey': routingKey,
      'messageType': messageType,
      'status': status,
      'priority': priority,
      'retryCount': retryCount,
      'maxRetries': maxRetries,
      'nextRetryAt': nextRetryAt?.toIso8601String(),
      'processedAt': processedAt?.toIso8601String(),
      'completedAt': completedAt?.toIso8601String(),
      'failedAt': failedAt?.toIso8601String(),
      'errorMessage': errorMessage,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'org': org?.toJson(),
    };
  }

  QueueMessage copyWith({
    String? id,
    String? orgId,
    String? messageId,
    String? queueName,
    String? exchangeName,
    String? routingKey,
    String? messageType,
    String? status,
    int? priority,
    int? retryCount,
    int? maxRetries,
    DateTime? nextRetryAt,
    DateTime? processedAt,
    DateTime? completedAt,
    DateTime? failedAt,
    String? errorMessage,
    DateTime? createdAt,
    DateTime? updatedAt,
    Organization? org,
  }) {
    return QueueMessage(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      messageId: messageId ?? this.messageId,
      queueName: queueName ?? this.queueName,
      exchangeName: exchangeName ?? this.exchangeName,
      routingKey: routingKey ?? this.routingKey,
      messageType: messageType ?? this.messageType,
      status: status ?? this.status,
      priority: priority ?? this.priority,
      retryCount: retryCount ?? this.retryCount,
      maxRetries: maxRetries ?? this.maxRetries,
      nextRetryAt: nextRetryAt ?? this.nextRetryAt,
      processedAt: processedAt ?? this.processedAt,
      completedAt: completedAt ?? this.completedAt,
      failedAt: failedAt ?? this.failedAt,
      errorMessage: errorMessage ?? this.errorMessage,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      org: org ?? this.org,
    );
  }
}
