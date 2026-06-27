import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/attorney_management_service.dart';
import 'package:reservatior/shared/repositories/attorney_management_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final attorneyManagementServiceProvider = Provider<AttorneyManagementService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return AttorneyManagementService(dioClient);
});

final attorneyManagementRepositoryProvider = Provider<AttorneyManagementRepository>((ref) {
  final service = ref.watch(attorneyManagementServiceProvider);
  return AttorneyManagementRepositoryImpl(service);
});

final attorneyManagementListProvider = FutureProvider.autoDispose<List<AttorneyManagement>>((ref) async {
  final repository = ref.watch(attorneyManagementRepositoryProvider);
  return repository.getAll();
});

final attorneyManagementCreateProvider = StateProvider<AttorneyManagement?>((ref) => null);
final attorneyManagementUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final attorneyManagementDeleteProvider = StateProvider<String?>((ref) => null);
final attorneyManagementLoadingProvider = StateProvider<bool>((ref) => false);
