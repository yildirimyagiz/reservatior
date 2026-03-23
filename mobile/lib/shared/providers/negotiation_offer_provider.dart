import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/negotiation_offer_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// NegotiationOffer Providers

final NegotiationOfferServiceProvider = Provider<NegotiationOfferService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return NegotiationOfferService(dioClient);
});

// List Provider
final negotiationOfferProvider = FutureProvider.autoDispose<List<NegotiationOffer>>((ref) async {
  final service = ref.watch(NegotiationOfferServiceProvider);
  return service.getNegotiationOffers();
});

// Create Provider
final NegotiationOfferCreateProvider = FutureProvider.autoDispose<NegotiationOffer>((ref) async {
  final service = ref.watch(NegotiationOfferServiceProvider);
  return service.createNegotiationOffer(NegotiationOffer());
});

// Update Provider  
final NegotiationOfferUpdateProvider = FutureProvider.autoDispose<NegotiationOffer>((ref) async {
  final service = ref.watch(NegotiationOfferServiceProvider);
  final state = ref.watch(NegotiationOfferUpdateStateProvider);
  if (state['id'] != null && state['negotiation_offer'] != null) {
    return service.updateNegotiationOffer(state['id'], state['negotiation_offer']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final NegotiationOfferDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(NegotiationOfferServiceProvider);
  final state = ref.watch(NegotiationOfferDeleteStateProvider);
  if (state != null) {
    return service.deleteNegotiationOffer(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final NegotiationOfferUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final NegotiationOfferDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final NegotiationOfferLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(negotiationOfferProvider);
  final createAsync = ref.watch(NegotiationOfferCreateProvider);
  final updateAsync = ref.watch(NegotiationOfferUpdateProvider);
  final deleteAsync = ref.watch(NegotiationOfferDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
