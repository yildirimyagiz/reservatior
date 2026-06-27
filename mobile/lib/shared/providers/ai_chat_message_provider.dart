import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/ai_chat_message_service.dart';
import 'package:reservatior/shared/repositories/ai_chat_message_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final aiChatMessageServiceProvider = Provider<AiChatMessageService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return AiChatMessageService(dioClient);
});

final aiChatMessageRepositoryProvider = Provider<AiChatMessageRepository>((ref) {
  final service = ref.watch(aiChatMessageServiceProvider);
  return AiChatMessageRepositoryImpl(service);
});

final aiChatMessageListProvider = FutureProvider.autoDispose<List<AiChatMessage>>((ref) async {
  final repository = ref.watch(aiChatMessageRepositoryProvider);
  return repository.getAll();
});

final aiChatMessageCreateProvider = StateProvider<AiChatMessage?>((ref) => null);
final aiChatMessageUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final aiChatMessageDeleteProvider = StateProvider<String?>((ref) => null);
final aiChatMessageLoadingProvider = StateProvider<bool>((ref) => false);
