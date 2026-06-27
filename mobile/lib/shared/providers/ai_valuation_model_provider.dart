import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/ai_valuation_model_service.dart';
import 'package:reservatior/shared/repositories/ai_valuation_model_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final aiValuationModelServiceProvider = Provider<AiValuationModelService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return AiValuationModelService(dioClient);
});

final aiValuationModelRepositoryProvider = Provider<AiValuationModelRepository>((ref) {
  final service = ref.watch(aiValuationModelServiceProvider);
  return AiValuationModelRepositoryImpl(service);
});

final aiValuationModelListProvider = FutureProvider.autoDispose<List<AiValuationModel>>((ref) async {
  final repository = ref.watch(aiValuationModelRepositoryProvider);
  return repository.getAll();
});

final aiValuationModelCreateProvider = StateProvider<AiValuationModel?>((ref) => null);
final aiValuationModelUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final aiValuationModelDeleteProvider = StateProvider<String?>((ref) => null);
final aiValuationModelLoadingProvider = StateProvider<bool>((ref) => false);
