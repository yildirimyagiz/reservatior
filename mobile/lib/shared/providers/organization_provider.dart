import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/organization_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// Organization Providers

final OrganizationServiceProvider = Provider<OrganizationService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return OrganizationService(dioClient);
});

// List Provider
final organizationProvider = FutureProvider.autoDispose<List<Organization>>((ref) async {
  final service = ref.watch(OrganizationServiceProvider);
  return service.getOrganizations();
});

// Create Provider
final OrganizationCreateProvider = FutureProvider.autoDispose<Organization>((ref) async {
  final service = ref.watch(OrganizationServiceProvider);
  return service.createOrganization(Organization());
});

// Update Provider  
final OrganizationUpdateProvider = FutureProvider.autoDispose<Organization>((ref) async {
  final service = ref.watch(OrganizationServiceProvider);
  final state = ref.watch(OrganizationUpdateStateProvider);
  if (state['id'] != null && state['organization'] != null) {
    return service.updateOrganization(state['id'], state['organization']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final OrganizationDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(OrganizationServiceProvider);
  final state = ref.watch(OrganizationDeleteStateProvider);
  if (state != null) {
    return service.deleteOrganization(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final OrganizationUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final OrganizationDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final OrganizationLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(organizationProvider);
  final createAsync = ref.watch(OrganizationCreateProvider);
  final updateAsync = ref.watch(OrganizationUpdateProvider);
  final deleteAsync = ref.watch(OrganizationDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
