import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/listing_service.dart';
import 'package:reservatior/shared/repositories/listing_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/providers/dio_client_provider.dart';

final listingServiceProvider = Provider<ListingService>((ref) {
  final dio = ref.watch(dioClientProvider);
  return ListingService(dio);
});

final listingRepositoryProvider = Provider<ListingRepository>((ref) {
  final service = ref.watch(listingServiceProvider);
  return ListingRepositoryImpl(service);
});

// Default list (unfiltered)
final listingListProvider = FutureProvider.autoDispose<List<Listing>>((ref) async {
  final repo = ref.watch(listingRepositoryProvider);
  return await repo.getAll();
});

// Advanced Filtered Provider
final filteredListingProvider = FutureProvider.family.autoDispose<List<Listing>, Map<String, dynamic>>((ref, filters) async {
  final repo = ref.watch(listingRepositoryProvider);
  return await repo.getAll(filters: filters);
});

final listingCreateProvider = StateProvider<Listing?>((ref) => null);
final listingUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final listingDeleteProvider = StateProvider<String?>((ref) => null);
final listingLoadingProvider = StateProvider<bool>((ref) => false);
