import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/ambassador_contract_service.dart';
import 'package:reservatior/shared/repositories/ambassador_contract_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final ambassadorContractServiceProvider = Provider<AmbassadorContractService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return AmbassadorContractService(dioClient);
});

final ambassadorContractRepositoryProvider = Provider<AmbassadorContractRepository>((ref) {
  final service = ref.watch(ambassadorContractServiceProvider);
  return AmbassadorContractRepositoryImpl(service);
});

final ambassadorContractListProvider = FutureProvider.autoDispose<List<AmbassadorContract>>((ref) async {
  final repository = ref.watch(ambassadorContractRepositoryProvider);
  return repository.getAll();
});

final ambassadorContractCreateProvider = StateProvider<AmbassadorContract?>((ref) => null);
final ambassadorContractUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final ambassadorContractDeleteProvider = StateProvider<String?>((ref) => null);
final ambassadorContractLoadingProvider = StateProvider<bool>((ref) => false);
