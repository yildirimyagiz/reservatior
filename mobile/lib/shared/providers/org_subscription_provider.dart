import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/org_subscription_service.dart';
import 'package:reservatior/shared/repositories/org_subscription_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final orgSubscriptionServiceProvider = Provider<OrgSubscriptionService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return OrgSubscriptionService(dioClient);
});

final orgSubscriptionRepositoryProvider = Provider<OrgSubscriptionRepository>((ref) {
  final service = ref.watch(orgSubscriptionServiceProvider);
  return OrgSubscriptionRepositoryImpl(service);
});

final orgSubscriptionListProvider = FutureProvider.autoDispose<List<OrgSubscription>>((ref) async {
  final repository = ref.watch(orgSubscriptionRepositoryProvider);
  return repository.getAll();
});

final orgSubscriptionCreateProvider = StateProvider<OrgSubscription?>((ref) => null);
final orgSubscriptionUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final orgSubscriptionDeleteProvider = StateProvider<String?>((ref) => null);
final orgSubscriptionLoadingProvider = StateProvider<bool>((ref) => false);
