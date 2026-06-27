import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/video_content_service.dart';
import 'package:reservatior/shared/repositories/video_content_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final videoContentServiceProvider = Provider<VideoContentService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return VideoContentService(dioClient);
});

final videoContentRepositoryProvider = Provider<VideoContentRepository>((ref) {
  final service = ref.watch(videoContentServiceProvider);
  return VideoContentRepositoryImpl(service);
});

final videoContentListProvider = FutureProvider.autoDispose<List<VideoContent>>((ref) async {
  final repository = ref.watch(videoContentRepositoryProvider);
  return repository.getAll();
});

final videoContentCreateProvider = StateProvider<VideoContent?>((ref) => null);
final videoContentUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final videoContentDeleteProvider = StateProvider<String?>((ref) => null);
final videoContentLoadingProvider = StateProvider<bool>((ref) => false);
