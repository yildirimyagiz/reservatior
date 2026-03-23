import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/shared/services/agent_assignment_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// agentAssignment Providers

final agentAssignmentServiceProvider = Provider<agentAssignmentService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return agentAssignmentService(dioClient);
});

// List Provider
final agentAssignmentListProvider = FutureProvider.autoDispose<List<agentAssignment>>((ref) async {
  final service = ref.watch(agentAssignmentServiceProvider);
  return service.getAll();
});

// Create Provider
final agentAssignmentCreateProvider = FutureProvider.autoDispose<agentAssignment>((ref) async {
  final service = ref.watch(agentAssignmentServiceProvider);
  final state = ref.watch(agentAssignmentCreateStateProvider);
  if (state != null) {
    return service.create(state);
  }
  throw Exception('No create data provided');
});

// Update Provider  
final agentAssignmentUpdateProvider = FutureProvider.autoDispose<agentAssignment>((ref) async {
  final service = ref.watch(agentAssignmentServiceProvider);
  final state = ref.watch(agentAssignmentUpdateStateProvider);
  if (state['id'] != null && state['data'] != null) {
    return service.update(state['id'], state['data']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final agentAssignmentDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(agentAssignmentServiceProvider);
  final state = ref.watch(agentAssignmentDeleteStateProvider);
  if (state != null) {
    return service.delete(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final agentAssignmentCreateStateProvider = StateProvider<agentAssignment?>((ref) => null);
final agentAssignmentUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final agentAssignmentDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final agentAssignmentLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(agentAssignmentListProvider);
  final createAsync = ref.watch(agentAssignmentCreateProvider);
  final updateAsync = ref.watch(agentAssignmentUpdateProvider);
  final deleteAsync = ref.watch(agentAssignmentDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
