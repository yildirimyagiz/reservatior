import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/mls_data_mapping_service.dart';
import 'package:reservatior/shared/repositories/mls_data_mapping_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final mlsDataMappingServiceProvider = Provider<MlsDataMappingService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return MlsDataMappingService(dioClient);
});

final mlsDataMappingRepositoryProvider = Provider<MlsDataMappingRepository>((ref) {
  final service = ref.watch(mlsDataMappingServiceProvider);
  return MlsDataMappingRepositoryImpl(service);
});

final mlsDataMappingListProvider = FutureProvider.autoDispose<List<MlsDataMapping>>((ref) async {
  final repository = ref.watch(mlsDataMappingRepositoryProvider);
  return repository.getAll();
});

final mlsDataMappingCreateProvider = StateProvider<MlsDataMapping?>((ref) => null);
final mlsDataMappingUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final mlsDataMappingDeleteProvider = StateProvider<String?>((ref) => null);
final mlsDataMappingLoadingProvider = StateProvider<bool>((ref) => false);
