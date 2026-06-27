import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/project_alert_service.dart';
import 'package:reservatior/shared/repositories/project_alert_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final projectAlertServiceProvider = Provider<ProjectAlertService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return ProjectAlertService(dioClient);
});

final projectAlertRepositoryProvider = Provider<ProjectAlertRepository>((ref) {
  final service = ref.watch(projectAlertServiceProvider);
  return ProjectAlertRepositoryImpl(service);
});

final projectAlertListProvider = FutureProvider.autoDispose<List<ProjectAlert>>((ref) async {
  final repository = ref.watch(projectAlertRepositoryProvider);
  return repository.getAll();
});

final projectAlertCreateProvider = StateProvider<ProjectAlert?>((ref) => null);
final projectAlertUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final projectAlertDeleteProvider = StateProvider<String?>((ref) => null);
final projectAlertLoadingProvider = StateProvider<bool>((ref) => false);
