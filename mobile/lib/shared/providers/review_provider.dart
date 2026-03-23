import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/review_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// Review Providers

final ReviewServiceProvider = Provider<ReviewService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return ReviewService(dioClient);
});

// List Provider
final reviewProvider = FutureProvider.autoDispose<List<Review>>((ref) async {
  final service = ref.watch(ReviewServiceProvider);
  return service.getReviews();
});

// Create Provider
final ReviewCreateProvider = FutureProvider.autoDispose<Review>((ref) async {
  final service = ref.watch(ReviewServiceProvider);
  return service.createReview(Review());
});

// Update Provider  
final ReviewUpdateProvider = FutureProvider.autoDispose<Review>((ref) async {
  final service = ref.watch(ReviewServiceProvider);
  final state = ref.watch(ReviewUpdateStateProvider);
  if (state['id'] != null && state['review'] != null) {
    return service.updateReview(state['id'], state['review']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final ReviewDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(ReviewServiceProvider);
  final state = ref.watch(ReviewDeleteStateProvider);
  if (state != null) {
    return service.deleteReview(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final ReviewUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final ReviewDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final ReviewLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(reviewProvider);
  final createAsync = ref.watch(ReviewCreateProvider);
  final updateAsync = ref.watch(ReviewUpdateProvider);
  final deleteAsync = ref.watch(ReviewDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
