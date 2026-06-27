import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/event_service.dart';
import 'package:reservatior/shared/repositories/event_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final eventServiceProvider = Provider<EventService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return EventService(dioClient);
});

final eventRepositoryProvider = Provider<EventRepository>((ref) {
  final service = ref.watch(eventServiceProvider);
  return EventRepositoryImpl(service);
});

final eventListProvider = FutureProvider.autoDispose<List<Event>>((ref) async {
  final repository = ref.watch(eventRepositoryProvider);
  return repository.getAll();
});

final eventCreateProvider = StateProvider<Event?>((ref) => null);
final eventUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final eventDeleteProvider = StateProvider<String?>((ref) => null);
final eventLoadingProvider = StateProvider<bool>((ref) => false);
