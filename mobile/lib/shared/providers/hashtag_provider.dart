import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/hashtag_service.dart';
import 'package:reservatior/shared/repositories/hashtag_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final hashtagServiceProvider = Provider<HashtagService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return HashtagService(dioClient);
});

final hashtagRepositoryProvider = Provider<HashtagRepository>((ref) {
  final service = ref.watch(hashtagServiceProvider);
  return HashtagRepositoryImpl(service);
});

final hashtagListProvider = FutureProvider.autoDispose<List<Hashtag>>((ref) async {
  final repository = ref.watch(hashtagRepositoryProvider);
  return repository.getAll();
});

final hashtagCreateProvider = StateProvider<Hashtag?>((ref) => null);
final hashtagUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final hashtagDeleteProvider = StateProvider<String?>((ref) => null);
final hashtagLoadingProvider = StateProvider<bool>((ref) => false);
