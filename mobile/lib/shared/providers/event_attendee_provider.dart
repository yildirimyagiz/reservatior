import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/event_attendee_service.dart';
import 'package:reservatior/shared/repositories/event_attendee_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final eventAttendeeServiceProvider = Provider<EventAttendeeService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return EventAttendeeService(dioClient);
});

final eventAttendeeRepositoryProvider = Provider<EventAttendeeRepository>((ref) {
  final service = ref.watch(eventAttendeeServiceProvider);
  return EventAttendeeRepositoryImpl(service);
});

final eventAttendeeListProvider = FutureProvider.autoDispose<List<EventAttendee>>((ref) async {
  final repository = ref.watch(eventAttendeeRepositoryProvider);
  return repository.getAll();
});

final eventAttendeeCreateProvider = StateProvider<EventAttendee?>((ref) => null);
final eventAttendeeUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final eventAttendeeDeleteProvider = StateProvider<String?>((ref) => null);
final eventAttendeeLoadingProvider = StateProvider<bool>((ref) => false);
