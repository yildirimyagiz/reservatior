import 'package:reservatior/shared/enums/message_participant_type.dart';
import 'attachment.dart';
import 'organization.dart';

class Message {
  final String id;
  final String orgId;
  final String? threadId;
  final MessageParticipantType senderType;
  final String? senderUserId;
  final String? senderContactId;
  final String body;
  final String? subject;
  final bool isThreadStarter;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final List<Attachment> attachments;
  final Organization org;

  const Message({
    required this.id,
    required this.orgId,
    this.threadId,
    required this.senderType,
    this.senderUserId,
    this.senderContactId,
    required this.body,
    this.subject,
    required this.isThreadStarter,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.attachments = const [],
    required this.org,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'] as String,
      orgId: json['orgId'] as String,
      threadId: json['threadId'] as String?,
      senderType: MessageParticipantType.values.firstWhere((v) => v.name == json['senderType']),
      senderUserId: json['senderUserId'] as String?,
      senderContactId: json['senderContactId'] as String?,
      body: json['body'] as String,
      subject: json['subject'] as String?,
      isThreadStarter: json['isThreadStarter'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      attachments: (json['attachments'] as List<dynamic>?)?.map((e) => Attachment.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      org: Organization.fromJson(json['org'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'threadId': threadId,
      'senderType': senderType.name,
      'senderUserId': senderUserId,
      'senderContactId': senderContactId,
      'body': body,
      'subject': subject,
      'isThreadStarter': isThreadStarter,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'attachments': attachments.map((e) => e.toJson()).toList(),
      'org': org.toJson(),
    };
  }

  Message copyWith({
    String? id,
    String? orgId,
    String? threadId,
    MessageParticipantType? senderType,
    String? senderUserId,
    String? senderContactId,
    String? body,
    String? subject,
    bool? isThreadStarter,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    List<Attachment>? attachments,
    Organization? org,
  }) {
    return Message(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      threadId: threadId ?? this.threadId,
      senderType: senderType ?? this.senderType,
      senderUserId: senderUserId ?? this.senderUserId,
      senderContactId: senderContactId ?? this.senderContactId,
      body: body ?? this.body,
      subject: subject ?? this.subject,
      isThreadStarter: isThreadStarter ?? this.isThreadStarter,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      attachments: attachments ?? this.attachments,
      org: org ?? this.org,
    );
  }
}
