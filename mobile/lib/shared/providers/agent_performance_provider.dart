import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/shared/services/agent_performance_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// agentPerformance Providers

final agentPerformanceServiceProvider = Provider<agentPerformanceService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return agentPerformanceService(dioClient);
});

// List Provider
final agentPerformanceListProvider = FutureProvider.autoDispose<List<agentPerformance>>((ref) async {
  final service = ref.watch(agentPerformanceServiceProvider);
  return service.getAll();
});

// Create Provider
final agentPerformanceCreateProvider = FutureProvider.autoDispose<agentPerformance>((ref) async {
  final service = ref.watch(agentPerformanceServiceProvider);
  final state = ref.watch(agentPerformanceCreateStateProvider);
  if (state != null) {
    return service.create(state);
  }
  throw Exception('No create data provided');
});

// Update Provider  
final agentPerformanceUpdateProvider = FutureProvider.autoDispose<agentPerformance>((ref) async {
  final service = ref.watch(agentPerformanceServiceProvider);
  final state = ref.watch(agentPerformanceUpdateStateProvider);
  if (state['id'] != null && state['data'] != null) {
    return service.update(state['id'], state['data']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final agentPerformanceDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(agentPerformanceServiceProvider);
  final state = ref.watch(agentPerformanceDeleteStateProvider);
  if (state != null) {
    return service.delete(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final agentPerformanceCreateStateProvider = StateProvider<agentPerformance?>((ref) => null);
final agentPerformanceUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final agentPerformanceDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final agentPerformanceLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(agentPerformanceListProvider);
  final createAsync = ref.watch(agentPerformanceCreateProvider);
  final updateAsync = ref.watch(agentPerformanceUpdateProvider);
  final deleteAsync = ref.watch(agentPerformanceDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
