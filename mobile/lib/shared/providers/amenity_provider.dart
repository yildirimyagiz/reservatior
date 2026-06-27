import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/amenity_service.dart';
import 'package:reservatior/shared/repositories/amenity_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final amenityServiceProvider = Provider<AmenityService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return AmenityService(dioClient);
});

final amenityRepositoryProvider = Provider<AmenityRepository>((ref) {
  final service = ref.watch(amenityServiceProvider);
  return AmenityRepositoryImpl(service);
});

final amenityListProvider = FutureProvider.autoDispose<List<Amenity>>((ref) async {
  final repository = ref.watch(amenityRepositoryProvider);
  return repository.getAll();
});

final amenityCreateProvider = StateProvider<Amenity?>((ref) => null);
final amenityUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final amenityDeleteProvider = StateProvider<String?>((ref) => null);
final amenityLoadingProvider = StateProvider<bool>((ref) => false);
