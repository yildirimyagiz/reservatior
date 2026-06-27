import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/ai_chatbot_session_service.dart';
import 'package:reservatior/shared/repositories/ai_chatbot_session_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final aiChatbotSessionServiceProvider = Provider<AiChatbotSessionService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return AiChatbotSessionService(dioClient);
});

final aiChatbotSessionRepositoryProvider = Provider<AiChatbotSessionRepository>((ref) {
  final service = ref.watch(aiChatbotSessionServiceProvider);
  return AiChatbotSessionRepositoryImpl(service);
});

final aiChatbotSessionListProvider = FutureProvider.autoDispose<List<AiChatbotSession>>((ref) async {
  final repository = ref.watch(aiChatbotSessionRepositoryProvider);
  return repository.getAll();
});

final aiChatbotSessionCreateProvider = StateProvider<AiChatbotSession?>((ref) => null);
final aiChatbotSessionUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final aiChatbotSessionDeleteProvider = StateProvider<String?>((ref) => null);
final aiChatbotSessionLoadingProvider = StateProvider<bool>((ref) => false);
