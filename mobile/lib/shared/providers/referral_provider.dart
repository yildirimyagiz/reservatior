import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/referral_service.dart';
import 'package:reservatior/shared/repositories/referral_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final referralServiceProvider = Provider<ReferralService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return ReferralService(dioClient);
});

final referralRepositoryProvider = Provider<ReferralRepository>((ref) {
  final service = ref.watch(referralServiceProvider);
  return ReferralRepositoryImpl(service);
});

final referralListProvider = FutureProvider.autoDispose<List<Referral>>((ref) async {
  final repository = ref.watch(referralRepositoryProvider);
  return repository.getAll();
});

final referralCreateProvider = StateProvider<Referral?>((ref) => null);
final referralUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final referralDeleteProvider = StateProvider<String?>((ref) => null);
final referralLoadingProvider = StateProvider<bool>((ref) => false);
