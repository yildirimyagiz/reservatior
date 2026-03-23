import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/map_data_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// MapData Providers

final MapDataServiceProvider = Provider<MapDataService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return MapDataService(dioClient);
});

// List Provider
final mapDataProvider = FutureProvider.autoDispose<List<MapData>>((ref) async {
  final service = ref.watch(MapDataServiceProvider);
  return service.getMapDatas();
});

// Create Provider
final MapDataCreateProvider = FutureProvider.autoDispose<MapData>((ref) async {
  final service = ref.watch(MapDataServiceProvider);
  return service.createMapData(MapData());
});

// Update Provider  
final MapDataUpdateProvider = FutureProvider.autoDispose<MapData>((ref) async {
  final service = ref.watch(MapDataServiceProvider);
  final state = ref.watch(MapDataUpdateStateProvider);
  if (state['id'] != null && state['map_data'] != null) {
    return service.updateMapData(state['id'], state['map_data']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final MapDataDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(MapDataServiceProvider);
  final state = ref.watch(MapDataDeleteStateProvider);
  if (state != null) {
    return service.deleteMapData(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final MapDataUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final MapDataDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final MapDataLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(mapDataProvider);
  final createAsync = ref.watch(MapDataCreateProvider);
  final updateAsync = ref.watch(MapDataUpdateProvider);
  final deleteAsync = ref.watch(MapDataDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
