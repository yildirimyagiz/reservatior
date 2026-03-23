import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/property_promotion_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// PropertyPromotion Providers

final PropertyPromotionServiceProvider = Provider<PropertyPromotionService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return PropertyPromotionService(dioClient);
});

// List Provider
final propertyPromotionProvider = FutureProvider.autoDispose<List<PropertyPromotion>>((ref) async {
  final service = ref.watch(PropertyPromotionServiceProvider);
  return service.getPropertyPromotions();
});

// Create Provider
final PropertyPromotionCreateProvider = FutureProvider.autoDispose<PropertyPromotion>((ref) async {
  final service = ref.watch(PropertyPromotionServiceProvider);
  return service.createPropertyPromotion(PropertyPromotion());
});

// Update Provider  
final PropertyPromotionUpdateProvider = FutureProvider.autoDispose<PropertyPromotion>((ref) async {
  final service = ref.watch(PropertyPromotionServiceProvider);
  final state = ref.watch(PropertyPromotionUpdateStateProvider);
  if (state['id'] != null && state['property_promotion'] != null) {
    return service.updatePropertyPromotion(state['id'], state['property_promotion']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final PropertyPromotionDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(PropertyPromotionServiceProvider);
  final state = ref.watch(PropertyPromotionDeleteStateProvider);
  if (state != null) {
    return service.deletePropertyPromotion(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final PropertyPromotionUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final PropertyPromotionDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final PropertyPromotionLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(propertyPromotionProvider);
  final createAsync = ref.watch(PropertyPromotionCreateProvider);
  final updateAsync = ref.watch(PropertyPromotionUpdateProvider);
  final deleteAsync = ref.watch(PropertyPromotionDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
