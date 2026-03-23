import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/vacation_rental_platform_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// VacationRentalPlatform Providers

final VacationRentalPlatformServiceProvider = Provider<VacationRentalPlatformService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return VacationRentalPlatformService(dioClient);
});

// List Provider
final vacationRentalPlatformProvider = FutureProvider.autoDispose<List<VacationRentalPlatform>>((ref) async {
  final service = ref.watch(VacationRentalPlatformServiceProvider);
  return service.getVacationRentalPlatforms();
});

// Create Provider
final VacationRentalPlatformCreateProvider = FutureProvider.autoDispose<VacationRentalPlatform>((ref) async {
  final service = ref.watch(VacationRentalPlatformServiceProvider);
  return service.createVacationRentalPlatform(VacationRentalPlatform());
});

// Update Provider  
final VacationRentalPlatformUpdateProvider = FutureProvider.autoDispose<VacationRentalPlatform>((ref) async {
  final service = ref.watch(VacationRentalPlatformServiceProvider);
  final state = ref.watch(VacationRentalPlatformUpdateStateProvider);
  if (state['id'] != null && state['vacation_rental_platform'] != null) {
    return service.updateVacationRentalPlatform(state['id'], state['vacation_rental_platform']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final VacationRentalPlatformDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(VacationRentalPlatformServiceProvider);
  final state = ref.watch(VacationRentalPlatformDeleteStateProvider);
  if (state != null) {
    return service.deleteVacationRentalPlatform(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final VacationRentalPlatformUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final VacationRentalPlatformDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final VacationRentalPlatformLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(vacationRentalPlatformProvider);
  final createAsync = ref.watch(VacationRentalPlatformCreateProvider);
  final updateAsync = ref.watch(VacationRentalPlatformUpdateProvider);
  final deleteAsync = ref.watch(VacationRentalPlatformDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
