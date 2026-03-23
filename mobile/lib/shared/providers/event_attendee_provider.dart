import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/event_attendee_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// EventAttendee Providers

final EventAttendeeServiceProvider = Provider<EventAttendeeService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return EventAttendeeService(dioClient);
});

// List Provider
final eventAttendeeProvider = FutureProvider.autoDispose<List<EventAttendee>>((ref) async {
  final service = ref.watch(EventAttendeeServiceProvider);
  return service.getEventAttendees();
});

// Create Provider
final EventAttendeeCreateProvider = FutureProvider.autoDispose<EventAttendee>((ref) async {
  final service = ref.watch(EventAttendeeServiceProvider);
  return service.createEventAttendee(EventAttendee());
});

// Update Provider  
final EventAttendeeUpdateProvider = FutureProvider.autoDispose<EventAttendee>((ref) async {
  final service = ref.watch(EventAttendeeServiceProvider);
  final state = ref.watch(EventAttendeeUpdateStateProvider);
  if (state['id'] != null && state['event_attendee'] != null) {
    return service.updateEventAttendee(state['id'], state['event_attendee']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final EventAttendeeDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(EventAttendeeServiceProvider);
  final state = ref.watch(EventAttendeeDeleteStateProvider);
  if (state != null) {
    return service.deleteEventAttendee(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final EventAttendeeUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final EventAttendeeDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final EventAttendeeLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(eventAttendeeProvider);
  final createAsync = ref.watch(EventAttendeeCreateProvider);
  final updateAsync = ref.watch(EventAttendeeUpdateProvider);
  final deleteAsync = ref.watch(EventAttendeeDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
