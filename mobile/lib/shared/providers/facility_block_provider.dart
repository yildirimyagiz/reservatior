import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/facility_block_service.dart';
import 'package:reservatior/shared/repositories/facility_block_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final facilityBlockServiceProvider = Provider<FacilityBlockService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return FacilityBlockService(dioClient);
});

final facilityBlockRepositoryProvider = Provider<FacilityBlockRepository>((ref) {
  final service = ref.watch(facilityBlockServiceProvider);
  return FacilityBlockRepositoryImpl(service);
});

final facilityBlockListProvider = FutureProvider.autoDispose<List<FacilityBlock>>((ref) async {
  final repository = ref.watch(facilityBlockRepositoryProvider);
  return repository.getAll();
});

final facilityBlockCreateProvider = StateProvider<FacilityBlock?>((ref) => null);
final facilityBlockUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final facilityBlockDeleteProvider = StateProvider<String?>((ref) => null);
final facilityBlockLoadingProvider = StateProvider<bool>((ref) => false);
