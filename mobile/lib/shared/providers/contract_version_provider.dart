import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/contract_version_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// ContractVersion Providers

final ContractVersionServiceProvider = Provider<ContractVersionService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return ContractVersionService(dioClient);
});

// List Provider
final contractVersionProvider = FutureProvider.autoDispose<List<ContractVersion>>((ref) async {
  final service = ref.watch(ContractVersionServiceProvider);
  return service.getContractVersions();
});

// Create Provider
final ContractVersionCreateProvider = FutureProvider.autoDispose<ContractVersion>((ref) async {
  final service = ref.watch(ContractVersionServiceProvider);
  return service.createContractVersion(ContractVersion());
});

// Update Provider  
final ContractVersionUpdateProvider = FutureProvider.autoDispose<ContractVersion>((ref) async {
  final service = ref.watch(ContractVersionServiceProvider);
  final state = ref.watch(ContractVersionUpdateStateProvider);
  if (state['id'] != null && state['contract_version'] != null) {
    return service.updateContractVersion(state['id'], state['contract_version']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final ContractVersionDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(ContractVersionServiceProvider);
  final state = ref.watch(ContractVersionDeleteStateProvider);
  if (state != null) {
    return service.deleteContractVersion(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final ContractVersionUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final ContractVersionDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final ContractVersionLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(contractVersionProvider);
  final createAsync = ref.watch(ContractVersionCreateProvider);
  final updateAsync = ref.watch(ContractVersionUpdateProvider);
  final deleteAsync = ref.watch(ContractVersionDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
