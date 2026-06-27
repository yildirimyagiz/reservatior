import 'agent_team.dart';
import 'user.dart';

class AgentTeamMember {
  final String id;
  final String teamId;
  final String userId;
  final String role;
  final AgentTeam team;
  final User user;

  const AgentTeamMember({
    required this.id,
    required this.teamId,
    required this.userId,
    required this.role,
    required this.team,
    required this.user,
  });

  factory AgentTeamMember.fromJson(Map<String, dynamic> json) {
    return AgentTeamMember(
      id: json['id'] as String,
      teamId: json['teamId'] as String,
      userId: json['userId'] as String,
      role: json['role'] as String,
      team: AgentTeam.fromJson(json['team'] as Map<String, dynamic>),
      user: User.fromJson(json['user'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'teamId': teamId,
      'userId': userId,
      'role': role,
      'team': team.toJson(),
      'user': user.toJson(),
    };
  }

  AgentTeamMember copyWith({
    String? id,
    String? teamId,
    String? userId,
    String? role,
    AgentTeam? team,
    User? user,
  }) {
    return AgentTeamMember(
      id: id ?? this.id,
      teamId: teamId ?? this.teamId,
      userId: userId ?? this.userId,
      role: role ?? this.role,
      team: team ?? this.team,
      user: user ?? this.user,
    );
  }
}
