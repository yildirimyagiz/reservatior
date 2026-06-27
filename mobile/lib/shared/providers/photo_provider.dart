import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/photo_service.dart';
import 'package:reservatior/shared/repositories/photo_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final photoServiceProvider = Provider<PhotoService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return PhotoService(dioClient);
});

final photoRepositoryProvider = Provider<PhotoRepository>((ref) {
  final service = ref.watch(photoServiceProvider);
  return PhotoRepositoryImpl(service);
});

final photoListProvider = FutureProvider.autoDispose<List<Photo>>((ref) async {
  final repository = ref.watch(photoRepositoryProvider);
  return repository.getAll();
});

final photoCreateProvider = StateProvider<Photo?>((ref) => null);
final photoUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final photoDeleteProvider = StateProvider<String?>((ref) => null);
final photoLoadingProvider = StateProvider<bool>((ref) => false);
