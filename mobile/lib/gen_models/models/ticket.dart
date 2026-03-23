
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'ticket_status.dart';
import 'communication_log.dart';
import 'user.dart';


class Ticket implements PrismaModel<String, Ticket> , Id<String> {
    @override
String? id;
	String? cuid;
	String? subject;
	String? description;
	TicketStatus? status;
	DateTime? createdAt;
	DateTime? updatedAt;
	DateTime? closedAt;
	DateTime? deletedAt;
	String? userId;
	String? agentId;
	List<CommunicationLog>? CommunicationLogs;
	User? Agent;
	User? User;
	int? $CommunicationLogsCount;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    Ticket({ this.id,
	 this.cuid,
	 this.subject,
	 this.description,
	 this.status = TicketStatus.OPEN,
	 this.createdAt,
	 this.updatedAt,
	 this.closedAt,
	 this.deletedAt,
	 this.userId,
	 this.agentId,
	 this.CommunicationLogs,
	 this.Agent,
	 this.User,
	this.$CommunicationLogsCount,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<Ticket, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"cuid": (m) => m.cuid,

	"subject": (m) => m.subject,

	"description": (m) => m.description,

	"status": (m) => m.status,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"closedAt": (m) => m.closedAt,

	"deletedAt": (m) => m.deletedAt,

	"userId": (m) => m.userId,

	"agentId": (m) => m.agentId,

	"CommunicationLogs": (m) => m.CommunicationLogs,

	"Agent": (m) => m.Agent,

	"User": (m) => m.User,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(Ticket) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in Ticket');
    }
    return propFunction as V? Function(Ticket);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory Ticket.fromJson(JsonMap json) =>
      Ticket(
        id: json['id'] as String?,
	cuid: json['cuid'] as String?,
	subject: json['subject'] as String?,
	description: json['description'] as String?,
	status: json['status'] != null ? TicketStatus.fromJson(json['status']) : null,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	closedAt: json['closedAt'] != null ? DateTime.parse(json['closedAt']) : null,
	deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
	userId: json['userId'] as String?,
	agentId: json['agentId'] as String?,
	CommunicationLogs: json['CommunicationLogs'] != null ? createModels<CommunicationLog>((json['CommunicationLogs'] as List).cast<JsonMap>(), CommunicationLog.fromJson) : null,
	Agent: json['Agent'] != null ? User.fromJson(json['Agent'] as JsonMap) : null,
	User: json['User'] != null ? User.fromJson(json['User'] as JsonMap) : null,
	$CommunicationLogsCount: json['_count']?['CommunicationLogs'] as int?,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    Ticket copyWith({
        Value<String?>? id,
		Value<String?>? cuid,
		Value<String?>? subject,
		Value<String?>? description,
		Value<TicketStatus?>? status,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<DateTime?>? closedAt,
		Value<DateTime?>? deletedAt,
		Value<String?>? userId,
		Value<String?>? agentId,
		Value<List<CommunicationLog>?>? CommunicationLogs,
		Value<User?>? Agent,
		Value<User?>? User,
		int? $CommunicationLogsCount,
        }) {
        return Ticket(
            id: id != null ? id.value : this.id,
		cuid: cuid != null ? cuid.value : this.cuid,
		subject: subject != null ? subject.value : this.subject,
		description: description != null ? description.value : this.description,
		status: status != null ? status.value : this.status,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		closedAt: closedAt != null ? closedAt.value : this.closedAt,
		deletedAt: deletedAt != null ? deletedAt.value : this.deletedAt,
		userId: userId != null ? userId.value : this.userId,
		agentId: agentId != null ? agentId.value : this.agentId,
		CommunicationLogs: CommunicationLogs != null ? CommunicationLogs.value : this.CommunicationLogs,
		Agent: Agent != null ? Agent.value : this.Agent,
		User: User != null ? User.value : this.User,
		$CommunicationLogsCount: $CommunicationLogsCount ?? this.$CommunicationLogsCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    Ticket copyWithInstanceValues(Ticket ticket) {
        return Ticket(
            id: ticket.id ?? id,
		cuid: ticket.cuid ?? cuid,
		subject: ticket.subject ?? subject,
		description: ticket.description ?? description,
		status: ticket.status ?? status,
		createdAt: ticket.createdAt ?? createdAt,
		updatedAt: ticket.updatedAt ?? updatedAt,
		closedAt: ticket.closedAt ?? closedAt,
		deletedAt: ticket.deletedAt ?? deletedAt,
		userId: ticket.userId ?? userId,
		agentId: ticket.agentId ?? agentId,
		CommunicationLogs: ticket.CommunicationLogs ?? CommunicationLogs,
		Agent: ticket.Agent ?? Agent,
		User: ticket.User ?? User,
		$CommunicationLogsCount: ticket.$CommunicationLogsCount ?? $CommunicationLogsCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    Ticket mergeWithInstanceValues(Ticket ticket) {
        return Ticket(
            id: ticket.$assignedFields.contains('id') ? ticket.id : id,
		cuid: ticket.$assignedFields.contains('cuid') ? ticket.cuid : cuid,
		subject: ticket.$assignedFields.contains('subject') ? ticket.subject : subject,
		description: ticket.$assignedFields.contains('description') ? ticket.description : description,
		status: ticket.$assignedFields.contains('status') ? ticket.status : status,
		createdAt: ticket.$assignedFields.contains('createdAt') ? ticket.createdAt : createdAt,
		updatedAt: ticket.$assignedFields.contains('updatedAt') ? ticket.updatedAt : updatedAt,
		closedAt: ticket.$assignedFields.contains('closedAt') ? ticket.closedAt : closedAt,
		deletedAt: ticket.$assignedFields.contains('deletedAt') ? ticket.deletedAt : deletedAt,
		userId: ticket.$assignedFields.contains('userId') ? ticket.userId : userId,
		agentId: ticket.$assignedFields.contains('agentId') ? ticket.agentId : agentId,
		CommunicationLogs: (ticket.$assignedFields.contains('CommunicationLogs') && ticket.CommunicationLogs != null) ? mergeModelLists(CommunicationLogs, ticket.CommunicationLogs) : CommunicationLogs,
		Agent: ticket.$assignedFields.contains('Agent') ? ticket.Agent : Agent,
		User: ticket.$assignedFields.contains('User') ? ticket.User : User,
		$CommunicationLogsCount: ticket.$CommunicationLogsCount ?? $CommunicationLogsCount
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    Ticket updateWithInstanceValues(Ticket ticket) {
        if (ticket.$assignedFields.contains('id')) { id = ticket.id; }
		if (ticket.$assignedFields.contains('cuid')) { cuid = ticket.cuid; }
		if (ticket.$assignedFields.contains('subject')) { subject = ticket.subject; }
		if (ticket.$assignedFields.contains('description')) { description = ticket.description; }
		if (ticket.$assignedFields.contains('status')) { status = ticket.status; }
		if (ticket.$assignedFields.contains('createdAt')) { createdAt = ticket.createdAt; }
		if (ticket.$assignedFields.contains('updatedAt')) { updatedAt = ticket.updatedAt; }
		if (ticket.$assignedFields.contains('closedAt')) { closedAt = ticket.closedAt; }
		if (ticket.$assignedFields.contains('deletedAt')) { deletedAt = ticket.deletedAt; }
		if (ticket.$assignedFields.contains('userId')) { userId = ticket.userId; }
		if (ticket.$assignedFields.contains('agentId')) { agentId = ticket.agentId; }
		if (ticket.$assignedFields.contains('CommunicationLogs') && ticket.CommunicationLogs != null) { CommunicationLogs = mergeModelLists(CommunicationLogs, ticket.CommunicationLogs); }
		if (ticket.$assignedFields.contains('Agent')) { Agent = ticket.Agent; }
		if (ticket.$assignedFields.contains('User')) { User = ticket.User; }
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
          ? {...?serializedTypes, 'Ticket'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(cuid != null) 'cuid': cuid,
	if(subject != null) 'subject': subject,
	if(description != null) 'description': description,
	if(status != null) 'status': status?.toJson(),
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(closedAt != null) 'closedAt': closedAt?.toIso8601String(),
	if(deletedAt != null) 'deletedAt': deletedAt?.toIso8601String(),
	if(userId != null) 'userId': userId,
	if(agentId != null) 'agentId': agentId,
	if(CommunicationLogs != null && (!preventCircularSerialization || !serializedModels.contains('CommunicationLog'))) 'CommunicationLogs': CommunicationLogs?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(Agent != null && (!preventCircularSerialization || !serializedModels.contains('User'))) 'Agent': Agent?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(User != null && (!preventCircularSerialization || !serializedModels.contains('User'))) 'User': User?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
		if ($CommunicationLogsCount != null) '_count': { 
		if ($CommunicationLogsCount != null) 'CommunicationLogs': $CommunicationLogsCount, 
		},
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is Ticket &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    