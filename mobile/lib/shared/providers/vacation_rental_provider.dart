import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/vacation_rental_service.dart';
import 'package:reservatior/shared/repositories/vacation_rental_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final vacationRentalServiceProvider = Provider<VacationRentalService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return VacationRentalService(dioClient);
});

final vacationRentalRepositoryProvider = Provider<VacationRentalRepository>((ref) {
  final service = ref.watch(vacationRentalServiceProvider);
  return VacationRentalRepositoryImpl(service);
});

final vacationRentalListProvider = FutureProvider.autoDispose<List<VacationRental>>((ref) async {
  final repository = ref.watch(vacationRentalRepositoryProvider);
  return repository.getAll();
});

final vacationRentalCreateProvider = StateProvider<VacationRental?>((ref) => null);
final vacationRentalUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final vacationRentalDeleteProvider = StateProvider<String?>((ref) => null);
final vacationRentalLoadingProvider = StateProvider<bool>((ref) => false);
