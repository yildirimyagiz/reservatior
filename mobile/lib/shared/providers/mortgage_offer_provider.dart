import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/mortgage_offer_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// MortgageOffer Providers

final MortgageOfferServiceProvider = Provider<MortgageOfferService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return MortgageOfferService(dioClient);
});

// List Provider
final mortgageOfferProvider = FutureProvider.autoDispose<List<MortgageOffer>>((ref) async {
  final service = ref.watch(MortgageOfferServiceProvider);
  return service.getMortgageOffers();
});

// Create Provider
final MortgageOfferCreateProvider = FutureProvider.autoDispose<MortgageOffer>((ref) async {
  final service = ref.watch(MortgageOfferServiceProvider);
  return service.createMortgageOffer(MortgageOffer());
});

// Update Provider  
final MortgageOfferUpdateProvider = FutureProvider.autoDispose<MortgageOffer>((ref) async {
  final service = ref.watch(MortgageOfferServiceProvider);
  final state = ref.watch(MortgageOfferUpdateStateProvider);
  if (state['id'] != null && state['mortgage_offer'] != null) {
    return service.updateMortgageOffer(state['id'], state['mortgage_offer']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final MortgageOfferDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(MortgageOfferServiceProvider);
  final state = ref.watch(MortgageOfferDeleteStateProvider);
  if (state != null) {
    return service.deleteMortgageOffer(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final MortgageOfferUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final MortgageOfferDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final MortgageOfferLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(mortgageOfferProvider);
  final createAsync = ref.watch(MortgageOfferCreateProvider);
  final updateAsync = ref.watch(MortgageOfferUpdateProvider);
  final deleteAsync = ref.watch(MortgageOfferDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
