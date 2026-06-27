import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/included_service_service.dart';
import 'package:reservatior/shared/repositories/included_service_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final includedServiceServiceProvider = Provider<IncludedServiceService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return IncludedServiceService(dioClient);
});

final includedServiceRepositoryProvider = Provider<IncludedServiceRepository>((ref) {
  final service = ref.watch(includedServiceServiceProvider);
  return IncludedServiceRepositoryImpl(service);
});

final includedServiceListProvider = FutureProvider.autoDispose<List<IncludedService>>((ref) async {
  final repository = ref.watch(includedServiceRepositoryProvider);
  return repository.getAll();
});

final includedServiceCreateProvider = StateProvider<IncludedService?>((ref) => null);
final includedServiceUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final includedServiceDeleteProvider = StateProvider<String?>((ref) => null);
final includedServiceLoadingProvider = StateProvider<bool>((ref) => false);
