import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/ai_chat_message_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// AIChatMessage Providers

final aiChatMessageServiceProvider = Provider<AIChatMessageService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return AIChatMessageService(dioClient);
});

// List Provider
final aiChatMessageListProvider = FutureProvider.autoDispose<List<AIChatMessage>>((ref) async {
  final service = ref.watch(aiChatMessageServiceProvider);
  return service.getAIChatMessages();
});

// Create Provider - for Side Effects
final aiChatMessageCreateStateProvider = StateProvider<AIChatMessage?>((ref) => null);

final aiChatMessageCreateProvider = FutureProvider.autoDispose<AIChatMessage?>((ref) async {
  final service = ref.watch(aiChatMessageServiceProvider);
  final aiChatMessage = ref.watch(aiChatMessageCreateStateProvider);
  if (aiChatMessage != null) {
    return service.createAIChatMessage(aiChatMessage);
  }
  return null;
});

// Update Provider  
final aiChatMessageUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});

final aiChatMessageUpdateProvider = FutureProvider.autoDispose<AIChatMessage?>((ref) async {
  final service = ref.watch(aiChatMessageServiceProvider);
  final state = ref.watch(aiChatMessageUpdateStateProvider);
  if (state['id'] != null && state['aiChatMessage'] != null) {
    return service.updateAIChatMessage(state['id'], state['aiChatMessage']);
  }
  return null;
});

// Delete Provider
final aiChatMessageDeleteStateProvider = StateProvider<String?>((ref) => null);

final aiChatMessageDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(aiChatMessageServiceProvider);
  final state = ref.watch(aiChatMessageDeleteStateProvider);
  if (state != null) {
    return service.deleteAIChatMessage(state);
  }
});

// Loading Provider
final aiChatMessageLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(aiChatMessageListProvider);
  final createAsync = ref.watch(aiChatMessageCreateProvider);
  final updateAsync = ref.watch(aiChatMessageUpdateProvider);
  final deleteAsync = ref.watch(aiChatMessageDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
