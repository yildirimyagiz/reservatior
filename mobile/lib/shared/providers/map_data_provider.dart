import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/map_data_service.dart';
import 'package:reservatior/shared/repositories/map_data_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final mapDataServiceProvider = Provider<MapDataService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return MapDataService(dioClient);
});

final mapDataRepositoryProvider = Provider<MapDataRepository>((ref) {
  final service = ref.watch(mapDataServiceProvider);
  return MapDataRepositoryImpl(service);
});

final mapDataListProvider = FutureProvider.autoDispose<List<MapData>>((ref) async {
  final repository = ref.watch(mapDataRepositoryProvider);
  return repository.getAll();
});

final mapDataCreateProvider = StateProvider<MapData?>((ref) => null);
final mapDataUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final mapDataDeleteProvider = StateProvider<String?>((ref) => null);
final mapDataLoadingProvider = StateProvider<bool>((ref) => false);
