import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/export_file_service.dart';
import 'package:reservatior/shared/repositories/export_file_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final exportFileServiceProvider = Provider<ExportFileService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return ExportFileService(dioClient);
});

final exportFileRepositoryProvider = Provider<ExportFileRepository>((ref) {
  final service = ref.watch(exportFileServiceProvider);
  return ExportFileRepositoryImpl(service);
});

final exportFileListProvider = FutureProvider.autoDispose<List<ExportFile>>((ref) async {
  final repository = ref.watch(exportFileRepositoryProvider);
  return repository.getAll();
});

final exportFileCreateProvider = StateProvider<ExportFile?>((ref) => null);
final exportFileUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final exportFileDeleteProvider = StateProvider<String?>((ref) => null);
final exportFileLoadingProvider = StateProvider<bool>((ref) => false);
