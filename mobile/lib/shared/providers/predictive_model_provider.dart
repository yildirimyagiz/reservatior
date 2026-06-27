import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/predictive_model_service.dart';
import 'package:reservatior/shared/repositories/predictive_model_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final predictiveModelServiceProvider = Provider<PredictiveModelService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return PredictiveModelService(dioClient);
});

final predictiveModelRepositoryProvider = Provider<PredictiveModelRepository>((ref) {
  final service = ref.watch(predictiveModelServiceProvider);
  return PredictiveModelRepositoryImpl(service);
});

final predictiveModelListProvider = FutureProvider.autoDispose<List<PredictiveModel>>((ref) async {
  final repository = ref.watch(predictiveModelRepositoryProvider);
  return repository.getAll();
});

final predictiveModelCreateProvider = StateProvider<PredictiveModel?>((ref) => null);
final predictiveModelUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final predictiveModelDeleteProvider = StateProvider<String?>((ref) => null);
final predictiveModelLoadingProvider = StateProvider<bool>((ref) => false);
