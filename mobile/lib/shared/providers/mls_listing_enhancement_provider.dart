import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/mls_listing_enhancement_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// MlsListingEnhancement Providers

final MlsListingEnhancementServiceProvider = Provider<MlsListingEnhancementService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return MlsListingEnhancementService(dioClient);
});

// List Provider
final mlsListingEnhancementProvider = FutureProvider.autoDispose<List<MlsListingEnhancement>>((ref) async {
  final service = ref.watch(MlsListingEnhancementServiceProvider);
  return service.getMlsListingEnhancements();
});

// Create Provider
final MlsListingEnhancementCreateProvider = FutureProvider.autoDispose<MlsListingEnhancement>((ref) async {
  final service = ref.watch(MlsListingEnhancementServiceProvider);
  return service.createMlsListingEnhancement(MlsListingEnhancement());
});

// Update Provider  
final MlsListingEnhancementUpdateProvider = FutureProvider.autoDispose<MlsListingEnhancement>((ref) async {
  final service = ref.watch(MlsListingEnhancementServiceProvider);
  final state = ref.watch(MlsListingEnhancementUpdateStateProvider);
  if (state['id'] != null && state['mls_listing_enhancement'] != null) {
    return service.updateMlsListingEnhancement(state['id'], state['mls_listing_enhancement']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final MlsListingEnhancementDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(MlsListingEnhancementServiceProvider);
  final state = ref.watch(MlsListingEnhancementDeleteStateProvider);
  if (state != null) {
    return service.deleteMlsListingEnhancement(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final MlsListingEnhancementUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final MlsListingEnhancementDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final MlsListingEnhancementLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(mlsListingEnhancementProvider);
  final createAsync = ref.watch(MlsListingEnhancementCreateProvider);
  final updateAsync = ref.watch(MlsListingEnhancementUpdateProvider);
  final deleteAsync = ref.watch(MlsListingEnhancementDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
