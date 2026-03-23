import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/webhook_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// Webhook Providers

final WebhookServiceProvider = Provider<WebhookService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return WebhookService(dioClient);
});

// List Provider
final webhookProvider = FutureProvider.autoDispose<List<Webhook>>((ref) async {
  final service = ref.watch(WebhookServiceProvider);
  return service.getWebhooks();
});

// Create Provider
final WebhookCreateProvider = FutureProvider.autoDispose<Webhook>((ref) async {
  final service = ref.watch(WebhookServiceProvider);
  return service.createWebhook(Webhook());
});

// Update Provider  
final WebhookUpdateProvider = FutureProvider.autoDispose<Webhook>((ref) async {
  final service = ref.watch(WebhookServiceProvider);
  final state = ref.watch(WebhookUpdateStateProvider);
  if (state['id'] != null && state['webhook'] != null) {
    return service.updateWebhook(state['id'], state['webhook']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final WebhookDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(WebhookServiceProvider);
  final state = ref.watch(WebhookDeleteStateProvider);
  if (state != null) {
    return service.deleteWebhook(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final WebhookUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final WebhookDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final WebhookLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(webhookProvider);
  final createAsync = ref.watch(WebhookCreateProvider);
  final updateAsync = ref.watch(WebhookUpdateProvider);
  final deleteAsync = ref.watch(WebhookDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
