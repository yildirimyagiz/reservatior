import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/ai_chat_handoff_service.dart';
import 'package:reservatior/shared/repositories/ai_chat_handoff_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final aiChatHandoffServiceProvider = Provider<AiChatHandoffService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return AiChatHandoffService(dioClient);
});

final aiChatHandoffRepositoryProvider = Provider<AiChatHandoffRepository>((ref) {
  final service = ref.watch(aiChatHandoffServiceProvider);
  return AiChatHandoffRepositoryImpl(service);
});

final aiChatHandoffListProvider = FutureProvider.autoDispose<List<AiChatHandoff>>((ref) async {
  final repository = ref.watch(aiChatHandoffRepositoryProvider);
  return repository.getAll();
});

final aiChatHandoffCreateProvider = StateProvider<AiChatHandoff?>((ref) => null);
final aiChatHandoffUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final aiChatHandoffDeleteProvider = StateProvider<String?>((ref) => null);
final aiChatHandoffLoadingProvider = StateProvider<bool>((ref) => false);
