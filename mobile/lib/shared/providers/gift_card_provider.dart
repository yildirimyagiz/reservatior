import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/gift_card_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// GiftCard Providers

final GiftCardServiceProvider = Provider<GiftCardService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return GiftCardService(dioClient);
});

// List Provider
final giftCardProvider = FutureProvider.autoDispose<List<GiftCard>>((ref) async {
  final service = ref.watch(GiftCardServiceProvider);
  return service.getGiftCards();
});

// Create Provider
final GiftCardCreateProvider = FutureProvider.autoDispose<GiftCard>((ref) async {
  final service = ref.watch(GiftCardServiceProvider);
  return service.createGiftCard(GiftCard());
});

// Update Provider  
final GiftCardUpdateProvider = FutureProvider.autoDispose<GiftCard>((ref) async {
  final service = ref.watch(GiftCardServiceProvider);
  final state = ref.watch(GiftCardUpdateStateProvider);
  if (state['id'] != null && state['gift_card'] != null) {
    return service.updateGiftCard(state['id'], state['gift_card']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final GiftCardDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(GiftCardServiceProvider);
  final state = ref.watch(GiftCardDeleteStateProvider);
  if (state != null) {
    return service.deleteGiftCard(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final GiftCardUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final GiftCardDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final GiftCardLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(giftCardProvider);
  final createAsync = ref.watch(GiftCardCreateProvider);
  final updateAsync = ref.watch(GiftCardUpdateProvider);
  final deleteAsync = ref.watch(GiftCardDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
