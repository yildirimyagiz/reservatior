import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/ai_image_analysis_service.dart';
import 'package:reservatior/shared/repositories/ai_image_analysis_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final aiImageAnalysisServiceProvider = Provider<AiImageAnalysisService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return AiImageAnalysisService(dioClient);
});

final aiImageAnalysisRepositoryProvider = Provider<AiImageAnalysisRepository>((ref) {
  final service = ref.watch(aiImageAnalysisServiceProvider);
  return AiImageAnalysisRepositoryImpl(service);
});

final aiImageAnalysisListProvider = FutureProvider.autoDispose<List<AiImageAnalysis>>((ref) async {
  final repository = ref.watch(aiImageAnalysisRepositoryProvider);
  return repository.getAll();
});

final aiImageAnalysisCreateProvider = StateProvider<AiImageAnalysis?>((ref) => null);
final aiImageAnalysisUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final aiImageAnalysisDeleteProvider = StateProvider<String?>((ref) => null);
final aiImageAnalysisLoadingProvider = StateProvider<bool>((ref) => false);
