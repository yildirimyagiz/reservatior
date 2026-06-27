import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/analytics_service.dart';
import 'package:reservatior/shared/repositories/analytics_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';
import 'auth_provider.dart';

final analyticsServiceProvider = Provider<AnalyticsService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return AnalyticsService(dioClient);
});

final analyticsRepositoryProvider = Provider<AnalyticsRepository>((ref) {
  final service = ref.watch(analyticsServiceProvider);
  return AnalyticsRepositoryImpl(service);
});

final dashboardStatsProvider = FutureProvider.autoDispose<DashboardStats>((ref) async {
  final authState = ref.watch(authProvider);
  final orgId = authState.user?.organizationId ?? 'global';
  final repository = ref.watch(analyticsRepositoryProvider);
  return repository.getDashboardStats(orgId);
});

final analyticsListProvider = FutureProvider.autoDispose<List<Analytics>>((ref) async {
  final repository = ref.watch(analyticsRepositoryProvider);
  return repository.getAll();
});

final analyticsCreateProvider = StateProvider<Analytics?>((ref) => null);
final analyticsUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final analyticsDeleteProvider = StateProvider<String?>((ref) => null);
final analyticsLoadingProvider = StateProvider<bool>((ref) => false);
