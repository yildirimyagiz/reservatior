import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/facility_block_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// FacilityBlock Providers

final FacilityBlockServiceProvider = Provider<FacilityBlockService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return FacilityBlockService(dioClient);
});

// List Provider
final facilityBlockProvider = FutureProvider.autoDispose<List<FacilityBlock>>((ref) async {
  final service = ref.watch(FacilityBlockServiceProvider);
  return service.getFacilityBlocks();
});

// Create Provider
final FacilityBlockCreateProvider = FutureProvider.autoDispose<FacilityBlock>((ref) async {
  final service = ref.watch(FacilityBlockServiceProvider);
  return service.createFacilityBlock(FacilityBlock());
});

// Update Provider  
final FacilityBlockUpdateProvider = FutureProvider.autoDispose<FacilityBlock>((ref) async {
  final service = ref.watch(FacilityBlockServiceProvider);
  final state = ref.watch(FacilityBlockUpdateStateProvider);
  if (state['id'] != null && state['facility_block'] != null) {
    return service.updateFacilityBlock(state['id'], state['facility_block']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final FacilityBlockDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(FacilityBlockServiceProvider);
  final state = ref.watch(FacilityBlockDeleteStateProvider);
  if (state != null) {
    return service.deleteFacilityBlock(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final FacilityBlockUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final FacilityBlockDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final FacilityBlockLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(facilityBlockProvider);
  final createAsync = ref.watch(FacilityBlockCreateProvider);
  final updateAsync = ref.watch(FacilityBlockUpdateProvider);
  final deleteAsync = ref.watch(FacilityBlockDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
