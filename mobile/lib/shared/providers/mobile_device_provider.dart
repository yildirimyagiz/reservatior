import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/mobile_device_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// MobileDevice Providers

final MobileDeviceServiceProvider = Provider<MobileDeviceService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return MobileDeviceService(dioClient);
});

// List Provider
final mobileDeviceProvider = FutureProvider.autoDispose<List<MobileDevice>>((ref) async {
  final service = ref.watch(MobileDeviceServiceProvider);
  return service.getMobileDevices();
});

// Create Provider
final MobileDeviceCreateProvider = FutureProvider.autoDispose<MobileDevice>((ref) async {
  final service = ref.watch(MobileDeviceServiceProvider);
  return service.createMobileDevice(MobileDevice());
});

// Update Provider  
final MobileDeviceUpdateProvider = FutureProvider.autoDispose<MobileDevice>((ref) async {
  final service = ref.watch(MobileDeviceServiceProvider);
  final state = ref.watch(MobileDeviceUpdateStateProvider);
  if (state['id'] != null && state['mobile_device'] != null) {
    return service.updateMobileDevice(state['id'], state['mobile_device']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final MobileDeviceDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(MobileDeviceServiceProvider);
  final state = ref.watch(MobileDeviceDeleteStateProvider);
  if (state != null) {
    return service.deleteMobileDevice(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final MobileDeviceUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final MobileDeviceDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final MobileDeviceLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(mobileDeviceProvider);
  final createAsync = ref.watch(MobileDeviceCreateProvider);
  final updateAsync = ref.watch(MobileDeviceUpdateProvider);
  final deleteAsync = ref.watch(MobileDeviceDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
