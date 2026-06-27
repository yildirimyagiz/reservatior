import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/ai_model_service.dart';
import 'package:reservatior/shared/repositories/ai_model_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final aiModelServiceProvider = Provider<AiModelService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return AiModelService(dioClient);
});

final aiModelRepositoryProvider = Provider<AiModelRepository>((ref) {
  final service = ref.watch(aiModelServiceProvider);
  return AiModelRepositoryImpl(service);
});

final aiModelListProvider = FutureProvider.autoDispose<List<AiModel>>((ref) async {
  final repository = ref.watch(aiModelRepositoryProvider);
  return repository.getAll();
});

final aiModelCreateProvider = StateProvider<AiModel?>((ref) => null);
final aiModelUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final aiModelDeleteProvider = StateProvider<String?>((ref) => null);
final aiModelLoadingProvider = StateProvider<bool>((ref) => false);
