import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/payout_service.dart';
import 'package:reservatior/shared/repositories/payout_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final payoutServiceProvider = Provider<PayoutService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return PayoutService(dioClient);
});

final payoutRepositoryProvider = Provider<PayoutRepository>((ref) {
  final service = ref.watch(payoutServiceProvider);
  return PayoutRepositoryImpl(service);
});

final payoutListProvider = FutureProvider.autoDispose<List<Payout>>((ref) async {
  final repository = ref.watch(payoutRepositoryProvider);
  return repository.getAll();
});

final payoutCreateProvider = StateProvider<Payout?>((ref) => null);
final payoutUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final payoutDeleteProvider = StateProvider<String?>((ref) => null);
final payoutLoadingProvider = StateProvider<bool>((ref) => false);
