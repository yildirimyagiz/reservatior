import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/exchange_rate_service.dart';
import 'package:reservatior/shared/repositories/exchange_rate_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final exchangeRateServiceProvider = Provider<ExchangeRateService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return ExchangeRateService(dioClient);
});

final exchangeRateRepositoryProvider = Provider<ExchangeRateRepository>((ref) {
  final service = ref.watch(exchangeRateServiceProvider);
  return ExchangeRateRepositoryImpl(service);
});

final exchangeRateListProvider = FutureProvider.autoDispose<List<ExchangeRate>>((ref) async {
  final repository = ref.watch(exchangeRateRepositoryProvider);
  return repository.getAll();
});

final exchangeRateCreateProvider = StateProvider<ExchangeRate?>((ref) => null);
final exchangeRateUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final exchangeRateDeleteProvider = StateProvider<String?>((ref) => null);
final exchangeRateLoadingProvider = StateProvider<bool>((ref) => false);

final exchangeRateLatestProvider = FutureProvider.family.autoDispose<ExchangeRate, ({String base, String quote})>((ref, arg) async {
  final repository = ref.watch(exchangeRateRepositoryProvider);
  return repository.getLatest(arg.base, arg.quote);
});

final currencyConversionProvider = FutureProvider.family.autoDispose<Map<String, dynamic>, ({String base, String quote, double amount, String? date})>((ref, arg) async {
  final repository = ref.watch(exchangeRateRepositoryProvider);
  return repository.convert(arg.base, arg.quote, arg.amount, date: arg.date);
});
