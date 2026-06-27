import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/ledger_entry_service.dart';
import 'package:reservatior/shared/repositories/ledger_entry_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final ledgerEntryServiceProvider = Provider<LedgerEntryService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return LedgerEntryService(dioClient);
});

final ledgerEntryRepositoryProvider = Provider<LedgerEntryRepository>((ref) {
  final service = ref.watch(ledgerEntryServiceProvider);
  return LedgerEntryRepositoryImpl(service);
});

final ledgerEntryListProvider = FutureProvider.autoDispose<List<LedgerEntry>>((ref) async {
  final repository = ref.watch(ledgerEntryRepositoryProvider);
  return repository.getAll();
});

final ledgerEntryCreateProvider = StateProvider<LedgerEntry?>((ref) => null);
final ledgerEntryUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final ledgerEntryDeleteProvider = StateProvider<String?>((ref) => null);
final ledgerEntryLoadingProvider = StateProvider<bool>((ref) => false);
