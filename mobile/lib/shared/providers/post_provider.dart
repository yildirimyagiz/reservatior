import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/post_service.dart';
import 'package:reservatior/shared/repositories/post_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final postServiceProvider = Provider<PostService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return PostService(dioClient);
});

final postRepositoryProvider = Provider<PostRepository>((ref) {
  final service = ref.watch(postServiceProvider);
  return PostRepositoryImpl(service);
});

final postListProvider = FutureProvider.autoDispose<List<Post>>((ref) async {
  final repository = ref.watch(postRepositoryProvider);
  return repository.getAll();
});

final postCreateProvider = StateProvider<Post?>((ref) => null);
final postUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final postDeleteProvider = StateProvider<String?>((ref) => null);
final postLoadingProvider = StateProvider<bool>((ref) => false);
