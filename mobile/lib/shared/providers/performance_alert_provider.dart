import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/performance_alert_service.dart';
import 'package:reservatior/shared/repositories/performance_alert_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final performanceAlertServiceProvider = Provider<PerformanceAlertService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return PerformanceAlertService(dioClient);
});

final performanceAlertRepositoryProvider = Provider<PerformanceAlertRepository>((ref) {
  final service = ref.watch(performanceAlertServiceProvider);
  return PerformanceAlertRepositoryImpl(service);
});

final performanceAlertListProvider = FutureProvider.autoDispose<List<PerformanceAlert>>((ref) async {
  final repository = ref.watch(performanceAlertRepositoryProvider);
  return repository.getAll();
});

final performanceAlertCreateProvider = StateProvider<PerformanceAlert?>((ref) => null);
final performanceAlertUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final performanceAlertDeleteProvider = StateProvider<String?>((ref) => null);
final performanceAlertLoadingProvider = StateProvider<bool>((ref) => false);
