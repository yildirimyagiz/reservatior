import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/webhook_delivery_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// WebhookDelivery Providers

final WebhookDeliveryServiceProvider = Provider<WebhookDeliveryService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return WebhookDeliveryService(dioClient);
});

// List Provider
final webhookDeliveryProvider = FutureProvider.autoDispose<List<WebhookDelivery>>((ref) async {
  final service = ref.watch(WebhookDeliveryServiceProvider);
  return service.getWebhookDeliverys();
});

// Create Provider
final WebhookDeliveryCreateProvider = FutureProvider.autoDispose<WebhookDelivery>((ref) async {
  final service = ref.watch(WebhookDeliveryServiceProvider);
  return service.createWebhookDelivery(WebhookDelivery());
});

// Update Provider  
final WebhookDeliveryUpdateProvider = FutureProvider.autoDispose<WebhookDelivery>((ref) async {
  final service = ref.watch(WebhookDeliveryServiceProvider);
  final state = ref.watch(WebhookDeliveryUpdateStateProvider);
  if (state['id'] != null && state['webhook_delivery'] != null) {
    return service.updateWebhookDelivery(state['id'], state['webhook_delivery']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final WebhookDeliveryDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(WebhookDeliveryServiceProvider);
  final state = ref.watch(WebhookDeliveryDeleteStateProvider);
  if (state != null) {
    return service.deleteWebhookDelivery(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final WebhookDeliveryUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final WebhookDeliveryDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final WebhookDeliveryLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(webhookDeliveryProvider);
  final createAsync = ref.watch(WebhookDeliveryCreateProvider);
  final updateAsync = ref.watch(WebhookDeliveryUpdateProvider);
  final deleteAsync = ref.watch(WebhookDeliveryDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
