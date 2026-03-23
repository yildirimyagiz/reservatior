import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/ambassador_contract_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// AmbassadorContract Providers

final ambassadorContractServiceProvider = Provider<AmbassadorContractService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return AmbassadorContractService(dioClient);
});

// List Provider
final ambassadorContractListProvider = FutureProvider.autoDispose<List<AmbassadorContract>>((ref) async {
  final service = ref.watch(ambassadorContractServiceProvider);
  return service.getAmbassadorContracts();
});

// Create Provider
final ambassadorContractCreateProvider = FutureProvider.autoDispose<AmbassadorContract>((ref) async {
  final service = ref.watch(ambassadorContractServiceProvider);
  return service.createAmbassadorContract(AmbassadorContract());
});

// Update Provider  
final ambassadorContractUpdateProvider = FutureProvider.autoDispose<AmbassadorContract>((ref) async {
  final service = ref.watch(ambassadorContractServiceProvider);
  final state = ref.watch(ambassadorContractUpdateStateProvider);
  if (state['id'] != null && state['ambassador_contract'] != null) {
    return service.updateAmbassadorContract(state['id'], state['ambassador_contract']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final ambassadorContractDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(ambassadorContractServiceProvider);
  final state = ref.watch(ambassadorContractDeleteStateProvider);
  if (state != null) {
    return service.deleteAmbassadorContract(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final ambassadorContractCreateStateProvider = StateProvider<AmbassadorContract?>((ref) => null);
final ambassadorContractUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final ambassadorContractDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final ambassadorContractLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(ambassadorContractListProvider);
  final createAsync = ref.watch(ambassadorContractCreateProvider);
  final updateAsync = ref.watch(ambassadorContractUpdateProvider);
  final deleteAsync = ref.watch(ambassadorContractDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
