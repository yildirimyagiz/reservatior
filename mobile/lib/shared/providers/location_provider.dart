import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/location_service.dart';
import 'package:reservatior/shared/repositories/location_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final locationServiceProvider = Provider<LocationService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return LocationService(dioClient);
});

final locationRepositoryProvider = Provider<LocationRepository>((ref) {
  final service = ref.watch(locationServiceProvider);
  return LocationRepositoryImpl(service);
});

final locationListProvider = FutureProvider.autoDispose<List<Location>>((ref) async {
  final repository = ref.watch(locationRepositoryProvider);
  return repository.getAll();
});

final locationCreateProvider = StateProvider<Location?>((ref) => null);
final locationUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final locationDeleteProvider = StateProvider<String?>((ref) => null);
final locationLoadingProvider = StateProvider<bool>((ref) => false);
