import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/escrow_dispute_service.dart';
import 'package:reservatior/shared/repositories/escrow_dispute_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final escrowDisputeServiceProvider = Provider<EscrowDisputeService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return EscrowDisputeService(dioClient);
});

final escrowDisputeRepositoryProvider = Provider<EscrowDisputeRepository>((ref) {
  final service = ref.watch(escrowDisputeServiceProvider);
  return EscrowDisputeRepositoryImpl(service);
});

final escrowDisputeListProvider = FutureProvider.autoDispose<List<EscrowDispute>>((ref) async {
  final repository = ref.watch(escrowDisputeRepositoryProvider);
  return repository.getAll();
});

final escrowDisputeCreateProvider = StateProvider<EscrowDispute?>((ref) => null);
final escrowDisputeUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final escrowDisputeDeleteProvider = StateProvider<String?>((ref) => null);
final escrowDisputeLoadingProvider = StateProvider<bool>((ref) => false);
