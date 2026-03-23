import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/mention_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// Mention Providers

final MentionServiceProvider = Provider<MentionService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return MentionService(dioClient);
});

// List Provider
final mentionProvider = FutureProvider.autoDispose<List<Mention>>((ref) async {
  final service = ref.watch(MentionServiceProvider);
  return service.getMentions();
});

// Create Provider
final MentionCreateProvider = FutureProvider.autoDispose<Mention>((ref) async {
  final service = ref.watch(MentionServiceProvider);
  return service.createMention(Mention());
});

// Update Provider  
final MentionUpdateProvider = FutureProvider.autoDispose<Mention>((ref) async {
  final service = ref.watch(MentionServiceProvider);
  final state = ref.watch(MentionUpdateStateProvider);
  if (state['id'] != null && state['mention'] != null) {
    return service.updateMention(state['id'], state['mention']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final MentionDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(MentionServiceProvider);
  final state = ref.watch(MentionDeleteStateProvider);
  if (state != null) {
    return service.deleteMention(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final MentionUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final MentionDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final MentionLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(mentionProvider);
  final createAsync = ref.watch(MentionCreateProvider);
  final updateAsync = ref.watch(MentionUpdateProvider);
  final deleteAsync = ref.watch(MentionDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
