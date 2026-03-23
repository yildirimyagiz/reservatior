import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/shared/services/property_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// Property Providers

final propertyServiceProvider = Provider<PropertyService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return PropertyService(dioClient);
});

// List Provider
final propertyListProvider = FutureProvider.autoDispose<List<Property>>((ref) async {
  final service = ref.watch(propertyServiceProvider);
  return service.getAll();
});

// Create Provider
final propertyCreateProvider = FutureProvider.autoDispose<Property>((ref) async {
  final service = ref.watch(propertyServiceProvider);
  final state = ref.watch(propertyCreateStateProvider);
  if (state != null) {
    return service.create(state);
  }
  throw Exception('No create data provided');
});

// Update Provider  
final propertyUpdateProvider = FutureProvider.autoDispose<Property>((ref) async {
  final service = ref.watch(propertyServiceProvider);
  final state = ref.watch(propertyUpdateStateProvider);
  if (state['id'] != null && state['data'] != null) {
    return service.update(state['id'], state['data']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final propertyDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(propertyServiceProvider);
  final state = ref.watch(propertyDeleteStateProvider);
  if (state != null) {
    return service.delete(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final propertyCreateStateProvider = StateProvider<Property?>((ref) => null);
final propertyUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final propertyDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final propertyLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(propertyListProvider);
  final createAsync = ref.watch(propertyCreateProvider);
  final updateAsync = ref.watch(propertyUpdateProvider);
  final deleteAsync = ref.watch(propertyDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
