import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/user_activity_log_service.dart';
import 'package:reservatior/shared/repositories/user_activity_log_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final userActivityLogServiceProvider = Provider<UserActivityLogService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return UserActivityLogService(dioClient);
});

final userActivityLogRepositoryProvider = Provider<UserActivityLogRepository>((ref) {
  final service = ref.watch(userActivityLogServiceProvider);
  return UserActivityLogRepositoryImpl(service);
});

final userActivityLogListProvider = FutureProvider.autoDispose<List<UserActivityLog>>((ref) async {
  final repository = ref.watch(userActivityLogRepositoryProvider);
  return repository.getAll();
});

final userActivityLogCreateProvider = StateProvider<UserActivityLog?>((ref) => null);
final userActivityLogUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final userActivityLogDeleteProvider = StateProvider<String?>((ref) => null);
final userActivityLogLoadingProvider = StateProvider<bool>((ref) => false);
