import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/signature_request_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// SignatureRequest Providers

final SignatureRequestServiceProvider = Provider<SignatureRequestService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return SignatureRequestService(dioClient);
});

// List Provider
final signatureRequestProvider = FutureProvider.autoDispose<List<SignatureRequest>>((ref) async {
  final service = ref.watch(SignatureRequestServiceProvider);
  return service.getSignatureRequests();
});

// Create Provider
final SignatureRequestCreateProvider = FutureProvider.autoDispose<SignatureRequest>((ref) async {
  final service = ref.watch(SignatureRequestServiceProvider);
  return service.createSignatureRequest(SignatureRequest());
});

// Update Provider  
final SignatureRequestUpdateProvider = FutureProvider.autoDispose<SignatureRequest>((ref) async {
  final service = ref.watch(SignatureRequestServiceProvider);
  final state = ref.watch(SignatureRequestUpdateStateProvider);
  if (state['id'] != null && state['signature_request'] != null) {
    return service.updateSignatureRequest(state['id'], state['signature_request']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final SignatureRequestDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(SignatureRequestServiceProvider);
  final state = ref.watch(SignatureRequestDeleteStateProvider);
  if (state != null) {
    return service.deleteSignatureRequest(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final SignatureRequestUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final SignatureRequestDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final SignatureRequestLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(signatureRequestProvider);
  final createAsync = ref.watch(SignatureRequestCreateProvider);
  final updateAsync = ref.watch(SignatureRequestUpdateProvider);
  final deleteAsync = ref.watch(SignatureRequestDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
