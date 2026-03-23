import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/session_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// Session Providers

final SessionServiceProvider = Provider<SessionService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return SessionService(dioClient);
});

// List Provider
final sessionProvider = FutureProvider.autoDispose<List<Session>>((ref) async {
  final service = ref.watch(SessionServiceProvider);
  return service.getSessions();
});

// Create Provider
final SessionCreateProvider = FutureProvider.autoDispose<Session>((ref) async {
  final service = ref.watch(SessionServiceProvider);
  return service.createSession(Session());
});

// Update Provider  
final SessionUpdateProvider = FutureProvider.autoDispose<Session>((ref) async {
  final service = ref.watch(SessionServiceProvider);
  final state = ref.watch(SessionUpdateStateProvider);
  if (state['id'] != null && state['session'] != null) {
    return service.updateSession(state['id'], state['session']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final SessionDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(SessionServiceProvider);
  final state = ref.watch(SessionDeleteStateProvider);
  if (state != null) {
    return service.deleteSession(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final SessionUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final SessionDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final SessionLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(sessionProvider);
  final createAsync = ref.watch(SessionCreateProvider);
  final updateAsync = ref.watch(SessionUpdateProvider);
  final deleteAsync = ref.watch(SessionDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
