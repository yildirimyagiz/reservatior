import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/amenity_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// Amenity Providers

final amenityServiceProvider = Provider<AmenityService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return AmenityService(dioClient);
});

// State Providers for create/update/delete
final amenityCreateStateProvider = StateProvider<Amenity?>((ref) => null);
final amenityUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final amenityDeleteStateProvider = StateProvider<String?>((ref) => null);

// List Provider
final amenityListProvider = FutureProvider.autoDispose<List<Amenity>>((ref) async {
  final service = ref.watch(amenityServiceProvider);
  return service.getAmenitys();
});

// Create Provider
final amenityCreateProvider = FutureProvider.autoDispose<Amenity?>((ref) async {
  final service = ref.watch(amenityServiceProvider);
  final state = ref.watch(amenityCreateStateProvider);
  if (state != null) {
    return service.createAmenity(state);
  }
  return null;
});

// Update Provider  
final amenityUpdateProvider = FutureProvider.autoDispose<Amenity?>((ref) async {
  final service = ref.watch(amenityServiceProvider);
  final state = ref.watch(amenityUpdateStateProvider);
  if (state['id'] != null && state['amenity'] != null) {
    return service.updateAmenity(state['id'], state['amenity']);
  }
  return null;
});

// Delete Provider
final amenityDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(amenityServiceProvider);
  final state = ref.watch(amenityDeleteStateProvider);
  if (state != null) {
    return service.deleteAmenity(state);
  }
});

// Loading Provider
final amenityLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(amenityListProvider);
  final createAsync = ref.watch(amenityCreateProvider);
  final updateAsync = ref.watch(amenityUpdateProvider);
  final deleteAsync = ref.watch(amenityDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
