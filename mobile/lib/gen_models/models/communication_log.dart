
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'communication_type.dart';
import 'agency.dart';
import 'channel.dart';
import 'communication_log.dart';
import 'ticket.dart';
import 'user.dart';


class CommunicationLog implements PrismaModel<String, CommunicationLog> , Id<String> {
    @override
String? id;
	String? senderId;
	String? receiverId;
	CommunicationType? type;
	String? content;
	String? entityId;
	String? entityType;
	dynamic metadata;
	bool? isRead;
	DateTime? readAt;
	DateTime? deliveredAt;
	DateTime? deletedAt;
	DateTime? timestamp;
	String? userId;
	String? agencyId;
	String? threadId;
	String? replyToId;
	String? channelId;
	String? ticketId;
	DateTime? createdAt;
	DateTime? updatedAt;
	bool? isEdited;
	DateTime? editedAt;
	String? deletedById;
	dynamic reactions;
	dynamic attachments;
	dynamic readBy;
	Agency? Agency;
	Channel? Channel;
	CommunicationLog? replyTo;
	List<CommunicationLog>? replies;
	Ticket? Ticket;
	User? User;
	int? $repliesCount;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    CommunicationLog({ this.id,
	 this.senderId,
	 this.receiverId,
	 this.type,
	 this.content,
	 this.entityId,
	 this.entityType,
	required this.metadata,
	 this.isRead = false,
	 this.readAt,
	 this.deliveredAt,
	 this.deletedAt,
	 this.timestamp,
	 this.userId,
	 this.agencyId,
	 this.threadId,
	 this.replyToId,
	 this.channelId,
	 this.ticketId,
	 this.createdAt,
	 this.updatedAt,
	 this.isEdited = false,
	 this.editedAt,
	 this.deletedById,
	required this.reactions,
	required this.attachments,
	required this.readBy,
	 this.Agency,
	 this.Channel,
	 this.replyTo,
	 this.replies,
	 this.Ticket,
	 this.User,
	this.$repliesCount,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<CommunicationLog, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"senderId": (m) => m.senderId,

	"receiverId": (m) => m.receiverId,

	"type": (m) => m.type,

	"content": (m) => m.content,

	"entityId": (m) => m.entityId,

	"entityType": (m) => m.entityType,

	"metadata": (m) => m.metadata,

	"isRead": (m) => m.isRead,

	"readAt": (m) => m.readAt,

	"deliveredAt": (m) => m.deliveredAt,

	"deletedAt": (m) => m.deletedAt,

	"timestamp": (m) => m.timestamp,

	"userId": (m) => m.userId,

	"agencyId": (m) => m.agencyId,

	"threadId": (m) => m.threadId,

	"replyToId": (m) => m.replyToId,

	"channelId": (m) => m.channelId,

	"ticketId": (m) => m.ticketId,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"isEdited": (m) => m.isEdited,

	"editedAt": (m) => m.editedAt,

	"deletedById": (m) => m.deletedById,

	"reactions": (m) => m.reactions,

	"attachments": (m) => m.attachments,

	"readBy": (m) => m.readBy,

	"Agency": (m) => m.Agency,

	"Channel": (m) => m.Channel,

	"replyTo": (m) => m.replyTo,

	"replies": (m) => m.replies,

	"Ticket": (m) => m.Ticket,

	"User": (m) => m.User,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(CommunicationLog) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in CommunicationLog');
    }
    return propFunction as V? Function(CommunicationLog);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory CommunicationLog.fromJson(JsonMap json) =>
      CommunicationLog(
        id: json['id'] as String?,
	senderId: json['senderId'] as String?,
	receiverId: json['receiverId'] as String?,
	type: json['type'] != null ? CommunicationType.fromJson(json['type']) : null,
	content: json['content'] as String?,
	entityId: json['entityId'] as String?,
	entityType: json['entityType'] as String?,
	metadata: json['metadata'] as dynamic,
	isRead: json['isRead'] as bool?,
	readAt: json['readAt'] != null ? DateTime.parse(json['readAt']) : null,
	deliveredAt: json['deliveredAt'] != null ? DateTime.parse(json['deliveredAt']) : null,
	deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
	timestamp: json['timestamp'] != null ? DateTime.parse(json['timestamp']) : null,
	userId: json['userId'] as String?,
	agencyId: json['agencyId'] as String?,
	threadId: json['threadId'] as String?,
	replyToId: json['replyToId'] as String?,
	channelId: json['channelId'] as String?,
	ticketId: json['ticketId'] as String?,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	isEdited: json['isEdited'] as bool?,
	editedAt: json['editedAt'] != null ? DateTime.parse(json['editedAt']) : null,
	deletedById: json['deletedById'] as String?,
	reactions: json['reactions'] as dynamic,
	attachments: json['attachments'] as dynamic,
	readBy: json['readBy'] as dynamic,
	Agency: json['Agency'] != null ? Agency.fromJson(json['Agency'] as JsonMap) : null,
	Channel: json['Channel'] != null ? Channel.fromJson(json['Channel'] as JsonMap) : null,
	replyTo: json['replyTo'] != null ? CommunicationLog.fromJson(json['replyTo'] as JsonMap) : null,
	replies: json['replies'] != null ? createModels<CommunicationLog>((json['replies'] as List).cast<JsonMap>(), CommunicationLog.fromJson) : null,
	Ticket: json['Ticket'] != null ? Ticket.fromJson(json['Ticket'] as JsonMap) : null,
	User: json['User'] != null ? User.fromJson(json['User'] as JsonMap) : null,
	$repliesCount: json['_count']?['replies'] as int?,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    CommunicationLog copyWith({
        Value<String?>? id,
		Value<String?>? senderId,
		Value<String?>? receiverId,
		Value<CommunicationType?>? type,
		Value<String?>? content,
		Value<String?>? entityId,
		Value<String?>? entityType,
		Value<dynamic>? metadata,
		Value<bool?>? isRead,
		Value<DateTime?>? readAt,
		Value<DateTime?>? deliveredAt,
		Value<DateTime?>? deletedAt,
		Value<DateTime?>? timestamp,
		Value<String?>? userId,
		Value<String?>? agencyId,
		Value<String?>? threadId,
		Value<String?>? replyToId,
		Value<String?>? channelId,
		Value<String?>? ticketId,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<bool?>? isEdited,
		Value<DateTime?>? editedAt,
		Value<String?>? deletedById,
		Value<dynamic>? reactions,
		Value<dynamic>? attachments,
		Value<dynamic>? readBy,
		Value<Agency?>? Agency,
		Value<Channel?>? Channel,
		Value<CommunicationLog?>? replyTo,
		Value<List<CommunicationLog>?>? replies,
		Value<Ticket?>? Ticket,
		Value<User?>? User,
		int? $repliesCount,
        }) {
        return CommunicationLog(
            id: id != null ? id.value : this.id,
		senderId: senderId != null ? senderId.value : this.senderId,
		receiverId: receiverId != null ? receiverId.value : this.receiverId,
		type: type != null ? type.value : this.type,
		content: content != null ? content.value : this.content,
		entityId: entityId != null ? entityId.value : this.entityId,
		entityType: entityType != null ? entityType.value : this.entityType,
		metadata: metadata != null ? metadata.value : this.metadata,
		isRead: isRead != null ? isRead.value : this.isRead,
		readAt: readAt != null ? readAt.value : this.readAt,
		deliveredAt: deliveredAt != null ? deliveredAt.value : this.deliveredAt,
		deletedAt: deletedAt != null ? deletedAt.value : this.deletedAt,
		timestamp: timestamp != null ? timestamp.value : this.timestamp,
		userId: userId != null ? userId.value : this.userId,
		agencyId: agencyId != null ? agencyId.value : this.agencyId,
		threadId: threadId != null ? threadId.value : this.threadId,
		replyToId: replyToId != null ? replyToId.value : this.replyToId,
		channelId: channelId != null ? channelId.value : this.channelId,
		ticketId: ticketId != null ? ticketId.value : this.ticketId,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		isEdited: isEdited != null ? isEdited.value : this.isEdited,
		editedAt: editedAt != null ? editedAt.value : this.editedAt,
		deletedById: deletedById != null ? deletedById.value : this.deletedById,
		reactions: reactions != null ? reactions.value : this.reactions,
		attachments: attachments != null ? attachments.value : this.attachments,
		readBy: readBy != null ? readBy.value : this.readBy,
		Agency: Agency != null ? Agency.value : this.Agency,
		Channel: Channel != null ? Channel.value : this.Channel,
		replyTo: replyTo != null ? replyTo.value : this.replyTo,
		replies: replies != null ? replies.value : this.replies,
		Ticket: Ticket != null ? Ticket.value : this.Ticket,
		User: User != null ? User.value : this.User,
		$repliesCount: $repliesCount ?? this.$repliesCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    CommunicationLog copyWithInstanceValues(CommunicationLog communicationLog) {
        return CommunicationLog(
            id: communicationLog.id ?? id,
		senderId: communicationLog.senderId ?? senderId,
		receiverId: communicationLog.receiverId ?? receiverId,
		type: communicationLog.type ?? type,
		content: communicationLog.content ?? content,
		entityId: communicationLog.entityId ?? entityId,
		entityType: communicationLog.entityType ?? entityType,
		metadata: communicationLog.metadata ?? metadata,
		isRead: communicationLog.isRead ?? isRead,
		readAt: communicationLog.readAt ?? readAt,
		deliveredAt: communicationLog.deliveredAt ?? deliveredAt,
		deletedAt: communicationLog.deletedAt ?? deletedAt,
		timestamp: communicationLog.timestamp ?? timestamp,
		userId: communicationLog.userId ?? userId,
		agencyId: communicationLog.agencyId ?? agencyId,
		threadId: communicationLog.threadId ?? threadId,
		replyToId: communicationLog.replyToId ?? replyToId,
		channelId: communicationLog.channelId ?? channelId,
		ticketId: communicationLog.ticketId ?? ticketId,
		createdAt: communicationLog.createdAt ?? createdAt,
		updatedAt: communicationLog.updatedAt ?? updatedAt,
		isEdited: communicationLog.isEdited ?? isEdited,
		editedAt: communicationLog.editedAt ?? editedAt,
		deletedById: communicationLog.deletedById ?? deletedById,
		reactions: communicationLog.reactions ?? reactions,
		attachments: communicationLog.attachments ?? attachments,
		readBy: communicationLog.readBy ?? readBy,
		Agency: communicationLog.Agency ?? Agency,
		Channel: communicationLog.Channel ?? Channel,
		replyTo: communicationLog.replyTo ?? replyTo,
		replies: communicationLog.replies ?? replies,
		Ticket: communicationLog.Ticket ?? Ticket,
		User: communicationLog.User ?? User,
		$repliesCount: communicationLog.$repliesCount ?? $repliesCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    CommunicationLog mergeWithInstanceValues(CommunicationLog communicationLog) {
        return CommunicationLog(
            id: communicationLog.$assignedFields.contains('id') ? communicationLog.id : id,
		senderId: communicationLog.$assignedFields.contains('senderId') ? communicationLog.senderId : senderId,
		receiverId: communicationLog.$assignedFields.contains('receiverId') ? communicationLog.receiverId : receiverId,
		type: communicationLog.$assignedFields.contains('type') ? communicationLog.type : type,
		content: communicationLog.$assignedFields.contains('content') ? communicationLog.content : content,
		entityId: communicationLog.$assignedFields.contains('entityId') ? communicationLog.entityId : entityId,
		entityType: communicationLog.$assignedFields.contains('entityType') ? communicationLog.entityType : entityType,
		metadata: communicationLog.$assignedFields.contains('metadata') ? communicationLog.metadata : metadata,
		isRead: communicationLog.$assignedFields.contains('isRead') ? communicationLog.isRead : isRead,
		readAt: communicationLog.$assignedFields.contains('readAt') ? communicationLog.readAt : readAt,
		deliveredAt: communicationLog.$assignedFields.contains('deliveredAt') ? communicationLog.deliveredAt : deliveredAt,
		deletedAt: communicationLog.$assignedFields.contains('deletedAt') ? communicationLog.deletedAt : deletedAt,
		timestamp: communicationLog.$assignedFields.contains('timestamp') ? communicationLog.timestamp : timestamp,
		userId: communicationLog.$assignedFields.contains('userId') ? communicationLog.userId : userId,
		agencyId: communicationLog.$assignedFields.contains('agencyId') ? communicationLog.agencyId : agencyId,
		threadId: communicationLog.$assignedFields.contains('threadId') ? communicationLog.threadId : threadId,
		replyToId: communicationLog.$assignedFields.contains('replyToId') ? communicationLog.replyToId : replyToId,
		channelId: communicationLog.$assignedFields.contains('channelId') ? communicationLog.channelId : channelId,
		ticketId: communicationLog.$assignedFields.contains('ticketId') ? communicationLog.ticketId : ticketId,
		createdAt: communicationLog.$assignedFields.contains('createdAt') ? communicationLog.createdAt : createdAt,
		updatedAt: communicationLog.$assignedFields.contains('updatedAt') ? communicationLog.updatedAt : updatedAt,
		isEdited: communicationLog.$assignedFields.contains('isEdited') ? communicationLog.isEdited : isEdited,
		editedAt: communicationLog.$assignedFields.contains('editedAt') ? communicationLog.editedAt : editedAt,
		deletedById: communicationLog.$assignedFields.contains('deletedById') ? communicationLog.deletedById : deletedById,
		reactions: communicationLog.$assignedFields.contains('reactions') ? communicationLog.reactions : reactions,
		attachments: communicationLog.$assignedFields.contains('attachments') ? communicationLog.attachments : attachments,
		readBy: communicationLog.$assignedFields.contains('readBy') ? communicationLog.readBy : readBy,
		Agency: communicationLog.$assignedFields.contains('Agency') ? communicationLog.Agency : Agency,
		Channel: communicationLog.$assignedFields.contains('Channel') ? communicationLog.Channel : Channel,
		replyTo: communicationLog.$assignedFields.contains('replyTo') ? communicationLog.replyTo : replyTo,
		replies: (communicationLog.$assignedFields.contains('replies') && communicationLog.replies != null) ? mergeModelLists(replies, communicationLog.replies) : replies,
		Ticket: communicationLog.$assignedFields.contains('Ticket') ? communicationLog.Ticket : Ticket,
		User: communicationLog.$assignedFields.contains('User') ? communicationLog.User : User,
		$repliesCount: communicationLog.$repliesCount ?? $repliesCount
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    CommunicationLog updateWithInstanceValues(CommunicationLog communicationLog) {
        if (communicationLog.$assignedFields.contains('id')) { id = communicationLog.id; }
		if (communicationLog.$assignedFields.contains('senderId')) { senderId = communicationLog.senderId; }
		if (communicationLog.$assignedFields.contains('receiverId')) { receiverId = communicationLog.receiverId; }
		if (communicationLog.$assignedFields.contains('type')) { type = communicationLog.type; }
		if (communicationLog.$assignedFields.contains('content')) { content = communicationLog.content; }
		if (communicationLog.$assignedFields.contains('entityId')) { entityId = communicationLog.entityId; }
		if (communicationLog.$assignedFields.contains('entityType')) { entityType = communicationLog.entityType; }
		if (communicationLog.$assignedFields.contains('metadata')) { metadata = communicationLog.metadata; }
		if (communicationLog.$assignedFields.contains('isRead')) { isRead = communicationLog.isRead; }
		if (communicationLog.$assignedFields.contains('readAt')) { readAt = communicationLog.readAt; }
		if (communicationLog.$assignedFields.contains('deliveredAt')) { deliveredAt = communicationLog.deliveredAt; }
		if (communicationLog.$assignedFields.contains('deletedAt')) { deletedAt = communicationLog.deletedAt; }
		if (communicationLog.$assignedFields.contains('timestamp')) { timestamp = communicationLog.timestamp; }
		if (communicationLog.$assignedFields.contains('userId')) { userId = communicationLog.userId; }
		if (communicationLog.$assignedFields.contains('agencyId')) { agencyId = communicationLog.agencyId; }
		if (communicationLog.$assignedFields.contains('threadId')) { threadId = communicationLog.threadId; }
		if (communicationLog.$assignedFields.contains('replyToId')) { replyToId = communicationLog.replyToId; }
		if (communicationLog.$assignedFields.contains('channelId')) { channelId = communicationLog.channelId; }
		if (communicationLog.$assignedFields.contains('ticketId')) { ticketId = communicationLog.ticketId; }
		if (communicationLog.$assignedFields.contains('createdAt')) { createdAt = communicationLog.createdAt; }
		if (communicationLog.$assignedFields.contains('updatedAt')) { updatedAt = communicationLog.updatedAt; }
		if (communicationLog.$assignedFields.contains('isEdited')) { isEdited = communicationLog.isEdited; }
		if (communicationLog.$assignedFields.contains('editedAt')) { editedAt = communicationLog.editedAt; }
		if (communicationLog.$assignedFields.contains('deletedById')) { deletedById = communicationLog.deletedById; }
		if (communicationLog.$assignedFields.contains('reactions')) { reactions = communicationLog.reactions; }
		if (communicationLog.$assignedFields.contains('attachments')) { attachments = communicationLog.attachments; }
		if (communicationLog.$assignedFields.contains('readBy')) { readBy = communicationLog.readBy; }
		if (communicationLog.$assignedFields.contains('Agency')) { Agency = communicationLog.Agency; }
		if (communicationLog.$assignedFields.contains('Channel')) { Channel = communicationLog.Channel; }
		if (communicationLog.$assignedFields.contains('replyTo')) { replyTo = communicationLog.replyTo; }
		if (communicationLog.$assignedFields.contains('replies') && communicationLog.replies != null) { replies = mergeModelLists(replies, communicationLog.replies); }
		if (communicationLog.$assignedFields.contains('Ticket')) { Ticket = communicationLog.Ticket; }
		if (communicationLog.$assignedFields.contains('User')) { User = communicationLog.User; }
        return this;
    }

    /// Converts this instance to a JSON object.
    /// 
    /// [serializedTypes] - Internal parameter tracking which model types have been serialized
    /// in the current chain to prevent circular references.
    /// [preventCircularSerialization] - When true (default), prevents infinite recursion by
    /// skipping relations whose types have already been serialized in the current chain.
    /// Set to false to serialize all relations (use with caution - may cause infinite loops).
    @override
    JsonMap toJson({
      Set<String>? serializedTypes,
      bool preventCircularSerialization = true,
    }) {
      final Set<String> serializedModels = preventCircularSerialization 
          ? {...?serializedTypes, 'CommunicationLog'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(senderId != null) 'senderId': senderId,
	if(receiverId != null) 'receiverId': receiverId,
	if(type != null) 'type': type?.toJson(),
	if(content != null) 'content': content,
	if(entityId != null) 'entityId': entityId,
	if(entityType != null) 'entityType': entityType,
	if(metadata != null) 'metadata': metadata,
	if(isRead != null) 'isRead': isRead,
	if(readAt != null) 'readAt': readAt?.toIso8601String(),
	if(deliveredAt != null) 'deliveredAt': deliveredAt?.toIso8601String(),
	if(deletedAt != null) 'deletedAt': deletedAt?.toIso8601String(),
	if(timestamp != null) 'timestamp': timestamp?.toIso8601String(),
	if(userId != null) 'userId': userId,
	if(agencyId != null) 'agencyId': agencyId,
	if(threadId != null) 'threadId': threadId,
	if(replyToId != null) 'replyToId': replyToId,
	if(channelId != null) 'channelId': channelId,
	if(ticketId != null) 'ticketId': ticketId,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(isEdited != null) 'isEdited': isEdited,
	if(editedAt != null) 'editedAt': editedAt?.toIso8601String(),
	if(deletedById != null) 'deletedById': deletedById,
	if(reactions != null) 'reactions': reactions,
	if(attachments != null) 'attachments': attachments,
	if(readBy != null) 'readBy': readBy,
	if(Agency != null && (!preventCircularSerialization || !serializedModels.contains('Agency'))) 'Agency': Agency?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(Channel != null && (!preventCircularSerialization || !serializedModels.contains('Channel'))) 'Channel': Channel?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(replyTo != null && (!preventCircularSerialization || !serializedModels.contains('CommunicationLog'))) 'replyTo': replyTo?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(replies != null && (!preventCircularSerialization || !serializedModels.contains('CommunicationLog'))) 'replies': replies?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(Ticket != null && (!preventCircularSerialization || !serializedModels.contains('Ticket'))) 'Ticket': Ticket?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(User != null && (!preventCircularSerialization || !serializedModels.contains('User'))) 'User': User?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
		if ($repliesCount != null) '_count': { 
		if ($repliesCount != null) 'replies': $repliesCount, 
		},
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is CommunicationLog &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    