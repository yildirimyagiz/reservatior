import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/session_service.dart';
import 'package:reservatior/shared/repositories/session_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final sessionServiceProvider = Provider<SessionService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return SessionService(dioClient);
});

final sessionRepositoryProvider = Provider<SessionRepository>((ref) {
  final service = ref.watch(sessionServiceProvider);
  return SessionRepositoryImpl(service);
});

final sessionListProvider = FutureProvider.autoDispose<List<Session>>((ref) async {
  final repository = ref.watch(sessionRepositoryProvider);
  return repository.getAll();
});

final sessionCreateProvider = StateProvider<Session?>((ref) => null);
final sessionUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final sessionDeleteProvider = StateProvider<String?>((ref) => null);
final sessionLoadingProvider = StateProvider<bool>((ref) => false);
