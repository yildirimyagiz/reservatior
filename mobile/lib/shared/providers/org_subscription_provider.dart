import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/org_subscription_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// OrgSubscription Providers

final OrgSubscriptionServiceProvider = Provider<OrgSubscriptionService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return OrgSubscriptionService(dioClient);
});

// List Provider
final orgSubscriptionProvider = FutureProvider.autoDispose<List<OrgSubscription>>((ref) async {
  final service = ref.watch(OrgSubscriptionServiceProvider);
  return service.getOrgSubscriptions();
});

// Create Provider
final OrgSubscriptionCreateProvider = FutureProvider.autoDispose<OrgSubscription>((ref) async {
  final service = ref.watch(OrgSubscriptionServiceProvider);
  return service.createOrgSubscription(OrgSubscription());
});

// Update Provider  
final OrgSubscriptionUpdateProvider = FutureProvider.autoDispose<OrgSubscription>((ref) async {
  final service = ref.watch(OrgSubscriptionServiceProvider);
  final state = ref.watch(OrgSubscriptionUpdateStateProvider);
  if (state['id'] != null && state['org_subscription'] != null) {
    return service.updateOrgSubscription(state['id'], state['org_subscription']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final OrgSubscriptionDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(OrgSubscriptionServiceProvider);
  final state = ref.watch(OrgSubscriptionDeleteStateProvider);
  if (state != null) {
    return service.deleteOrgSubscription(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final OrgSubscriptionUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final OrgSubscriptionDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final OrgSubscriptionLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(orgSubscriptionProvider);
  final createAsync = ref.watch(OrgSubscriptionCreateProvider);
  final updateAsync = ref.watch(OrgSubscriptionUpdateProvider);
  final deleteAsync = ref.watch(OrgSubscriptionDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
