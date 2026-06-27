import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/external_rental_listing_service.dart';
import 'package:reservatior/shared/repositories/external_rental_listing_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final externalRentalListingServiceProvider = Provider<ExternalRentalListingService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return ExternalRentalListingService(dioClient);
});

final externalRentalListingRepositoryProvider = Provider<ExternalRentalListingRepository>((ref) {
  final service = ref.watch(externalRentalListingServiceProvider);
  return ExternalRentalListingRepositoryImpl(service);
});

final externalRentalListingListProvider = FutureProvider.autoDispose<List<ExternalRentalListing>>((ref) async {
  final repository = ref.watch(externalRentalListingRepositoryProvider);
  return repository.getAll();
});

final externalRentalListingCreateProvider = StateProvider<ExternalRentalListing?>((ref) => null);
final externalRentalListingUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final externalRentalListingDeleteProvider = StateProvider<String?>((ref) => null);
final externalRentalListingLoadingProvider = StateProvider<bool>((ref) => false);
