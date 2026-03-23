import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/m_l_s_connection_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// MLSConnection Providers

final MLSConnectionServiceProvider = Provider<MLSConnectionService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return MLSConnectionService(dioClient);
});

// List Provider
final mLSConnectionProvider = FutureProvider.autoDispose<List<MLSConnection>>((ref) async {
  final service = ref.watch(MLSConnectionServiceProvider);
  return service.getMLSConnections();
});

// Create Provider
final MLSConnectionCreateProvider = FutureProvider.autoDispose<MLSConnection>((ref) async {
  final service = ref.watch(MLSConnectionServiceProvider);
  return service.createMLSConnection(MLSConnection());
});

// Update Provider  
final MLSConnectionUpdateProvider = FutureProvider.autoDispose<MLSConnection>((ref) async {
  final service = ref.watch(MLSConnectionServiceProvider);
  final state = ref.watch(MLSConnectionUpdateStateProvider);
  if (state['id'] != null && state['m_l_s_connection'] != null) {
    return service.updateMLSConnection(state['id'], state['m_l_s_connection']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final MLSConnectionDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(MLSConnectionServiceProvider);
  final state = ref.watch(MLSConnectionDeleteStateProvider);
  if (state != null) {
    return service.deleteMLSConnection(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final MLSConnectionUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final MLSConnectionDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final MLSConnectionLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(mLSConnectionProvider);
  final createAsync = ref.watch(MLSConnectionCreateProvider);
  final updateAsync = ref.watch(MLSConnectionUpdateProvider);
  final deleteAsync = ref.watch(MLSConnectionDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
