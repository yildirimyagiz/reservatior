import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/client_relationship_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// ClientRelationship Providers

final ClientRelationshipServiceProvider = Provider<ClientRelationshipService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return ClientRelationshipService(dioClient);
});

// List Provider
final clientRelationshipProvider = FutureProvider.autoDispose<List<ClientRelationship>>((ref) async {
  final service = ref.watch(ClientRelationshipServiceProvider);
  return service.getClientRelationships();
});

// Create Provider
final ClientRelationshipCreateProvider = FutureProvider.autoDispose<ClientRelationship>((ref) async {
  final service = ref.watch(ClientRelationshipServiceProvider);
  return service.createClientRelationship(ClientRelationship());
});

// Update Provider  
final ClientRelationshipUpdateProvider = FutureProvider.autoDispose<ClientRelationship>((ref) async {
  final service = ref.watch(ClientRelationshipServiceProvider);
  final state = ref.watch(ClientRelationshipUpdateStateProvider);
  if (state['id'] != null && state['client_relationship'] != null) {
    return service.updateClientRelationship(state['id'], state['client_relationship']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final ClientRelationshipDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(ClientRelationshipServiceProvider);
  final state = ref.watch(ClientRelationshipDeleteStateProvider);
  if (state != null) {
    return service.deleteClientRelationship(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final ClientRelationshipUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final ClientRelationshipDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final ClientRelationshipLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(clientRelationshipProvider);
  final createAsync = ref.watch(ClientRelationshipCreateProvider);
  final updateAsync = ref.watch(ClientRelationshipUpdateProvider);
  final deleteAsync = ref.watch(ClientRelationshipDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
