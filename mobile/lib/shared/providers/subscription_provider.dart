import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/subscription_service.dart';
import 'package:reservatior/shared/repositories/subscription_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final subscriptionServiceProvider = Provider<SubscriptionService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return SubscriptionService(dioClient);
});

final subscriptionRepositoryProvider = Provider<SubscriptionRepository>((ref) {
  final service = ref.watch(subscriptionServiceProvider);
  return SubscriptionRepositoryImpl(service);
});

final subscriptionListProvider = FutureProvider.autoDispose<List<Subscription>>((ref) async {
  final repository = ref.watch(subscriptionRepositoryProvider);
  return repository.getAll();
});

final subscriptionCreateProvider = StateProvider<Subscription?>((ref) => null);
final subscriptionUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final subscriptionDeleteProvider = StateProvider<String?>((ref) => null);
final subscriptionLoadingProvider = StateProvider<bool>((ref) => false);
