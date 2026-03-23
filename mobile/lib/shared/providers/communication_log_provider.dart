import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/communication_log_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// CommunicationLog Providers

final CommunicationLogServiceProvider = Provider<CommunicationLogService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return CommunicationLogService(dioClient);
});

// List Provider
final communicationLogProvider = FutureProvider.autoDispose<List<CommunicationLog>>((ref) async {
  final service = ref.watch(CommunicationLogServiceProvider);
  return service.getCommunicationLogs();
});

// Create Provider
final CommunicationLogCreateProvider = FutureProvider.autoDispose<CommunicationLog>((ref) async {
  final service = ref.watch(CommunicationLogServiceProvider);
  return service.createCommunicationLog(CommunicationLog());
});

// Update Provider  
final CommunicationLogUpdateProvider = FutureProvider.autoDispose<CommunicationLog>((ref) async {
  final service = ref.watch(CommunicationLogServiceProvider);
  final state = ref.watch(CommunicationLogUpdateStateProvider);
  if (state['id'] != null && state['communication_log'] != null) {
    return service.updateCommunicationLog(state['id'], state['communication_log']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final CommunicationLogDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(CommunicationLogServiceProvider);
  final state = ref.watch(CommunicationLogDeleteStateProvider);
  if (state != null) {
    return service.deleteCommunicationLog(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final CommunicationLogUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final CommunicationLogDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final CommunicationLogLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(communicationLogProvider);
  final createAsync = ref.watch(CommunicationLogCreateProvider);
  final updateAsync = ref.watch(CommunicationLogUpdateProvider);
  final deleteAsync = ref.watch(CommunicationLogDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
