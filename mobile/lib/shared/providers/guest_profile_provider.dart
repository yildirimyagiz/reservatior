import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/guest_profile_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// GuestProfile Providers

final GuestProfileServiceProvider = Provider<GuestProfileService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return GuestProfileService(dioClient);
});

// List Provider
final guestProfileProvider = FutureProvider.autoDispose<List<GuestProfile>>((ref) async {
  final service = ref.watch(GuestProfileServiceProvider);
  return service.getGuestProfiles();
});

// Create Provider
final GuestProfileCreateProvider = FutureProvider.autoDispose<GuestProfile>((ref) async {
  final service = ref.watch(GuestProfileServiceProvider);
  return service.createGuestProfile(GuestProfile());
});

// Update Provider  
final GuestProfileUpdateProvider = FutureProvider.autoDispose<GuestProfile>((ref) async {
  final service = ref.watch(GuestProfileServiceProvider);
  final state = ref.watch(GuestProfileUpdateStateProvider);
  if (state['id'] != null && state['guest_profile'] != null) {
    return service.updateGuestProfile(state['id'], state['guest_profile']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final GuestProfileDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(GuestProfileServiceProvider);
  final state = ref.watch(GuestProfileDeleteStateProvider);
  if (state != null) {
    return service.deleteGuestProfile(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final GuestProfileUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final GuestProfileDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final GuestProfileLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(guestProfileProvider);
  final createAsync = ref.watch(GuestProfileCreateProvider);
  final updateAsync = ref.watch(GuestProfileUpdateProvider);
  final deleteAsync = ref.watch(GuestProfileDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
