import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/listing_channel_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// ListingChannel Providers

final ListingChannelServiceProvider = Provider<ListingChannelService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return ListingChannelService(dioClient);
});

// List Provider
final listingChannelProvider = FutureProvider.autoDispose<List<ListingChannel>>((ref) async {
  final service = ref.watch(ListingChannelServiceProvider);
  return service.getListingChannels();
});

// Create Provider
final ListingChannelCreateProvider = FutureProvider.autoDispose<ListingChannel>((ref) async {
  final service = ref.watch(ListingChannelServiceProvider);
  return service.createListingChannel(ListingChannel());
});

// Update Provider  
final ListingChannelUpdateProvider = FutureProvider.autoDispose<ListingChannel>((ref) async {
  final service = ref.watch(ListingChannelServiceProvider);
  final state = ref.watch(ListingChannelUpdateStateProvider);
  if (state['id'] != null && state['listing_channel'] != null) {
    return service.updateListingChannel(state['id'], state['listing_channel']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final ListingChannelDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(ListingChannelServiceProvider);
  final state = ref.watch(ListingChannelDeleteStateProvider);
  if (state != null) {
    return service.deleteListingChannel(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final ListingChannelUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final ListingChannelDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final ListingChannelLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(listingChannelProvider);
  final createAsync = ref.watch(ListingChannelCreateProvider);
  final updateAsync = ref.watch(ListingChannelUpdateProvider);
  final deleteAsync = ref.watch(ListingChannelDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
