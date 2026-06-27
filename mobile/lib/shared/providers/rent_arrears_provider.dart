import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/rent_arrears_service.dart';
import 'package:reservatior/shared/repositories/rent_arrears_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final rentArrearsServiceProvider = Provider<RentArrearsService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return RentArrearsService(dioClient);
});

final rentArrearsRepositoryProvider = Provider<RentArrearsRepository>((ref) {
  final service = ref.watch(rentArrearsServiceProvider);
  return RentArrearsRepositoryImpl(service);
});

final rentArrearsListProvider = FutureProvider.autoDispose<List<RentArrears>>((ref) async {
  final repository = ref.watch(rentArrearsRepositoryProvider);
  return repository.getAll();
});

final rentArrearsCreateProvider = StateProvider<RentArrears?>((ref) => null);
final rentArrearsUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final rentArrearsDeleteProvider = StateProvider<String?>((ref) => null);
final rentArrearsLoadingProvider = StateProvider<bool>((ref) => false);
