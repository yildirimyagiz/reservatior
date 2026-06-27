import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/escrow_status_history_service.dart';
import 'package:reservatior/shared/repositories/escrow_status_history_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final escrowStatusHistoryServiceProvider = Provider<EscrowStatusHistoryService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return EscrowStatusHistoryService(dioClient);
});

final escrowStatusHistoryRepositoryProvider = Provider<EscrowStatusHistoryRepository>((ref) {
  final service = ref.watch(escrowStatusHistoryServiceProvider);
  return EscrowStatusHistoryRepositoryImpl(service);
});

final escrowStatusHistoryListProvider = FutureProvider.autoDispose<List<EscrowStatusHistory>>((ref) async {
  final repository = ref.watch(escrowStatusHistoryRepositoryProvider);
  return repository.getAll();
});

final escrowStatusHistoryCreateProvider = StateProvider<EscrowStatusHistory?>((ref) => null);
final escrowStatusHistoryUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final escrowStatusHistoryDeleteProvider = StateProvider<String?>((ref) => null);
final escrowStatusHistoryLoadingProvider = StateProvider<bool>((ref) => false);
