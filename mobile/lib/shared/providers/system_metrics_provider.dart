import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/system_metrics_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// SystemMetrics Providers

final SystemMetricsServiceProvider = Provider<SystemMetricsService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return SystemMetricsService(dioClient);
});

// List Provider
final systemMetricsProvider = FutureProvider.autoDispose<List<SystemMetrics>>((ref) async {
  final service = ref.watch(SystemMetricsServiceProvider);
  return service.getSystemMetricss();
});

// Create Provider
final SystemMetricsCreateProvider = FutureProvider.autoDispose<SystemMetrics>((ref) async {
  final service = ref.watch(SystemMetricsServiceProvider);
  return service.createSystemMetrics(SystemMetrics());
});

// Update Provider  
final SystemMetricsUpdateProvider = FutureProvider.autoDispose<SystemMetrics>((ref) async {
  final service = ref.watch(SystemMetricsServiceProvider);
  final state = ref.watch(SystemMetricsUpdateStateProvider);
  if (state['id'] != null && state['system_metrics'] != null) {
    return service.updateSystemMetrics(state['id'], state['system_metrics']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final SystemMetricsDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(SystemMetricsServiceProvider);
  final state = ref.watch(SystemMetricsDeleteStateProvider);
  if (state != null) {
    return service.deleteSystemMetrics(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final SystemMetricsUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final SystemMetricsDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final SystemMetricsLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(systemMetricsProvider);
  final createAsync = ref.watch(SystemMetricsCreateProvider);
  final updateAsync = ref.watch(SystemMetricsUpdateProvider);
  final deleteAsync = ref.watch(SystemMetricsDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
