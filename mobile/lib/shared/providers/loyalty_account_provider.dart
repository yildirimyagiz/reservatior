import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/loyalty_account_service.dart';
import 'package:reservatior/shared/repositories/loyalty_account_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final loyaltyAccountServiceProvider = Provider<LoyaltyAccountService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return LoyaltyAccountService(dioClient);
});

final loyaltyAccountRepositoryProvider = Provider<LoyaltyAccountRepository>((ref) {
  final service = ref.watch(loyaltyAccountServiceProvider);
  return LoyaltyAccountRepositoryImpl(service);
});

final loyaltyAccountListProvider = FutureProvider.autoDispose<List<LoyaltyAccount>>((ref) async {
  final repository = ref.watch(loyaltyAccountRepositoryProvider);
  return repository.getAll();
});

final loyaltyAccountCreateProvider = StateProvider<LoyaltyAccount?>((ref) => null);
final loyaltyAccountUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final loyaltyAccountDeleteProvider = StateProvider<String?>((ref) => null);
final loyaltyAccountLoadingProvider = StateProvider<bool>((ref) => false);
