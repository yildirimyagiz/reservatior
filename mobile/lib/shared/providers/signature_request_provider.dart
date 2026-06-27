import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/signature_request_service.dart';
import 'package:reservatior/shared/repositories/signature_request_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final signatureRequestServiceProvider = Provider<SignatureRequestService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return SignatureRequestService(dioClient);
});

final signatureRequestRepositoryProvider = Provider<SignatureRequestRepository>((ref) {
  final service = ref.watch(signatureRequestServiceProvider);
  return SignatureRequestRepositoryImpl(service);
});

final signatureRequestListProvider = FutureProvider.autoDispose<List<SignatureRequest>>((ref) async {
  final repository = ref.watch(signatureRequestRepositoryProvider);
  return repository.getAll();
});

final signatureRequestCreateProvider = StateProvider<SignatureRequest?>((ref) => null);
final signatureRequestUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final signatureRequestDeleteProvider = StateProvider<String?>((ref) => null);
final signatureRequestLoadingProvider = StateProvider<bool>((ref) => false);
