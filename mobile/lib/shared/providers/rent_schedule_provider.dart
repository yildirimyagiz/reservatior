import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/rent_schedule_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// RentSchedule Providers

final RentScheduleServiceProvider = Provider<RentScheduleService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return RentScheduleService(dioClient);
});

// List Provider
final rentScheduleProvider = FutureProvider.autoDispose<List<RentSchedule>>((ref) async {
  final service = ref.watch(RentScheduleServiceProvider);
  return service.getRentSchedules();
});

// Create Provider
final RentScheduleCreateProvider = FutureProvider.autoDispose<RentSchedule>((ref) async {
  final service = ref.watch(RentScheduleServiceProvider);
  return service.createRentSchedule(RentSchedule());
});

// Update Provider  
final RentScheduleUpdateProvider = FutureProvider.autoDispose<RentSchedule>((ref) async {
  final service = ref.watch(RentScheduleServiceProvider);
  final state = ref.watch(RentScheduleUpdateStateProvider);
  if (state['id'] != null && state['rent_schedule'] != null) {
    return service.updateRentSchedule(state['id'], state['rent_schedule']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final RentScheduleDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(RentScheduleServiceProvider);
  final state = ref.watch(RentScheduleDeleteStateProvider);
  if (state != null) {
    return service.deleteRentSchedule(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final RentScheduleUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final RentScheduleDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final RentScheduleLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(rentScheduleProvider);
  final createAsync = ref.watch(RentScheduleCreateProvider);
  final updateAsync = ref.watch(RentScheduleUpdateProvider);
  final deleteAsync = ref.watch(RentScheduleDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
