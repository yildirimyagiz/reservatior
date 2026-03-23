import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/quote_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// Quote Providers

final QuoteServiceProvider = Provider<QuoteService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return QuoteService(dioClient);
});

// List Provider
final quoteProvider = FutureProvider.autoDispose<List<Quote>>((ref) async {
  final service = ref.watch(QuoteServiceProvider);
  return service.getQuotes();
});

// Create Provider
final QuoteCreateProvider = FutureProvider.autoDispose<Quote>((ref) async {
  final service = ref.watch(QuoteServiceProvider);
  return service.createQuote(Quote());
});

// Update Provider  
final QuoteUpdateProvider = FutureProvider.autoDispose<Quote>((ref) async {
  final service = ref.watch(QuoteServiceProvider);
  final state = ref.watch(QuoteUpdateStateProvider);
  if (state['id'] != null && state['quote'] != null) {
    return service.updateQuote(state['id'], state['quote']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final QuoteDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(QuoteServiceProvider);
  final state = ref.watch(QuoteDeleteStateProvider);
  if (state != null) {
    return service.deleteQuote(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final QuoteUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final QuoteDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final QuoteLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(quoteProvider);
  final createAsync = ref.watch(QuoteCreateProvider);
  final updateAsync = ref.watch(QuoteUpdateProvider);
  final deleteAsync = ref.watch(QuoteDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
