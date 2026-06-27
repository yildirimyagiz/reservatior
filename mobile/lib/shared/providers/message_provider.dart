import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/message_service.dart';
import 'package:reservatior/shared/repositories/message_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final messageServiceProvider = Provider<MessageService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return MessageService(dioClient);
});

final messageRepositoryProvider = Provider<MessageRepository>((ref) {
  final service = ref.watch(messageServiceProvider);
  return MessageRepositoryImpl(service);
});

final messageListProvider = FutureProvider.autoDispose<List<Message>>((ref) async {
  final repository = ref.watch(messageRepositoryProvider);
  return repository.getAll();
});

final messageCreateProvider = StateProvider<Message?>((ref) => null);
final messageUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final messageDeleteProvider = StateProvider<String?>((ref) => null);
final messageLoadingProvider = StateProvider<bool>((ref) => false);

final messageThreadsProvider = FutureProvider.autoDispose<List<Message>>((ref) async {
  final repository = ref.watch(messageRepositoryProvider);
  return repository.getThreads();
});

final threadMessagesProvider = FutureProvider.family.autoDispose<List<Message>, String>((ref, threadId) async {
  final repository = ref.watch(messageRepositoryProvider);
  return repository.getThreadMessages(threadId);
});
