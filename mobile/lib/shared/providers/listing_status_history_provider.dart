import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/listing_status_history_service.dart';
import 'package:reservatior/shared/repositories/listing_status_history_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final listingStatusHistoryServiceProvider = Provider<ListingStatusHistoryService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return ListingStatusHistoryService(dioClient);
});

final listingStatusHistoryRepositoryProvider = Provider<ListingStatusHistoryRepository>((ref) {
  final service = ref.watch(listingStatusHistoryServiceProvider);
  return ListingStatusHistoryRepositoryImpl(service);
});

final listingStatusHistoryListProvider = FutureProvider.autoDispose<List<ListingStatusHistory>>((ref) async {
  final repository = ref.watch(listingStatusHistoryRepositoryProvider);
  return repository.getAll();
});

final listingStatusHistoryCreateProvider = StateProvider<ListingStatusHistory?>((ref) => null);
final listingStatusHistoryUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final listingStatusHistoryDeleteProvider = StateProvider<String?>((ref) => null);
final listingStatusHistoryLoadingProvider = StateProvider<bool>((ref) => false);
