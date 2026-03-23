import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/property_offer_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// PropertyOffer Providers

final PropertyOfferServiceProvider = Provider<PropertyOfferService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return PropertyOfferService(dioClient);
});

// List Provider
final propertyOfferProvider = FutureProvider.autoDispose<List<PropertyOffer>>((ref) async {
  final service = ref.watch(PropertyOfferServiceProvider);
  return service.getPropertyOffers();
});

// Create Provider
final PropertyOfferCreateProvider = FutureProvider.autoDispose<PropertyOffer>((ref) async {
  final service = ref.watch(PropertyOfferServiceProvider);
  return service.createPropertyOffer(PropertyOffer());
});

// Update Provider  
final PropertyOfferUpdateProvider = FutureProvider.autoDispose<PropertyOffer>((ref) async {
  final service = ref.watch(PropertyOfferServiceProvider);
  final state = ref.watch(PropertyOfferUpdateStateProvider);
  if (state['id'] != null && state['property_offer'] != null) {
    return service.updatePropertyOffer(state['id'], state['property_offer']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final PropertyOfferDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(PropertyOfferServiceProvider);
  final state = ref.watch(PropertyOfferDeleteStateProvider);
  if (state != null) {
    return service.deletePropertyOffer(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final PropertyOfferUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final PropertyOfferDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final PropertyOfferLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(propertyOfferProvider);
  final createAsync = ref.watch(PropertyOfferCreateProvider);
  final updateAsync = ref.watch(PropertyOfferUpdateProvider);
  final deleteAsync = ref.watch(PropertyOfferDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
