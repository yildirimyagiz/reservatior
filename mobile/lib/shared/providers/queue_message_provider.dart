import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/queue_message_service.dart';
import 'package:reservatior/shared/repositories/queue_message_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final queueMessageServiceProvider = Provider<QueueMessageService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return QueueMessageService(dioClient);
});

final queueMessageRepositoryProvider = Provider<QueueMessageRepository>((ref) {
  final service = ref.watch(queueMessageServiceProvider);
  return QueueMessageRepositoryImpl(service);
});

final queueMessageListProvider = FutureProvider.autoDispose<List<QueueMessage>>((ref) async {
  final repository = ref.watch(queueMessageRepositoryProvider);
  return repository.getAll();
});

final queueMessageCreateProvider = StateProvider<QueueMessage?>((ref) => null);
final queueMessageUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final queueMessageDeleteProvider = StateProvider<String?>((ref) => null);
final queueMessageLoadingProvider = StateProvider<bool>((ref) => false);
