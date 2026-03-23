import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/listing_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// Listing Providers

final ListingServiceProvider = Provider<ListingService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return ListingService(dioClient);
});

// List Provider
final listingProvider = FutureProvider.autoDispose<List<Listing>>((ref) async {
  final service = ref.watch(ListingServiceProvider);
  return service.getListings();
});

// Create Provider
final ListingCreateProvider = FutureProvider.autoDispose<Listing>((ref) async {
  final service = ref.watch(ListingServiceProvider);
  return service.createListing(Listing());
});

// Update Provider  
final ListingUpdateProvider = FutureProvider.autoDispose<Listing>((ref) async {
  final service = ref.watch(ListingServiceProvider);
  final state = ref.watch(ListingUpdateStateProvider);
  if (state['id'] != null && state['listing'] != null) {
    return service.updateListing(state['id'], state['listing']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final ListingDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(ListingServiceProvider);
  final state = ref.watch(ListingDeleteStateProvider);
  if (state != null) {
    return service.deleteListing(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final ListingUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final ListingDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final ListingLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(listingProvider);
  final createAsync = ref.watch(ListingCreateProvider);
  final updateAsync = ref.watch(ListingUpdateProvider);
  final deleteAsync = ref.watch(ListingDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
