import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/project_service.dart';
import 'package:reservatior/shared/repositories/project_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final projectServiceProvider = Provider<ProjectService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return ProjectService(dioClient);
});

final projectRepositoryProvider = Provider<ProjectRepository>((ref) {
  final service = ref.watch(projectServiceProvider);
  return ProjectRepositoryImpl(service);
});

final projectListProvider = FutureProvider.autoDispose<List<Project>>((ref) async {
  final repository = ref.watch(projectRepositoryProvider);
  return repository.getAll();
});

final projectCreateProvider = StateProvider<Project?>((ref) => null);
final projectUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final projectDeleteProvider = StateProvider<String?>((ref) => null);
final projectLoadingProvider = StateProvider<bool>((ref) => false);
