import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/calendar_event_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// CalendarEvent Providers

final CalendarEventServiceProvider = Provider<CalendarEventService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return CalendarEventService(dioClient);
});

// List Provider
final calendarEventProvider = FutureProvider.autoDispose<List<CalendarEvent>>((ref) async {
  final service = ref.watch(CalendarEventServiceProvider);
  return service.getCalendarEvents();
});

// Create Provider
final CalendarEventCreateProvider = FutureProvider.autoDispose<CalendarEvent>((ref) async {
  final service = ref.watch(CalendarEventServiceProvider);
  return service.createCalendarEvent(CalendarEvent());
});

// Update Provider  
final CalendarEventUpdateProvider = FutureProvider.autoDispose<CalendarEvent>((ref) async {
  final service = ref.watch(CalendarEventServiceProvider);
  final state = ref.watch(CalendarEventUpdateStateProvider);
  if (state['id'] != null && state['calendar_event'] != null) {
    return service.updateCalendarEvent(state['id'], state['calendar_event']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final CalendarEventDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(CalendarEventServiceProvider);
  final state = ref.watch(CalendarEventDeleteStateProvider);
  if (state != null) {
    return service.deleteCalendarEvent(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final CalendarEventUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final CalendarEventDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final CalendarEventLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(calendarEventProvider);
  final createAsync = ref.watch(CalendarEventCreateProvider);
  final updateAsync = ref.watch(CalendarEventUpdateProvider);
  final deleteAsync = ref.watch(CalendarEventDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
