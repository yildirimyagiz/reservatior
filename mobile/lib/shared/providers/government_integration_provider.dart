import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/government_integration_service.dart';
import 'package:reservatior/shared/repositories/government_integration_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final governmentIntegrationServiceProvider = Provider<GovernmentIntegrationService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return GovernmentIntegrationService(dioClient);
});

final governmentIntegrationRepositoryProvider = Provider<GovernmentIntegrationRepository>((ref) {
  final service = ref.watch(governmentIntegrationServiceProvider);
  return GovernmentIntegrationRepositoryImpl(service);
});

final governmentIntegrationListProvider = FutureProvider.autoDispose<List<GovernmentIntegration>>((ref) async {
  final repository = ref.watch(governmentIntegrationRepositoryProvider);
  return repository.getAll();
});

final governmentIntegrationCreateProvider = StateProvider<GovernmentIntegration?>((ref) => null);
final governmentIntegrationUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final governmentIntegrationDeleteProvider = StateProvider<String?>((ref) => null);
final governmentIntegrationLoadingProvider = StateProvider<bool>((ref) => false);
