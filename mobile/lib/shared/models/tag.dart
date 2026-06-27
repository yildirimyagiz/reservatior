import 'listing_tag.dart';
import 'organization.dart';

class Tag {
  final String id;
  final String orgId;
  final String name;
  final String? color;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final List<ListingTag> listingTags;
  final Organization org;

  const Tag({
    required this.id,
    required this.orgId,
    required this.name,
    this.color,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.listingTags = const [],
    required this.org,
  });

  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(
      id: json['id'] as String,
      orgId: json['orgId'] as String,
      name: json['name'] as String,
      color: json['color'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      listingTags: (json['listingTags'] as List<dynamic>?)?.map((e) => ListingTag.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      org: Organization.fromJson(json['org'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'name': name,
      'color': color,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'listingTags': listingTags.map((e) => e.toJson()).toList(),
      'org': org.toJson(),
    };
  }

  Tag copyWith({
    String? id,
    String? orgId,
    String? name,
    String? color,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    List<ListingTag>? listingTags,
    Organization? org,
  }) {
    return Tag(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      name: name ?? this.name,
      color: color ?? this.color,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      listingTags: listingTags ?? this.listingTags,
      org: org ?? this.org,
    );
  }
}
