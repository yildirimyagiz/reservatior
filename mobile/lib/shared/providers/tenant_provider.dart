import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/tenant_service.dart';
import 'package:reservatior/shared/repositories/tenant_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final tenantServiceProvider = Provider<TenantService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return TenantService(dioClient);
});

final tenantRepositoryProvider = Provider<TenantRepository>((ref) {
  final service = ref.watch(tenantServiceProvider);
  return TenantRepositoryImpl(service);
});

final tenantListProvider = FutureProvider.autoDispose<List<Tenant>>((ref) async {
  final repository = ref.watch(tenantRepositoryProvider);
  return repository.getAll();
});

final tenantCreateProvider = StateProvider<Tenant?>((ref) => null);
final tenantUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final tenantDeleteProvider = StateProvider<String?>((ref) => null);
final tenantLoadingProvider = StateProvider<bool>((ref) => false);
