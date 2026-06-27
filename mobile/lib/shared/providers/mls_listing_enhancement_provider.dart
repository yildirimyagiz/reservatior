import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/mls_listing_enhancement_service.dart';
import 'package:reservatior/shared/repositories/mls_listing_enhancement_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final mlsListingEnhancementServiceProvider = Provider<MlsListingEnhancementService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return MlsListingEnhancementService(dioClient);
});

final mlsListingEnhancementRepositoryProvider = Provider<MlsListingEnhancementRepository>((ref) {
  final service = ref.watch(mlsListingEnhancementServiceProvider);
  return MlsListingEnhancementRepositoryImpl(service);
});

final mlsListingEnhancementListProvider = FutureProvider.autoDispose<List<MlsListingEnhancement>>((ref) async {
  final repository = ref.watch(mlsListingEnhancementRepositoryProvider);
  return repository.getAll();
});

final mlsListingEnhancementCreateProvider = StateProvider<MlsListingEnhancement?>((ref) => null);
final mlsListingEnhancementUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final mlsListingEnhancementDeleteProvider = StateProvider<String?>((ref) => null);
final mlsListingEnhancementLoadingProvider = StateProvider<bool>((ref) => false);
