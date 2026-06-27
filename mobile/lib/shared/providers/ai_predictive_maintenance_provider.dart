import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/ai_predictive_maintenance_service.dart';
import 'package:reservatior/shared/repositories/ai_predictive_maintenance_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final aiPredictiveMaintenanceServiceProvider = Provider<AiPredictiveMaintenanceService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return AiPredictiveMaintenanceService(dioClient);
});

final aiPredictiveMaintenanceRepositoryProvider = Provider<AiPredictiveMaintenanceRepository>((ref) {
  final service = ref.watch(aiPredictiveMaintenanceServiceProvider);
  return AiPredictiveMaintenanceRepositoryImpl(service);
});

final aiPredictiveMaintenanceListProvider = FutureProvider.autoDispose<List<AiPredictiveMaintenance>>((ref) async {
  final repository = ref.watch(aiPredictiveMaintenanceRepositoryProvider);
  return repository.getAll();
});

final aiPredictiveMaintenanceCreateProvider = StateProvider<AiPredictiveMaintenance?>((ref) => null);
final aiPredictiveMaintenanceUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final aiPredictiveMaintenanceDeleteProvider = StateProvider<String?>((ref) => null);
final aiPredictiveMaintenanceLoadingProvider = StateProvider<bool>((ref) => false);
