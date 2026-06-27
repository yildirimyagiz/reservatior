import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/key_management_service.dart';
import 'package:reservatior/shared/repositories/key_management_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final keyManagementServiceProvider = Provider<KeyManagementService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return KeyManagementService(dioClient);
});

final keyManagementRepositoryProvider = Provider<KeyManagementRepository>((ref) {
  final service = ref.watch(keyManagementServiceProvider);
  return KeyManagementRepositoryImpl(service);
});

final keyManagementListProvider = FutureProvider.autoDispose<List<KeyManagement>>((ref) async {
  final repository = ref.watch(keyManagementRepositoryProvider);
  return repository.getAll();
});

final keyManagementCreateProvider = StateProvider<KeyManagement?>((ref) => null);
final keyManagementUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final keyManagementDeleteProvider = StateProvider<String?>((ref) => null);
final keyManagementLoadingProvider = StateProvider<bool>((ref) => false);
