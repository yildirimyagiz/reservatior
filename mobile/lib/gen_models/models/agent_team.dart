
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'user.dart';
import 'organization.dart';
import 'agent_team_member.dart';
import 'lead.dart';


class AgentTeam implements PrismaModel<String, AgentTeam> , Id<String> {
    @override
String? id;
	String? orgId;
	String? name;
	String? leaderId;
	User? leader;
	Organization? org;
	List<AgentTeamMember>? members;
	List<Lead>? leads;
	int? $membersCount;
	int? $leadsCount;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    AgentTeam({ this.id,
	 this.orgId,
	 this.name,
	 this.leaderId,
	 this.leader,
	 this.org,
	 this.members,
	 this.leads,
	this.$membersCount,
	this.$leadsCount,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<AgentTeam, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"orgId": (m) => m.orgId,

	"name": (m) => m.name,

	"leaderId": (m) => m.leaderId,

	"leader": (m) => m.leader,

	"org": (m) => m.org,

	"members": (m) => m.members,

	"leads": (m) => m.leads,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(AgentTeam) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in AgentTeam');
    }
    return propFunction as V? Function(AgentTeam);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory AgentTeam.fromJson(JsonMap json) =>
      AgentTeam(
        id: json['id'] as String?,
	orgId: json['orgId'] as String?,
	name: json['name'] as String?,
	leaderId: json['leaderId'] as String?,
	leader: json['leader'] != null ? User.fromJson(json['leader'] as JsonMap) : null,
	org: json['org'] != null ? Organization.fromJson(json['org'] as JsonMap) : null,
	members: json['members'] != null ? createModels<AgentTeamMember>((json['members'] as List).cast<JsonMap>(), AgentTeamMember.fromJson) : null,
	leads: json['leads'] != null ? createModels<Lead>((json['leads'] as List).cast<JsonMap>(), Lead.fromJson) : null,
	$membersCount: json['_count']?['members'] as int?,
	$leadsCount: json['_count']?['leads'] as int?,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    AgentTeam copyWith({
        Value<String?>? id,
		Value<String?>? orgId,
		Value<String?>? name,
		Value<String?>? leaderId,
		Value<User?>? leader,
		Value<Organization?>? org,
		Value<List<AgentTeamMember>?>? members,
		Value<List<Lead>?>? leads,
		int? $membersCount,
		int? $leadsCount,
        }) {
        return AgentTeam(
            id: id != null ? id.value : this.id,
		orgId: orgId != null ? orgId.value : this.orgId,
		name: name != null ? name.value : this.name,
		leaderId: leaderId != null ? leaderId.value : this.leaderId,
		leader: leader != null ? leader.value : this.leader,
		org: org != null ? org.value : this.org,
		members: members != null ? members.value : this.members,
		leads: leads != null ? leads.value : this.leads,
		$membersCount: $membersCount ?? this.$membersCount,
		$leadsCount: $leadsCount ?? this.$leadsCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    AgentTeam copyWithInstanceValues(AgentTeam agentTeam) {
        return AgentTeam(
            id: agentTeam.id ?? id,
		orgId: agentTeam.orgId ?? orgId,
		name: agentTeam.name ?? name,
		leaderId: agentTeam.leaderId ?? leaderId,
		leader: agentTeam.leader ?? leader,
		org: agentTeam.org ?? org,
		members: agentTeam.members ?? members,
		leads: agentTeam.leads ?? leads,
		$membersCount: agentTeam.$membersCount ?? $membersCount,
		$leadsCount: agentTeam.$leadsCount ?? $leadsCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    AgentTeam mergeWithInstanceValues(AgentTeam agentTeam) {
        return AgentTeam(
            id: agentTeam.$assignedFields.contains('id') ? agentTeam.id : id,
		orgId: agentTeam.$assignedFields.contains('orgId') ? agentTeam.orgId : orgId,
		name: agentTeam.$assignedFields.contains('name') ? agentTeam.name : name,
		leaderId: agentTeam.$assignedFields.contains('leaderId') ? agentTeam.leaderId : leaderId,
		leader: agentTeam.$assignedFields.contains('leader') ? agentTeam.leader : leader,
		org: agentTeam.$assignedFields.contains('org') ? agentTeam.org : org,
		members: (agentTeam.$assignedFields.contains('members') && agentTeam.members != null) ? mergeModelLists(members, agentTeam.members) : members,
		leads: (agentTeam.$assignedFields.contains('leads') && agentTeam.leads != null) ? mergeModelLists(leads, agentTeam.leads) : leads,
		$membersCount: agentTeam.$membersCount ?? $membersCount,
		$leadsCount: agentTeam.$leadsCount ?? $leadsCount
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    AgentTeam updateWithInstanceValues(AgentTeam agentTeam) {
        if (agentTeam.$assignedFields.contains('id')) { id = agentTeam.id; }
		if (agentTeam.$assignedFields.contains('orgId')) { orgId = agentTeam.orgId; }
		if (agentTeam.$assignedFields.contains('name')) { name = agentTeam.name; }
		if (agentTeam.$assignedFields.contains('leaderId')) { leaderId = agentTeam.leaderId; }
		if (agentTeam.$assignedFields.contains('leader')) { leader = agentTeam.leader; }
		if (agentTeam.$assignedFields.contains('org')) { org = agentTeam.org; }
		if (agentTeam.$assignedFields.contains('members') && agentTeam.members != null) { members = mergeModelLists(members, agentTeam.members); }
		if (agentTeam.$assignedFields.contains('leads') && agentTeam.leads != null) { leads = mergeModelLists(leads, agentTeam.leads); }
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
          ? {...?serializedTypes, 'AgentTeam'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(orgId != null) 'orgId': orgId,
	if(name != null) 'name': name,
	if(leaderId != null) 'leaderId': leaderId,
	if(leader != null && (!preventCircularSerialization || !serializedModels.contains('User'))) 'leader': leader?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(org != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'org': org?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(members != null && (!preventCircularSerialization || !serializedModels.contains('AgentTeamMember'))) 'members': members?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(leads != null && (!preventCircularSerialization || !serializedModels.contains('Lead'))) 'leads': leads?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
		if ($membersCount != null || $leadsCount != null) '_count': { 
		if ($membersCount != null) 'members': $membersCount, 
		if ($leadsCount != null) 'leads': $leadsCount, 
		},
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is AgentTeam &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    