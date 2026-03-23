import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/queue_message_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// QueueMessage Providers

final QueueMessageServiceProvider = Provider<QueueMessageService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return QueueMessageService(dioClient);
});

// List Provider
final queueMessageProvider = FutureProvider.autoDispose<List<QueueMessage>>((ref) async {
  final service = ref.watch(QueueMessageServiceProvider);
  return service.getQueueMessages();
});

// Create Provider
final QueueMessageCreateProvider = FutureProvider.autoDispose<QueueMessage>((ref) async {
  final service = ref.watch(QueueMessageServiceProvider);
  return service.createQueueMessage(QueueMessage());
});

// Update Provider  
final QueueMessageUpdateProvider = FutureProvider.autoDispose<QueueMessage>((ref) async {
  final service = ref.watch(QueueMessageServiceProvider);
  final state = ref.watch(QueueMessageUpdateStateProvider);
  if (state['id'] != null && state['queue_message'] != null) {
    return service.updateQueueMessage(state['id'], state['queue_message']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final QueueMessageDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(QueueMessageServiceProvider);
  final state = ref.watch(QueueMessageDeleteStateProvider);
  if (state != null) {
    return service.deleteQueueMessage(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final QueueMessageUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final QueueMessageDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final QueueMessageLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(queueMessageProvider);
  final createAsync = ref.watch(QueueMessageCreateProvider);
  final updateAsync = ref.watch(QueueMessageUpdateProvider);
  final deleteAsync = ref.watch(QueueMessageDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
