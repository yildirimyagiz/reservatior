import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/user_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// User Providers

final UserServiceProvider = Provider<UserService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return UserService(dioClient);
});

// List Provider
final userProvider = FutureProvider.autoDispose<List<User>>((ref) async {
  final service = ref.watch(UserServiceProvider);
  return service.getUsers();
});

// Create Provider
final UserCreateProvider = FutureProvider.autoDispose<User>((ref) async {
  final service = ref.watch(UserServiceProvider);
  return service.createUser(User());
});

// Update Provider  
final UserUpdateProvider = FutureProvider.autoDispose<User>((ref) async {
  final service = ref.watch(UserServiceProvider);
  final state = ref.watch(UserUpdateStateProvider);
  if (state['id'] != null && state['user'] != null) {
    return service.updateUser(state['id'], state['user']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final UserDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(UserServiceProvider);
  final state = ref.watch(UserDeleteStateProvider);
  if (state != null) {
    return service.deleteUser(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final UserUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final UserDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final UserLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(userProvider);
  final createAsync = ref.watch(UserCreateProvider);
  final updateAsync = ref.watch(UserUpdateProvider);
  final deleteAsync = ref.watch(UserDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
