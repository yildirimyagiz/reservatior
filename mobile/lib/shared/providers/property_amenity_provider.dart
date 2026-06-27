import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/property_amenity_service.dart';
import 'package:reservatior/shared/repositories/property_amenity_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final propertyAmenityServiceProvider = Provider<PropertyAmenityService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return PropertyAmenityService(dioClient);
});

final propertyAmenityRepositoryProvider = Provider<PropertyAmenityRepository>((ref) {
  final service = ref.watch(propertyAmenityServiceProvider);
  return PropertyAmenityRepositoryImpl(service);
});

final propertyAmenityListProvider = FutureProvider.autoDispose.family<List<PropertyAmenity>, String>((ref, propertyId) async {
  final repository = ref.watch(propertyAmenityRepositoryProvider);
  return repository.getAll(filters: {'propertyId': propertyId});
});

final propertyAmenityCreateProvider = StateProvider<PropertyAmenity?>((ref) => null);
final propertyAmenityUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final propertyAmenityDeleteProvider = StateProvider<String?>((ref) => null);
final propertyAmenityLoadingProvider = StateProvider<bool>((ref) => false);
