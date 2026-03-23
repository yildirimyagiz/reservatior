import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/home_information_pack_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// HomeInformationPack Providers

final HomeInformationPackServiceProvider = Provider<HomeInformationPackService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return HomeInformationPackService(dioClient);
});

// List Provider
final homeInformationPackProvider = FutureProvider.autoDispose<List<HomeInformationPack>>((ref) async {
  final service = ref.watch(HomeInformationPackServiceProvider);
  return service.getHomeInformationPacks();
});

// Create Provider
final HomeInformationPackCreateProvider = FutureProvider.autoDispose<HomeInformationPack>((ref) async {
  final service = ref.watch(HomeInformationPackServiceProvider);
  return service.createHomeInformationPack(HomeInformationPack());
});

// Update Provider  
final HomeInformationPackUpdateProvider = FutureProvider.autoDispose<HomeInformationPack>((ref) async {
  final service = ref.watch(HomeInformationPackServiceProvider);
  final state = ref.watch(HomeInformationPackUpdateStateProvider);
  if (state['id'] != null && state['home_information_pack'] != null) {
    return service.updateHomeInformationPack(state['id'], state['home_information_pack']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final HomeInformationPackDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(HomeInformationPackServiceProvider);
  final state = ref.watch(HomeInformationPackDeleteStateProvider);
  if (state != null) {
    return service.deleteHomeInformationPack(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final HomeInformationPackUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final HomeInformationPackDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final HomeInformationPackLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(homeInformationPackProvider);
  final createAsync = ref.watch(HomeInformationPackCreateProvider);
  final updateAsync = ref.watch(HomeInformationPackUpdateProvider);
  final deleteAsync = ref.watch(HomeInformationPackDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
