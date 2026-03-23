import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/mls_data_mapping_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// MlsDataMapping Providers

final MlsDataMappingServiceProvider = Provider<MlsDataMappingService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return MlsDataMappingService(dioClient);
});

// List Provider
final mlsDataMappingProvider = FutureProvider.autoDispose<List<MlsDataMapping>>((ref) async {
  final service = ref.watch(MlsDataMappingServiceProvider);
  return service.getMlsDataMappings();
});

// Create Provider
final MlsDataMappingCreateProvider = FutureProvider.autoDispose<MlsDataMapping>((ref) async {
  final service = ref.watch(MlsDataMappingServiceProvider);
  return service.createMlsDataMapping(MlsDataMapping());
});

// Update Provider  
final MlsDataMappingUpdateProvider = FutureProvider.autoDispose<MlsDataMapping>((ref) async {
  final service = ref.watch(MlsDataMappingServiceProvider);
  final state = ref.watch(MlsDataMappingUpdateStateProvider);
  if (state['id'] != null && state['mls_data_mapping'] != null) {
    return service.updateMlsDataMapping(state['id'], state['mls_data_mapping']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final MlsDataMappingDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(MlsDataMappingServiceProvider);
  final state = ref.watch(MlsDataMappingDeleteStateProvider);
  if (state != null) {
    return service.deleteMlsDataMapping(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final MlsDataMappingUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final MlsDataMappingDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final MlsDataMappingLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(mlsDataMappingProvider);
  final createAsync = ref.watch(MlsDataMappingCreateProvider);
  final updateAsync = ref.watch(MlsDataMappingUpdateProvider);
  final deleteAsync = ref.watch(MlsDataMappingDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
