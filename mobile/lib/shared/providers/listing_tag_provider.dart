import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/listing_tag_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// ListingTag Providers

final ListingTagServiceProvider = Provider<ListingTagService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return ListingTagService(dioClient);
});

// List Provider
final listingTagProvider = FutureProvider.autoDispose<List<ListingTag>>((ref) async {
  final service = ref.watch(ListingTagServiceProvider);
  return service.getListingTags();
});

// Create Provider
final ListingTagCreateProvider = FutureProvider.autoDispose<ListingTag>((ref) async {
  final service = ref.watch(ListingTagServiceProvider);
  return service.createListingTag(ListingTag());
});

// Update Provider  
final ListingTagUpdateProvider = FutureProvider.autoDispose<ListingTag>((ref) async {
  final service = ref.watch(ListingTagServiceProvider);
  final state = ref.watch(ListingTagUpdateStateProvider);
  if (state['id'] != null && state['listing_tag'] != null) {
    return service.updateListingTag(state['id'], state['listing_tag']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final ListingTagDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(ListingTagServiceProvider);
  final state = ref.watch(ListingTagDeleteStateProvider);
  if (state != null) {
    return service.deleteListingTag(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final ListingTagUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final ListingTagDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final ListingTagLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(listingTagProvider);
  final createAsync = ref.watch(ListingTagCreateProvider);
  final updateAsync = ref.watch(ListingTagUpdateProvider);
  final deleteAsync = ref.watch(ListingTagDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
