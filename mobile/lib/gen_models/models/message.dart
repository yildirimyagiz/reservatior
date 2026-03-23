
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'message_participant_type.dart';
import 'attachment.dart';
import 'organization.dart';


class Message implements PrismaModel<String, Message> , Id<String> {
    @override
String? id;
	String? orgId;
	String? threadId;
	MessageParticipantType? senderType;
	String? senderUserId;
	String? senderContactId;
	String? body;
	String? subject;
	bool? isThreadStarter;
	dynamic threadInfo;
	dynamic readStatus;
	DateTime? createdAt;
	DateTime? updatedAt;
	DateTime? deletedAt;
	List<Attachment>? attachments;
	Organization? org;
	int? $attachmentsCount;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    Message({ this.id,
	 this.orgId,
	 this.threadId,
	 this.senderType,
	 this.senderUserId,
	 this.senderContactId,
	 this.body,
	 this.subject,
	 this.isThreadStarter = false,
	required this.threadInfo,
	required this.readStatus,
	 this.createdAt,
	 this.updatedAt,
	 this.deletedAt,
	 this.attachments,
	 this.org,
	this.$attachmentsCount,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<Message, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"orgId": (m) => m.orgId,

	"threadId": (m) => m.threadId,

	"senderType": (m) => m.senderType,

	"senderUserId": (m) => m.senderUserId,

	"senderContactId": (m) => m.senderContactId,

	"body": (m) => m.body,

	"subject": (m) => m.subject,

	"isThreadStarter": (m) => m.isThreadStarter,

	"threadInfo": (m) => m.threadInfo,

	"readStatus": (m) => m.readStatus,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"deletedAt": (m) => m.deletedAt,

	"attachments": (m) => m.attachments,

	"org": (m) => m.org,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(Message) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in Message');
    }
    return propFunction as V? Function(Message);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory Message.fromJson(JsonMap json) =>
      Message(
        id: json['id'] as String?,
	orgId: json['orgId'] as String?,
	threadId: json['threadId'] as String?,
	senderType: json['senderType'] != null ? MessageParticipantType.fromJson(json['senderType']) : null,
	senderUserId: json['senderUserId'] as String?,
	senderContactId: json['senderContactId'] as String?,
	body: json['body'] as String?,
	subject: json['subject'] as String?,
	isThreadStarter: json['isThreadStarter'] as bool?,
	threadInfo: json['threadInfo'] as dynamic,
	readStatus: json['readStatus'] as dynamic,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
	attachments: json['attachments'] != null ? createModels<Attachment>((json['attachments'] as List).cast<JsonMap>(), Attachment.fromJson) : null,
	org: json['org'] != null ? Organization.fromJson(json['org'] as JsonMap) : null,
	$attachmentsCount: json['_count']?['attachments'] as int?,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    Message copyWith({
        Value<String?>? id,
		Value<String?>? orgId,
		Value<String?>? threadId,
		Value<MessageParticipantType?>? senderType,
		Value<String?>? senderUserId,
		Value<String?>? senderContactId,
		Value<String?>? body,
		Value<String?>? subject,
		Value<bool?>? isThreadStarter,
		Value<dynamic>? threadInfo,
		Value<dynamic>? readStatus,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<DateTime?>? deletedAt,
		Value<List<Attachment>?>? attachments,
		Value<Organization?>? org,
		int? $attachmentsCount,
        }) {
        return Message(
            id: id != null ? id.value : this.id,
		orgId: orgId != null ? orgId.value : this.orgId,
		threadId: threadId != null ? threadId.value : this.threadId,
		senderType: senderType != null ? senderType.value : this.senderType,
		senderUserId: senderUserId != null ? senderUserId.value : this.senderUserId,
		senderContactId: senderContactId != null ? senderContactId.value : this.senderContactId,
		body: body != null ? body.value : this.body,
		subject: subject != null ? subject.value : this.subject,
		isThreadStarter: isThreadStarter != null ? isThreadStarter.value : this.isThreadStarter,
		threadInfo: threadInfo != null ? threadInfo.value : this.threadInfo,
		readStatus: readStatus != null ? readStatus.value : this.readStatus,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		deletedAt: deletedAt != null ? deletedAt.value : this.deletedAt,
		attachments: attachments != null ? attachments.value : this.attachments,
		org: org != null ? org.value : this.org,
		$attachmentsCount: $attachmentsCount ?? this.$attachmentsCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    Message copyWithInstanceValues(Message message) {
        return Message(
            id: message.id ?? id,
		orgId: message.orgId ?? orgId,
		threadId: message.threadId ?? threadId,
		senderType: message.senderType ?? senderType,
		senderUserId: message.senderUserId ?? senderUserId,
		senderContactId: message.senderContactId ?? senderContactId,
		body: message.body ?? body,
		subject: message.subject ?? subject,
		isThreadStarter: message.isThreadStarter ?? isThreadStarter,
		threadInfo: message.threadInfo ?? threadInfo,
		readStatus: message.readStatus ?? readStatus,
		createdAt: message.createdAt ?? createdAt,
		updatedAt: message.updatedAt ?? updatedAt,
		deletedAt: message.deletedAt ?? deletedAt,
		attachments: message.attachments ?? attachments,
		org: message.org ?? org,
		$attachmentsCount: message.$attachmentsCount ?? $attachmentsCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    Message mergeWithInstanceValues(Message message) {
        return Message(
            id: message.$assignedFields.contains('id') ? message.id : id,
		orgId: message.$assignedFields.contains('orgId') ? message.orgId : orgId,
		threadId: message.$assignedFields.contains('threadId') ? message.threadId : threadId,
		senderType: message.$assignedFields.contains('senderType') ? message.senderType : senderType,
		senderUserId: message.$assignedFields.contains('senderUserId') ? message.senderUserId : senderUserId,
		senderContactId: message.$assignedFields.contains('senderContactId') ? message.senderContactId : senderContactId,
		body: message.$assignedFields.contains('body') ? message.body : body,
		subject: message.$assignedFields.contains('subject') ? message.subject : subject,
		isThreadStarter: message.$assignedFields.contains('isThreadStarter') ? message.isThreadStarter : isThreadStarter,
		threadInfo: message.$assignedFields.contains('threadInfo') ? message.threadInfo : threadInfo,
		readStatus: message.$assignedFields.contains('readStatus') ? message.readStatus : readStatus,
		createdAt: message.$assignedFields.contains('createdAt') ? message.createdAt : createdAt,
		updatedAt: message.$assignedFields.contains('updatedAt') ? message.updatedAt : updatedAt,
		deletedAt: message.$assignedFields.contains('deletedAt') ? message.deletedAt : deletedAt,
		attachments: (message.$assignedFields.contains('attachments') && message.attachments != null) ? mergeModelLists(attachments, message.attachments) : attachments,
		org: message.$assignedFields.contains('org') ? message.org : org,
		$attachmentsCount: message.$attachmentsCount ?? $attachmentsCount
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    Message updateWithInstanceValues(Message message) {
        if (message.$assignedFields.contains('id')) { id = message.id; }
		if (message.$assignedFields.contains('orgId')) { orgId = message.orgId; }
		if (message.$assignedFields.contains('threadId')) { threadId = message.threadId; }
		if (message.$assignedFields.contains('senderType')) { senderType = message.senderType; }
		if (message.$assignedFields.contains('senderUserId')) { senderUserId = message.senderUserId; }
		if (message.$assignedFields.contains('senderContactId')) { senderContactId = message.senderContactId; }
		if (message.$assignedFields.contains('body')) { body = message.body; }
		if (message.$assignedFields.contains('subject')) { subject = message.subject; }
		if (message.$assignedFields.contains('isThreadStarter')) { isThreadStarter = message.isThreadStarter; }
		if (message.$assignedFields.contains('threadInfo')) { threadInfo = message.threadInfo; }
		if (message.$assignedFields.contains('readStatus')) { readStatus = message.readStatus; }
		if (message.$assignedFields.contains('createdAt')) { createdAt = message.createdAt; }
		if (message.$assignedFields.contains('updatedAt')) { updatedAt = message.updatedAt; }
		if (message.$assignedFields.contains('deletedAt')) { deletedAt = message.deletedAt; }
		if (message.$assignedFields.contains('attachments') && message.attachments != null) { attachments = mergeModelLists(attachments, message.attachments); }
		if (message.$assignedFields.contains('org')) { org = message.org; }
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
          ? {...?serializedTypes, 'Message'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(orgId != null) 'orgId': orgId,
	if(threadId != null) 'threadId': threadId,
	if(senderType != null) 'senderType': senderType?.toJson(),
	if(senderUserId != null) 'senderUserId': senderUserId,
	if(senderContactId != null) 'senderContactId': senderContactId,
	if(body != null) 'body': body,
	if(subject != null) 'subject': subject,
	if(isThreadStarter != null) 'isThreadStarter': isThreadStarter,
	if(threadInfo != null) 'threadInfo': threadInfo,
	if(readStatus != null) 'readStatus': readStatus,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(deletedAt != null) 'deletedAt': deletedAt?.toIso8601String(),
	if(attachments != null && (!preventCircularSerialization || !serializedModels.contains('Attachment'))) 'attachments': attachments?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(org != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'org': org?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
		if ($attachmentsCount != null) '_count': { 
		if ($attachmentsCount != null) 'attachments': $attachmentsCount, 
		},
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is Message &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    