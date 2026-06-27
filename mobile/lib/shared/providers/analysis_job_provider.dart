import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/analysis_job_service.dart';
import 'package:reservatior/shared/repositories/analysis_job_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final analysisJobServiceProvider = Provider<AnalysisJobService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return AnalysisJobService(dioClient);
});

final analysisJobRepositoryProvider = Provider<AnalysisJobRepository>((ref) {
  final service = ref.watch(analysisJobServiceProvider);
  return AnalysisJobRepositoryImpl(service);
});

final analysisJobListProvider = FutureProvider.autoDispose<List<AnalysisJob>>((ref) async {
  final repository = ref.watch(analysisJobRepositoryProvider);
  return repository.getAll();
});

final analysisJobCreateProvider = StateProvider<AnalysisJob?>((ref) => null);
final analysisJobUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final analysisJobDeleteProvider = StateProvider<String?>((ref) => null);
final analysisJobLoadingProvider = StateProvider<bool>((ref) => false);
