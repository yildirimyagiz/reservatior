import 'agency.dart';
import 'agent.dart';
import 'attachment.dart';
import 'organization.dart';

class Review {
  final String id;
  final String orgId;
  final String reviewerId;
  final String targetId;
  final String targetType;
  final int rating;
  final String? title;
  final String? comment;
  final bool isVerified;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final List<Attachment> attachments;
  final Organization org;
  final List<Agent> agents;
  final List<Agency> agencies;

  const Review({
    required this.id,
    required this.orgId,
    required this.reviewerId,
    required this.targetId,
    required this.targetType,
    required this.rating,
    this.title,
    this.comment,
    required this.isVerified,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.attachments = const [],
    required this.org,
    this.agents = const [],
    this.agencies = const [],
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'] as String,
      orgId: json['orgId'] as String,
      reviewerId: json['reviewerId'] as String,
      targetId: json['targetId'] as String,
      targetType: json['targetType'] as String,
      rating: json['rating'] as int,
      title: json['title'] as String?,
      comment: json['comment'] as String?,
      isVerified: json['isVerified'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      attachments: (json['attachments'] as List<dynamic>?)?.map((e) => Attachment.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      org: Organization.fromJson(json['org'] as Map<String, dynamic>),
      agents: (json['agents'] as List<dynamic>?)?.map((e) => Agent.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      agencies: (json['agencies'] as List<dynamic>?)?.map((e) => Agency.fromJson(e as Map<String, dynamic>)).toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'reviewerId': reviewerId,
      'targetId': targetId,
      'targetType': targetType,
      'rating': rating,
      'title': title,
      'comment': comment,
      'isVerified': isVerified,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'attachments': attachments.map((e) => e.toJson()).toList(),
      'org': org.toJson(),
      'agents': agents.map((e) => e.toJson()).toList(),
      'agencies': agencies.map((e) => e.toJson()).toList(),
    };
  }

  Review copyWith({
    String? id,
    String? orgId,
    String? reviewerId,
    String? targetId,
    String? targetType,
    int? rating,
    String? title,
    String? comment,
    bool? isVerified,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    List<Attachment>? attachments,
    Organization? org,
    List<Agent>? agents,
    List<Agency>? agencies,
  }) {
    return Review(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      reviewerId: reviewerId ?? this.reviewerId,
      targetId: targetId ?? this.targetId,
      targetType: targetType ?? this.targetType,
      rating: rating ?? this.rating,
      title: title ?? this.title,
      comment: comment ?? this.comment,
      isVerified: isVerified ?? this.isVerified,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      attachments: attachments ?? this.attachments,
      org: org ?? this.org,
      agents: agents ?? this.agents,
      agencies: agencies ?? this.agencies,
    );
  }
}
