import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/dashboard_widget_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// DashboardWidget Providers

final dashboardWidgetServiceProvider = Provider<DashboardWidgetService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return DashboardWidgetService(dioClient);
});

// List Provider
final dashboardWidgetProvider = FutureProvider.autoDispose<List<DashboardWidget>>((ref) async {
  final service = ref.watch(dashboardWidgetServiceProvider);
  return service.getDashboardWidgets();
});

// Create Provider
final dashboardWidgetCreateProvider = FutureProvider.autoDispose<DashboardWidget>((ref) async {
  final service = ref.watch(dashboardWidgetServiceProvider);
  return service.createDashboardWidget(DashboardWidget());
});

// Update Provider  
final dashboardWidgetUpdateProvider = FutureProvider.autoDispose<DashboardWidget>((ref) async {
  final service = ref.watch(dashboardWidgetServiceProvider);
  final state = ref.watch(dashboardWidgetUpdateStateProvider);
  if (state['id'] != null && state['dashboard_widget'] != null) {
    return service.updateDashboardWidget(state['id'], state['dashboard_widget']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final dashboardWidgetDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(dashboardWidgetServiceProvider);
  final state = ref.watch(dashboardWidgetDeleteStateProvider);
  if (state != null) {
    return service.deleteDashboardWidget(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final dashboardWidgetCreateStateProvider = StateProvider<DashboardWidget?>((ref) => null);
final dashboardWidgetUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final dashboardWidgetDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final dashboardWidgetLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(dashboardWidgetProvider);
  final createAsync = ref.watch(dashboardWidgetCreateProvider);
  final updateAsync = ref.watch(dashboardWidgetUpdateProvider);
  final deleteAsync = ref.watch(dashboardWidgetDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
