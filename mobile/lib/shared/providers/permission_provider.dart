import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/permission_service.dart';
import 'package:reservatior/shared/repositories/permission_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final permissionServiceProvider = Provider<PermissionService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return PermissionService(dioClient);
});

final permissionRepositoryProvider = Provider<PermissionRepository>((ref) {
  final service = ref.watch(permissionServiceProvider);
  return PermissionRepositoryImpl(service);
});

final permissionListProvider = FutureProvider.autoDispose<List<Permission>>((ref) async {
  final repository = ref.watch(permissionRepositoryProvider);
  return repository.getAll();
});

final permissionCreateProvider = StateProvider<Permission?>((ref) => null);
final permissionUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final permissionDeleteProvider = StateProvider<String?>((ref) => null);
final permissionLoadingProvider = StateProvider<bool>((ref) => false);
