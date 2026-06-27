import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/project_analytics_service.dart';
import 'package:reservatior/shared/repositories/project_analytics_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final projectAnalyticsServiceProvider = Provider<ProjectAnalyticsService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return ProjectAnalyticsService(dioClient);
});

final projectAnalyticsRepositoryProvider = Provider<ProjectAnalyticsRepository>((ref) {
  final service = ref.watch(projectAnalyticsServiceProvider);
  return ProjectAnalyticsRepositoryImpl(service);
});

final projectAnalyticsListProvider = FutureProvider.autoDispose<List<ProjectAnalytics>>((ref) async {
  final repository = ref.watch(projectAnalyticsRepositoryProvider);
  return repository.getAll();
});

final projectAnalyticsCreateProvider = StateProvider<ProjectAnalytics?>((ref) => null);
final projectAnalyticsUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final projectAnalyticsDeleteProvider = StateProvider<String?>((ref) => null);
final projectAnalyticsLoadingProvider = StateProvider<bool>((ref) => false);
