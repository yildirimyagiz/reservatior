import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/reservation_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// Reservation Providers

final ReservationServiceProvider = Provider<ReservationService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return ReservationService(dioClient);
});

// List Provider
final reservationProvider = FutureProvider.autoDispose<List<Reservation>>((ref) async {
  final service = ref.watch(ReservationServiceProvider);
  return service.getReservations();
});

// Create Provider
final ReservationCreateProvider = FutureProvider.autoDispose<Reservation>((ref) async {
  final service = ref.watch(ReservationServiceProvider);
  return service.createReservation(Reservation());
});

// Update Provider  
final ReservationUpdateProvider = FutureProvider.autoDispose<Reservation>((ref) async {
  final service = ref.watch(ReservationServiceProvider);
  final state = ref.watch(ReservationUpdateStateProvider);
  if (state['id'] != null && state['reservation'] != null) {
    return service.updateReservation(state['id'], state['reservation']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final ReservationDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(ReservationServiceProvider);
  final state = ref.watch(ReservationDeleteStateProvider);
  if (state != null) {
    return service.deleteReservation(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final ReservationUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final ReservationDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final ReservationLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(reservationProvider);
  final createAsync = ref.watch(ReservationCreateProvider);
  final updateAsync = ref.watch(ReservationUpdateProvider);
  final deleteAsync = ref.watch(ReservationDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
