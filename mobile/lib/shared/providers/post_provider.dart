import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/post_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// Post Providers

final PostServiceProvider = Provider<PostService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return PostService(dioClient);
});

// List Provider
final postProvider = FutureProvider.autoDispose<List<Post>>((ref) async {
  final service = ref.watch(PostServiceProvider);
  return service.getPosts();
});

// Create Provider
final PostCreateProvider = FutureProvider.autoDispose<Post>((ref) async {
  final service = ref.watch(PostServiceProvider);
  return service.createPost(Post());
});

// Update Provider  
final PostUpdateProvider = FutureProvider.autoDispose<Post>((ref) async {
  final service = ref.watch(PostServiceProvider);
  final state = ref.watch(PostUpdateStateProvider);
  if (state['id'] != null && state['post'] != null) {
    return service.updatePost(state['id'], state['post']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final PostDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(PostServiceProvider);
  final state = ref.watch(PostDeleteStateProvider);
  if (state != null) {
    return service.deletePost(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final PostUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final PostDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final PostLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(postProvider);
  final createAsync = ref.watch(PostCreateProvider);
  final updateAsync = ref.watch(PostUpdateProvider);
  final deleteAsync = ref.watch(PostDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
