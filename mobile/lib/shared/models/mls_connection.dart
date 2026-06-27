import 'package:reservatior/shared/enums/mls_provider_key.dart';
import 'package:reservatior/shared/enums/region.dart';
import 'package:reservatior/shared/enums/sync_status.dart';
import 'mls_external_listing.dart';
import 'mls_sync_job.dart';
import 'organization.dart';

class MlsConnection {
  final String id;
  final String orgId;
  final MlsProviderKey provider;
  final String name;
  final String? baseUrl;
  final bool isEnabled;
  final String? usernameCiphertext;
  final String? passwordCiphertext;
  final String? apiKeyCiphertext;
  final String? tokenCiphertext;
  final Region? region;
  final DateTime? lastSyncAt;
  final SyncStatus status;
  final String? lastError;
  final String? createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final Organization org;
  final List<MlsExternalListing> externalListings;
  final List<MlsSyncJob> syncJobs;

  const MlsConnection({
    required this.id,
    required this.orgId,
    required this.provider,
    required this.name,
    this.baseUrl,
    required this.isEnabled,
    this.usernameCiphertext,
    this.passwordCiphertext,
    this.apiKeyCiphertext,
    this.tokenCiphertext,
    this.region,
    this.lastSyncAt,
    required this.status,
    this.lastError,
    this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.org,
    this.externalListings = const [],
    this.syncJobs = const [],
  });

  factory MlsConnection.fromJson(Map<String, dynamic> json) {
    return MlsConnection(
      id: json['id'] as String,
      orgId: json['orgId'] as String,
      provider: MlsProviderKey.values.firstWhere((v) => v.name == json['provider']),
      name: json['name'] as String,
      baseUrl: json['baseUrl'] as String?,
      isEnabled: json['isEnabled'] as bool,
      usernameCiphertext: json['usernameCiphertext'] as String?,
      passwordCiphertext: json['passwordCiphertext'] as String?,
      apiKeyCiphertext: json['apiKeyCiphertext'] as String?,
      tokenCiphertext: json['tokenCiphertext'] as String?,
      region: json['region'] != null ? Region.values.firstWhere((v) => v.name == json['region']) : null,
      lastSyncAt: json['lastSyncAt'] != null ? DateTime.parse(json['lastSyncAt'] as String) : null,
      status: SyncStatus.values.firstWhere((v) => v.name == json['status']),
      lastError: json['lastError'] as String?,
      createdBy: json['createdBy'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      org: Organization.fromJson(json['org'] as Map<String, dynamic>),
      externalListings: (json['externalListings'] as List<dynamic>?)?.map((e) => MlsExternalListing.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      syncJobs: (json['syncJobs'] as List<dynamic>?)?.map((e) => MlsSyncJob.fromJson(e as Map<String, dynamic>)).toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'provider': provider.name,
      'name': name,
      'baseUrl': baseUrl,
      'isEnabled': isEnabled,
      'usernameCiphertext': usernameCiphertext,
      'passwordCiphertext': passwordCiphertext,
      'apiKeyCiphertext': apiKeyCiphertext,
      'tokenCiphertext': tokenCiphertext,
      'region': region?.name,
      'lastSyncAt': lastSyncAt?.toIso8601String(),
      'status': status.name,
      'lastError': lastError,
      'createdBy': createdBy,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'org': org.toJson(),
      'externalListings': externalListings.map((e) => e.toJson()).toList(),
      'syncJobs': syncJobs.map((e) => e.toJson()).toList(),
    };
  }

  MlsConnection copyWith({
    String? id,
    String? orgId,
    MlsProviderKey? provider,
    String? name,
    String? baseUrl,
    bool? isEnabled,
    String? usernameCiphertext,
    String? passwordCiphertext,
    String? apiKeyCiphertext,
    String? tokenCiphertext,
    Region? region,
    DateTime? lastSyncAt,
    SyncStatus? status,
    String? lastError,
    String? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    Organization? org,
    List<MlsExternalListing>? externalListings,
    List<MlsSyncJob>? syncJobs,
  }) {
    return MlsConnection(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      provider: provider ?? this.provider,
      name: name ?? this.name,
      baseUrl: baseUrl ?? this.baseUrl,
      isEnabled: isEnabled ?? this.isEnabled,
      usernameCiphertext: usernameCiphertext ?? this.usernameCiphertext,
      passwordCiphertext: passwordCiphertext ?? this.passwordCiphertext,
      apiKeyCiphertext: apiKeyCiphertext ?? this.apiKeyCiphertext,
      tokenCiphertext: tokenCiphertext ?? this.tokenCiphertext,
      region: region ?? this.region,
      lastSyncAt: lastSyncAt ?? this.lastSyncAt,
      status: status ?? this.status,
      lastError: lastError ?? this.lastError,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      org: org ?? this.org,
      externalListings: externalListings ?? this.externalListings,
      syncJobs: syncJobs ?? this.syncJobs,
    );
  }
}
