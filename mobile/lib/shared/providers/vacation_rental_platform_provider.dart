import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/vacation_rental_platform_service.dart';
import 'package:reservatior/shared/repositories/vacation_rental_platform_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final vacationRentalPlatformServiceProvider = Provider<VacationRentalPlatformService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return VacationRentalPlatformService(dioClient);
});

final vacationRentalPlatformRepositoryProvider = Provider<VacationRentalPlatformRepository>((ref) {
  final service = ref.watch(vacationRentalPlatformServiceProvider);
  return VacationRentalPlatformRepositoryImpl(service);
});

final vacationRentalPlatformListProvider = FutureProvider.autoDispose<List<VacationRentalPlatform>>((ref) async {
  final repository = ref.watch(vacationRentalPlatformRepositoryProvider);
  return repository.getAll();
});

final vacationRentalPlatformCreateProvider = StateProvider<VacationRentalPlatform?>((ref) => null);
final vacationRentalPlatformUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final vacationRentalPlatformDeleteProvider = StateProvider<String?>((ref) => null);
final vacationRentalPlatformLoadingProvider = StateProvider<bool>((ref) => false);
