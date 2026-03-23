import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/listing_status_history_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// ListingStatusHistory Providers

final ListingStatusHistoryServiceProvider = Provider<ListingStatusHistoryService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return ListingStatusHistoryService(dioClient);
});

// List Provider
final listingStatusHistoryProvider = FutureProvider.autoDispose<List<ListingStatusHistory>>((ref) async {
  final service = ref.watch(ListingStatusHistoryServiceProvider);
  return service.getListingStatusHistorys();
});

// Create Provider
final ListingStatusHistoryCreateProvider = FutureProvider.autoDispose<ListingStatusHistory>((ref) async {
  final service = ref.watch(ListingStatusHistoryServiceProvider);
  return service.createListingStatusHistory(ListingStatusHistory());
});

// Update Provider  
final ListingStatusHistoryUpdateProvider = FutureProvider.autoDispose<ListingStatusHistory>((ref) async {
  final service = ref.watch(ListingStatusHistoryServiceProvider);
  final state = ref.watch(ListingStatusHistoryUpdateStateProvider);
  if (state['id'] != null && state['listing_status_history'] != null) {
    return service.updateListingStatusHistory(state['id'], state['listing_status_history']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final ListingStatusHistoryDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(ListingStatusHistoryServiceProvider);
  final state = ref.watch(ListingStatusHistoryDeleteStateProvider);
  if (state != null) {
    return service.deleteListingStatusHistory(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final ListingStatusHistoryUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final ListingStatusHistoryDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final ListingStatusHistoryLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(listingStatusHistoryProvider);
  final createAsync = ref.watch(ListingStatusHistoryCreateProvider);
  final updateAsync = ref.watch(ListingStatusHistoryUpdateProvider);
  final deleteAsync = ref.watch(ListingStatusHistoryDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
