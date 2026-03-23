import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/currency_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// Currency Providers

final CurrencyServiceProvider = Provider<CurrencyService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return CurrencyService(dioClient);
});

// List Provider
final currencyProvider = FutureProvider.autoDispose<List<Currency>>((ref) async {
  final service = ref.watch(CurrencyServiceProvider);
  return service.getCurrencys();
});

// Create Provider
final CurrencyCreateProvider = FutureProvider.autoDispose<Currency>((ref) async {
  final service = ref.watch(CurrencyServiceProvider);
  return service.createCurrency(Currency());
});

// Update Provider  
final CurrencyUpdateProvider = FutureProvider.autoDispose<Currency>((ref) async {
  final service = ref.watch(CurrencyServiceProvider);
  final state = ref.watch(CurrencyUpdateStateProvider);
  if (state['id'] != null && state['currency'] != null) {
    return service.updateCurrency(state['id'], state['currency']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final CurrencyDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(CurrencyServiceProvider);
  final state = ref.watch(CurrencyDeleteStateProvider);
  if (state != null) {
    return service.deleteCurrency(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final CurrencyUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final CurrencyDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final CurrencyLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(currencyProvider);
  final createAsync = ref.watch(CurrencyCreateProvider);
  final updateAsync = ref.watch(CurrencyUpdateProvider);
  final deleteAsync = ref.watch(CurrencyDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
