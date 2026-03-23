import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/offer_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// Offer Providers

final OfferServiceProvider = Provider<OfferService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return OfferService(dioClient);
});

// List Provider
final offerProvider = FutureProvider.autoDispose<List<Offer>>((ref) async {
  final service = ref.watch(OfferServiceProvider);
  return service.getOffers();
});

// Create Provider
final OfferCreateProvider = FutureProvider.autoDispose<Offer>((ref) async {
  final service = ref.watch(OfferServiceProvider);
  return service.createOffer(Offer());
});

// Update Provider  
final OfferUpdateProvider = FutureProvider.autoDispose<Offer>((ref) async {
  final service = ref.watch(OfferServiceProvider);
  final state = ref.watch(OfferUpdateStateProvider);
  if (state['id'] != null && state['offer'] != null) {
    return service.updateOffer(state['id'], state['offer']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final OfferDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(OfferServiceProvider);
  final state = ref.watch(OfferDeleteStateProvider);
  if (state != null) {
    return service.deleteOffer(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final OfferUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final OfferDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final OfferLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(offerProvider);
  final createAsync = ref.watch(OfferCreateProvider);
  final updateAsync = ref.watch(OfferUpdateProvider);
  final deleteAsync = ref.watch(OfferDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
