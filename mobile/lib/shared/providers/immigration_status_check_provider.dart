import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/immigration_status_check_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// ImmigrationStatusCheck Providers

final ImmigrationStatusCheckServiceProvider = Provider<ImmigrationStatusCheckService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return ImmigrationStatusCheckService(dioClient);
});

// List Provider
final immigrationStatusCheckProvider = FutureProvider.autoDispose<List<ImmigrationStatusCheck>>((ref) async {
  final service = ref.watch(ImmigrationStatusCheckServiceProvider);
  return service.getImmigrationStatusChecks();
});

// Create Provider
final ImmigrationStatusCheckCreateProvider = FutureProvider.autoDispose<ImmigrationStatusCheck>((ref) async {
  final service = ref.watch(ImmigrationStatusCheckServiceProvider);
  return service.createImmigrationStatusCheck(ImmigrationStatusCheck());
});

// Update Provider  
final ImmigrationStatusCheckUpdateProvider = FutureProvider.autoDispose<ImmigrationStatusCheck>((ref) async {
  final service = ref.watch(ImmigrationStatusCheckServiceProvider);
  final state = ref.watch(ImmigrationStatusCheckUpdateStateProvider);
  if (state['id'] != null && state['immigration_status_check'] != null) {
    return service.updateImmigrationStatusCheck(state['id'], state['immigration_status_check']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final ImmigrationStatusCheckDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(ImmigrationStatusCheckServiceProvider);
  final state = ref.watch(ImmigrationStatusCheckDeleteStateProvider);
  if (state != null) {
    return service.deleteImmigrationStatusCheck(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final ImmigrationStatusCheckUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final ImmigrationStatusCheckDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final ImmigrationStatusCheckLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(immigrationStatusCheckProvider);
  final createAsync = ref.watch(ImmigrationStatusCheckCreateProvider);
  final updateAsync = ref.watch(ImmigrationStatusCheckUpdateProvider);
  final deleteAsync = ref.watch(ImmigrationStatusCheckDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
