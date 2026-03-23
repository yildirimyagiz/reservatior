import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/m_l_s_external_listing_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// MLSExternalListing Providers

final MLSExternalListingServiceProvider = Provider<MLSExternalListingService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return MLSExternalListingService(dioClient);
});

// List Provider
final mLSExternalListingProvider = FutureProvider.autoDispose<List<MLSExternalListing>>((ref) async {
  final service = ref.watch(MLSExternalListingServiceProvider);
  return service.getMLSExternalListings();
});

// Create Provider
final MLSExternalListingCreateProvider = FutureProvider.autoDispose<MLSExternalListing>((ref) async {
  final service = ref.watch(MLSExternalListingServiceProvider);
  return service.createMLSExternalListing(MLSExternalListing());
});

// Update Provider  
final MLSExternalListingUpdateProvider = FutureProvider.autoDispose<MLSExternalListing>((ref) async {
  final service = ref.watch(MLSExternalListingServiceProvider);
  final state = ref.watch(MLSExternalListingUpdateStateProvider);
  if (state['id'] != null && state['m_l_s_external_listing'] != null) {
    return service.updateMLSExternalListing(state['id'], state['m_l_s_external_listing']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final MLSExternalListingDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(MLSExternalListingServiceProvider);
  final state = ref.watch(MLSExternalListingDeleteStateProvider);
  if (state != null) {
    return service.deleteMLSExternalListing(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final MLSExternalListingUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final MLSExternalListingDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final MLSExternalListingLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(mLSExternalListingProvider);
  final createAsync = ref.watch(MLSExternalListingCreateProvider);
  final updateAsync = ref.watch(MLSExternalListingUpdateProvider);
  final deleteAsync = ref.watch(MLSExternalListingDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
