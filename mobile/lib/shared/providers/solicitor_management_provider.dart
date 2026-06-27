import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/solicitor_management_service.dart';
import 'package:reservatior/shared/repositories/solicitor_management_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final solicitorManagementServiceProvider = Provider<SolicitorManagementService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return SolicitorManagementService(dioClient);
});

final solicitorManagementRepositoryProvider = Provider<SolicitorManagementRepository>((ref) {
  final service = ref.watch(solicitorManagementServiceProvider);
  return SolicitorManagementRepositoryImpl(service);
});

final solicitorManagementListProvider = FutureProvider.autoDispose<List<SolicitorManagement>>((ref) async {
  final repository = ref.watch(solicitorManagementRepositoryProvider);
  return repository.getAll();
});

final solicitorManagementCreateProvider = StateProvider<SolicitorManagement?>((ref) => null);
final solicitorManagementUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final solicitorManagementDeleteProvider = StateProvider<String?>((ref) => null);
final solicitorManagementLoadingProvider = StateProvider<bool>((ref) => false);
