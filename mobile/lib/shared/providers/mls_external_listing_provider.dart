import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/mls_external_listing_service.dart';
import 'package:reservatior/shared/repositories/mls_external_listing_repository.dart';
import 'dio_client_provider.dart';
import 'package:reservatior/shared/models/models.dart';

final mlsExternalListingServiceProvider = Provider<MlsExternalListingService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return MlsExternalListingService(dioClient);
});

final mlsExternalListingRepositoryProvider = Provider<MlsExternalListingRepository>((ref) {
  final service = ref.watch(mlsExternalListingServiceProvider);
  return MlsExternalListingRepositoryImpl(service);
});

final mlsExternalListingListProvider = FutureProvider.autoDispose<List<MlsExternalListing>>((ref) async {
  final repository = ref.watch(mlsExternalListingRepositoryProvider);
  return repository.getAll();
});

final mlsExternalListingCreateProvider = StateProvider<MlsExternalListing?>((ref) => null);
final mlsExternalListingUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final mlsExternalListingDeleteProvider = StateProvider<String?>((ref) => null);
final mlsExternalListingLoadingProvider = StateProvider<bool>((ref) => false);
