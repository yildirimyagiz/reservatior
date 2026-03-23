import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/shared_amenity_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// SharedAmenity Providers

final SharedAmenityServiceProvider = Provider<SharedAmenityService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return SharedAmenityService(dioClient);
});

// List Provider
final sharedAmenityProvider = FutureProvider.autoDispose<List<SharedAmenity>>((ref) async {
  final service = ref.watch(SharedAmenityServiceProvider);
  return service.getSharedAmenitys();
});

// Create Provider
final SharedAmenityCreateProvider = FutureProvider.autoDispose<SharedAmenity>((ref) async {
  final service = ref.watch(SharedAmenityServiceProvider);
  return service.createSharedAmenity(SharedAmenity());
});

// Update Provider  
final SharedAmenityUpdateProvider = FutureProvider.autoDispose<SharedAmenity>((ref) async {
  final service = ref.watch(SharedAmenityServiceProvider);
  final state = ref.watch(SharedAmenityUpdateStateProvider);
  if (state['id'] != null && state['shared_amenity'] != null) {
    return service.updateSharedAmenity(state['id'], state['shared_amenity']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final SharedAmenityDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(SharedAmenityServiceProvider);
  final state = ref.watch(SharedAmenityDeleteStateProvider);
  if (state != null) {
    return service.deleteSharedAmenity(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final SharedAmenityUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final SharedAmenityDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final SharedAmenityLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(sharedAmenityProvider);
  final createAsync = ref.watch(SharedAmenityCreateProvider);
  final updateAsync = ref.watch(SharedAmenityUpdateProvider);
  final deleteAsync = ref.watch(SharedAmenityDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
