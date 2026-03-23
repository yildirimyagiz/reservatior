import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/exchange_rate_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// ExchangeRate Providers

final ExchangeRateServiceProvider = Provider<ExchangeRateService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return ExchangeRateService(dioClient);
});

// List Provider
final exchangeRateProvider = FutureProvider.autoDispose<List<ExchangeRate>>((ref) async {
  final service = ref.watch(ExchangeRateServiceProvider);
  return service.getExchangeRates();
});

// Create Provider
final ExchangeRateCreateProvider = FutureProvider.autoDispose<ExchangeRate>((ref) async {
  final service = ref.watch(ExchangeRateServiceProvider);
  return service.createExchangeRate(ExchangeRate());
});

// Update Provider  
final ExchangeRateUpdateProvider = FutureProvider.autoDispose<ExchangeRate>((ref) async {
  final service = ref.watch(ExchangeRateServiceProvider);
  final state = ref.watch(ExchangeRateUpdateStateProvider);
  if (state['id'] != null && state['exchange_rate'] != null) {
    return service.updateExchangeRate(state['id'], state['exchange_rate']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final ExchangeRateDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(ExchangeRateServiceProvider);
  final state = ref.watch(ExchangeRateDeleteStateProvider);
  if (state != null) {
    return service.deleteExchangeRate(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final ExchangeRateUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final ExchangeRateDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final ExchangeRateLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(exchangeRateProvider);
  final createAsync = ref.watch(ExchangeRateCreateProvider);
  final updateAsync = ref.watch(ExchangeRateUpdateProvider);
  final deleteAsync = ref.watch(ExchangeRateDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
