import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/health_check_service.dart';
import 'package:reservatior/shared/repositories/health_check_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final healthCheckServiceProvider = Provider<HealthCheckService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return HealthCheckService(dioClient);
});

final healthCheckRepositoryProvider = Provider<HealthCheckRepository>((ref) {
  final service = ref.watch(healthCheckServiceProvider);
  return HealthCheckRepositoryImpl(service);
});

final healthCheckListProvider = FutureProvider.autoDispose<List<HealthCheck>>((ref) async {
  final repository = ref.watch(healthCheckRepositoryProvider);
  return repository.getAll();
});

final healthCheckCreateProvider = StateProvider<HealthCheck?>((ref) => null);
final healthCheckUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final healthCheckDeleteProvider = StateProvider<String?>((ref) => null);
final healthCheckLoadingProvider = StateProvider<bool>((ref) => false);
