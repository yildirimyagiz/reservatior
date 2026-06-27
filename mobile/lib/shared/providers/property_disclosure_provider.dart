import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/property_disclosure_service.dart';
import 'package:reservatior/shared/repositories/property_disclosure_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final propertyDisclosureServiceProvider = Provider<PropertyDisclosureService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return PropertyDisclosureService(dioClient);
});

final propertyDisclosureRepositoryProvider = Provider<PropertyDisclosureRepository>((ref) {
  final service = ref.watch(propertyDisclosureServiceProvider);
  return PropertyDisclosureRepositoryImpl(service);
});

final propertyDisclosureListProvider = FutureProvider.autoDispose.family<List<PropertyDisclosure>, String>((ref, propertyId) async {
  final repository = ref.watch(propertyDisclosureRepositoryProvider);
  return repository.getAll(filters: {'propertyId': propertyId});
});

final propertyDisclosureCreateProvider = StateProvider<PropertyDisclosure?>((ref) => null);
final propertyDisclosureUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final propertyDisclosureDeleteProvider = StateProvider<String?>((ref) => null);
final propertyDisclosureLoadingProvider = StateProvider<bool>((ref) => false);
