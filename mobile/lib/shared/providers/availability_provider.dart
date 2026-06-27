import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/availability_service.dart';
import 'package:reservatior/shared/repositories/availability_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final availabilityServiceProvider = Provider<AvailabilityService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return AvailabilityService(dioClient);
});

final availabilityRepositoryProvider = Provider<AvailabilityRepository>((ref) {
  final service = ref.watch(availabilityServiceProvider);
  return AvailabilityRepositoryImpl(service);
});

final availabilityListProvider = FutureProvider.autoDispose<List<Availability>>((ref) async {
  final repository = ref.watch(availabilityRepositoryProvider);
  return repository.getAll();
});

final availabilityCreateProvider = StateProvider<Availability?>((ref) => null);
final availabilityUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final availabilityDeleteProvider = StateProvider<String?>((ref) => null);
final availabilityLoadingProvider = StateProvider<bool>((ref) => false);
