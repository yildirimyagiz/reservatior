import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/shared/services/agent_team_member_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// agentTeamMember Providers

final agentTeamMemberServiceProvider = Provider<agentTeamMemberService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return agentTeamMemberService(dioClient);
});

// List Provider
final agentTeamMemberListProvider = FutureProvider.autoDispose<List<AgentTeamMember>>((ref) async {
  final service = ref.watch(agentTeamMemberServiceProvider);
  return service.getAll();
});

// Create Provider
final agentTeamMemberCreateProvider = FutureProvider.autoDispose<AgentTeamMember>((ref) async {
  final service = ref.watch(agentTeamMemberServiceProvider);
  final state = ref.watch(agentTeamMemberCreateStateProvider);
  if (state != null) {
    return service.create(state);
  }
  throw Exception('No create data provided');
});

// Update Provider  
final agentTeamMemberUpdateProvider = FutureProvider.autoDispose<AgentTeamMember>((ref) async {
  final service = ref.watch(agentTeamMemberServiceProvider);
  final state = ref.watch(agentTeamMemberUpdateStateProvider);
  if (state['id'] != null && state['data'] != null) {
    return service.update(state['id'], state['data']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final agentTeamMemberDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(agentTeamMemberServiceProvider);
  final state = ref.watch(agentTeamMemberDeleteStateProvider);
  if (state != null) {
    return service.delete(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final agentTeamMemberCreateStateProvider = StateProvider<AgentTeamMember?>((ref) => null);
final agentTeamMemberUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final agentTeamMemberDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final agentTeamMemberLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(agentTeamMemberListProvider);
  final createAsync = ref.watch(agentTeamMemberCreateProvider);
  final updateAsync = ref.watch(agentTeamMemberUpdateProvider);
  final deleteAsync = ref.watch(agentTeamMemberDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
