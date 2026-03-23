import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/contract_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// Contract Providers

final ContractServiceProvider = Provider<ContractService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return ContractService(dioClient);
});

// List Provider
final contractProvider = FutureProvider.autoDispose<List<Contract>>((ref) async {
  final service = ref.watch(ContractServiceProvider);
  return service.getContracts();
});

// Create Provider
final ContractCreateProvider = FutureProvider.autoDispose<Contract>((ref) async {
  final service = ref.watch(ContractServiceProvider);
  return service.createContract(Contract());
});

// Update Provider  
final ContractUpdateProvider = FutureProvider.autoDispose<Contract>((ref) async {
  final service = ref.watch(ContractServiceProvider);
  final state = ref.watch(ContractUpdateStateProvider);
  if (state['id'] != null && state['contract'] != null) {
    return service.updateContract(state['id'], state['contract']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final ContractDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(ContractServiceProvider);
  final state = ref.watch(ContractDeleteStateProvider);
  if (state != null) {
    return service.deleteContract(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final ContractUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final ContractDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final ContractLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(contractProvider);
  final createAsync = ref.watch(ContractCreateProvider);
  final updateAsync = ref.watch(ContractUpdateProvider);
  final deleteAsync = ref.watch(ContractDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
