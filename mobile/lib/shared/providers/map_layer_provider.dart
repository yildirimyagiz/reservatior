import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/map_layer_service.dart';
import 'package:reservatior/shared/repositories/map_layer_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final mapLayerServiceProvider = Provider<MapLayerService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return MapLayerService(dioClient);
});

final mapLayerRepositoryProvider = Provider<MapLayerRepository>((ref) {
  final service = ref.watch(mapLayerServiceProvider);
  return MapLayerRepositoryImpl(service);
});

final mapLayerListProvider = FutureProvider.autoDispose<List<MapLayer>>((ref) async {
  final repository = ref.watch(mapLayerRepositoryProvider);
  return repository.getAll();
});

final mapLayerCreateProvider = StateProvider<MapLayer?>((ref) => null);
final mapLayerUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final mapLayerDeleteProvider = StateProvider<String?>((ref) => null);
final mapLayerLoadingProvider = StateProvider<bool>((ref) => false);
