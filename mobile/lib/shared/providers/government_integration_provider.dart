import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/government_integration_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// GovernmentIntegration Providers

final GovernmentIntegrationServiceProvider = Provider<GovernmentIntegrationService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return GovernmentIntegrationService(dioClient);
});

// List Provider
final governmentIntegrationProvider = FutureProvider.autoDispose<List<GovernmentIntegration>>((ref) async {
  final service = ref.watch(GovernmentIntegrationServiceProvider);
  return service.getGovernmentIntegrations();
});

// Create Provider
final GovernmentIntegrationCreateProvider = FutureProvider.autoDispose<GovernmentIntegration>((ref) async {
  final service = ref.watch(GovernmentIntegrationServiceProvider);
  return service.createGovernmentIntegration(GovernmentIntegration());
});

// Update Provider  
final GovernmentIntegrationUpdateProvider = FutureProvider.autoDispose<GovernmentIntegration>((ref) async {
  final service = ref.watch(GovernmentIntegrationServiceProvider);
  final state = ref.watch(GovernmentIntegrationUpdateStateProvider);
  if (state['id'] != null && state['government_integration'] != null) {
    return service.updateGovernmentIntegration(state['id'], state['government_integration']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final GovernmentIntegrationDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(GovernmentIntegrationServiceProvider);
  final state = ref.watch(GovernmentIntegrationDeleteStateProvider);
  if (state != null) {
    return service.deleteGovernmentIntegration(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final GovernmentIntegrationUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final GovernmentIntegrationDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final GovernmentIntegrationLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(governmentIntegrationProvider);
  final createAsync = ref.watch(GovernmentIntegrationCreateProvider);
  final updateAsync = ref.watch(GovernmentIntegrationUpdateProvider);
  final deleteAsync = ref.watch(GovernmentIntegrationDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
