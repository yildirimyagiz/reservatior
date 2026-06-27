import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/quote_service.dart';
import 'package:reservatior/shared/repositories/quote_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final quoteServiceProvider = Provider<QuoteService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return QuoteService(dioClient);
});

final quoteRepositoryProvider = Provider<QuoteRepository>((ref) {
  final service = ref.watch(quoteServiceProvider);
  return QuoteRepositoryImpl(service);
});

final quoteListProvider = FutureProvider.autoDispose<List<Quote>>((ref) async {
  final repository = ref.watch(quoteRepositoryProvider);
  return repository.getAll();
});

final quoteCreateProvider = StateProvider<Quote?>((ref) => null);
final quoteUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final quoteDeleteProvider = StateProvider<String?>((ref) => null);
final quoteLoadingProvider = StateProvider<bool>((ref) => false);
