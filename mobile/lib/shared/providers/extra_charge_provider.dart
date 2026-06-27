import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/extra_charge_service.dart';
import 'package:reservatior/shared/repositories/extra_charge_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final extraChargeServiceProvider = Provider<ExtraChargeService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return ExtraChargeService(dioClient);
});

final extraChargeRepositoryProvider = Provider<ExtraChargeRepository>((ref) {
  final service = ref.watch(extraChargeServiceProvider);
  return ExtraChargeRepositoryImpl(service);
});

final extraChargeListProvider = FutureProvider.autoDispose<List<ExtraCharge>>((ref) async {
  final repository = ref.watch(extraChargeRepositoryProvider);
  return repository.getAll();
});

final extraChargeCreateProvider = StateProvider<ExtraCharge?>((ref) => null);
final extraChargeUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final extraChargeDeleteProvider = StateProvider<String?>((ref) => null);
final extraChargeLoadingProvider = StateProvider<bool>((ref) => false);
