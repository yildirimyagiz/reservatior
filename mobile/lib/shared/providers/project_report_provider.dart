import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/project_report_service.dart';
import 'package:reservatior/shared/repositories/project_report_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final projectReportServiceProvider = Provider<ProjectReportService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return ProjectReportService(dioClient);
});

final projectReportRepositoryProvider = Provider<ProjectReportRepository>((ref) {
  final service = ref.watch(projectReportServiceProvider);
  return ProjectReportRepositoryImpl(service);
});

final projectReportListProvider = FutureProvider.autoDispose<List<ProjectReport>>((ref) async {
  final repository = ref.watch(projectReportRepositoryProvider);
  return repository.getAll();
});

final projectReportCreateProvider = StateProvider<ProjectReport?>((ref) => null);
final projectReportUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final projectReportDeleteProvider = StateProvider<String?>((ref) => null);
final projectReportLoadingProvider = StateProvider<bool>((ref) => false);
