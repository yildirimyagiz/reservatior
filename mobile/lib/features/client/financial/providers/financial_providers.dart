
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/dio_client.dart';
import 'package:reservatior/features/client/financial/data/services/escrow_service.dart';
import 'package:reservatior/features/client/financial/data/models/escrow_account.dart';

final escrowServiceProvider = Provider<EscrowService>((ref) {
  return EscrowService(DioClient());
});

final escrowAccountsProvider = FutureProvider<List<EscrowAccount>>((ref) async {
  final service = ref.watch(escrowServiceProvider);
  return await service.getAccounts();
});

final walletProvider = FutureProvider<Map<String, dynamic>>((ref) async {
  final service = ref.watch(escrowServiceProvider);
  return await service.getWallet();
});
