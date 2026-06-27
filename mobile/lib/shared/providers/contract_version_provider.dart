import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/contract_version_service.dart';
import 'package:reservatior/shared/repositories/contract_version_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final contractVersionServiceProvider = Provider<ContractVersionService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return ContractVersionService(dioClient);
});

final contractVersionRepositoryProvider = Provider<ContractVersionRepository>((ref) {
  final service = ref.watch(contractVersionServiceProvider);
  return ContractVersionRepositoryImpl(service);
});

final contractVersionListProvider = FutureProvider.autoDispose<List<ContractVersion>>((ref) async {
  final repository = ref.watch(contractVersionRepositoryProvider);
  return repository.getAll();
});

final contractVersionCreateProvider = StateProvider<ContractVersion?>((ref) => null);
final contractVersionUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final contractVersionDeleteProvider = StateProvider<String?>((ref) => null);
final contractVersionLoadingProvider = StateProvider<bool>((ref) => false);
