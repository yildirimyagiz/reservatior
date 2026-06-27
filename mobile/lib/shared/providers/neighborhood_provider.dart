import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/neighborhood_service.dart';
import 'package:reservatior/shared/repositories/neighborhood_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final neighborhoodServiceProvider = Provider<NeighborhoodService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return NeighborhoodService(dioClient);
});

final neighborhoodRepositoryProvider = Provider<NeighborhoodRepository>((ref) {
  final service = ref.watch(neighborhoodServiceProvider);
  return NeighborhoodRepositoryImpl(service);
});

final neighborhoodListProvider = FutureProvider.autoDispose<List<Neighborhood>>((ref) async {
  final repository = ref.watch(neighborhoodRepositoryProvider);
  return repository.getAll();
});

final neighborhoodCreateProvider = StateProvider<Neighborhood?>((ref) => null);
final neighborhoodUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final neighborhoodDeleteProvider = StateProvider<String?>((ref) => null);
final neighborhoodLoadingProvider = StateProvider<bool>((ref) => false);
