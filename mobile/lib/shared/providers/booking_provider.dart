import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/booking_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// Booking Providers

final bookingServiceProvider = Provider<BookingService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return BookingService(dioClient);
});

// List Provider
final bookingListProvider = FutureProvider.autoDispose<List<Booking>>((ref) async {
  final service = ref.watch(bookingServiceProvider);
  return service.getBookings();
});

// State Providers for create/update/delete
final bookingCreateStateProvider = StateProvider<Booking?>((ref) => null);
final bookingUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final bookingDeleteStateProvider = StateProvider<String?>((ref) => null);

// Create Provider
final bookingCreateProvider = FutureProvider.autoDispose<Booking?>((ref) async {
  final service = ref.watch(bookingServiceProvider);
  final state = ref.watch(bookingCreateStateProvider);
  if (state != null) {
    return service.createBooking(state);
  }
  return null;
});

// Update Provider  
final bookingUpdateProvider = FutureProvider.autoDispose<Booking?>((ref) async {
  final service = ref.watch(bookingServiceProvider);
  final state = ref.watch(bookingUpdateStateProvider);
  if (state['id'] != null && state['booking'] != null) {
    return service.updateBooking(state['id'], state['booking']);
  }
  return null;
});

// Delete Provider
final bookingDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(bookingServiceProvider);
  final state = ref.watch(bookingDeleteStateProvider);
  if (state != null) {
    return service.deleteBooking(state);
  }
});

// Loading Provider
final bookingLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(bookingListProvider);
  return listAsync.isLoading;
});
