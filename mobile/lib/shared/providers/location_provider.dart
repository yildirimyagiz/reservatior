import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/location_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// Location Providers

final LocationServiceProvider = Provider<LocationService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return LocationService(dioClient);
});

// List Provider
final locationProvider = FutureProvider.autoDispose<List<Location>>((ref) async {
  final service = ref.watch(LocationServiceProvider);
  return service.getLocations();
});

// Create Provider
final LocationCreateProvider = FutureProvider.autoDispose<Location>((ref) async {
  final service = ref.watch(LocationServiceProvider);
  return service.createLocation(Location());
});

// Update Provider  
final LocationUpdateProvider = FutureProvider.autoDispose<Location>((ref) async {
  final service = ref.watch(LocationServiceProvider);
  final state = ref.watch(LocationUpdateStateProvider);
  if (state['id'] != null && state['location'] != null) {
    return service.updateLocation(state['id'], state['location']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final LocationDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(LocationServiceProvider);
  final state = ref.watch(LocationDeleteStateProvider);
  if (state != null) {
    return service.deleteLocation(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final LocationUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final LocationDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final LocationLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(locationProvider);
  final createAsync = ref.watch(LocationCreateProvider);
  final updateAsync = ref.watch(LocationUpdateProvider);
  final deleteAsync = ref.watch(LocationDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
