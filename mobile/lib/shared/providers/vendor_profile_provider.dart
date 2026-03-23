import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/vendor_profile_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// VendorProfile Providers

final VendorProfileServiceProvider = Provider<VendorProfileService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return VendorProfileService(dioClient);
});

// List Provider
final vendorProfileProvider = FutureProvider.autoDispose<List<VendorProfile>>((ref) async {
  final service = ref.watch(VendorProfileServiceProvider);
  return service.getVendorProfiles();
});

// Create Provider
final VendorProfileCreateProvider = FutureProvider.autoDispose<VendorProfile>((ref) async {
  final service = ref.watch(VendorProfileServiceProvider);
  return service.createVendorProfile(VendorProfile());
});

// Update Provider  
final VendorProfileUpdateProvider = FutureProvider.autoDispose<VendorProfile>((ref) async {
  final service = ref.watch(VendorProfileServiceProvider);
  final state = ref.watch(VendorProfileUpdateStateProvider);
  if (state['id'] != null && state['vendor_profile'] != null) {
    return service.updateVendorProfile(state['id'], state['vendor_profile']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final VendorProfileDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(VendorProfileServiceProvider);
  final state = ref.watch(VendorProfileDeleteStateProvider);
  if (state != null) {
    return service.deleteVendorProfile(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final VendorProfileUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final VendorProfileDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final VendorProfileLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(vendorProfileProvider);
  final createAsync = ref.watch(VendorProfileCreateProvider);
  final updateAsync = ref.watch(VendorProfileUpdateProvider);
  final deleteAsync = ref.watch(VendorProfileDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
