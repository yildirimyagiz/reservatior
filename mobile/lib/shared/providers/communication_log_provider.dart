import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/communication_log_service.dart';
import 'package:reservatior/shared/repositories/communication_log_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final communicationLogServiceProvider = Provider<CommunicationLogService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return CommunicationLogService(dioClient);
});

final communicationLogRepositoryProvider = Provider<CommunicationLogRepository>((ref) {
  final service = ref.watch(communicationLogServiceProvider);
  return CommunicationLogRepositoryImpl(service);
});

final communicationLogListProvider = FutureProvider.autoDispose<List<CommunicationLog>>((ref) async {
  final repository = ref.watch(communicationLogRepositoryProvider);
  return repository.getAll();
});

final communicationLogCreateProvider = StateProvider<CommunicationLog?>((ref) => null);
final communicationLogUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final communicationLogDeleteProvider = StateProvider<String?>((ref) => null);
final communicationLogLoadingProvider = StateProvider<bool>((ref) => false);
