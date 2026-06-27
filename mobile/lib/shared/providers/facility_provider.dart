import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/facility_service.dart';
import 'package:reservatior/shared/repositories/facility_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final facilityServiceProvider = Provider<FacilityService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return FacilityService(dioClient);
});

final facilityRepositoryProvider = Provider<FacilityRepository>((ref) {
  final service = ref.watch(facilityServiceProvider);
  return FacilityRepositoryImpl(service);
});

final facilityListProvider = FutureProvider.autoDispose<List<Facility>>((ref) async {
  final repository = ref.watch(facilityRepositoryProvider);
  return repository.getAll();
});

final facilityCreateProvider = StateProvider<Facility?>((ref) => null);
final facilityUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final facilityDeleteProvider = StateProvider<String?>((ref) => null);
final facilityLoadingProvider = StateProvider<bool>((ref) => false);
