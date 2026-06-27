import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/signature_signer_service.dart';
import 'package:reservatior/shared/repositories/signature_signer_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final signatureSignerServiceProvider = Provider<SignatureSignerService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return SignatureSignerService(dioClient);
});

final signatureSignerRepositoryProvider = Provider<SignatureSignerRepository>((ref) {
  final service = ref.watch(signatureSignerServiceProvider);
  return SignatureSignerRepositoryImpl(service);
});

final signatureSignerListProvider = FutureProvider.autoDispose<List<SignatureSigner>>((ref) async {
  final repository = ref.watch(signatureSignerRepositoryProvider);
  return repository.getAll();
});

final signatureSignerCreateProvider = StateProvider<SignatureSigner?>((ref) => null);
final signatureSignerUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final signatureSignerDeleteProvider = StateProvider<String?>((ref) => null);
final signatureSignerLoadingProvider = StateProvider<bool>((ref) => false);
