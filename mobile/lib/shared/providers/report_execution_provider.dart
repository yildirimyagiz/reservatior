import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/report_execution_service.dart';
import 'package:reservatior/shared/repositories/report_execution_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final reportExecutionServiceProvider = Provider<ReportExecutionService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return ReportExecutionService(dioClient);
});

final reportExecutionRepositoryProvider = Provider<ReportExecutionRepository>((ref) {
  final service = ref.watch(reportExecutionServiceProvider);
  return ReportExecutionRepositoryImpl(service);
});

final reportExecutionListProvider = FutureProvider.autoDispose<List<ReportExecution>>((ref) async {
  final repository = ref.watch(reportExecutionRepositoryProvider);
  return repository.getAll();
});

final reportExecutionCreateProvider = StateProvider<ReportExecution?>((ref) => null);
final reportExecutionUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final reportExecutionDeleteProvider = StateProvider<String?>((ref) => null);
final reportExecutionLoadingProvider = StateProvider<bool>((ref) => false);
