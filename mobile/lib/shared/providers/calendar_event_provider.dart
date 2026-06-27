import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/calendar_event_service.dart';
import 'package:reservatior/shared/repositories/calendar_event_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final calendarEventServiceProvider = Provider<CalendarEventService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return CalendarEventService(dioClient);
});

final calendarEventRepositoryProvider = Provider<CalendarEventRepository>((ref) {
  final service = ref.watch(calendarEventServiceProvider);
  return CalendarEventRepositoryImpl(service);
});

final calendarEventListProvider = FutureProvider.autoDispose<List<CalendarEvent>>((ref) async {
  final repository = ref.watch(calendarEventRepositoryProvider);
  return repository.getAll();
});

final calendarEventCreateProvider = StateProvider<CalendarEvent?>((ref) => null);
final calendarEventUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final calendarEventDeleteProvider = StateProvider<String?>((ref) => null);
final calendarEventLoadingProvider = StateProvider<bool>((ref) => false);
