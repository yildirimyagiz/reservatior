import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/signature_signer_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// SignatureSigner Providers

final SignatureSignerServiceProvider = Provider<SignatureSignerService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return SignatureSignerService(dioClient);
});

// List Provider
final signatureSignerProvider = FutureProvider.autoDispose<List<SignatureSigner>>((ref) async {
  final service = ref.watch(SignatureSignerServiceProvider);
  return service.getSignatureSigners();
});

// Create Provider
final SignatureSignerCreateProvider = FutureProvider.autoDispose<SignatureSigner>((ref) async {
  final service = ref.watch(SignatureSignerServiceProvider);
  return service.createSignatureSigner(SignatureSigner());
});

// Update Provider  
final SignatureSignerUpdateProvider = FutureProvider.autoDispose<SignatureSigner>((ref) async {
  final service = ref.watch(SignatureSignerServiceProvider);
  final state = ref.watch(SignatureSignerUpdateStateProvider);
  if (state['id'] != null && state['signature_signer'] != null) {
    return service.updateSignatureSigner(state['id'], state['signature_signer']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final SignatureSignerDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(SignatureSignerServiceProvider);
  final state = ref.watch(SignatureSignerDeleteStateProvider);
  if (state != null) {
    return service.deleteSignatureSigner(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final SignatureSignerUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final SignatureSignerDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final SignatureSignerLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(signatureSignerProvider);
  final createAsync = ref.watch(SignatureSignerCreateProvider);
  final updateAsync = ref.watch(SignatureSignerUpdateProvider);
  final deleteAsync = ref.watch(SignatureSignerDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
