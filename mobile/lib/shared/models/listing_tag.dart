import 'listing.dart';
import 'organization.dart';
import 'tag.dart';

class ListingTag {
  final String id;
  final String listingId;
  final String tagId;
  final String orgId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final Listing listing;
  final Organization org;
  final Tag tag;

  const ListingTag({
    required this.id,
    required this.listingId,
    required this.tagId,
    required this.orgId,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.listing,
    required this.org,
    required this.tag,
  });

  factory ListingTag.fromJson(Map<String, dynamic> json) {
    return ListingTag(
      id: json['id'] as String,
      listingId: json['listingId'] as String,
      tagId: json['tagId'] as String,
      orgId: json['orgId'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      listing: Listing.fromJson(json['listing'] as Map<String, dynamic>),
      org: Organization.fromJson(json['org'] as Map<String, dynamic>),
      tag: Tag.fromJson(json['tag'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'listingId': listingId,
      'tagId': tagId,
      'orgId': orgId,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'listing': listing.toJson(),
      'org': org.toJson(),
      'tag': tag.toJson(),
    };
  }

  ListingTag copyWith({
    String? id,
    String? listingId,
    String? tagId,
    String? orgId,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    Listing? listing,
    Organization? org,
    Tag? tag,
  }) {
    return ListingTag(
      id: id ?? this.id,
      listingId: listingId ?? this.listingId,
      tagId: tagId ?? this.tagId,
      orgId: orgId ?? this.orgId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      listing: listing ?? this.listing,
      org: org ?? this.org,
      tag: tag ?? this.tag,
    );
  }
}
