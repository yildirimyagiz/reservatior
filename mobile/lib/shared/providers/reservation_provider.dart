import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/reservation_service.dart';
import 'package:reservatior/shared/repositories/reservation_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final reservationServiceProvider = Provider<ReservationService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return ReservationService(dioClient);
});

final reservationRepositoryProvider = Provider<ReservationRepository>((ref) {
  final service = ref.watch(reservationServiceProvider);
  return ReservationRepositoryImpl(service);
});

final reservationListProvider = FutureProvider.autoDispose<List<Reservation>>((ref) async {
  final repository = ref.watch(reservationRepositoryProvider);
  return repository.getAll();
});

final reservationCreateProvider = StateProvider<Reservation?>((ref) => null);
final reservationUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final reservationDeleteProvider = StateProvider<String?>((ref) => null);
final reservationLoadingProvider = StateProvider<bool>((ref) => false);
