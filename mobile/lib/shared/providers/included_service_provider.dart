import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/included_service_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// IncludedService Providers

final IncludedServiceServiceProvider = Provider<IncludedServiceService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return IncludedServiceService(dioClient);
});

// List Provider
final includedServiceProvider = FutureProvider.autoDispose<List<IncludedService>>((ref) async {
  final service = ref.watch(IncludedServiceServiceProvider);
  return service.getIncludedServices();
});

// Create Provider
final IncludedServiceCreateProvider = FutureProvider.autoDispose<IncludedService>((ref) async {
  final service = ref.watch(IncludedServiceServiceProvider);
  return service.createIncludedService(IncludedService());
});

// Update Provider  
final IncludedServiceUpdateProvider = FutureProvider.autoDispose<IncludedService>((ref) async {
  final service = ref.watch(IncludedServiceServiceProvider);
  final state = ref.watch(IncludedServiceUpdateStateProvider);
  if (state['id'] != null && state['included_service'] != null) {
    return service.updateIncludedService(state['id'], state['included_service']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final IncludedServiceDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(IncludedServiceServiceProvider);
  final state = ref.watch(IncludedServiceDeleteStateProvider);
  if (state != null) {
    return service.deleteIncludedService(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final IncludedServiceUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final IncludedServiceDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final IncludedServiceLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(includedServiceProvider);
  final createAsync = ref.watch(IncludedServiceCreateProvider);
  final updateAsync = ref.watch(IncludedServiceUpdateProvider);
  final deleteAsync = ref.watch(IncludedServiceDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
