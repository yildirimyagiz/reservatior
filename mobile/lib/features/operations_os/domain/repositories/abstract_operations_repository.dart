import 'package:reservatior/shared/models/system_metrics.dart';
import 'package:reservatior/shared/models/automation_execution.dart';
import 'package:reservatior/shared/models/automation_task.dart';

abstract class AbstractOperationsRepository {
  Future<List<SystemMetrics>> getSystemMetrics({
    int page,
    int limit,
    String? orgId,
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  });

  Future<SystemMetrics> getSystemMetricsById(String id);

  Future<List<AutomationExecution>> getAutomationExecutions({
    int page,
    int limit,
    String? orgId,
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  });

  Future<AutomationExecution> getAutomationExecutionById(String id);

  Future<List<AutomationTask>> getAutomationTasks({
    int page,
    int limit,
    String? orgId,
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  });

  Future<AutomationTask> getAutomationTaskById(String id);
}
