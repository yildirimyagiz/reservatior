import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/property_amenity_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// PropertyAmenity Providers

final PropertyAmenityServiceProvider = Provider<PropertyAmenityService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return PropertyAmenityService(dioClient);
});

// List Provider
final propertyAmenityProvider = FutureProvider.autoDispose<List<PropertyAmenity>>((ref) async {
  final service = ref.watch(PropertyAmenityServiceProvider);
  return service.getPropertyAmenitys();
});

// Create Provider
final PropertyAmenityCreateProvider = FutureProvider.autoDispose<PropertyAmenity>((ref) async {
  final service = ref.watch(PropertyAmenityServiceProvider);
  return service.createPropertyAmenity(PropertyAmenity());
});

// Update Provider  
final PropertyAmenityUpdateProvider = FutureProvider.autoDispose<PropertyAmenity>((ref) async {
  final service = ref.watch(PropertyAmenityServiceProvider);
  final state = ref.watch(PropertyAmenityUpdateStateProvider);
  if (state['id'] != null && state['property_amenity'] != null) {
    return service.updatePropertyAmenity(state['id'], state['property_amenity']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final PropertyAmenityDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(PropertyAmenityServiceProvider);
  final state = ref.watch(PropertyAmenityDeleteStateProvider);
  if (state != null) {
    return service.deletePropertyAmenity(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final PropertyAmenityUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final PropertyAmenityDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final PropertyAmenityLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(propertyAmenityProvider);
  final createAsync = ref.watch(PropertyAmenityCreateProvider);
  final updateAsync = ref.watch(PropertyAmenityUpdateProvider);
  final deleteAsync = ref.watch(PropertyAmenityDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
