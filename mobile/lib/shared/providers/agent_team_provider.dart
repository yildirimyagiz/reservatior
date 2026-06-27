import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/agent_team_service.dart';
import 'package:reservatior/shared/repositories/agent_team_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final agentTeamServiceProvider = Provider<AgentTeamService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return AgentTeamService(dioClient);
});

final agentTeamRepositoryProvider = Provider<AgentTeamRepository>((ref) {
  final service = ref.watch(agentTeamServiceProvider);
  return AgentTeamRepositoryImpl(service);
});

final agentTeamListProvider = FutureProvider.autoDispose<List<AgentTeam>>((ref) async {
  final repository = ref.watch(agentTeamRepositoryProvider);
  return repository.getAll();
});

final agentTeamCreateProvider = StateProvider<AgentTeam?>((ref) => null);
final agentTeamUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final agentTeamDeleteProvider = StateProvider<String?>((ref) => null);
final agentTeamLoadingProvider = StateProvider<bool>((ref) => false);

final agentTeamMembersProvider = FutureProvider.family.autoDispose<List<Map<String, dynamic>>, String>((ref, teamId) async {
  final repository = ref.watch(agentTeamRepositoryProvider);
  return repository.getMembers(teamId);
});
