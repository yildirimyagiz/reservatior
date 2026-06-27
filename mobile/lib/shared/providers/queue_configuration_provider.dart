import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/queue_configuration_service.dart';
import 'package:reservatior/shared/repositories/queue_configuration_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final queueConfigurationServiceProvider = Provider<QueueConfigurationService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return QueueConfigurationService(dioClient);
});

final queueConfigurationRepositoryProvider = Provider<QueueConfigurationRepository>((ref) {
  final service = ref.watch(queueConfigurationServiceProvider);
  return QueueConfigurationRepositoryImpl(service);
});

final queueConfigurationListProvider = FutureProvider.autoDispose<List<QueueConfiguration>>((ref) async {
  final repository = ref.watch(queueConfigurationRepositoryProvider);
  return repository.getAll();
});

final queueConfigurationCreateProvider = StateProvider<QueueConfiguration?>((ref) => null);
final queueConfigurationUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final queueConfigurationDeleteProvider = StateProvider<String?>((ref) => null);
final queueConfigurationLoadingProvider = StateProvider<bool>((ref) => false);
