import 'package:reservatior/shared/models/agent.dart';
import 'package:reservatior/shared/models/agent_assignment.dart';
import 'package:reservatior/shared/models/agent_performance.dart';
import 'package:reservatior/shared/models/agent_team.dart';
import 'package:reservatior/shared/models/agent_team_member.dart';

abstract class AbstractAgentRepository {
  Future<List<Agent>> getAgents({int page, int limit, String? orgId});

  Future<Agent> getAgentById(String id);

  Future<List<AgentAssignment>> getAgentAssignments({int page, int limit});

  Future<AgentAssignment> getAgentAssignmentById(String id);

  Future<List<AgentPerformance>> getAgentPerformances({int page, int limit});

  Future<AgentPerformance> getAgentPerformanceById(String id);

  Future<List<AgentTeam>> getAgentTeams({int page, int limit, String? orgId});

  Future<AgentTeam> getAgentTeamById(String id);

  Future<List<AgentTeamMember>> getAgentTeamMembers({int page, int limit});

  Future<AgentTeamMember> getAgentTeamMemberById(String id);
}
