import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/event_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// Event Providers

final EventServiceProvider = Provider<EventService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return EventService(dioClient);
});

// List Provider
final eventProvider = FutureProvider.autoDispose<List<Event>>((ref) async {
  final service = ref.watch(EventServiceProvider);
  return service.getEvents();
});

// Create Provider
final EventCreateProvider = FutureProvider.autoDispose<Event>((ref) async {
  final service = ref.watch(EventServiceProvider);
  return service.createEvent(Event());
});

// Update Provider  
final EventUpdateProvider = FutureProvider.autoDispose<Event>((ref) async {
  final service = ref.watch(EventServiceProvider);
  final state = ref.watch(EventUpdateStateProvider);
  if (state['id'] != null && state['event'] != null) {
    return service.updateEvent(state['id'], state['event']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final EventDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(EventServiceProvider);
  final state = ref.watch(EventDeleteStateProvider);
  if (state != null) {
    return service.deleteEvent(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final EventUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final EventDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final EventLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(eventProvider);
  final createAsync = ref.watch(EventCreateProvider);
  final updateAsync = ref.watch(EventUpdateProvider);
  final deleteAsync = ref.watch(EventDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
