import 'organization.dart';

class IntegrationLog {
  final String id;
  final String? orgId;
  final String integrationType;
  final String operation;
  final int? statusCode;
  final bool succes;
  final String? errorMessage;
  final int? processingTimeMs;
  final String? externalId;
  final String? correlationId;
  final DateTime createdAt;
  final Organization? org;

  const IntegrationLog({
    required this.id,
    this.orgId,
    required this.integrationType,
    required this.operation,
    this.statusCode,
    required this.succes,
    this.errorMessage,
    this.processingTimeMs,
    this.externalId,
    this.correlationId,
    required this.createdAt,
    this.org,
  });

  factory IntegrationLog.fromJson(Map<String, dynamic> json) {
    return IntegrationLog(
      id: json['id'] as String,
      orgId: json['orgId'] as String?,
      integrationType: json['integrationType'] as String,
      operation: json['operation'] as String,
      statusCode: json['statusCode'] as int?,
      succes: json['Succes'] as bool,
      errorMessage: json['errorMessage'] as String?,
      processingTimeMs: json['processingTimeMs'] as int?,
      externalId: json['externalId'] as String?,
      correlationId: json['correlationId'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      org: json['org'] != null ? Organization.fromJson(json['org'] as Map<String, dynamic>) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'integrationType': integrationType,
      'operation': operation,
      'statusCode': statusCode,
      'Succes': succes,
      'errorMessage': errorMessage,
      'processingTimeMs': processingTimeMs,
      'externalId': externalId,
      'correlationId': correlationId,
      'createdAt': createdAt.toIso8601String(),
      'org': org?.toJson(),
    };
  }

  IntegrationLog copyWith({
    String? id,
    String? orgId,
    String? integrationType,
    String? operation,
    int? statusCode,
    bool? succes,
    String? errorMessage,
    int? processingTimeMs,
    String? externalId,
    String? correlationId,
    DateTime? createdAt,
    Organization? org,
  }) {
    return IntegrationLog(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      integrationType: integrationType ?? this.integrationType,
      operation: operation ?? this.operation,
      statusCode: statusCode ?? this.statusCode,
      succes: succes ?? this.succes,
      errorMessage: errorMessage ?? this.errorMessage,
      processingTimeMs: processingTimeMs ?? this.processingTimeMs,
      externalId: externalId ?? this.externalId,
      correlationId: correlationId ?? this.correlationId,
      createdAt: createdAt ?? this.createdAt,
      org: org ?? this.org,
    );
  }
}
