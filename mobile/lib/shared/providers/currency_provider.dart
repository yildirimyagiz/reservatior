import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/currency_service.dart';
import 'package:reservatior/shared/repositories/currency_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final currencyServiceProvider = Provider<CurrencyService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return CurrencyService(dioClient);
});

final currencyRepositoryProvider = Provider<CurrencyRepository>((ref) {
  final service = ref.watch(currencyServiceProvider);
  return CurrencyRepositoryImpl(service);
});

final currencyListProvider = FutureProvider.autoDispose<List<Currency>>((ref) async {
  final repository = ref.watch(currencyRepositoryProvider);
  return repository.getAll();
});

final currencyCreateProvider = StateProvider<Currency?>((ref) => null);
final currencyUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final currencyDeleteProvider = StateProvider<String?>((ref) => null);
final currencyLoadingProvider = StateProvider<bool>((ref) => false);
