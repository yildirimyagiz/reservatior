import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/aiChatbotSession_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// AIChatbotSession Providers

final aiChatbotSessionServiceProvider = Provider<AIChatbotSessionService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return AIChatbotSessionService(dioClient);
});

// List Provider
final aiChatbotSessionListProvider = FutureProvider.autoDispose<List<AIChatbotSession>>((ref) async {
  final service = ref.watch(aiChatbotSessionServiceProvider);
  return service.getAIChatbotSessions();
});

// Create Provider - for Side Effects
final aiChatbotSessionCreateStateProvider = StateProvider<AIChatbotSession?>((ref) => null);

final aiChatbotSessionCreateProvider = FutureProvider.autoDispose<AIChatbotSession?>((ref) async {
  final service = ref.watch(aiChatbotSessionServiceProvider);
  final aiChatbotSession = ref.watch(aiChatbotSessionCreateStateProvider);
  if (aiChatbotSession != null) {
    return service.createAIChatbotSession(aiChatbotSession);
  }
  return null;
});

// Update Provider  
final aiChatbotSessionUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});

final aiChatbotSessionUpdateProvider = FutureProvider.autoDispose<AIChatbotSession?>((ref) async {
  final service = ref.watch(aiChatbotSessionServiceProvider);
  final state = ref.watch(aiChatbotSessionUpdateStateProvider);
  if (state['id'] != null && state['aiChatbotSession'] != null) {
    return service.updateAIChatbotSession(state['id'], state['aiChatbotSession']);
  }
  return null;
});

// Delete Provider
final aiChatbotSessionDeleteStateProvider = StateProvider<String?>((ref) => null);

final aiChatbotSessionDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(aiChatbotSessionServiceProvider);
  final state = ref.watch(aiChatbotSessionDeleteStateProvider);
  if (state != null) {
    return service.deleteAIChatbotSession(state);
  }
});

// Loading Provider
final aiChatbotSessionLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(aiChatbotSessionListProvider);
  final createAsync = ref.watch(aiChatbotSessionCreateProvider);
  final updateAsync = ref.watch(aiChatbotSessionUpdateProvider);
  final deleteAsync = ref.watch(aiChatbotSessionDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
