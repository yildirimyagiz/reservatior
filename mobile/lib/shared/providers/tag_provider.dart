import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/tag_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// Tag Providers

final TagServiceProvider = Provider<TagService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return TagService(dioClient);
});

// List Provider
final tagProvider = FutureProvider.autoDispose<List<Tag>>((ref) async {
  final service = ref.watch(TagServiceProvider);
  return service.getTags();
});

// Create Provider
final TagCreateProvider = FutureProvider.autoDispose<Tag>((ref) async {
  final service = ref.watch(TagServiceProvider);
  return service.createTag(Tag());
});

// Update Provider  
final TagUpdateProvider = FutureProvider.autoDispose<Tag>((ref) async {
  final service = ref.watch(TagServiceProvider);
  final state = ref.watch(TagUpdateStateProvider);
  if (state['id'] != null && state['tag'] != null) {
    return service.updateTag(state['id'], state['tag']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final TagDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(TagServiceProvider);
  final state = ref.watch(TagDeleteStateProvider);
  if (state != null) {
    return service.deleteTag(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final TagUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final TagDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final TagLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(tagProvider);
  final createAsync = ref.watch(TagCreateProvider);
  final updateAsync = ref.watch(TagUpdateProvider);
  final deleteAsync = ref.watch(TagDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
