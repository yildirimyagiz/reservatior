import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/property_photo_service.dart';
import 'package:reservatior/shared/repositories/property_photo_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final propertyPhotoServiceProvider = Provider<PropertyPhotoService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return PropertyPhotoService(dioClient);
});

final propertyPhotoRepositoryProvider = Provider<PropertyPhotoRepository>((ref) {
  final service = ref.watch(propertyPhotoServiceProvider);
  return PropertyPhotoRepositoryImpl(service);
});

final propertyPhotoListProvider = FutureProvider.autoDispose.family<List<PropertyPhoto>, String>((ref, propertyId) async {
  final repository = ref.watch(propertyPhotoRepositoryProvider);
  return repository.getAll(filters: {'propertyId': propertyId});
});

final propertyPhotoCreateProvider = StateProvider<PropertyPhoto?>((ref) => null);
final propertyPhotoUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final propertyPhotoDeleteProvider = StateProvider<String?>((ref) => null);
final propertyPhotoLoadingProvider = StateProvider<bool>((ref) => false);
