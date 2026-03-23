import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/rent_arrears_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// RentArrears Providers

final RentArrearsServiceProvider = Provider<RentArrearsService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return RentArrearsService(dioClient);
});

// List Provider
final rentArrearsProvider = FutureProvider.autoDispose<List<RentArrears>>((ref) async {
  final service = ref.watch(RentArrearsServiceProvider);
  return service.getRentArrearss();
});

// Create Provider
final RentArrearsCreateProvider = FutureProvider.autoDispose<RentArrears>((ref) async {
  final service = ref.watch(RentArrearsServiceProvider);
  return service.createRentArrears(RentArrears());
});

// Update Provider  
final RentArrearsUpdateProvider = FutureProvider.autoDispose<RentArrears>((ref) async {
  final service = ref.watch(RentArrearsServiceProvider);
  final state = ref.watch(RentArrearsUpdateStateProvider);
  if (state['id'] != null && state['rent_arrears'] != null) {
    return service.updateRentArrears(state['id'], state['rent_arrears']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final RentArrearsDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(RentArrearsServiceProvider);
  final state = ref.watch(RentArrearsDeleteStateProvider);
  if (state != null) {
    return service.deleteRentArrears(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final RentArrearsUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final RentArrearsDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final RentArrearsLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(rentArrearsProvider);
  final createAsync = ref.watch(RentArrearsCreateProvider);
  final updateAsync = ref.watch(RentArrearsUpdateProvider);
  final deleteAsync = ref.watch(RentArrearsDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
