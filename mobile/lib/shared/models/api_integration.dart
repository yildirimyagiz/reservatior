import 'organization.dart';

class APIIntegration {
  final String id;
  final String orgId;
  final String providerName;
  final String integrationType;
  final String? apiKeyCiphertext;
  final String? apiSecretCiphertext;
  final String? accessTokenCiphertext;
  final String? refreshTokenCiphertext;
  final String? baseUrl;
  final int? rateLimit;
  final int timeout;
  final String status;
  final DateTime? lastUsedAt;
  final int errorCount;
  final String? lastError;
  final bool isSandbox;
  final DateTime? deletedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Organization org;

  const APIIntegration({
    required this.id,
    required this.orgId,
    required this.providerName,
    required this.integrationType,
    this.apiKeyCiphertext,
    this.apiSecretCiphertext,
    this.accessTokenCiphertext,
    this.refreshTokenCiphertext,
    this.baseUrl,
    this.rateLimit,
    required this.timeout,
    required this.status,
    this.lastUsedAt,
    required this.errorCount,
    this.lastError,
    required this.isSandbox,
    this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.org,
  });

  factory APIIntegration.fromJson(Map<String, dynamic> json) {
    return APIIntegration(
      id: json['id'] as String,
      orgId: json['orgId'] as String,
      providerName: json['providerName'] as String,
      integrationType: json['integrationType'] as String,
      apiKeyCiphertext: json['apiKeyCiphertext'] as String?,
      apiSecretCiphertext: json['apiSecretCiphertext'] as String?,
      accessTokenCiphertext: json['accessTokenCiphertext'] as String?,
      refreshTokenCiphertext: json['refreshTokenCiphertext'] as String?,
      baseUrl: json['baseUrl'] as String?,
      rateLimit: json['rateLimit'] as int?,
      timeout: json['timeout'] as int,
      status: json['status'] as String,
      lastUsedAt: json['lastUsedAt'] != null ? DateTime.parse(json['lastUsedAt'] as String) : null,
      errorCount: json['errorCount'] as int,
      lastError: json['lastError'] as String?,
      isSandbox: json['isSandbox'] as bool,
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      org: Organization.fromJson(json['org'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'providerName': providerName,
      'integrationType': integrationType,
      'apiKeyCiphertext': apiKeyCiphertext,
      'apiSecretCiphertext': apiSecretCiphertext,
      'accessTokenCiphertext': accessTokenCiphertext,
      'refreshTokenCiphertext': refreshTokenCiphertext,
      'baseUrl': baseUrl,
      'rateLimit': rateLimit,
      'timeout': timeout,
      'status': status,
      'lastUsedAt': lastUsedAt?.toIso8601String(),
      'errorCount': errorCount,
      'lastError': lastError,
      'isSandbox': isSandbox,
      'deletedAt': deletedAt?.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'org': org.toJson(),
    };
  }

  APIIntegration copyWith({
    String? id,
    String? orgId,
    String? providerName,
    String? integrationType,
    String? apiKeyCiphertext,
    String? apiSecretCiphertext,
    String? accessTokenCiphertext,
    String? refreshTokenCiphertext,
    String? baseUrl,
    int? rateLimit,
    int? timeout,
    String? status,
    DateTime? lastUsedAt,
    int? errorCount,
    String? lastError,
    bool? isSandbox,
    DateTime? deletedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
    Organization? org,
  }) {
    return APIIntegration(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      providerName: providerName ?? this.providerName,
      integrationType: integrationType ?? this.integrationType,
      apiKeyCiphertext: apiKeyCiphertext ?? this.apiKeyCiphertext,
      apiSecretCiphertext: apiSecretCiphertext ?? this.apiSecretCiphertext,
      accessTokenCiphertext: accessTokenCiphertext ?? this.accessTokenCiphertext,
      refreshTokenCiphertext: refreshTokenCiphertext ?? this.refreshTokenCiphertext,
      baseUrl: baseUrl ?? this.baseUrl,
      rateLimit: rateLimit ?? this.rateLimit,
      timeout: timeout ?? this.timeout,
      status: status ?? this.status,
      lastUsedAt: lastUsedAt ?? this.lastUsedAt,
      errorCount: errorCount ?? this.errorCount,
      lastError: lastError ?? this.lastError,
      isSandbox: isSandbox ?? this.isSandbox,
      deletedAt: deletedAt ?? this.deletedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      org: org ?? this.org,
    );
  }
}
