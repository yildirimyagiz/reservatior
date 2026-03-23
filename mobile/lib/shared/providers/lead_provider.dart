import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/lead_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// Lead Providers

final LeadServiceProvider = Provider<LeadService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return LeadService(dioClient);
});

// List Provider
final leadProvider = FutureProvider.autoDispose<List<Lead>>((ref) async {
  final service = ref.watch(LeadServiceProvider);
  return service.getLeads();
});

// Create Provider
final LeadCreateProvider = FutureProvider.autoDispose<Lead>((ref) async {
  final service = ref.watch(LeadServiceProvider);
  return service.createLead(Lead());
});

// Update Provider  
final LeadUpdateProvider = FutureProvider.autoDispose<Lead>((ref) async {
  final service = ref.watch(LeadServiceProvider);
  final state = ref.watch(LeadUpdateStateProvider);
  if (state['id'] != null && state['lead'] != null) {
    return service.updateLead(state['id'], state['lead']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final LeadDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(LeadServiceProvider);
  final state = ref.watch(LeadDeleteStateProvider);
  if (state != null) {
    return service.deleteLead(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final LeadUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final LeadDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final LeadLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(leadProvider);
  final createAsync = ref.watch(LeadCreateProvider);
  final updateAsync = ref.watch(LeadUpdateProvider);
  final deleteAsync = ref.watch(LeadDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
