import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/contract_service.dart';
import 'package:reservatior/shared/repositories/contract_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final contractServiceProvider = Provider<ContractService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return ContractService(dioClient);
});

final contractRepositoryProvider = Provider<ContractRepository>((ref) {
  final service = ref.watch(contractServiceProvider);
  return ContractRepositoryImpl(service);
});

final contractListProvider = FutureProvider.autoDispose<List<Contract>>((ref) async {
  final repository = ref.watch(contractRepositoryProvider);
  return repository.getAll();
});

final contractCreateProvider = StateProvider<Contract?>((ref) => null);
final contractUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final contractDeleteProvider = StateProvider<String?>((ref) => null);
final contractLoadingProvider = StateProvider<bool>((ref) => false);
