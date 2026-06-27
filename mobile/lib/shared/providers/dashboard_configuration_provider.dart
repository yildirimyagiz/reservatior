import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/dashboard_configuration_service.dart';
import 'package:reservatior/shared/repositories/dashboard_configuration_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final dashboardConfigurationServiceProvider = Provider<DashboardConfigurationService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return DashboardConfigurationService(dioClient);
});

final dashboardConfigurationRepositoryProvider = Provider<DashboardConfigurationRepository>((ref) {
  final service = ref.watch(dashboardConfigurationServiceProvider);
  return DashboardConfigurationRepositoryImpl(service);
});

final dashboardConfigurationListProvider = FutureProvider.autoDispose<List<DashboardConfiguration>>((ref) async {
  final repository = ref.watch(dashboardConfigurationRepositoryProvider);
  return repository.getAll();
});

final dashboardConfigurationCreateProvider = StateProvider<DashboardConfiguration?>((ref) => null);
final dashboardConfigurationUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final dashboardConfigurationDeleteProvider = StateProvider<String?>((ref) => null);
final dashboardConfigurationLoadingProvider = StateProvider<bool>((ref) => false);
