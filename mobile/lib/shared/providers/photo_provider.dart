import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/photo_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// Photo Providers

final PhotoServiceProvider = Provider<PhotoService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return PhotoService(dioClient);
});

// List Provider
final photoProvider = FutureProvider.autoDispose<List<Photo>>((ref) async {
  final service = ref.watch(PhotoServiceProvider);
  return service.getPhotos();
});

// Create Provider
final PhotoCreateProvider = FutureProvider.autoDispose<Photo>((ref) async {
  final service = ref.watch(PhotoServiceProvider);
  return service.createPhoto(Photo());
});

// Update Provider  
final PhotoUpdateProvider = FutureProvider.autoDispose<Photo>((ref) async {
  final service = ref.watch(PhotoServiceProvider);
  final state = ref.watch(PhotoUpdateStateProvider);
  if (state['id'] != null && state['photo'] != null) {
    return service.updatePhoto(state['id'], state['photo']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final PhotoDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(PhotoServiceProvider);
  final state = ref.watch(PhotoDeleteStateProvider);
  if (state != null) {
    return service.deletePhoto(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final PhotoUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final PhotoDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final PhotoLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(photoProvider);
  final createAsync = ref.watch(PhotoCreateProvider);
  final updateAsync = ref.watch(PhotoUpdateProvider);
  final deleteAsync = ref.watch(PhotoDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
