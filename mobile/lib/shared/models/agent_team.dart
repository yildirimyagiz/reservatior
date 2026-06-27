import 'agent_team_member.dart';
import 'lead.dart';
import 'organization.dart';
import 'user.dart';

class AgentTeam {
  final String id;
  final String orgId;
  final String name;
  final String leaderId;
  final User leader;
  final Organization org;
  final List<AgentTeamMember> members;
  final List<Lead> leads;

  const AgentTeam({
    required this.id,
    required this.orgId,
    required this.name,
    required this.leaderId,
    required this.leader,
    required this.org,
    this.members = const [],
    this.leads = const [],
  });

  factory AgentTeam.fromJson(Map<String, dynamic> json) {
    return AgentTeam(
      id: json['id'] as String,
      orgId: json['orgId'] as String,
      name: json['name'] as String,
      leaderId: json['leaderId'] as String,
      leader: User.fromJson(json['leader'] as Map<String, dynamic>),
      org: Organization.fromJson(json['org'] as Map<String, dynamic>),
      members: (json['members'] as List<dynamic>?)?.map((e) => AgentTeamMember.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      leads: (json['leads'] as List<dynamic>?)?.map((e) => Lead.fromJson(e as Map<String, dynamic>)).toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'name': name,
      'leaderId': leaderId,
      'leader': leader.toJson(),
      'org': org.toJson(),
      'members': members.map((e) => e.toJson()).toList(),
      'leads': leads.map((e) => e.toJson()).toList(),
    };
  }

  AgentTeam copyWith({
    String? id,
    String? orgId,
    String? name,
    String? leaderId,
    User? leader,
    Organization? org,
    List<AgentTeamMember>? members,
    List<Lead>? leads,
  }) {
    return AgentTeam(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      name: name ?? this.name,
      leaderId: leaderId ?? this.leaderId,
      leader: leader ?? this.leader,
      org: org ?? this.org,
      members: members ?? this.members,
      leads: leads ?? this.leads,
    );
  }
}
