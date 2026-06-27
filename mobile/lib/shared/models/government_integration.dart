import 'package:reservatior/shared/enums/region.dart';
import 'package:reservatior/shared/enums/sync_status.dart';
import 'organization.dart';
import 'user.dart';

class GovernmentIntegration {
  final String id;
  final String orgId;
  final String? userId;
  final Region region;
  final String name;
  final String? baseUrl;
  final bool isEnabled;
  final String? apiKeyCiphertext;
  final String? apiSecretCiphertext;
  final String? tokenCiphertext;
  final List<String> scopes;
  final DateTime? lastSyncAt;
  final SyncStatus status;
  final String? lastError;
  final String? createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final Organization org;
  final User? user;

  const GovernmentIntegration({
    required this.id,
    required this.orgId,
    this.userId,
    required this.region,
    required this.name,
    this.baseUrl,
    required this.isEnabled,
    this.apiKeyCiphertext,
    this.apiSecretCiphertext,
    this.tokenCiphertext,
    this.scopes = const [],
    this.lastSyncAt,
    required this.status,
    this.lastError,
    this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.org,
    this.user,
  });

  factory GovernmentIntegration.fromJson(Map<String, dynamic> json) {
    return GovernmentIntegration(
      id: json['id'] as String,
      orgId: json['orgId'] as String,
      userId: json['userId'] as String?,
      region: Region.values.firstWhere((v) => v.name == json['region']),
      name: json['name'] as String,
      baseUrl: json['baseUrl'] as String?,
      isEnabled: json['isEnabled'] as bool,
      apiKeyCiphertext: json['apiKeyCiphertext'] as String?,
      apiSecretCiphertext: json['apiSecretCiphertext'] as String?,
      tokenCiphertext: json['tokenCiphertext'] as String?,
      scopes: (json['scopes'] as List<dynamic>?)?.cast<String>() ?? [],
      lastSyncAt: json['lastSyncAt'] != null ? DateTime.parse(json['lastSyncAt'] as String) : null,
      status: SyncStatus.values.firstWhere((v) => v.name == json['status']),
      lastError: json['lastError'] as String?,
      createdBy: json['createdBy'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      org: Organization.fromJson(json['org'] as Map<String, dynamic>),
      user: json['user'] != null ? User.fromJson(json['user'] as Map<String, dynamic>) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'userId': userId,
      'region': region.name,
      'name': name,
      'baseUrl': baseUrl,
      'isEnabled': isEnabled,
      'apiKeyCiphertext': apiKeyCiphertext,
      'apiSecretCiphertext': apiSecretCiphertext,
      'tokenCiphertext': tokenCiphertext,
      'scopes': scopes,
      'lastSyncAt': lastSyncAt?.toIso8601String(),
      'status': status.name,
      'lastError': lastError,
      'createdBy': createdBy,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'org': org.toJson(),
      'user': user?.toJson(),
    };
  }

  GovernmentIntegration copyWith({
    String? id,
    String? orgId,
    String? userId,
    Region? region,
    String? name,
    String? baseUrl,
    bool? isEnabled,
    String? apiKeyCiphertext,
    String? apiSecretCiphertext,
    String? tokenCiphertext,
    List<String>? scopes,
    DateTime? lastSyncAt,
    SyncStatus? status,
    String? lastError,
    String? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    Organization? org,
    User? user,
  }) {
    return GovernmentIntegration(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      userId: userId ?? this.userId,
      region: region ?? this.region,
      name: name ?? this.name,
      baseUrl: baseUrl ?? this.baseUrl,
      isEnabled: isEnabled ?? this.isEnabled,
      apiKeyCiphertext: apiKeyCiphertext ?? this.apiKeyCiphertext,
      apiSecretCiphertext: apiSecretCiphertext ?? this.apiSecretCiphertext,
      tokenCiphertext: tokenCiphertext ?? this.tokenCiphertext,
      scopes: scopes ?? this.scopes,
      lastSyncAt: lastSyncAt ?? this.lastSyncAt,
      status: status ?? this.status,
      lastError: lastError ?? this.lastError,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      org: org ?? this.org,
      user: user ?? this.user,
    );
  }
}
