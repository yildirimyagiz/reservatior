import 'mls_connection.dart';
import 'organization.dart';

class MlsExternalListing {
  final String id;
  final String orgId;
  final String connectionId;
  final String externalId;
  final String? externalUrl;
  final String? mappedListingId;
  final String? status;
  final DateTime? lastSeenAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final MlsConnection connection;
  final Organization org;

  const MlsExternalListing({
    required this.id,
    required this.orgId,
    required this.connectionId,
    required this.externalId,
    this.externalUrl,
    this.mappedListingId,
    this.status,
    this.lastSeenAt,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.connection,
    required this.org,
  });

  factory MlsExternalListing.fromJson(Map<String, dynamic> json) {
    return MlsExternalListing(
      id: json['id'] as String,
      orgId: json['orgId'] as String,
      connectionId: json['connectionId'] as String,
      externalId: json['externalId'] as String,
      externalUrl: json['externalUrl'] as String?,
      mappedListingId: json['mappedListingId'] as String?,
      status: json['status'] as String?,
      lastSeenAt: json['lastSeenAt'] != null ? DateTime.parse(json['lastSeenAt'] as String) : null,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      connection: MlsConnection.fromJson(json['connection'] as Map<String, dynamic>),
      org: Organization.fromJson(json['org'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'connectionId': connectionId,
      'externalId': externalId,
      'externalUrl': externalUrl,
      'mappedListingId': mappedListingId,
      'status': status,
      'lastSeenAt': lastSeenAt?.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'connection': connection.toJson(),
      'org': org.toJson(),
    };
  }

  MlsExternalListing copyWith({
    String? id,
    String? orgId,
    String? connectionId,
    String? externalId,
    String? externalUrl,
    String? mappedListingId,
    String? status,
    DateTime? lastSeenAt,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    MlsConnection? connection,
    Organization? org,
  }) {
    return MlsExternalListing(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      connectionId: connectionId ?? this.connectionId,
      externalId: externalId ?? this.externalId,
      externalUrl: externalUrl ?? this.externalUrl,
      mappedListingId: mappedListingId ?? this.mappedListingId,
      status: status ?? this.status,
      lastSeenAt: lastSeenAt ?? this.lastSeenAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      connection: connection ?? this.connection,
      org: org ?? this.org,
    );
  }
}
