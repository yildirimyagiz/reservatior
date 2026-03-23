import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/dashboard_configuration_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// DashboardConfiguration Providers

final dashboardConfigurationServiceProvider = Provider<DashboardConfigurationService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return DashboardConfigurationService(dioClient);
});

// List Provider
final dashboardConfigurationProvider = FutureProvider.autoDispose<List<DashboardConfiguration>>((ref) async {
  final service = ref.watch(dashboardConfigurationServiceProvider);
  return service.getDashboardConfigurations();
});

// Create Provider
final dashboardConfigurationCreateProvider = FutureProvider.autoDispose<DashboardConfiguration>((ref) async {
  final service = ref.watch(dashboardConfigurationServiceProvider);
  return service.createDashboardConfiguration(DashboardConfiguration());
});

// Update Provider  
final dashboardConfigurationUpdateProvider = FutureProvider.autoDispose<DashboardConfiguration>((ref) async {
  final service = ref.watch(dashboardConfigurationServiceProvider);
  final state = ref.watch(dashboardConfigurationUpdateStateProvider);
  if (state['id'] != null && state['dashboard_configuration'] != null) {
    return service.updateDashboardConfiguration(state['id'], state['dashboard_configuration']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final dashboardConfigurationDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(dashboardConfigurationServiceProvider);
  final state = ref.watch(dashboardConfigurationDeleteStateProvider);
  if (state != null) {
    return service.deleteDashboardConfiguration(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final dashboardConfigurationCreateStateProvider = StateProvider<DashboardConfiguration?>((ref) => null);
final dashboardConfigurationUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final dashboardConfigurationDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final dashboardConfigurationLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(dashboardConfigurationProvider);
  final createAsync = ref.watch(dashboardConfigurationCreateProvider);
  final updateAsync = ref.watch(dashboardConfigurationUpdateProvider);
  final deleteAsync = ref.watch(dashboardConfigurationDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
