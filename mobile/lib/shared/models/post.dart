import 'agency.dart';
import 'agent.dart';
import 'hashtag.dart';
import 'photo.dart';
import 'user.dart';

class Post {
  final DateTime? deletedAt;
  final String id;
  final String title;
  final String content;
  final String slug;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String userId;
  final String? agencyId;
  final String? hashtagId;
  final String? agentId;
  final List<Photo> photo;
  final Agency? agency;
  final Agent? agent;
  final Hashtag? hashtag;
  final User user;

  const Post({
    this.deletedAt,
    required this.id,
    required this.title,
    required this.content,
    required this.slug,
    required this.createdAt,
    required this.updatedAt,
    required this.userId,
    this.agencyId,
    this.hashtagId,
    this.agentId,
    this.photo = const [],
    this.agency,
    this.agent,
    this.hashtag,
    required this.user,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      id: json['id'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      slug: json['slug'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      userId: json['userId'] as String,
      agencyId: json['agencyId'] as String?,
      hashtagId: json['hashtagId'] as String?,
      agentId: json['agentId'] as String?,
      photo: (json['Photo'] as List<dynamic>?)?.map((e) => Photo.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      agency: json['Agency'] != null ? Agency.fromJson(json['Agency'] as Map<String, dynamic>) : null,
      agent: json['Agent'] != null ? Agent.fromJson(json['Agent'] as Map<String, dynamic>) : null,
      hashtag: json['Hashtag'] != null ? Hashtag.fromJson(json['Hashtag'] as Map<String, dynamic>) : null,
      user: User.fromJson(json['User'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'deletedAt': deletedAt?.toIso8601String(),
      'id': id,
      'title': title,
      'content': content,
      'slug': slug,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'userId': userId,
      'agencyId': agencyId,
      'hashtagId': hashtagId,
      'agentId': agentId,
      'Photo': photo.map((e) => e.toJson()).toList(),
      'Agency': agency?.toJson(),
      'Agent': agent?.toJson(),
      'Hashtag': hashtag?.toJson(),
      'User': user.toJson(),
    };
  }

  Post copyWith({
    DateTime? deletedAt,
    String? id,
    String? title,
    String? content,
    String? slug,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? userId,
    String? agencyId,
    String? hashtagId,
    String? agentId,
    List<Photo>? photo,
    Agency? agency,
    Agent? agent,
    Hashtag? hashtag,
    User? user,
  }) {
    return Post(
      deletedAt: deletedAt ?? this.deletedAt,
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      slug: slug ?? this.slug,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      userId: userId ?? this.userId,
      agencyId: agencyId ?? this.agencyId,
      hashtagId: hashtagId ?? this.hashtagId,
      agentId: agentId ?? this.agentId,
      photo: photo ?? this.photo,
      agency: agency ?? this.agency,
      agent: agent ?? this.agent,
      hashtag: hashtag ?? this.hashtag,
      user: user ?? this.user,
    );
  }
}
