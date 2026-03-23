import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/virtual_tour_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// VirtualTour Providers

final VirtualTourServiceProvider = Provider<VirtualTourService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return VirtualTourService(dioClient);
});

// List Provider
final virtualTourProvider = FutureProvider.autoDispose<List<VirtualTour>>((ref) async {
  final service = ref.watch(VirtualTourServiceProvider);
  return service.getVirtualTours();
});

// Create Provider
final VirtualTourCreateProvider = FutureProvider.autoDispose<VirtualTour>((ref) async {
  final service = ref.watch(VirtualTourServiceProvider);
  return service.createVirtualTour(VirtualTour());
});

// Update Provider  
final VirtualTourUpdateProvider = FutureProvider.autoDispose<VirtualTour>((ref) async {
  final service = ref.watch(VirtualTourServiceProvider);
  final state = ref.watch(VirtualTourUpdateStateProvider);
  if (state['id'] != null && state['virtual_tour'] != null) {
    return service.updateVirtualTour(state['id'], state['virtual_tour']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final VirtualTourDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(VirtualTourServiceProvider);
  final state = ref.watch(VirtualTourDeleteStateProvider);
  if (state != null) {
    return service.deleteVirtualTour(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final VirtualTourUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final VirtualTourDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final VirtualTourLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(virtualTourProvider);
  final createAsync = ref.watch(VirtualTourCreateProvider);
  final updateAsync = ref.watch(VirtualTourUpdateProvider);
  final deleteAsync = ref.watch(VirtualTourDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
