import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/agent_assignment_service.dart';
import 'package:reservatior/shared/repositories/agent_assignment_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final agentAssignmentServiceProvider = Provider<AgentAssignmentService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return AgentAssignmentService(dioClient);
});

final agentAssignmentRepositoryProvider = Provider<AgentAssignmentRepository>((ref) {
  final service = ref.watch(agentAssignmentServiceProvider);
  return AgentAssignmentRepositoryImpl(service);
});

final agentAssignmentListProvider = FutureProvider.autoDispose<List<AgentAssignment>>((ref) async {
  final repository = ref.watch(agentAssignmentRepositoryProvider);
  return repository.getAll();
});

final agentAssignmentCreateProvider = StateProvider<AgentAssignment?>((ref) => null);
final agentAssignmentUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final agentAssignmentDeleteProvider = StateProvider<String?>((ref) => null);
final agentAssignmentLoadingProvider = StateProvider<bool>((ref) => false);
