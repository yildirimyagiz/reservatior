import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/rent_schedule_service.dart';
import 'package:reservatior/shared/repositories/rent_schedule_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final rentScheduleServiceProvider = Provider<RentScheduleService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return RentScheduleService(dioClient);
});

final rentScheduleRepositoryProvider = Provider<RentScheduleRepository>((ref) {
  final service = ref.watch(rentScheduleServiceProvider);
  return RentScheduleRepositoryImpl(service);
});

final rentScheduleListProvider = FutureProvider.autoDispose<List<RentSchedule>>((ref) async {
  final repository = ref.watch(rentScheduleRepositoryProvider);
  return repository.getAll();
});

final rentScheduleCreateProvider = StateProvider<RentSchedule?>((ref) => null);
final rentScheduleUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final rentScheduleDeleteProvider = StateProvider<String?>((ref) => null);
final rentScheduleLoadingProvider = StateProvider<bool>((ref) => false);
