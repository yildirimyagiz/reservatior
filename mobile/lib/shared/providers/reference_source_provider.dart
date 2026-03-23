import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/reference_source_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// ReferenceSource Providers

final ReferenceSourceServiceProvider = Provider<ReferenceSourceService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return ReferenceSourceService(dioClient);
});

// List Provider
final referenceSourceProvider = FutureProvider.autoDispose<List<ReferenceSource>>((ref) async {
  final service = ref.watch(ReferenceSourceServiceProvider);
  return service.getReferenceSources();
});

// Create Provider
final ReferenceSourceCreateProvider = FutureProvider.autoDispose<ReferenceSource>((ref) async {
  final service = ref.watch(ReferenceSourceServiceProvider);
  return service.createReferenceSource(ReferenceSource());
});

// Update Provider  
final ReferenceSourceUpdateProvider = FutureProvider.autoDispose<ReferenceSource>((ref) async {
  final service = ref.watch(ReferenceSourceServiceProvider);
  final state = ref.watch(ReferenceSourceUpdateStateProvider);
  if (state['id'] != null && state['reference_source'] != null) {
    return service.updateReferenceSource(state['id'], state['reference_source']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final ReferenceSourceDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(ReferenceSourceServiceProvider);
  final state = ref.watch(ReferenceSourceDeleteStateProvider);
  if (state != null) {
    return service.deleteReferenceSource(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final ReferenceSourceUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final ReferenceSourceDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final ReferenceSourceLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(referenceSourceProvider);
  final createAsync = ref.watch(ReferenceSourceCreateProvider);
  final updateAsync = ref.watch(ReferenceSourceUpdateProvider);
  final deleteAsync = ref.watch(ReferenceSourceDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
