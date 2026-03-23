import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/ai_chat_handoff_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// AIChatHandoff Providers

final aiChatHandoffServiceProvider = Provider<AIChatHandoffService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return AIChatHandoffService(dioClient);
});

// List Provider
final aiChatHandoffListProvider = FutureProvider.autoDispose<List<AIChatHandoff>>((ref) async {
  final service = ref.watch(aiChatHandoffServiceProvider);
  return service.getAIChatHandoffs();
});

// Create Provider - for Side Effects
final aiChatHandoffCreateStateProvider = StateProvider<AIChatHandoff?>((ref) => null);

final aiChatHandoffCreateProvider = FutureProvider.autoDispose<AIChatHandoff?>((ref) async {
  final service = ref.watch(aiChatHandoffServiceProvider);
  final aiChatHandoff = ref.watch(aiChatHandoffCreateStateProvider);
  if (aiChatHandoff != null) {
    return service.createAIChatHandoff(aiChatHandoff);
  }
  return null;
});

// Update Provider  
final aiChatHandoffUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});

final aiChatHandoffUpdateProvider = FutureProvider.autoDispose<AIChatHandoff?>((ref) async {
  final service = ref.watch(aiChatHandoffServiceProvider);
  final state = ref.watch(aiChatHandoffUpdateStateProvider);
  if (state['id'] != null && state['aiChatHandoff'] != null) {
    return service.updateAIChatHandoff(state['id'], state['aiChatHandoff']);
  }
  return null;
});

// Delete Provider
final aiChatHandoffDeleteStateProvider = StateProvider<String?>((ref) => null);

final aiChatHandoffDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(aiChatHandoffServiceProvider);
  final state = ref.watch(aiChatHandoffDeleteStateProvider);
  if (state != null) {
    return service.deleteAIChatHandoff(state);
  }
});

// Loading Provider
final aiChatHandoffLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(aiChatHandoffListProvider);
  final createAsync = ref.watch(aiChatHandoffCreateProvider);
  final updateAsync = ref.watch(aiChatHandoffUpdateProvider);
  final deleteAsync = ref.watch(aiChatHandoffDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
