import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/dashboard_widget_service.dart';
import 'package:reservatior/shared/repositories/dashboard_widget_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final dashboardWidgetServiceProvider = Provider<DashboardWidgetService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return DashboardWidgetService(dioClient);
});

final dashboardWidgetRepositoryProvider = Provider<DashboardWidgetRepository>((ref) {
  final service = ref.watch(dashboardWidgetServiceProvider);
  return DashboardWidgetRepositoryImpl(service);
});

final dashboardWidgetListProvider = FutureProvider.autoDispose<List<DashboardWidget>>((ref) async {
  final repository = ref.watch(dashboardWidgetRepositoryProvider);
  return repository.getAll();
});

final dashboardWidgetCreateProvider = StateProvider<DashboardWidget?>((ref) => null);
final dashboardWidgetUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final dashboardWidgetDeleteProvider = StateProvider<String?>((ref) => null);
final dashboardWidgetLoadingProvider = StateProvider<bool>((ref) => false);
