import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/guest_review_service.dart';
import 'package:reservatior/shared/repositories/guest_review_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final guestReviewServiceProvider = Provider<GuestReviewService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return GuestReviewService(dioClient);
});

final guestReviewRepositoryProvider = Provider<GuestReviewRepository>((ref) {
  final service = ref.watch(guestReviewServiceProvider);
  return GuestReviewRepositoryImpl(service);
});

final guestReviewListProvider = FutureProvider.autoDispose<List<GuestReview>>((ref) async {
  final repository = ref.watch(guestReviewRepositoryProvider);
  return repository.getAll();
});

final guestReviewCreateProvider = StateProvider<GuestReview?>((ref) => null);
final guestReviewUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final guestReviewDeleteProvider = StateProvider<String?>((ref) => null);
final guestReviewLoadingProvider = StateProvider<bool>((ref) => false);
