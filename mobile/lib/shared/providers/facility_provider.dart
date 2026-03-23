import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/facility_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// Facility Providers

final FacilityServiceProvider = Provider<FacilityService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return FacilityService(dioClient);
});

// List Provider
final facilityProvider = FutureProvider.autoDispose<List<Facility>>((ref) async {
  final service = ref.watch(FacilityServiceProvider);
  return service.getFacilitys();
});

// Create Provider
final FacilityCreateProvider = FutureProvider.autoDispose<Facility>((ref) async {
  final service = ref.watch(FacilityServiceProvider);
  return service.createFacility(Facility());
});

// Update Provider  
final FacilityUpdateProvider = FutureProvider.autoDispose<Facility>((ref) async {
  final service = ref.watch(FacilityServiceProvider);
  final state = ref.watch(FacilityUpdateStateProvider);
  if (state['id'] != null && state['facility'] != null) {
    return service.updateFacility(state['id'], state['facility']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final FacilityDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(FacilityServiceProvider);
  final state = ref.watch(FacilityDeleteStateProvider);
  if (state != null) {
    return service.deleteFacility(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final FacilityUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final FacilityDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final FacilityLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(facilityProvider);
  final createAsync = ref.watch(FacilityCreateProvider);
  final updateAsync = ref.watch(FacilityUpdateProvider);
  final deleteAsync = ref.watch(FacilityDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
