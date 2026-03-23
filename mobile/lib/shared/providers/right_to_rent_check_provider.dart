import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/right_to_rent_check_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// RightToRentCheck Providers

final RightToRentCheckServiceProvider = Provider<RightToRentCheckService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return RightToRentCheckService(dioClient);
});

// List Provider
final rightToRentCheckProvider = FutureProvider.autoDispose<List<RightToRentCheck>>((ref) async {
  final service = ref.watch(RightToRentCheckServiceProvider);
  return service.getRightToRentChecks();
});

// Create Provider
final RightToRentCheckCreateProvider = FutureProvider.autoDispose<RightToRentCheck>((ref) async {
  final service = ref.watch(RightToRentCheckServiceProvider);
  return service.createRightToRentCheck(RightToRentCheck());
});

// Update Provider  
final RightToRentCheckUpdateProvider = FutureProvider.autoDispose<RightToRentCheck>((ref) async {
  final service = ref.watch(RightToRentCheckServiceProvider);
  final state = ref.watch(RightToRentCheckUpdateStateProvider);
  if (state['id'] != null && state['right_to_rent_check'] != null) {
    return service.updateRightToRentCheck(state['id'], state['right_to_rent_check']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final RightToRentCheckDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(RightToRentCheckServiceProvider);
  final state = ref.watch(RightToRentCheckDeleteStateProvider);
  if (state != null) {
    return service.deleteRightToRentCheck(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final RightToRentCheckUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final RightToRentCheckDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final RightToRentCheckLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(rightToRentCheckProvider);
  final createAsync = ref.watch(RightToRentCheckCreateProvider);
  final updateAsync = ref.watch(RightToRentCheckUpdateProvider);
  final deleteAsync = ref.watch(RightToRentCheckDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
