import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/api_integration_service.dart';
import 'package:reservatior/shared/repositories/api_integration_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final apiIntegrationServiceProvider = Provider<APIIntegrationService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return APIIntegrationService(dioClient);
});

final apiIntegrationRepositoryProvider = Provider<APIIntegrationRepository>((ref) {
  final service = ref.watch(apiIntegrationServiceProvider);
  return APIIntegrationRepositoryImpl(service);
});

final apiIntegrationListProvider = FutureProvider.autoDispose<List<APIIntegration>>((ref) async {
  final repository = ref.watch(apiIntegrationRepositoryProvider);
  return repository.getAll();
});

final apiIntegrationCreateProvider = StateProvider<APIIntegration?>((ref) => null);
final apiIntegrationUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final apiIntegrationDeleteProvider = StateProvider<String?>((ref) => null);
final apiIntegrationLoadingProvider = StateProvider<bool>((ref) => false);
