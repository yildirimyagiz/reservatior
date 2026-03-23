import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/property_compliance_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// PropertyCompliance Providers

final PropertyComplianceServiceProvider = Provider<PropertyComplianceService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return PropertyComplianceService(dioClient);
});

// List Provider
final propertyComplianceProvider = FutureProvider.autoDispose<List<PropertyCompliance>>((ref) async {
  final service = ref.watch(PropertyComplianceServiceProvider);
  return service.getPropertyCompliances();
});

// Create Provider
final PropertyComplianceCreateProvider = FutureProvider.autoDispose<PropertyCompliance>((ref) async {
  final service = ref.watch(PropertyComplianceServiceProvider);
  return service.createPropertyCompliance(PropertyCompliance());
});

// Update Provider  
final PropertyComplianceUpdateProvider = FutureProvider.autoDispose<PropertyCompliance>((ref) async {
  final service = ref.watch(PropertyComplianceServiceProvider);
  final state = ref.watch(PropertyComplianceUpdateStateProvider);
  if (state['id'] != null && state['property_compliance'] != null) {
    return service.updatePropertyCompliance(state['id'], state['property_compliance']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final PropertyComplianceDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(PropertyComplianceServiceProvider);
  final state = ref.watch(PropertyComplianceDeleteStateProvider);
  if (state != null) {
    return service.deletePropertyCompliance(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final PropertyComplianceUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final PropertyComplianceDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final PropertyComplianceLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(propertyComplianceProvider);
  final createAsync = ref.watch(PropertyComplianceCreateProvider);
  final updateAsync = ref.watch(PropertyComplianceUpdateProvider);
  final deleteAsync = ref.watch(PropertyComplianceDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
