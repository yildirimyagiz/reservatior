import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/brand_ambassador_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// BrandAmbassador Providers

final BrandAmbassadorServiceProvider = Provider<BrandAmbassadorService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return BrandAmbassadorService(dioClient);
});

// List Provider
final brandAmbassadorProvider = FutureProvider.autoDispose<List<BrandAmbassador>>((ref) async {
  final service = ref.watch(BrandAmbassadorServiceProvider);
  return service.getBrandAmbassadors();
});

// Create Provider
final BrandAmbassadorCreateProvider = FutureProvider.autoDispose<BrandAmbassador>((ref) async {
  final service = ref.watch(BrandAmbassadorServiceProvider);
  return service.createBrandAmbassador(BrandAmbassador());
});

// Update Provider  
final BrandAmbassadorUpdateProvider = FutureProvider.autoDispose<BrandAmbassador>((ref) async {
  final service = ref.watch(BrandAmbassadorServiceProvider);
  final state = ref.watch(BrandAmbassadorUpdateStateProvider);
  if (state['id'] != null && state['brand_ambassador'] != null) {
    return service.updateBrandAmbassador(state['id'], state['brand_ambassador']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final BrandAmbassadorDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(BrandAmbassadorServiceProvider);
  final state = ref.watch(BrandAmbassadorDeleteStateProvider);
  if (state != null) {
    return service.deleteBrandAmbassador(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final BrandAmbassadorUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final BrandAmbassadorDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final BrandAmbassadorLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(brandAmbassadorProvider);
  final createAsync = ref.watch(BrandAmbassadorCreateProvider);
  final updateAsync = ref.watch(BrandAmbassadorUpdateProvider);
  final deleteAsync = ref.watch(BrandAmbassadorDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
