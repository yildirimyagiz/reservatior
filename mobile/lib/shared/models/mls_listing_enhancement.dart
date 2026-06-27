import 'listing.dart';
import 'organization.dart';

class MlsListingEnhancement {
  final String id;
  final String orgId;
  final String listingId;
  final String? mlsNumber;
  final String? mlsStatus;
  final DateTime? lastMlsUpdate;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Listing listing;
  final Organization org;

  const MlsListingEnhancement({
    required this.id,
    required this.orgId,
    required this.listingId,
    this.mlsNumber,
    this.mlsStatus,
    this.lastMlsUpdate,
    required this.createdAt,
    required this.updatedAt,
    required this.listing,
    required this.org,
  });

  factory MlsListingEnhancement.fromJson(Map<String, dynamic> json) {
    return MlsListingEnhancement(
      id: json['id'] as String,
      orgId: json['orgId'] as String,
      listingId: json['listingId'] as String,
      mlsNumber: json['mlsNumber'] as String?,
      mlsStatus: json['mlsStatus'] as String?,
      lastMlsUpdate: json['lastMlsUpdate'] != null ? DateTime.parse(json['lastMlsUpdate'] as String) : null,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      listing: Listing.fromJson(json['listing'] as Map<String, dynamic>),
      org: Organization.fromJson(json['org'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'listingId': listingId,
      'mlsNumber': mlsNumber,
      'mlsStatus': mlsStatus,
      'lastMlsUpdate': lastMlsUpdate?.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'listing': listing.toJson(),
      'org': org.toJson(),
    };
  }

  MlsListingEnhancement copyWith({
    String? id,
    String? orgId,
    String? listingId,
    String? mlsNumber,
    String? mlsStatus,
    DateTime? lastMlsUpdate,
    DateTime? createdAt,
    DateTime? updatedAt,
    Listing? listing,
    Organization? org,
  }) {
    return MlsListingEnhancement(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      listingId: listingId ?? this.listingId,
      mlsNumber: mlsNumber ?? this.mlsNumber,
      mlsStatus: mlsStatus ?? this.mlsStatus,
      lastMlsUpdate: lastMlsUpdate ?? this.lastMlsUpdate,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      listing: listing ?? this.listing,
      org: org ?? this.org,
    );
  }
}
