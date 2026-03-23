import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/neighborhood_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// Neighborhood Providers

final NeighborhoodServiceProvider = Provider<NeighborhoodService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return NeighborhoodService(dioClient);
});

// List Provider
final neighborhoodProvider = FutureProvider.autoDispose<List<Neighborhood>>((ref) async {
  final service = ref.watch(NeighborhoodServiceProvider);
  return service.getNeighborhoods();
});

// Create Provider
final NeighborhoodCreateProvider = FutureProvider.autoDispose<Neighborhood>((ref) async {
  final service = ref.watch(NeighborhoodServiceProvider);
  return service.createNeighborhood(Neighborhood());
});

// Update Provider  
final NeighborhoodUpdateProvider = FutureProvider.autoDispose<Neighborhood>((ref) async {
  final service = ref.watch(NeighborhoodServiceProvider);
  final state = ref.watch(NeighborhoodUpdateStateProvider);
  if (state['id'] != null && state['neighborhood'] != null) {
    return service.updateNeighborhood(state['id'], state['neighborhood']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final NeighborhoodDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(NeighborhoodServiceProvider);
  final state = ref.watch(NeighborhoodDeleteStateProvider);
  if (state != null) {
    return service.deleteNeighborhood(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final NeighborhoodUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final NeighborhoodDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final NeighborhoodLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(neighborhoodProvider);
  final createAsync = ref.watch(NeighborhoodCreateProvider);
  final updateAsync = ref.watch(NeighborhoodUpdateProvider);
  final deleteAsync = ref.watch(NeighborhoodDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
