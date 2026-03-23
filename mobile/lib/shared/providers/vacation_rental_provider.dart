import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/vacation_rental_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// VacationRental Providers

final VacationRentalServiceProvider = Provider<VacationRentalService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return VacationRentalService(dioClient);
});

// List Provider
final vacationRentalProvider = FutureProvider.autoDispose<List<VacationRental>>((ref) async {
  final service = ref.watch(VacationRentalServiceProvider);
  return service.getVacationRentals();
});

// Create Provider
final VacationRentalCreateProvider = FutureProvider.autoDispose<VacationRental>((ref) async {
  final service = ref.watch(VacationRentalServiceProvider);
  return service.createVacationRental(VacationRental());
});

// Update Provider  
final VacationRentalUpdateProvider = FutureProvider.autoDispose<VacationRental>((ref) async {
  final service = ref.watch(VacationRentalServiceProvider);
  final state = ref.watch(VacationRentalUpdateStateProvider);
  if (state['id'] != null && state['vacation_rental'] != null) {
    return service.updateVacationRental(state['id'], state['vacation_rental']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final VacationRentalDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(VacationRentalServiceProvider);
  final state = ref.watch(VacationRentalDeleteStateProvider);
  if (state != null) {
    return service.deleteVacationRental(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final VacationRentalUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final VacationRentalDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final VacationRentalLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(vacationRentalProvider);
  final createAsync = ref.watch(VacationRentalCreateProvider);
  final updateAsync = ref.watch(VacationRentalUpdateProvider);
  final deleteAsync = ref.watch(VacationRentalDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
