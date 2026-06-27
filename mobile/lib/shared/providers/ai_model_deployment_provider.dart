import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/ai_model_deployment_service.dart';
import 'package:reservatior/shared/repositories/ai_model_deployment_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final aiModelDeploymentServiceProvider = Provider<AiModelDeploymentService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return AiModelDeploymentService(dioClient);
});

final aiModelDeploymentRepositoryProvider = Provider<AiModelDeploymentRepository>((ref) {
  final service = ref.watch(aiModelDeploymentServiceProvider);
  return AiModelDeploymentRepositoryImpl(service);
});

final aiModelDeploymentListProvider = FutureProvider.autoDispose<List<AiModelDeployment>>((ref) async {
  final repository = ref.watch(aiModelDeploymentRepositoryProvider);
  return repository.getAll();
});

final aiModelDeploymentCreateProvider = StateProvider<AiModelDeployment?>((ref) => null);
final aiModelDeploymentUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final aiModelDeploymentDeleteProvider = StateProvider<String?>((ref) => null);
final aiModelDeploymentLoadingProvider = StateProvider<bool>((ref) => false);
