import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/favorite_service.dart';
import 'package:reservatior/shared/repositories/favorite_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final favoriteServiceProvider = Provider<FavoriteService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return FavoriteService(dioClient);
});

final favoriteRepositoryProvider = Provider<FavoriteRepository>((ref) {
  final service = ref.watch(favoriteServiceProvider);
  return FavoriteRepositoryImpl(service);
});

final favoriteListProvider = FutureProvider.autoDispose<List<Favorite>>((ref) async {
  final repository = ref.watch(favoriteRepositoryProvider);
  return repository.getAll();
});

final favoriteCreateProvider = StateProvider<Favorite?>((ref) => null);
final favoriteUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final favoriteDeleteProvider = StateProvider<String?>((ref) => null);
final favoriteLoadingProvider = StateProvider<bool>((ref) => false);
