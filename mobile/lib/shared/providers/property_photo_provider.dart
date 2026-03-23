import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/property_photo_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// PropertyPhoto Providers

final PropertyPhotoServiceProvider = Provider<PropertyPhotoService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return PropertyPhotoService(dioClient);
});

// List Provider
final propertyPhotoProvider = FutureProvider.autoDispose<List<PropertyPhoto>>((ref) async {
  final service = ref.watch(PropertyPhotoServiceProvider);
  return service.getPropertyPhotos();
});

// Create Provider
final PropertyPhotoCreateProvider = FutureProvider.autoDispose<PropertyPhoto>((ref) async {
  final service = ref.watch(PropertyPhotoServiceProvider);
  return service.createPropertyPhoto(PropertyPhoto());
});

// Update Provider  
final PropertyPhotoUpdateProvider = FutureProvider.autoDispose<PropertyPhoto>((ref) async {
  final service = ref.watch(PropertyPhotoServiceProvider);
  final state = ref.watch(PropertyPhotoUpdateStateProvider);
  if (state['id'] != null && state['property_photo'] != null) {
    return service.updatePropertyPhoto(state['id'], state['property_photo']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final PropertyPhotoDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(PropertyPhotoServiceProvider);
  final state = ref.watch(PropertyPhotoDeleteStateProvider);
  if (state != null) {
    return service.deletePropertyPhoto(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final PropertyPhotoUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final PropertyPhotoDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final PropertyPhotoLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(propertyPhotoProvider);
  final createAsync = ref.watch(PropertyPhotoCreateProvider);
  final updateAsync = ref.watch(PropertyPhotoUpdateProvider);
  final deleteAsync = ref.watch(PropertyPhotoDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
