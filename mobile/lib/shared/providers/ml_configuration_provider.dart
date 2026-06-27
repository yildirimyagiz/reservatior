import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/ml_configuration_service.dart';
import 'package:reservatior/shared/repositories/ml_configuration_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final mlConfigurationServiceProvider = Provider<MlConfigurationService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return MlConfigurationService(dioClient);
});

final mlConfigurationRepositoryProvider = Provider<MlConfigurationRepository>((ref) {
  final service = ref.watch(mlConfigurationServiceProvider);
  return MlConfigurationRepositoryImpl(service);
});

final mlConfigurationListProvider = FutureProvider.autoDispose<List<MlConfiguration>>((ref) async {
  final repository = ref.watch(mlConfigurationRepositoryProvider);
  return repository.getAll();
});

final mlConfigurationCreateProvider = StateProvider<MlConfiguration?>((ref) => null);
final mlConfigurationUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final mlConfigurationDeleteProvider = StateProvider<String?>((ref) => null);
final mlConfigurationLoadingProvider = StateProvider<bool>((ref) => false);
