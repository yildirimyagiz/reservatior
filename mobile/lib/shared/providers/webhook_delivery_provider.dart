import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/webhook_delivery_service.dart';
import 'package:reservatior/shared/repositories/webhook_delivery_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final webhookDeliveryServiceProvider = Provider<WebhookDeliveryService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return WebhookDeliveryService(dioClient);
});

final webhookDeliveryRepositoryProvider = Provider<WebhookDeliveryRepository>((ref) {
  final service = ref.watch(webhookDeliveryServiceProvider);
  return WebhookDeliveryRepositoryImpl(service);
});

final webhookDeliveryListProvider = FutureProvider.autoDispose<List<WebhookDelivery>>((ref) async {
  final repository = ref.watch(webhookDeliveryRepositoryProvider);
  return repository.getAll();
});

final webhookDeliveryCreateProvider = StateProvider<WebhookDelivery?>((ref) => null);
final webhookDeliveryUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final webhookDeliveryDeleteProvider = StateProvider<String?>((ref) => null);
final webhookDeliveryLoadingProvider = StateProvider<bool>((ref) => false);
