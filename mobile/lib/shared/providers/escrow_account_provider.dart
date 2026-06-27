import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/escrow_account_service.dart';
import 'package:reservatior/shared/repositories/escrow_account_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final escrowAccountServiceProvider = Provider<EscrowAccountService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return EscrowAccountService(dioClient);
});

final escrowAccountRepositoryProvider = Provider<EscrowAccountRepository>((ref) {
  final service = ref.watch(escrowAccountServiceProvider);
  return EscrowAccountRepositoryImpl(service);
});

final escrowAccountListProvider = FutureProvider.autoDispose<List<EscrowAccount>>((ref) async {
  final repository = ref.watch(escrowAccountRepositoryProvider);
  return repository.getAll();
});

final escrowAccountCreateProvider = StateProvider<EscrowAccount?>((ref) => null);
final escrowAccountUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final escrowAccountDeleteProvider = StateProvider<String?>((ref) => null);
final escrowAccountLoadingProvider = StateProvider<bool>((ref) => false);
