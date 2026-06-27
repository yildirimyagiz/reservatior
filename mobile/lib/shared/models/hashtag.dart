import 'package:reservatior/shared/enums/hashtag_type.dart';
import 'agency.dart';
import 'post.dart';
import 'property.dart';
import 'user.dart';

class Hashtag {
  final DateTime? deletedAt;
  final String id;
  final String name;
  final HashtagType type;
  final String? description;
  final int usageCount;
  final List<String> relatedTags;
  final String? createdById;
  final String? agencyId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Agency? agency;
  final User? user;
  final List<Post> post;
  final List<Property> property;

  const Hashtag({
    this.deletedAt,
    required this.id,
    required this.name,
    required this.type,
    this.description,
    required this.usageCount,
    this.relatedTags = const [],
    this.createdById,
    this.agencyId,
    required this.createdAt,
    required this.updatedAt,
    this.agency,
    this.user,
    this.post = const [],
    this.property = const [],
  });

  factory Hashtag.fromJson(Map<String, dynamic> json) {
    return Hashtag(
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      id: json['id'] as String,
      name: json['name'] as String,
      type: HashtagType.values.firstWhere((v) => v.name == json['type']),
      description: json['description'] as String?,
      usageCount: json['usageCount'] as int,
      relatedTags: (json['relatedTags'] as List<dynamic>?)?.cast<String>() ?? [],
      createdById: json['createdById'] as String?,
      agencyId: json['agencyId'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      agency: json['Agency'] != null ? Agency.fromJson(json['Agency'] as Map<String, dynamic>) : null,
      user: json['User'] != null ? User.fromJson(json['User'] as Map<String, dynamic>) : null,
      post: (json['Post'] as List<dynamic>?)?.map((e) => Post.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      property: (json['Property'] as List<dynamic>?)?.map((e) => Property.fromJson(e as Map<String, dynamic>)).toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'deletedAt': deletedAt?.toIso8601String(),
      'id': id,
      'name': name,
      'type': type.name,
      'description': description,
      'usageCount': usageCount,
      'relatedTags': relatedTags,
      'createdById': createdById,
      'agencyId': agencyId,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'Agency': agency?.toJson(),
      'User': user?.toJson(),
      'Post': post.map((e) => e.toJson()).toList(),
      'Property': property.map((e) => e.toJson()).toList(),
    };
  }

  Hashtag copyWith({
    DateTime? deletedAt,
    String? id,
    String? name,
    HashtagType? type,
    String? description,
    int? usageCount,
    List<String>? relatedTags,
    String? createdById,
    String? agencyId,
    DateTime? createdAt,
    DateTime? updatedAt,
    Agency? agency,
    User? user,
    List<Post>? post,
    List<Property>? property,
  }) {
    return Hashtag(
      deletedAt: deletedAt ?? this.deletedAt,
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      description: description ?? this.description,
      usageCount: usageCount ?? this.usageCount,
      relatedTags: relatedTags ?? this.relatedTags,
      createdById: createdById ?? this.createdById,
      agencyId: agencyId ?? this.agencyId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      agency: agency ?? this.agency,
      user: user ?? this.user,
      post: post ?? this.post,
      property: property ?? this.property,
    );
  }
}
