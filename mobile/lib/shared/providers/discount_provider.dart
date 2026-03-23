import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/discount_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// Discount Providers

final DiscountServiceProvider = Provider<DiscountService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return DiscountService(dioClient);
});

// List Provider
final discountProvider = FutureProvider.autoDispose<List<Discount>>((ref) async {
  final service = ref.watch(DiscountServiceProvider);
  return service.getDiscounts();
});

// Create Provider
final DiscountCreateProvider = FutureProvider.autoDispose<Discount>((ref) async {
  final service = ref.watch(DiscountServiceProvider);
  return service.createDiscount(Discount());
});

// Update Provider  
final DiscountUpdateProvider = FutureProvider.autoDispose<Discount>((ref) async {
  final service = ref.watch(DiscountServiceProvider);
  final state = ref.watch(DiscountUpdateStateProvider);
  if (state['id'] != null && state['discount'] != null) {
    return service.updateDiscount(state['id'], state['discount']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final DiscountDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(DiscountServiceProvider);
  final state = ref.watch(DiscountDeleteStateProvider);
  if (state != null) {
    return service.deleteDiscount(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final DiscountUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final DiscountDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final DiscountLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(discountProvider);
  final createAsync = ref.watch(DiscountCreateProvider);
  final updateAsync = ref.watch(DiscountUpdateProvider);
  final deleteAsync = ref.watch(DiscountDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
