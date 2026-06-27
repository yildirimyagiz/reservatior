import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/right_to_rent_check_service.dart';
import 'package:reservatior/shared/repositories/right_to_rent_check_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final rightToRentCheckServiceProvider = Provider<RightToRentCheckService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return RightToRentCheckService(dioClient);
});

final rightToRentCheckRepositoryProvider = Provider<RightToRentCheckRepository>((ref) {
  final service = ref.watch(rightToRentCheckServiceProvider);
  return RightToRentCheckRepositoryImpl(service);
});

final rightToRentCheckListProvider = FutureProvider.autoDispose<List<RightToRentCheck>>((ref) async {
  final repository = ref.watch(rightToRentCheckRepositoryProvider);
  return repository.getAll();
});

final rightToRentCheckCreateProvider = StateProvider<RightToRentCheck?>((ref) => null);
final rightToRentCheckUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final rightToRentCheckDeleteProvider = StateProvider<String?>((ref) => null);
final rightToRentCheckLoadingProvider = StateProvider<bool>((ref) => false);
