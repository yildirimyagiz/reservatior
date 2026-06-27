import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/tag_service.dart';
import 'package:reservatior/shared/repositories/tag_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final tagServiceProvider = Provider<TagService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return TagService(dioClient);
});

final tagRepositoryProvider = Provider<TagRepository>((ref) {
  final service = ref.watch(tagServiceProvider);
  return TagRepositoryImpl(service);
});

final tagListProvider = FutureProvider.autoDispose<List<Tag>>((ref) async {
  final repository = ref.watch(tagRepositoryProvider);
  return repository.getAll();
});

final tagCreateProvider = StateProvider<Tag?>((ref) => null);
final tagUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final tagDeleteProvider = StateProvider<String?>((ref) => null);
final tagLoadingProvider = StateProvider<bool>((ref) => false);
