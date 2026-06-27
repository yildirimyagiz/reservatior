import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/review_service.dart';
import 'package:reservatior/shared/repositories/review_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final reviewServiceProvider = Provider<ReviewService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return ReviewService(dioClient);
});

final reviewRepositoryProvider = Provider<ReviewRepository>((ref) {
  final service = ref.watch(reviewServiceProvider);
  return ReviewRepositoryImpl(service);
});

final reviewListProvider = FutureProvider.autoDispose<List<Review>>((ref) async {
  final repository = ref.watch(reviewRepositoryProvider);
  return repository.getAll();
});

final propertyReviewsProvider = FutureProvider.family.autoDispose<List<Review>, String>((ref, propertyId) async {
  final repository = ref.watch(reviewRepositoryProvider);
  return repository.getAll(filters: {'propertyId': propertyId});
});

final reviewCreateProvider = StateProvider<Review?>((ref) => null);
final reviewUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final reviewDeleteProvider = StateProvider<String?>((ref) => null);
final reviewLoadingProvider = StateProvider<bool>((ref) => false);
