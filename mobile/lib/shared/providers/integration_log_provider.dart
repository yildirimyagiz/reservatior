import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/integration_log_service.dart';
import 'package:reservatior/shared/repositories/integration_log_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final integrationLogServiceProvider = Provider<IntegrationLogService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return IntegrationLogService(dioClient);
});

final integrationLogRepositoryProvider = Provider<IntegrationLogRepository>((ref) {
  final service = ref.watch(integrationLogServiceProvider);
  return IntegrationLogRepositoryImpl(service);
});

final integrationLogListProvider = FutureProvider.autoDispose<List<IntegrationLog>>((ref) async {
  final repository = ref.watch(integrationLogRepositoryProvider);
  return repository.getAll();
});

final integrationLogCreateProvider = StateProvider<IntegrationLog?>((ref) => null);
final integrationLogUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final integrationLogDeleteProvider = StateProvider<String?>((ref) => null);
final integrationLogLoadingProvider = StateProvider<bool>((ref) => false);
