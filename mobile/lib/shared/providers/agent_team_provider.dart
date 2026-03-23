import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/shared/services/agent_team_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// agentTeam Providers

final agentTeamServiceProvider = Provider<agentTeamService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return agentTeamService(dioClient);
});

// List Provider
final agentTeamListProvider = FutureProvider.autoDispose<List<agentTeam>>((ref) async {
  final service = ref.watch(agentTeamServiceProvider);
  return service.getAll();
});

// Create Provider
final agentTeamCreateProvider = FutureProvider.autoDispose<agentTeam>((ref) async {
  final service = ref.watch(agentTeamServiceProvider);
  final state = ref.watch(agentTeamCreateStateProvider);
  if (state != null) {
    return service.create(state);
  }
  throw Exception('No create data provided');
});

// Update Provider  
final agentTeamUpdateProvider = FutureProvider.autoDispose<agentTeam>((ref) async {
  final service = ref.watch(agentTeamServiceProvider);
  final state = ref.watch(agentTeamUpdateStateProvider);
  if (state['id'] != null && state['data'] != null) {
    return service.update(state['id'], state['data']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final agentTeamDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(agentTeamServiceProvider);
  final state = ref.watch(agentTeamDeleteStateProvider);
  if (state != null) {
    return service.delete(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final agentTeamCreateStateProvider = StateProvider<agentTeam?>((ref) => null);
final agentTeamUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final agentTeamDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final agentTeamLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(agentTeamListProvider);
  final createAsync = ref.watch(agentTeamCreateProvider);
  final updateAsync = ref.watch(agentTeamUpdateProvider);
  final deleteAsync = ref.watch(agentTeamDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
