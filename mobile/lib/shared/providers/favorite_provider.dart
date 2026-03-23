import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/favorite_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// Favorite Providers

final FavoriteServiceProvider = Provider<FavoriteService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return FavoriteService(dioClient);
});

// List Provider
final favoriteProvider = FutureProvider.autoDispose<List<Favorite>>((ref) async {
  final service = ref.watch(FavoriteServiceProvider);
  return service.getFavorites();
});

// Create Provider
final FavoriteCreateProvider = FutureProvider.autoDispose<Favorite>((ref) async {
  final service = ref.watch(FavoriteServiceProvider);
  return service.createFavorite(Favorite());
});

// Update Provider  
final FavoriteUpdateProvider = FutureProvider.autoDispose<Favorite>((ref) async {
  final service = ref.watch(FavoriteServiceProvider);
  final state = ref.watch(FavoriteUpdateStateProvider);
  if (state['id'] != null && state['favorite'] != null) {
    return service.updateFavorite(state['id'], state['favorite']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final FavoriteDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(FavoriteServiceProvider);
  final state = ref.watch(FavoriteDeleteStateProvider);
  if (state != null) {
    return service.deleteFavorite(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final FavoriteUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final FavoriteDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final FavoriteLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(favoriteProvider);
  final createAsync = ref.watch(FavoriteCreateProvider);
  final updateAsync = ref.watch(FavoriteUpdateProvider);
  final deleteAsync = ref.watch(FavoriteDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
