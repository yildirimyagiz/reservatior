import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/user_activity_log_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// UserActivityLog Providers

final UserActivityLogServiceProvider = Provider<UserActivityLogService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return UserActivityLogService(dioClient);
});

// List Provider
final userActivityLogProvider = FutureProvider.autoDispose<List<UserActivityLog>>((ref) async {
  final service = ref.watch(UserActivityLogServiceProvider);
  return service.getUserActivityLogs();
});

// Create Provider
final UserActivityLogCreateProvider = FutureProvider.autoDispose<UserActivityLog>((ref) async {
  final service = ref.watch(UserActivityLogServiceProvider);
  return service.createUserActivityLog(UserActivityLog());
});

// Update Provider  
final UserActivityLogUpdateProvider = FutureProvider.autoDispose<UserActivityLog>((ref) async {
  final service = ref.watch(UserActivityLogServiceProvider);
  final state = ref.watch(UserActivityLogUpdateStateProvider);
  if (state['id'] != null && state['user_activity_log'] != null) {
    return service.updateUserActivityLog(state['id'], state['user_activity_log']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final UserActivityLogDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(UserActivityLogServiceProvider);
  final state = ref.watch(UserActivityLogDeleteStateProvider);
  if (state != null) {
    return service.deleteUserActivityLog(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final UserActivityLogUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final UserActivityLogDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final UserActivityLogLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(userActivityLogProvider);
  final createAsync = ref.watch(UserActivityLogCreateProvider);
  final updateAsync = ref.watch(UserActivityLogUpdateProvider);
  final deleteAsync = ref.watch(UserActivityLogDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
