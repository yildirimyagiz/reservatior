import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/hashtag_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// Hashtag Providers

final HashtagServiceProvider = Provider<HashtagService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return HashtagService(dioClient);
});

// List Provider
final hashtagProvider = FutureProvider.autoDispose<List<Hashtag>>((ref) async {
  final service = ref.watch(HashtagServiceProvider);
  return service.getHashtags();
});

// Create Provider
final HashtagCreateProvider = FutureProvider.autoDispose<Hashtag>((ref) async {
  final service = ref.watch(HashtagServiceProvider);
  return service.createHashtag(Hashtag());
});

// Update Provider  
final HashtagUpdateProvider = FutureProvider.autoDispose<Hashtag>((ref) async {
  final service = ref.watch(HashtagServiceProvider);
  final state = ref.watch(HashtagUpdateStateProvider);
  if (state['id'] != null && state['hashtag'] != null) {
    return service.updateHashtag(state['id'], state['hashtag']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final HashtagDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(HashtagServiceProvider);
  final state = ref.watch(HashtagDeleteStateProvider);
  if (state != null) {
    return service.deleteHashtag(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final HashtagUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final HashtagDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final HashtagLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(hashtagProvider);
  final createAsync = ref.watch(HashtagCreateProvider);
  final updateAsync = ref.watch(HashtagUpdateProvider);
  final deleteAsync = ref.watch(HashtagDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
