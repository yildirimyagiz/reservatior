import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/ai_fraud_detection_service.dart';
import 'package:reservatior/shared/repositories/ai_fraud_detection_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final aiFraudDetectionServiceProvider = Provider<AiFraudDetectionService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return AiFraudDetectionService(dioClient);
});

final aiFraudDetectionRepositoryProvider = Provider<AiFraudDetectionRepository>((ref) {
  final service = ref.watch(aiFraudDetectionServiceProvider);
  return AiFraudDetectionRepositoryImpl(service);
});

final aiFraudDetectionListProvider = FutureProvider.autoDispose<List<AiFraudDetection>>((ref) async {
  final repository = ref.watch(aiFraudDetectionRepositoryProvider);
  return repository.getAll();
});

final aiFraudDetectionCreateProvider = StateProvider<AiFraudDetection?>((ref) => null);
final aiFraudDetectionUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final aiFraudDetectionDeleteProvider = StateProvider<String?>((ref) => null);
final aiFraudDetectionLoadingProvider = StateProvider<bool>((ref) => false);
