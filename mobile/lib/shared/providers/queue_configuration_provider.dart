import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/queue_configuration_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// QueueConfiguration Providers

final QueueConfigurationServiceProvider = Provider<QueueConfigurationService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return QueueConfigurationService(dioClient);
});

// List Provider
final queueConfigurationProvider = FutureProvider.autoDispose<List<QueueConfiguration>>((ref) async {
  final service = ref.watch(QueueConfigurationServiceProvider);
  return service.getQueueConfigurations();
});

// Create Provider
final QueueConfigurationCreateProvider = FutureProvider.autoDispose<QueueConfiguration>((ref) async {
  final service = ref.watch(QueueConfigurationServiceProvider);
  return service.createQueueConfiguration(QueueConfiguration());
});

// Update Provider  
final QueueConfigurationUpdateProvider = FutureProvider.autoDispose<QueueConfiguration>((ref) async {
  final service = ref.watch(QueueConfigurationServiceProvider);
  final state = ref.watch(QueueConfigurationUpdateStateProvider);
  if (state['id'] != null && state['queue_configuration'] != null) {
    return service.updateQueueConfiguration(state['id'], state['queue_configuration']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final QueueConfigurationDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(QueueConfigurationServiceProvider);
  final state = ref.watch(QueueConfigurationDeleteStateProvider);
  if (state != null) {
    return service.deleteQueueConfiguration(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final QueueConfigurationUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final QueueConfigurationDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final QueueConfigurationLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(queueConfigurationProvider);
  final createAsync = ref.watch(QueueConfigurationCreateProvider);
  final updateAsync = ref.watch(QueueConfigurationUpdateProvider);
  final deleteAsync = ref.watch(QueueConfigurationDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
