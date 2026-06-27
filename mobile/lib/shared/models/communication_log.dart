import 'package:reservatior/shared/enums/communication_type.dart';
import 'agency.dart';
import 'channel.dart';
import 'ticket.dart';
import 'user.dart';

class CommunicationLog {
  final String id;
  final String senderId;
  final String receiverId;
  final CommunicationType type;
  final String content;
  final String? entityId;
  final String? entityType;
  final bool isRead;
  final DateTime? readAt;
  final DateTime? deliveredAt;
  final DateTime? deletedAt;
  final DateTime timestamp;
  final String? userId;
  final String? agencyId;
  final String? threadId;
  final String? replyToId;
  final String? channelId;
  final String? ticketId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isEdited;
  final DateTime? editedAt;
  final String? deletedById;
  final Agency? agency;
  final Channel? channel;
  final CommunicationLog? replyTo;
  final List<CommunicationLog> replies;
  final Ticket? ticket;
  final User? user;

  const CommunicationLog({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.type,
    required this.content,
    this.entityId,
    this.entityType,
    required this.isRead,
    this.readAt,
    this.deliveredAt,
    this.deletedAt,
    required this.timestamp,
    this.userId,
    this.agencyId,
    this.threadId,
    this.replyToId,
    this.channelId,
    this.ticketId,
    required this.createdAt,
    required this.updatedAt,
    required this.isEdited,
    this.editedAt,
    this.deletedById,
    this.agency,
    this.channel,
    this.replyTo,
    this.replies = const [],
    this.ticket,
    this.user,
  });

  factory CommunicationLog.fromJson(Map<String, dynamic> json) {
    return CommunicationLog(
      id: json['id'] as String,
      senderId: json['senderId'] as String,
      receiverId: json['receiverId'] as String,
      type: CommunicationType.values.firstWhere((v) => v.name == json['type']),
      content: json['content'] as String,
      entityId: json['entityId'] as String?,
      entityType: json['entityType'] as String?,
      isRead: json['isRead'] as bool,
      readAt: json['readAt'] != null ? DateTime.parse(json['readAt'] as String) : null,
      deliveredAt: json['deliveredAt'] != null ? DateTime.parse(json['deliveredAt'] as String) : null,
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      timestamp: DateTime.parse(json['timestamp'] as String),
      userId: json['userId'] as String?,
      agencyId: json['agencyId'] as String?,
      threadId: json['threadId'] as String?,
      replyToId: json['replyToId'] as String?,
      channelId: json['channelId'] as String?,
      ticketId: json['ticketId'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      isEdited: json['isEdited'] as bool,
      editedAt: json['editedAt'] != null ? DateTime.parse(json['editedAt'] as String) : null,
      deletedById: json['deletedById'] as String?,
      agency: json['Agency'] != null ? Agency.fromJson(json['Agency'] as Map<String, dynamic>) : null,
      channel: json['Channel'] != null ? Channel.fromJson(json['Channel'] as Map<String, dynamic>) : null,
      replyTo: json['replyTo'] != null ? CommunicationLog.fromJson(json['replyTo'] as Map<String, dynamic>) : null,
      replies: (json['replies'] as List<dynamic>?)?.map((e) => CommunicationLog.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      ticket: json['Ticket'] != null ? Ticket.fromJson(json['Ticket'] as Map<String, dynamic>) : null,
      user: json['User'] != null ? User.fromJson(json['User'] as Map<String, dynamic>) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'senderId': senderId,
      'receiverId': receiverId,
      'type': type.name,
      'content': content,
      'entityId': entityId,
      'entityType': entityType,
      'isRead': isRead,
      'readAt': readAt?.toIso8601String(),
      'deliveredAt': deliveredAt?.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'timestamp': timestamp.toIso8601String(),
      'userId': userId,
      'agencyId': agencyId,
      'threadId': threadId,
      'replyToId': replyToId,
      'channelId': channelId,
      'ticketId': ticketId,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'isEdited': isEdited,
      'editedAt': editedAt?.toIso8601String(),
      'deletedById': deletedById,
      'Agency': agency?.toJson(),
      'Channel': channel?.toJson(),
      'replyTo': replyTo?.toJson(),
      'replies': replies.map((e) => e.toJson()).toList(),
      'Ticket': ticket?.toJson(),
      'User': user?.toJson(),
    };
  }

  CommunicationLog copyWith({
    String? id,
    String? senderId,
    String? receiverId,
    CommunicationType? type,
    String? content,
    String? entityId,
    String? entityType,
    bool? isRead,
    DateTime? readAt,
    DateTime? deliveredAt,
    DateTime? deletedAt,
    DateTime? timestamp,
    String? userId,
    String? agencyId,
    String? threadId,
    String? replyToId,
    String? channelId,
    String? ticketId,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isEdited,
    DateTime? editedAt,
    String? deletedById,
    Agency? agency,
    Channel? channel,
    CommunicationLog? replyTo,
    List<CommunicationLog>? replies,
    Ticket? ticket,
    User? user,
  }) {
    return CommunicationLog(
      id: id ?? this.id,
      senderId: senderId ?? this.senderId,
      receiverId: receiverId ?? this.receiverId,
      type: type ?? this.type,
      content: content ?? this.content,
      entityId: entityId ?? this.entityId,
      entityType: entityType ?? this.entityType,
      isRead: isRead ?? this.isRead,
      readAt: readAt ?? this.readAt,
      deliveredAt: deliveredAt ?? this.deliveredAt,
      deletedAt: deletedAt ?? this.deletedAt,
      timestamp: timestamp ?? this.timestamp,
      userId: userId ?? this.userId,
      agencyId: agencyId ?? this.agencyId,
      threadId: threadId ?? this.threadId,
      replyToId: replyToId ?? this.replyToId,
      channelId: channelId ?? this.channelId,
      ticketId: ticketId ?? this.ticketId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isEdited: isEdited ?? this.isEdited,
      editedAt: editedAt ?? this.editedAt,
      deletedById: deletedById ?? this.deletedById,
      agency: agency ?? this.agency,
      channel: channel ?? this.channel,
      replyTo: replyTo ?? this.replyTo,
      replies: replies ?? this.replies,
      ticket: ticket ?? this.ticket,
      user: user ?? this.user,
    );
  }
}
