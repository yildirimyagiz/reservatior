import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/tenant_application_service.dart';
import 'package:reservatior/shared/repositories/tenant_application_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final tenantApplicationServiceProvider = Provider<TenantApplicationService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return TenantApplicationService(dioClient);
});

final tenantApplicationRepositoryProvider = Provider<TenantApplicationRepository>((ref) {
  final service = ref.watch(tenantApplicationServiceProvider);
  return TenantApplicationRepositoryImpl(service);
});

final tenantApplicationListProvider = FutureProvider.autoDispose<List<TenantApplication>>((ref) async {
  final repository = ref.watch(tenantApplicationRepositoryProvider);
  return repository.getAll();
});

final tenantApplicationCreateProvider = StateProvider<TenantApplication?>((ref) => null);
final tenantApplicationUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final tenantApplicationDeleteProvider = StateProvider<String?>((ref) => null);
final tenantApplicationLoadingProvider = StateProvider<bool>((ref) => false);
