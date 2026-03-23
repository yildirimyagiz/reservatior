import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/video_content_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// VideoContent Providers

final VideoContentServiceProvider = Provider<VideoContentService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return VideoContentService(dioClient);
});

// List Provider
final videoContentProvider = FutureProvider.autoDispose<List<VideoContent>>((ref) async {
  final service = ref.watch(VideoContentServiceProvider);
  return service.getVideoContents();
});

// Create Provider
final VideoContentCreateProvider = FutureProvider.autoDispose<VideoContent>((ref) async {
  final service = ref.watch(VideoContentServiceProvider);
  return service.createVideoContent(VideoContent());
});

// Update Provider  
final VideoContentUpdateProvider = FutureProvider.autoDispose<VideoContent>((ref) async {
  final service = ref.watch(VideoContentServiceProvider);
  final state = ref.watch(VideoContentUpdateStateProvider);
  if (state['id'] != null && state['video_content'] != null) {
    return service.updateVideoContent(state['id'], state['video_content']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final VideoContentDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(VideoContentServiceProvider);
  final state = ref.watch(VideoContentDeleteStateProvider);
  if (state != null) {
    return service.deleteVideoContent(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final VideoContentUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final VideoContentDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final VideoContentLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(videoContentProvider);
  final createAsync = ref.watch(VideoContentCreateProvider);
  final updateAsync = ref.watch(VideoContentUpdateProvider);
  final deleteAsync = ref.watch(VideoContentDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
