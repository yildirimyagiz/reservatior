import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/ledger_entry_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// LedgerEntry Providers

final LedgerEntryServiceProvider = Provider<LedgerEntryService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return LedgerEntryService(dioClient);
});

// List Provider
final ledgerEntryProvider = FutureProvider.autoDispose<List<LedgerEntry>>((ref) async {
  final service = ref.watch(LedgerEntryServiceProvider);
  return service.getLedgerEntrys();
});

// Create Provider
final LedgerEntryCreateProvider = FutureProvider.autoDispose<LedgerEntry>((ref) async {
  final service = ref.watch(LedgerEntryServiceProvider);
  return service.createLedgerEntry(LedgerEntry());
});

// Update Provider  
final LedgerEntryUpdateProvider = FutureProvider.autoDispose<LedgerEntry>((ref) async {
  final service = ref.watch(LedgerEntryServiceProvider);
  final state = ref.watch(LedgerEntryUpdateStateProvider);
  if (state['id'] != null && state['ledger_entry'] != null) {
    return service.updateLedgerEntry(state['id'], state['ledger_entry']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final LedgerEntryDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(LedgerEntryServiceProvider);
  final state = ref.watch(LedgerEntryDeleteStateProvider);
  if (state != null) {
    return service.deleteLedgerEntry(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final LedgerEntryUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final LedgerEntryDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final LedgerEntryLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(ledgerEntryProvider);
  final createAsync = ref.watch(LedgerEntryCreateProvider);
  final updateAsync = ref.watch(LedgerEntryUpdateProvider);
  final deleteAsync = ref.watch(LedgerEntryDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
