
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'mention_type.dart';
import 'agency.dart';
import 'user.dart';
import 'property.dart';
import 'task.dart';


class Mention implements PrismaModel<String, Mention> , Id<String> {
    @override
String? id;
	String? mentionedById;
	String? mentionedToId;
	MentionType? type;
	String? taskId;
	String? propertyId;
	String? content;
	bool? isRead;
	String? agencyId;
	DateTime? createdAt;
	DateTime? updatedAt;
	DateTime? deletedAt;
	String? userId;
	Agency? Agency;
	User? mentionedBy;
	User? mentionedTo;
	Property? Property;
	Task? Task;
	User? user;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    Mention({ this.id,
	 this.mentionedById,
	 this.mentionedToId,
	 this.type,
	 this.taskId,
	 this.propertyId,
	 this.content,
	 this.isRead = false,
	 this.agencyId,
	 this.createdAt,
	 this.updatedAt,
	 this.deletedAt,
	 this.userId,
	 this.Agency,
	 this.mentionedBy,
	 this.mentionedTo,
	 this.Property,
	 this.Task,
	 this.user,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<Mention, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"mentionedById": (m) => m.mentionedById,

	"mentionedToId": (m) => m.mentionedToId,

	"type": (m) => m.type,

	"taskId": (m) => m.taskId,

	"propertyId": (m) => m.propertyId,

	"content": (m) => m.content,

	"isRead": (m) => m.isRead,

	"agencyId": (m) => m.agencyId,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"deletedAt": (m) => m.deletedAt,

	"userId": (m) => m.userId,

	"Agency": (m) => m.Agency,

	"mentionedBy": (m) => m.mentionedBy,

	"mentionedTo": (m) => m.mentionedTo,

	"Property": (m) => m.Property,

	"Task": (m) => m.Task,

	"user": (m) => m.user,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(Mention) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in Mention');
    }
    return propFunction as V? Function(Mention);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory Mention.fromJson(JsonMap json) =>
      Mention(
        id: json['id'] as String?,
	mentionedById: json['mentionedById'] as String?,
	mentionedToId: json['mentionedToId'] as String?,
	type: json['type'] != null ? MentionType.fromJson(json['type']) : null,
	taskId: json['taskId'] as String?,
	propertyId: json['propertyId'] as String?,
	content: json['content'] as String?,
	isRead: json['isRead'] as bool?,
	agencyId: json['agencyId'] as String?,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
	userId: json['userId'] as String?,
	Agency: json['Agency'] != null ? Agency.fromJson(json['Agency'] as JsonMap) : null,
	mentionedBy: json['mentionedBy'] != null ? User.fromJson(json['mentionedBy'] as JsonMap) : null,
	mentionedTo: json['mentionedTo'] != null ? User.fromJson(json['mentionedTo'] as JsonMap) : null,
	Property: json['Property'] != null ? Property.fromJson(json['Property'] as JsonMap) : null,
	Task: json['Task'] != null ? Task.fromJson(json['Task'] as JsonMap) : null,
	user: json['user'] != null ? User.fromJson(json['user'] as JsonMap) : null,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    Mention copyWith({
        Value<String?>? id,
		Value<String?>? mentionedById,
		Value<String?>? mentionedToId,
		Value<MentionType?>? type,
		Value<String?>? taskId,
		Value<String?>? propertyId,
		Value<String?>? content,
		Value<bool?>? isRead,
		Value<String?>? agencyId,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<DateTime?>? deletedAt,
		Value<String?>? userId,
		Value<Agency?>? Agency,
		Value<User?>? mentionedBy,
		Value<User?>? mentionedTo,
		Value<Property?>? Property,
		Value<Task?>? Task,
		Value<User?>? user,
        }) {
        return Mention(
            id: id != null ? id.value : this.id,
		mentionedById: mentionedById != null ? mentionedById.value : this.mentionedById,
		mentionedToId: mentionedToId != null ? mentionedToId.value : this.mentionedToId,
		type: type != null ? type.value : this.type,
		taskId: taskId != null ? taskId.value : this.taskId,
		propertyId: propertyId != null ? propertyId.value : this.propertyId,
		content: content != null ? content.value : this.content,
		isRead: isRead != null ? isRead.value : this.isRead,
		agencyId: agencyId != null ? agencyId.value : this.agencyId,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		deletedAt: deletedAt != null ? deletedAt.value : this.deletedAt,
		userId: userId != null ? userId.value : this.userId,
		Agency: Agency != null ? Agency.value : this.Agency,
		mentionedBy: mentionedBy != null ? mentionedBy.value : this.mentionedBy,
		mentionedTo: mentionedTo != null ? mentionedTo.value : this.mentionedTo,
		Property: Property != null ? Property.value : this.Property,
		Task: Task != null ? Task.value : this.Task,
		user: user != null ? user.value : this.user
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    Mention copyWithInstanceValues(Mention mention) {
        return Mention(
            id: mention.id ?? id,
		mentionedById: mention.mentionedById ?? mentionedById,
		mentionedToId: mention.mentionedToId ?? mentionedToId,
		type: mention.type ?? type,
		taskId: mention.taskId ?? taskId,
		propertyId: mention.propertyId ?? propertyId,
		content: mention.content ?? content,
		isRead: mention.isRead ?? isRead,
		agencyId: mention.agencyId ?? agencyId,
		createdAt: mention.createdAt ?? createdAt,
		updatedAt: mention.updatedAt ?? updatedAt,
		deletedAt: mention.deletedAt ?? deletedAt,
		userId: mention.userId ?? userId,
		Agency: mention.Agency ?? Agency,
		mentionedBy: mention.mentionedBy ?? mentionedBy,
		mentionedTo: mention.mentionedTo ?? mentionedTo,
		Property: mention.Property ?? Property,
		Task: mention.Task ?? Task,
		user: mention.user ?? user
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    Mention mergeWithInstanceValues(Mention mention) {
        return Mention(
            id: mention.$assignedFields.contains('id') ? mention.id : id,
		mentionedById: mention.$assignedFields.contains('mentionedById') ? mention.mentionedById : mentionedById,
		mentionedToId: mention.$assignedFields.contains('mentionedToId') ? mention.mentionedToId : mentionedToId,
		type: mention.$assignedFields.contains('type') ? mention.type : type,
		taskId: mention.$assignedFields.contains('taskId') ? mention.taskId : taskId,
		propertyId: mention.$assignedFields.contains('propertyId') ? mention.propertyId : propertyId,
		content: mention.$assignedFields.contains('content') ? mention.content : content,
		isRead: mention.$assignedFields.contains('isRead') ? mention.isRead : isRead,
		agencyId: mention.$assignedFields.contains('agencyId') ? mention.agencyId : agencyId,
		createdAt: mention.$assignedFields.contains('createdAt') ? mention.createdAt : createdAt,
		updatedAt: mention.$assignedFields.contains('updatedAt') ? mention.updatedAt : updatedAt,
		deletedAt: mention.$assignedFields.contains('deletedAt') ? mention.deletedAt : deletedAt,
		userId: mention.$assignedFields.contains('userId') ? mention.userId : userId,
		Agency: mention.$assignedFields.contains('Agency') ? mention.Agency : Agency,
		mentionedBy: mention.$assignedFields.contains('mentionedBy') ? mention.mentionedBy : mentionedBy,
		mentionedTo: mention.$assignedFields.contains('mentionedTo') ? mention.mentionedTo : mentionedTo,
		Property: mention.$assignedFields.contains('Property') ? mention.Property : Property,
		Task: mention.$assignedFields.contains('Task') ? mention.Task : Task,
		user: mention.$assignedFields.contains('user') ? mention.user : user
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    Mention updateWithInstanceValues(Mention mention) {
        if (mention.$assignedFields.contains('id')) { id = mention.id; }
		if (mention.$assignedFields.contains('mentionedById')) { mentionedById = mention.mentionedById; }
		if (mention.$assignedFields.contains('mentionedToId')) { mentionedToId = mention.mentionedToId; }
		if (mention.$assignedFields.contains('type')) { type = mention.type; }
		if (mention.$assignedFields.contains('taskId')) { taskId = mention.taskId; }
		if (mention.$assignedFields.contains('propertyId')) { propertyId = mention.propertyId; }
		if (mention.$assignedFields.contains('content')) { content = mention.content; }
		if (mention.$assignedFields.contains('isRead')) { isRead = mention.isRead; }
		if (mention.$assignedFields.contains('agencyId')) { agencyId = mention.agencyId; }
		if (mention.$assignedFields.contains('createdAt')) { createdAt = mention.createdAt; }
		if (mention.$assignedFields.contains('updatedAt')) { updatedAt = mention.updatedAt; }
		if (mention.$assignedFields.contains('deletedAt')) { deletedAt = mention.deletedAt; }
		if (mention.$assignedFields.contains('userId')) { userId = mention.userId; }
		if (mention.$assignedFields.contains('Agency')) { Agency = mention.Agency; }
		if (mention.$assignedFields.contains('mentionedBy')) { mentionedBy = mention.mentionedBy; }
		if (mention.$assignedFields.contains('mentionedTo')) { mentionedTo = mention.mentionedTo; }
		if (mention.$assignedFields.contains('Property')) { Property = mention.Property; }
		if (mention.$assignedFields.contains('Task')) { Task = mention.Task; }
		if (mention.$assignedFields.contains('user')) { user = mention.user; }
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
          ? {...?serializedTypes, 'Mention'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(mentionedById != null) 'mentionedById': mentionedById,
	if(mentionedToId != null) 'mentionedToId': mentionedToId,
	if(type != null) 'type': type?.toJson(),
	if(taskId != null) 'taskId': taskId,
	if(propertyId != null) 'propertyId': propertyId,
	if(content != null) 'content': content,
	if(isRead != null) 'isRead': isRead,
	if(agencyId != null) 'agencyId': agencyId,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(deletedAt != null) 'deletedAt': deletedAt?.toIso8601String(),
	if(userId != null) 'userId': userId,
	if(Agency != null && (!preventCircularSerialization || !serializedModels.contains('Agency'))) 'Agency': Agency?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(mentionedBy != null && (!preventCircularSerialization || !serializedModels.contains('User'))) 'mentionedBy': mentionedBy?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(mentionedTo != null && (!preventCircularSerialization || !serializedModels.contains('User'))) 'mentionedTo': mentionedTo?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(Property != null && (!preventCircularSerialization || !serializedModels.contains('Property'))) 'Property': Property?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(Task != null && (!preventCircularSerialization || !serializedModels.contains('Task'))) 'Task': Task?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(user != null && (!preventCircularSerialization || !serializedModels.contains('User'))) 'user': user?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is Mention &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    