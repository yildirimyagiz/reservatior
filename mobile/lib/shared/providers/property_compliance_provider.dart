import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/property_compliance_service.dart';
import 'package:reservatior/shared/repositories/property_compliance_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final propertyComplianceServiceProvider = Provider<PropertyComplianceService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return PropertyComplianceService(dioClient);
});

final propertyComplianceRepositoryProvider = Provider<PropertyComplianceRepository>((ref) {
  final service = ref.watch(propertyComplianceServiceProvider);
  return PropertyComplianceRepositoryImpl(service);
});

final propertyComplianceListProvider = FutureProvider.autoDispose.family<List<PropertyCompliance>, String>((ref, propertyId) async {
  final repository = ref.watch(propertyComplianceRepositoryProvider);
  return repository.getAll(filters: {'propertyId': propertyId});
});

final propertyComplianceCreateProvider = StateProvider<PropertyCompliance?>((ref) => null);
final propertyComplianceUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final propertyComplianceDeleteProvider = StateProvider<String?>((ref) => null);
final propertyComplianceLoadingProvider = StateProvider<bool>((ref) => false);
