import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/immigration_status_check_service.dart';
import 'package:reservatior/shared/repositories/immigration_status_check_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final immigrationStatusCheckServiceProvider = Provider<ImmigrationStatusCheckService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return ImmigrationStatusCheckService(dioClient);
});

final immigrationStatusCheckRepositoryProvider = Provider<ImmigrationStatusCheckRepository>((ref) {
  final service = ref.watch(immigrationStatusCheckServiceProvider);
  return ImmigrationStatusCheckRepositoryImpl(service);
});

final immigrationStatusCheckListProvider = FutureProvider.autoDispose<List<ImmigrationStatusCheck>>((ref) async {
  final repository = ref.watch(immigrationStatusCheckRepositoryProvider);
  return repository.getAll();
});

final immigrationStatusCheckCreateProvider = StateProvider<ImmigrationStatusCheck?>((ref) => null);
final immigrationStatusCheckUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final immigrationStatusCheckDeleteProvider = StateProvider<String?>((ref) => null);
final immigrationStatusCheckLoadingProvider = StateProvider<bool>((ref) => false);
