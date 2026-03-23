import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/external_rental_listing_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// ExternalRentalListing Providers

final ExternalRentalListingServiceProvider = Provider<ExternalRentalListingService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return ExternalRentalListingService(dioClient);
});

// List Provider
final externalRentalListingProvider = FutureProvider.autoDispose<List<ExternalRentalListing>>((ref) async {
  final service = ref.watch(ExternalRentalListingServiceProvider);
  return service.getExternalRentalListings();
});

// Create Provider
final ExternalRentalListingCreateProvider = FutureProvider.autoDispose<ExternalRentalListing>((ref) async {
  final service = ref.watch(ExternalRentalListingServiceProvider);
  return service.createExternalRentalListing(ExternalRentalListing());
});

// Update Provider  
final ExternalRentalListingUpdateProvider = FutureProvider.autoDispose<ExternalRentalListing>((ref) async {
  final service = ref.watch(ExternalRentalListingServiceProvider);
  final state = ref.watch(ExternalRentalListingUpdateStateProvider);
  if (state['id'] != null && state['external_rental_listing'] != null) {
    return service.updateExternalRentalListing(state['id'], state['external_rental_listing']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final ExternalRentalListingDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(ExternalRentalListingServiceProvider);
  final state = ref.watch(ExternalRentalListingDeleteStateProvider);
  if (state != null) {
    return service.deleteExternalRentalListing(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final ExternalRentalListingUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final ExternalRentalListingDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final ExternalRentalListingLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(externalRentalListingProvider);
  final createAsync = ref.watch(ExternalRentalListingCreateProvider);
  final updateAsync = ref.watch(ExternalRentalListingUpdateProvider);
  final deleteAsync = ref.watch(ExternalRentalListingDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
