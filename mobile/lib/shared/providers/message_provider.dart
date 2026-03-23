import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/message_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// Message Providers

final MessageServiceProvider = Provider<MessageService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return MessageService(dioClient);
});

// List Provider
final messageProvider = FutureProvider.autoDispose<List<Message>>((ref) async {
  final service = ref.watch(MessageServiceProvider);
  return service.getMessages();
});

// Create Provider
final MessageCreateProvider = FutureProvider.autoDispose<Message>((ref) async {
  final service = ref.watch(MessageServiceProvider);
  return service.createMessage(Message());
});

// Update Provider  
final MessageUpdateProvider = FutureProvider.autoDispose<Message>((ref) async {
  final service = ref.watch(MessageServiceProvider);
  final state = ref.watch(MessageUpdateStateProvider);
  if (state['id'] != null && state['message'] != null) {
    return service.updateMessage(state['id'], state['message']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final MessageDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(MessageServiceProvider);
  final state = ref.watch(MessageDeleteStateProvider);
  if (state != null) {
    return service.deleteMessage(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final MessageUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final MessageDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final MessageLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(messageProvider);
  final createAsync = ref.watch(MessageCreateProvider);
  final updateAsync = ref.watch(MessageUpdateProvider);
  final deleteAsync = ref.watch(MessageDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
