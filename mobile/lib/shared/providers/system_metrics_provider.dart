import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/system_metrics_service.dart';
import 'package:reservatior/shared/repositories/system_metrics_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final systemMetricsServiceProvider = Provider<SystemMetricsService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return SystemMetricsService(dioClient);
});

final systemMetricsRepositoryProvider = Provider<SystemMetricsRepository>((ref) {
  final service = ref.watch(systemMetricsServiceProvider);
  return SystemMetricsRepositoryImpl(service);
});

final systemMetricsListProvider = FutureProvider.autoDispose<List<SystemMetrics>>((ref) async {
  final repository = ref.watch(systemMetricsRepositoryProvider);
  return repository.getAll();
});

final systemMetricsCreateProvider = StateProvider<SystemMetrics?>((ref) => null);
final systemMetricsUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final systemMetricsDeleteProvider = StateProvider<String?>((ref) => null);
final systemMetricsLoadingProvider = StateProvider<bool>((ref) => false);
