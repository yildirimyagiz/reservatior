import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/lead_source_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// LeadSource Providers

final LeadSourceServiceProvider = Provider<LeadSourceService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return LeadSourceService(dioClient);
});

// List Provider
final leadSourceProvider = FutureProvider.autoDispose<List<LeadSource>>((ref) async {
  final service = ref.watch(LeadSourceServiceProvider);
  return service.getLeadSources();
});

// Create Provider
final LeadSourceCreateProvider = FutureProvider.autoDispose<LeadSource>((ref) async {
  final service = ref.watch(LeadSourceServiceProvider);
  return service.createLeadSource(LeadSource());
});

// Update Provider  
final LeadSourceUpdateProvider = FutureProvider.autoDispose<LeadSource>((ref) async {
  final service = ref.watch(LeadSourceServiceProvider);
  final state = ref.watch(LeadSourceUpdateStateProvider);
  if (state['id'] != null && state['lead_source'] != null) {
    return service.updateLeadSource(state['id'], state['lead_source']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final LeadSourceDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(LeadSourceServiceProvider);
  final state = ref.watch(LeadSourceDeleteStateProvider);
  if (state != null) {
    return service.deleteLeadSource(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final LeadSourceUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final LeadSourceDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final LeadSourceLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(leadSourceProvider);
  final createAsync = ref.watch(LeadSourceCreateProvider);
  final updateAsync = ref.watch(LeadSourceUpdateProvider);
  final deleteAsync = ref.watch(LeadSourceDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
