import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/subscription_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// Subscription Providers

final SubscriptionServiceProvider = Provider<SubscriptionService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return SubscriptionService(dioClient);
});

// List Provider
final subscriptionProvider = FutureProvider.autoDispose<List<Subscription>>((ref) async {
  final service = ref.watch(SubscriptionServiceProvider);
  return service.getSubscriptions();
});

// Create Provider
final SubscriptionCreateProvider = FutureProvider.autoDispose<Subscription>((ref) async {
  final service = ref.watch(SubscriptionServiceProvider);
  return service.createSubscription(Subscription());
});

// Update Provider  
final SubscriptionUpdateProvider = FutureProvider.autoDispose<Subscription>((ref) async {
  final service = ref.watch(SubscriptionServiceProvider);
  final state = ref.watch(SubscriptionUpdateStateProvider);
  if (state['id'] != null && state['subscription'] != null) {
    return service.updateSubscription(state['id'], state['subscription']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final SubscriptionDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(SubscriptionServiceProvider);
  final state = ref.watch(SubscriptionDeleteStateProvider);
  if (state != null) {
    return service.deleteSubscription(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final SubscriptionUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final SubscriptionDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final SubscriptionLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(subscriptionProvider);
  final createAsync = ref.watch(SubscriptionCreateProvider);
  final updateAsync = ref.watch(SubscriptionUpdateProvider);
  final deleteAsync = ref.watch(SubscriptionDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
