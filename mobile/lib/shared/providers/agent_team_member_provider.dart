import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/agent_team_member_service.dart';
import 'package:reservatior/shared/repositories/agent_team_member_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final agentTeamMemberServiceProvider = Provider<AgentTeamMemberService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return AgentTeamMemberService(dioClient);
});

final agentTeamMemberRepositoryProvider = Provider<AgentTeamMemberRepository>((ref) {
  final service = ref.watch(agentTeamMemberServiceProvider);
  return AgentTeamMemberRepositoryImpl(service);
});

final agentTeamMemberListProvider = FutureProvider.autoDispose<List<AgentTeamMember>>((ref) async {
  final repository = ref.watch(agentTeamMemberRepositoryProvider);
  return repository.getAll();
});

final agentTeamMemberCreateProvider = StateProvider<AgentTeamMember?>((ref) => null);
final agentTeamMemberUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final agentTeamMemberDeleteProvider = StateProvider<String?>((ref) => null);
final agentTeamMemberLoadingProvider = StateProvider<bool>((ref) => false);
