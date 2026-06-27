import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/verification_service.dart';
import 'package:reservatior/shared/repositories/verification_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final verificationServiceProvider = Provider<VerificationService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return VerificationService(dioClient);
});

final verificationRepositoryProvider = Provider<VerificationRepository>((ref) {
  final service = ref.watch(verificationServiceProvider);
  return VerificationRepositoryImpl(service);
});

final verificationListProvider = FutureProvider.autoDispose<List<Verification>>((ref) async {
  final repository = ref.watch(verificationRepositoryProvider);
  return repository.getAll();
});

final verificationCreateProvider = StateProvider<Verification?>((ref) => null);
final verificationUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final verificationDeleteProvider = StateProvider<String?>((ref) => null);
final verificationLoadingProvider = StateProvider<bool>((ref) => false);
