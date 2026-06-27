import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/ai_lead_score_service.dart';
import 'package:reservatior/shared/repositories/ai_lead_score_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final aiLeadScoreServiceProvider = Provider<AiLeadScoreService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return AiLeadScoreService(dioClient);
});

final aiLeadScoreRepositoryProvider = Provider<AiLeadScoreRepository>((ref) {
  final service = ref.watch(aiLeadScoreServiceProvider);
  return AiLeadScoreRepositoryImpl(service);
});

final aiLeadScoreListProvider = FutureProvider.autoDispose<List<AiLeadScore>>((ref) async {
  final repository = ref.watch(aiLeadScoreRepositoryProvider);
  return repository.getAll();
});

final aiLeadScoreCreateProvider = StateProvider<AiLeadScore?>((ref) => null);
final aiLeadScoreUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final aiLeadScoreDeleteProvider = StateProvider<String?>((ref) => null);
final aiLeadScoreLoadingProvider = StateProvider<bool>((ref) => false);
