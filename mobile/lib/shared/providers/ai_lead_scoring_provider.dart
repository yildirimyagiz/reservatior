import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/ai_lead_scoring_service.dart';
import 'package:reservatior/shared/repositories/ai_lead_scoring_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final aiLeadScoringServiceProvider = Provider<AiLeadScoringService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return AiLeadScoringService(dioClient);
});

final aiLeadScoringRepositoryProvider = Provider<AiLeadScoringRepository>((ref) {
  final service = ref.watch(aiLeadScoringServiceProvider);
  return AiLeadScoringRepositoryImpl(service);
});

final aiLeadScoringListProvider = FutureProvider.autoDispose<List<AiLeadScoring>>((ref) async {
  final repository = ref.watch(aiLeadScoringRepositoryProvider);
  return repository.getAll();
});

final aiLeadScoringCreateProvider = StateProvider<AiLeadScoring?>((ref) => null);
final aiLeadScoringUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final aiLeadScoringDeleteProvider = StateProvider<String?>((ref) => null);
final aiLeadScoringLoadingProvider = StateProvider<bool>((ref) => false);
