import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/property_viewing_service.dart';
import 'package:reservatior/shared/repositories/property_viewing_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final propertyViewingServiceProvider = Provider<PropertyViewingService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return PropertyViewingService(dioClient);
});

final propertyViewingRepositoryProvider = Provider<PropertyViewingRepository>((ref) {
  final service = ref.watch(propertyViewingServiceProvider);
  return PropertyViewingRepositoryImpl(service);
});

final propertyViewingListProvider = FutureProvider.autoDispose.family<List<PropertyViewing>, String>((ref, propertyId) async {
  final repository = ref.watch(propertyViewingRepositoryProvider);
  return repository.getAll(filters: {'propertyId': propertyId});
});

final propertyViewingCreateProvider = StateProvider<PropertyViewing?>((ref) => null);
final propertyViewingUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final propertyViewingDeleteProvider = StateProvider<String?>((ref) => null);
final propertyViewingLoadingProvider = StateProvider<bool>((ref) => false);
