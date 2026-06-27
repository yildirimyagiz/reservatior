import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/booking_service.dart';
import 'package:reservatior/shared/repositories/booking_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final bookingServiceProvider = Provider<BookingService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return BookingService(dioClient);
});

final bookingRepositoryProvider = Provider<BookingRepository>((ref) {
  final service = ref.watch(bookingServiceProvider);
  return BookingRepositoryImpl(service);
});

final bookingListProvider = FutureProvider.autoDispose<List<Booking>>((ref) async {
  final repository = ref.watch(bookingRepositoryProvider);
  return repository.getAll();
});

final bookingGuestReviewProvider = FutureProvider.family.autoDispose<Map<String, dynamic>, Map<String, dynamic>>((ref, params) async {
  final repository = ref.watch(bookingRepositoryProvider);
  final bookingId = params['bookingId'] as String;
  final reviewData = params['reviewData'] as Map<String, dynamic>;
  return repository.createGuestReview(bookingId, reviewData);
});

final bookingCreateProvider = StateProvider<Booking?>((ref) => null);
final bookingUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final bookingDeleteProvider = StateProvider<String?>((ref) => null);
final bookingLoadingProvider = StateProvider<bool>((ref) => false);
