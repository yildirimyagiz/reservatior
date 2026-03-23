import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/m_l_configuration_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// MLConfiguration Providers

final MLConfigurationServiceProvider = Provider<MLConfigurationService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return MLConfigurationService(dioClient);
});

// List Provider
final mLConfigurationProvider = FutureProvider.autoDispose<List<MLConfiguration>>((ref) async {
  final service = ref.watch(MLConfigurationServiceProvider);
  return service.getMLConfigurations();
});

// Create Provider
final MLConfigurationCreateProvider = FutureProvider.autoDispose<MLConfiguration>((ref) async {
  final service = ref.watch(MLConfigurationServiceProvider);
  return service.createMLConfiguration(MLConfiguration());
});

// Update Provider  
final MLConfigurationUpdateProvider = FutureProvider.autoDispose<MLConfiguration>((ref) async {
  final service = ref.watch(MLConfigurationServiceProvider);
  final state = ref.watch(MLConfigurationUpdateStateProvider);
  if (state['id'] != null && state['m_l_configuration'] != null) {
    return service.updateMLConfiguration(state['id'], state['m_l_configuration']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final MLConfigurationDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(MLConfigurationServiceProvider);
  final state = ref.watch(MLConfigurationDeleteStateProvider);
  if (state != null) {
    return service.deleteMLConfiguration(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final MLConfigurationUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final MLConfigurationDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final MLConfigurationLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(mLConfigurationProvider);
  final createAsync = ref.watch(MLConfigurationCreateProvider);
  final updateAsync = ref.watch(MLConfigurationUpdateProvider);
  final deleteAsync = ref.watch(MLConfigurationDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
