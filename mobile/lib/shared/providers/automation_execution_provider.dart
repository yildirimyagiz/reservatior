import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/automation_execution_service.dart';
import 'package:reservatior/shared/repositories/automation_execution_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final automationExecutionServiceProvider = Provider<AutomationExecutionService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return AutomationExecutionService(dioClient);
});

final automationExecutionRepositoryProvider = Provider<AutomationExecutionRepository>((ref) {
  final service = ref.watch(automationExecutionServiceProvider);
  return AutomationExecutionRepositoryImpl(service);
});

final automationExecutionListProvider = FutureProvider.autoDispose<List<AutomationExecution>>((ref) async {
  final repository = ref.watch(automationExecutionRepositoryProvider);
  return repository.getAll();
});

final automationExecutionCreateProvider = StateProvider<AutomationExecution?>((ref) => null);
final automationExecutionUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final automationExecutionDeleteProvider = StateProvider<String?>((ref) => null);
final automationExecutionLoadingProvider = StateProvider<bool>((ref) => false);
