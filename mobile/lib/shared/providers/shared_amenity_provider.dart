import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/shared_amenity_service.dart';
import 'package:reservatior/shared/repositories/shared_amenity_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final sharedAmenityServiceProvider = Provider<SharedAmenityService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return SharedAmenityService(dioClient);
});

final sharedAmenityRepositoryProvider = Provider<SharedAmenityRepository>((ref) {
  final service = ref.watch(sharedAmenityServiceProvider);
  return SharedAmenityRepositoryImpl(service);
});

final sharedAmenityListProvider = FutureProvider.autoDispose<List<SharedAmenity>>((ref) async {
  final repository = ref.watch(sharedAmenityRepositoryProvider);
  return repository.getAll();
});

final sharedAmenityCreateProvider = StateProvider<SharedAmenity?>((ref) => null);
final sharedAmenityUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final sharedAmenityDeleteProvider = StateProvider<String?>((ref) => null);
final sharedAmenityLoadingProvider = StateProvider<bool>((ref) => false);
