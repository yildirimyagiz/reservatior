import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/document_analysis_service.dart';
import 'package:reservatior/shared/repositories/document_analysis_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final documentAnalysisServiceProvider = Provider<DocumentAnalysisService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return DocumentAnalysisService(dioClient);
});

final documentAnalysisRepositoryProvider = Provider<DocumentAnalysisRepository>((ref) {
  final service = ref.watch(documentAnalysisServiceProvider);
  return DocumentAnalysisRepositoryImpl(service);
});

final documentAnalysisListProvider = FutureProvider.family.autoDispose<List<DocumentAnalysis>, String>((ref, orgId) async {
  final repository = ref.watch(documentAnalysisRepositoryProvider);
  return repository.getAll(filters: {'orgId': orgId});
});

final documentAnalysisCreateProvider = StateProvider<DocumentAnalysis?>((ref) => null);
final documentAnalysisUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final documentAnalysisDeleteProvider = StateProvider<String?>((ref) => null);
final documentAnalysisLoadingProvider = StateProvider<bool>((ref) => false);

final documentAnalysisJobStatusProvider = FutureProvider.family.autoDispose<Map<String, dynamic>, String>((ref, jobId) async {
  final repository = ref.watch(documentAnalysisRepositoryProvider);
  return repository.getJobStatus(jobId);
});

final documentContentSearchProvider = FutureProvider.family.autoDispose<List<Map<String, dynamic>>, ({String orgId, String query})>((ref, arg) async {
  final repository = ref.watch(documentAnalysisRepositoryProvider);
  return repository.searchContent(arg.orgId, arg.query);
});
