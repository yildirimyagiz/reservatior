import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/integration_log_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// IntegrationLog Providers

final IntegrationLogServiceProvider = Provider<IntegrationLogService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return IntegrationLogService(dioClient);
});

// List Provider
final integrationLogProvider = FutureProvider.autoDispose<List<IntegrationLog>>((ref) async {
  final service = ref.watch(IntegrationLogServiceProvider);
  return service.getIntegrationLogs();
});

// Create Provider
final IntegrationLogCreateProvider = FutureProvider.autoDispose<IntegrationLog>((ref) async {
  final service = ref.watch(IntegrationLogServiceProvider);
  return service.createIntegrationLog(IntegrationLog());
});

// Update Provider  
final IntegrationLogUpdateProvider = FutureProvider.autoDispose<IntegrationLog>((ref) async {
  final service = ref.watch(IntegrationLogServiceProvider);
  final state = ref.watch(IntegrationLogUpdateStateProvider);
  if (state['id'] != null && state['integration_log'] != null) {
    return service.updateIntegrationLog(state['id'], state['integration_log']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final IntegrationLogDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(IntegrationLogServiceProvider);
  final state = ref.watch(IntegrationLogDeleteStateProvider);
  if (state != null) {
    return service.deleteIntegrationLog(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final IntegrationLogUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final IntegrationLogDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final IntegrationLogLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(integrationLogProvider);
  final createAsync = ref.watch(IntegrationLogCreateProvider);
  final updateAsync = ref.watch(IntegrationLogUpdateProvider);
  final deleteAsync = ref.watch(IntegrationLogDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
