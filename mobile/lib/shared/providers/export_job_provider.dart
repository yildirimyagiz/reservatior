import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/export_job_service.dart';
import 'package:reservatior/shared/repositories/export_job_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final exportJobServiceProvider = Provider<ExportJobService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return ExportJobService(dioClient);
});

final exportJobRepositoryProvider = Provider<ExportJobRepository>((ref) {
  final service = ref.watch(exportJobServiceProvider);
  return ExportJobRepositoryImpl(service);
});

final exportJobListProvider = FutureProvider.autoDispose<List<ExportJob>>((ref) async {
  final repository = ref.watch(exportJobRepositoryProvider);
  return repository.getAll();
});

final exportJobCreateProvider = StateProvider<ExportJob?>((ref) => null);
final exportJobUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final exportJobDeleteProvider = StateProvider<String?>((ref) => null);
final exportJobLoadingProvider = StateProvider<bool>((ref) => false);
