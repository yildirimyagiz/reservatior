import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/health_check_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// HealthCheck Providers

final HealthCheckServiceProvider = Provider<HealthCheckService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return HealthCheckService(dioClient);
});

// List Provider
final healthCheckProvider = FutureProvider.autoDispose<List<HealthCheck>>((ref) async {
  final service = ref.watch(HealthCheckServiceProvider);
  return service.getHealthChecks();
});

// Create Provider
final HealthCheckCreateProvider = FutureProvider.autoDispose<HealthCheck>((ref) async {
  final service = ref.watch(HealthCheckServiceProvider);
  return service.createHealthCheck(HealthCheck());
});

// Update Provider  
final HealthCheckUpdateProvider = FutureProvider.autoDispose<HealthCheck>((ref) async {
  final service = ref.watch(HealthCheckServiceProvider);
  final state = ref.watch(HealthCheckUpdateStateProvider);
  if (state['id'] != null && state['health_check'] != null) {
    return service.updateHealthCheck(state['id'], state['health_check']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final HealthCheckDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(HealthCheckServiceProvider);
  final state = ref.watch(HealthCheckDeleteStateProvider);
  if (state != null) {
    return service.deleteHealthCheck(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final HealthCheckUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final HealthCheckDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final HealthCheckLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(healthCheckProvider);
  final createAsync = ref.watch(HealthCheckCreateProvider);
  final updateAsync = ref.watch(HealthCheckUpdateProvider);
  final deleteAsync = ref.watch(HealthCheckDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
