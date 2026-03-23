import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/map_layer_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// MapLayer Providers

final MapLayerServiceProvider = Provider<MapLayerService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return MapLayerService(dioClient);
});

// List Provider
final mapLayerProvider = FutureProvider.autoDispose<List<MapLayer>>((ref) async {
  final service = ref.watch(MapLayerServiceProvider);
  return service.getMapLayers();
});

// Create Provider
final MapLayerCreateProvider = FutureProvider.autoDispose<MapLayer>((ref) async {
  final service = ref.watch(MapLayerServiceProvider);
  return service.createMapLayer(MapLayer());
});

// Update Provider  
final MapLayerUpdateProvider = FutureProvider.autoDispose<MapLayer>((ref) async {
  final service = ref.watch(MapLayerServiceProvider);
  final state = ref.watch(MapLayerUpdateStateProvider);
  if (state['id'] != null && state['map_layer'] != null) {
    return service.updateMapLayer(state['id'], state['map_layer']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final MapLayerDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(MapLayerServiceProvider);
  final state = ref.watch(MapLayerDeleteStateProvider);
  if (state != null) {
    return service.deleteMapLayer(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final MapLayerUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final MapLayerDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final MapLayerLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(mapLayerProvider);
  final createAsync = ref.watch(MapLayerCreateProvider);
  final updateAsync = ref.watch(MapLayerUpdateProvider);
  final deleteAsync = ref.watch(MapLayerDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
