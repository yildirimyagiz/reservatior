import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/maintenance_block_service.dart';
import 'package:reservatior/shared/repositories/maintenance_block_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final maintenanceBlockServiceProvider = Provider<MaintenanceBlockService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return MaintenanceBlockService(dioClient);
});

final maintenanceBlockRepositoryProvider = Provider<MaintenanceBlockRepository>((ref) {
  final service = ref.watch(maintenanceBlockServiceProvider);
  return MaintenanceBlockRepositoryImpl(service);
});

final maintenanceBlockListProvider = FutureProvider.autoDispose<List<MaintenanceBlock>>((ref) async {
  final repository = ref.watch(maintenanceBlockRepositoryProvider);
  return repository.getAll();
});

final maintenanceBlockCreateProvider = StateProvider<MaintenanceBlock?>((ref) => null);
final maintenanceBlockUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final maintenanceBlockDeleteProvider = StateProvider<String?>((ref) => null);
final maintenanceBlockLoadingProvider = StateProvider<bool>((ref) => false);
