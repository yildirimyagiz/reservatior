import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/availability_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// Availability Providers

final AvailabilityServiceProvider = Provider<AvailabilityService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return AvailabilityService(dioClient);
});

// List Provider
final availabilityProvider = FutureProvider.autoDispose<List<Availability>>((ref) async {
  final service = ref.watch(AvailabilityServiceProvider);
  return service.getAvailabilitys();
});

// Create Provider
final AvailabilityCreateProvider = FutureProvider.autoDispose<Availability>((ref) async {
  final service = ref.watch(AvailabilityServiceProvider);
  return service.createAvailability(Availability());
});

// Update Provider  
final AvailabilityUpdateProvider = FutureProvider.autoDispose<Availability>((ref) async {
  final service = ref.watch(AvailabilityServiceProvider);
  final state = ref.watch(AvailabilityUpdateStateProvider);
  if (state['id'] != null && state['availability'] != null) {
    return service.updateAvailability(state['id'], state['availability']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final AvailabilityDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(AvailabilityServiceProvider);
  final state = ref.watch(AvailabilityDeleteStateProvider);
  if (state != null) {
    return service.deleteAvailability(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final AvailabilityUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final AvailabilityDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final AvailabilityLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(availabilityProvider);
  final createAsync = ref.watch(AvailabilityCreateProvider);
  final updateAsync = ref.watch(AvailabilityUpdateProvider);
  final deleteAsync = ref.watch(AvailabilityDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
