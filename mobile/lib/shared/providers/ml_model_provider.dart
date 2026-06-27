import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/ml_model_service.dart';
import 'package:reservatior/shared/repositories/ml_model_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final mlModelServiceProvider = Provider<MlModelService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return MlModelService(dioClient);
});

final mlModelRepositoryProvider = Provider<MlModelRepository>((ref) {
  final service = ref.watch(mlModelServiceProvider);
  return MlModelRepositoryImpl(service);
});

final mlModelListProvider = FutureProvider.autoDispose<List<MlModel>>((ref) async {
  final repository = ref.watch(mlModelRepositoryProvider);
  return repository.getAll();
});

final mlModelCreateProvider = StateProvider<MlModel?>((ref) => null);
final mlModelUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final mlModelDeleteProvider = StateProvider<String?>((ref) => null);
final mlModelLoadingProvider = StateProvider<bool>((ref) => false);
