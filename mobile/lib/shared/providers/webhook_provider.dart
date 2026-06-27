import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/webhook_service.dart';
import 'package:reservatior/shared/repositories/webhook_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final webhookServiceProvider = Provider<WebhookService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return WebhookService(dioClient);
});

final webhookRepositoryProvider = Provider<WebhookRepository>((ref) {
  final service = ref.watch(webhookServiceProvider);
  return WebhookRepositoryImpl(service);
});

final webhookListProvider = FutureProvider.autoDispose<List<Webhook>>((ref) async {
  final repository = ref.watch(webhookRepositoryProvider);
  return repository.getAll();
});

final webhookCreateProvider = StateProvider<Webhook?>((ref) => null);
final webhookUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final webhookDeleteProvider = StateProvider<String?>((ref) => null);
final webhookLoadingProvider = StateProvider<bool>((ref) => false);
