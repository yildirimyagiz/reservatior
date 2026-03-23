import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/shared/services/agent_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// Agent Providers

final agentServiceProvider = Provider<AgentService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return AgentService(dioClient);
});

// List Provider
final agentListProvider = FutureProvider.autoDispose<List<Agent>>((ref) async {
  final service = ref.watch(agentServiceProvider);
  return service.getAll();
});

// Create Provider
final agentCreateProvider = FutureProvider.autoDispose<Agent>((ref) async {
  final service = ref.watch(agentServiceProvider);
  final state = ref.watch(agentCreateStateProvider);
  if (state != null) {
    return service.create(state);
  }
  throw Exception('No create data provided');
});

// Update Provider  
final agentUpdateProvider = FutureProvider.autoDispose<Agent>((ref) async {
  final service = ref.watch(agentServiceProvider);
  final state = ref.watch(agentUpdateStateProvider);
  if (state['id'] != null && state['agent'] != null) {
    return service.update(state['id'], state['agent']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final agentDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(agentServiceProvider);
  final state = ref.watch(agentDeleteStateProvider);
  if (state != null) {
    return service.delete(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final agentCreateStateProvider = StateProvider<Agent?>((ref) => null);
final agentUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final agentDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final agentLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(agentListProvider);
  final createAsync = ref.watch(agentCreateProvider);
  final updateAsync = ref.watch(agentUpdateProvider);
  final deleteAsync = ref.watch(agentDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
