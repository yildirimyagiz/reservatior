import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/performance_alert_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// PerformanceAlert Providers

final PerformanceAlertServiceProvider = Provider<PerformanceAlertService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return PerformanceAlertService(dioClient);
});

// List Provider
final performanceAlertProvider = FutureProvider.autoDispose<List<PerformanceAlert>>((ref) async {
  final service = ref.watch(PerformanceAlertServiceProvider);
  return service.getPerformanceAlerts();
});

// Create Provider
final PerformanceAlertCreateProvider = FutureProvider.autoDispose<PerformanceAlert>((ref) async {
  final service = ref.watch(PerformanceAlertServiceProvider);
  return service.createPerformanceAlert(PerformanceAlert());
});

// Update Provider  
final PerformanceAlertUpdateProvider = FutureProvider.autoDispose<PerformanceAlert>((ref) async {
  final service = ref.watch(PerformanceAlertServiceProvider);
  final state = ref.watch(PerformanceAlertUpdateStateProvider);
  if (state['id'] != null && state['performance_alert'] != null) {
    return service.updatePerformanceAlert(state['id'], state['performance_alert']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final PerformanceAlertDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(PerformanceAlertServiceProvider);
  final state = ref.watch(PerformanceAlertDeleteStateProvider);
  if (state != null) {
    return service.deletePerformanceAlert(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final PerformanceAlertUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final PerformanceAlertDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final PerformanceAlertLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(performanceAlertProvider);
  final createAsync = ref.watch(PerformanceAlertCreateProvider);
  final updateAsync = ref.watch(PerformanceAlertUpdateProvider);
  final deleteAsync = ref.watch(PerformanceAlertDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
