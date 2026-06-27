import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/agent_service.dart';
import 'package:reservatior/shared/repositories/agent_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final agentServiceProvider = Provider<AgentService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return AgentService(dioClient);
});

final agentRepositoryProvider = Provider<AgentRepository>((ref) {
  final service = ref.watch(agentServiceProvider);
  return AgentRepositoryImpl(service);
});

final agentListProvider = FutureProvider.autoDispose<List<Agent>>((ref) async {
  final repository = ref.watch(agentRepositoryProvider);
  return repository.getAll();
});

final agentPerformanceProvider = FutureProvider.family.autoDispose<Map<String, dynamic>, String>((ref, id) async {
  final repository = ref.watch(agentRepositoryProvider);
  return repository.getPerformance(id);
});

final agentAssignmentsProvider = FutureProvider.family.autoDispose<List<AgentAssignment>, String>((ref, id) async {
  final repository = ref.watch(agentRepositoryProvider);
  return repository.getAssignments(id);
});

final agentCreateProvider = StateProvider<Agent?>((ref) => null);
final agentUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final agentDeleteProvider = StateProvider<String?>((ref) => null);
final agentLoadingProvider = StateProvider<bool>((ref) => false);
