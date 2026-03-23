
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'agent_team.dart';
import 'user.dart';


class AgentTeamMember implements PrismaModel<String, AgentTeamMember> , Id<String> {
    @override
String? id;
	String? teamId;
	String? userId;
	String? role;
	AgentTeam? team;
	User? user;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    AgentTeamMember({ this.id,
	 this.teamId,
	 this.userId,
	 this.role,
	 this.team,
	 this.user,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<AgentTeamMember, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"teamId": (m) => m.teamId,

	"userId": (m) => m.userId,

	"role": (m) => m.role,

	"team": (m) => m.team,

	"user": (m) => m.user,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(AgentTeamMember) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in AgentTeamMember');
    }
    return propFunction as V? Function(AgentTeamMember);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory AgentTeamMember.fromJson(JsonMap json) =>
      AgentTeamMember(
        id: json['id'] as String?,
	teamId: json['teamId'] as String?,
	userId: json['userId'] as String?,
	role: json['role'] as String?,
	team: json['team'] != null ? AgentTeam.fromJson(json['team'] as JsonMap) : null,
	user: json['user'] != null ? User.fromJson(json['user'] as JsonMap) : null,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    AgentTeamMember copyWith({
        Value<String?>? id,
		Value<String?>? teamId,
		Value<String?>? userId,
		Value<String?>? role,
		Value<AgentTeam?>? team,
		Value<User?>? user,
        }) {
        return AgentTeamMember(
            id: id != null ? id.value : this.id,
		teamId: teamId != null ? teamId.value : this.teamId,
		userId: userId != null ? userId.value : this.userId,
		role: role != null ? role.value : this.role,
		team: team != null ? team.value : this.team,
		user: user != null ? user.value : this.user
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    AgentTeamMember copyWithInstanceValues(AgentTeamMember agentTeamMember) {
        return AgentTeamMember(
            id: agentTeamMember.id ?? id,
		teamId: agentTeamMember.teamId ?? teamId,
		userId: agentTeamMember.userId ?? userId,
		role: agentTeamMember.role ?? role,
		team: agentTeamMember.team ?? team,
		user: agentTeamMember.user ?? user
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    AgentTeamMember mergeWithInstanceValues(AgentTeamMember agentTeamMember) {
        return AgentTeamMember(
            id: agentTeamMember.$assignedFields.contains('id') ? agentTeamMember.id : id,
		teamId: agentTeamMember.$assignedFields.contains('teamId') ? agentTeamMember.teamId : teamId,
		userId: agentTeamMember.$assignedFields.contains('userId') ? agentTeamMember.userId : userId,
		role: agentTeamMember.$assignedFields.contains('role') ? agentTeamMember.role : role,
		team: agentTeamMember.$assignedFields.contains('team') ? agentTeamMember.team : team,
		user: agentTeamMember.$assignedFields.contains('user') ? agentTeamMember.user : user
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    AgentTeamMember updateWithInstanceValues(AgentTeamMember agentTeamMember) {
        if (agentTeamMember.$assignedFields.contains('id')) { id = agentTeamMember.id; }
		if (agentTeamMember.$assignedFields.contains('teamId')) { teamId = agentTeamMember.teamId; }
		if (agentTeamMember.$assignedFields.contains('userId')) { userId = agentTeamMember.userId; }
		if (agentTeamMember.$assignedFields.contains('role')) { role = agentTeamMember.role; }
		if (agentTeamMember.$assignedFields.contains('team')) { team = agentTeamMember.team; }
		if (agentTeamMember.$assignedFields.contains('user')) { user = agentTeamMember.user; }
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
          ? {...?serializedTypes, 'AgentTeamMember'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(teamId != null) 'teamId': teamId,
	if(userId != null) 'userId': userId,
	if(role != null) 'role': role,
	if(team != null && (!preventCircularSerialization || !serializedModels.contains('AgentTeam'))) 'team': team?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(user != null && (!preventCircularSerialization || !serializedModels.contains('User'))) 'user': user?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is AgentTeamMember &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    