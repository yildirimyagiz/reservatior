import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/providers/dio_client_provider.dart';
import 'package:reservatior/features/operations_os/data/datasources/operations_remote_datasource.dart';
import 'package:reservatior/features/operations_os/data/repositories/operations_repository_impl.dart';
import 'package:reservatior/features/operations_os/domain/repositories/abstract_operations_repository.dart';
import 'package:reservatior/shared/models/system_metrics.dart';
import 'package:reservatior/shared/models/automation_execution.dart';
import 'package:reservatior/shared/models/automation_task.dart';

final operationsRepositoryProvider = Provider<AbstractOperationsRepository>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return OperationsRepositoryImpl(OperationsRemoteDataSource(dioClient));
});

final operationsSystemMetricsListProvider =
    FutureProvider.autoDispose<List<SystemMetrics>>((ref) {
  final repository = ref.watch(operationsRepositoryProvider);
  return repository.getSystemMetrics(limit: 50);
});

final operationsAutomationTasksProvider =
    FutureProvider.autoDispose<List<AutomationTask>>((ref) {
  final repository = ref.watch(operationsRepositoryProvider);
  return repository.getAutomationTasks(limit: 50);
});

final operationsAutomationExecutionsProvider =
    FutureProvider.autoDispose<List<AutomationExecution>>((ref) {
  final repository = ref.watch(operationsRepositoryProvider);
  return repository.getAutomationExecutions(limit: 50);
});
