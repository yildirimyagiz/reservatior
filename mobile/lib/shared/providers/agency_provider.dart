import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/shared/services/agency_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// Agency Providers

final agencyServiceProvider = Provider<AgencyService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return AgencyService(dioClient);
});

// List Provider - İSİM DÜZELTİLDİ
final agencyListProvider = FutureProvider.autoDispose<List<Agency>>((ref) async {
  final service = ref.watch(agencyServiceProvider);
  return service.getAll();
});

// Create Provider
final agencyCreateProvider = FutureProvider.autoDispose<Agency>((ref) async {
  final service = ref.watch(agencyServiceProvider);
  final state = ref.watch(agencyCreateStateProvider);
  if (state != null) {
    return service.create(state);
  }
  throw Exception('No create data provided');
});

// Update Provider  
final agencyUpdateProvider = FutureProvider.autoDispose<Agency>((ref) async {
  final service = ref.watch(agencyServiceProvider);
  final state = ref.watch(agencyUpdateStateProvider);
  if (state['id'] != null && state['data'] != null) {
    return service.update(state['id'], state['data']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final agencyDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(agencyServiceProvider);
  final state = ref.watch(agencyDeleteStateProvider);
  if (state != null) {
    return service.delete(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final agencyCreateStateProvider = StateProvider<Agency?>((ref) => null);
final agencyUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final agencyDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final agencyLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(agencyListProvider);
  final createAsync = ref.watch(agencyCreateProvider);
  final updateAsync = ref.watch(agencyUpdateProvider);
  final deleteAsync = ref.watch(agencyDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
