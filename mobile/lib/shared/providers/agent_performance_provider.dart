import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/agent_performance_service.dart';
import 'package:reservatior/shared/repositories/agent_performance_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final agentPerformanceServiceProvider = Provider<AgentPerformanceService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return AgentPerformanceService(dioClient);
});

final agentPerformanceRepositoryProvider = Provider<AgentPerformanceRepository>((ref) {
  final service = ref.watch(agentPerformanceServiceProvider);
  return AgentPerformanceRepositoryImpl(service);
});

final agentPerformanceListProvider = FutureProvider.autoDispose<List<AgentPerformance>>((ref) async {
  final repository = ref.watch(agentPerformanceRepositoryProvider);
  return repository.getAll();
});

final agentPerformanceCreateProvider = StateProvider<AgentPerformance?>((ref) => null);
final agentPerformanceUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final agentPerformanceDeleteProvider = StateProvider<String?>((ref) => null);
final agentPerformanceLoadingProvider = StateProvider<bool>((ref) => false);
