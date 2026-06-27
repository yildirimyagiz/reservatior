import 'package:reservatior/shared/enums/mention_type.dart';
import 'agency.dart';
import 'property.dart';
import 'task.dart';
import 'user.dart';

class Mention {
  final String id;
  final String mentionedById;
  final String mentionedToId;
  final MentionType type;
  final String? taskId;
  final String? propertyId;
  final String? content;
  final bool isRead;
  final String? agencyId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String? userId;
  final Agency? agency;
  final User mentionedBy;
  final User mentionedTo;
  final Property? property;
  final Task? task;
  final User? user;

  const Mention({
    required this.id,
    required this.mentionedById,
    required this.mentionedToId,
    required this.type,
    this.taskId,
    this.propertyId,
    this.content,
    required this.isRead,
    this.agencyId,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.userId,
    this.agency,
    required this.mentionedBy,
    required this.mentionedTo,
    this.property,
    this.task,
    this.user,
  });

  factory Mention.fromJson(Map<String, dynamic> json) {
    return Mention(
      id: json['id'] as String,
      mentionedById: json['mentionedById'] as String,
      mentionedToId: json['mentionedToId'] as String,
      type: (() {
        final valUpper = json['type']?.toString().toUpperCase() ?? '';
        return MentionType.values.firstWhere(
          (v) => v.name.toUpperCase() == valUpper,
          orElse: () => MentionType.PROPERTY,
        );
      })(),
      taskId: json['taskId'] as String?,
      propertyId: json['propertyId'] as String?,
      content: json['content'] as String?,
      isRead: json['isRead'] as bool,
      agencyId: json['agencyId'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      userId: json['userId'] as String?,
      agency: json['Agency'] != null ? Agency.fromJson(json['Agency'] as Map<String, dynamic>) : null,
      mentionedBy: User.fromJson(json['mentionedBy'] as Map<String, dynamic>),
      mentionedTo: User.fromJson(json['mentionedTo'] as Map<String, dynamic>),
      property: json['Property'] != null ? Property.fromJson(json['Property'] as Map<String, dynamic>) : null,
      task: json['Task'] != null ? Task.fromJson(json['Task'] as Map<String, dynamic>) : null,
      user: json['user'] != null ? User.fromJson(json['user'] as Map<String, dynamic>) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'mentionedById': mentionedById,
      'mentionedToId': mentionedToId,
      'type': type.name,
      'taskId': taskId,
      'propertyId': propertyId,
      'content': content,
      'isRead': isRead,
      'agencyId': agencyId,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'userId': userId,
      'Agency': agency?.toJson(),
      'mentionedBy': mentionedBy.toJson(),
      'mentionedTo': mentionedTo.toJson(),
      'Property': property?.toJson(),
      'Task': task?.toJson(),
      'user': user?.toJson(),
    };
  }

  Mention copyWith({
    String? id,
    String? mentionedById,
    String? mentionedToId,
    MentionType? type,
    String? taskId,
    String? propertyId,
    String? content,
    bool? isRead,
    String? agencyId,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    String? userId,
    Agency? agency,
    User? mentionedBy,
    User? mentionedTo,
    Property? property,
    Task? task,
    User? user,
  }) {
    return Mention(
      id: id ?? this.id,
      mentionedById: mentionedById ?? this.mentionedById,
      mentionedToId: mentionedToId ?? this.mentionedToId,
      type: type ?? this.type,
      taskId: taskId ?? this.taskId,
      propertyId: propertyId ?? this.propertyId,
      content: content ?? this.content,
      isRead: isRead ?? this.isRead,
      agencyId: agencyId ?? this.agencyId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      userId: userId ?? this.userId,
      agency: agency ?? this.agency,
      mentionedBy: mentionedBy ?? this.mentionedBy,
      mentionedTo: mentionedTo ?? this.mentionedTo,
      property: property ?? this.property,
      task: task ?? this.task,
      user: user ?? this.user,
    );
  }
}
