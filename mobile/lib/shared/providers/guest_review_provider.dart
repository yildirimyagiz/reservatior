import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/guest_review_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// GuestReview Providers

final GuestReviewServiceProvider = Provider<GuestReviewService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return GuestReviewService(dioClient);
});

// List Provider
final guestReviewProvider = FutureProvider.autoDispose<List<GuestReview>>((ref) async {
  final service = ref.watch(GuestReviewServiceProvider);
  return service.getGuestReviews();
});

// Create Provider
final GuestReviewCreateProvider = FutureProvider.autoDispose<GuestReview>((ref) async {
  final service = ref.watch(GuestReviewServiceProvider);
  return service.createGuestReview(GuestReview());
});

// Update Provider  
final GuestReviewUpdateProvider = FutureProvider.autoDispose<GuestReview>((ref) async {
  final service = ref.watch(GuestReviewServiceProvider);
  final state = ref.watch(GuestReviewUpdateStateProvider);
  if (state['id'] != null && state['guest_review'] != null) {
    return service.updateGuestReview(state['id'], state['guest_review']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final GuestReviewDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(GuestReviewServiceProvider);
  final state = ref.watch(GuestReviewDeleteStateProvider);
  if (state != null) {
    return service.deleteGuestReview(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final GuestReviewUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final GuestReviewDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final GuestReviewLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(guestReviewProvider);
  final createAsync = ref.watch(GuestReviewCreateProvider);
  final updateAsync = ref.watch(GuestReviewUpdateProvider);
  final deleteAsync = ref.watch(GuestReviewDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
