import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/user_service.dart';
import 'package:reservatior/shared/repositories/user_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final userServiceProvider = Provider<UserService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return UserService(dioClient);
});

final userRepositoryProvider = Provider<UserRepository>((ref) {
  final service = ref.watch(userServiceProvider);
  return UserRepositoryImpl(service);
});

final userListProvider = FutureProvider.autoDispose<List<User>>((ref) async {
  final repository = ref.watch(userRepositoryProvider);
  return repository.getAll();
});

final userCreateProvider = StateProvider<User?>((ref) => null);
final userUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final userDeleteProvider = StateProvider<String?>((ref) => null);
final userLoadingProvider = StateProvider<bool>((ref) => false);
