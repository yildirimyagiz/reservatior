import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/guest_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// Guest Providers

final GuestServiceProvider = Provider<GuestService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return GuestService(dioClient);
});

// List Provider
final guestProvider = FutureProvider.autoDispose<List<Guest>>((ref) async {
  final service = ref.watch(GuestServiceProvider);
  return service.getGuests();
});

// Create Provider
final GuestCreateProvider = FutureProvider.autoDispose<Guest>((ref) async {
  final service = ref.watch(GuestServiceProvider);
  return service.createGuest(Guest());
});

// Update Provider  
final GuestUpdateProvider = FutureProvider.autoDispose<Guest>((ref) async {
  final service = ref.watch(GuestServiceProvider);
  final state = ref.watch(GuestUpdateStateProvider);
  if (state['id'] != null && state['guest'] != null) {
    return service.updateGuest(state['id'], state['guest']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final GuestDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(GuestServiceProvider);
  final state = ref.watch(GuestDeleteStateProvider);
  if (state != null) {
    return service.deleteGuest(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final GuestUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final GuestDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final GuestLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(guestProvider);
  final createAsync = ref.watch(GuestCreateProvider);
  final updateAsync = ref.watch(GuestUpdateProvider);
  final deleteAsync = ref.watch(GuestDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
