import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/verification_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// Verification Providers

final VerificationServiceProvider = Provider<VerificationService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return VerificationService(dioClient);
});

// List Provider
final verificationProvider = FutureProvider.autoDispose<List<Verification>>((ref) async {
  final service = ref.watch(VerificationServiceProvider);
  return service.getVerifications();
});

// Create Provider
final VerificationCreateProvider = FutureProvider.autoDispose<Verification>((ref) async {
  final service = ref.watch(VerificationServiceProvider);
  return service.createVerification(Verification());
});

// Update Provider  
final VerificationUpdateProvider = FutureProvider.autoDispose<Verification>((ref) async {
  final service = ref.watch(VerificationServiceProvider);
  final state = ref.watch(VerificationUpdateStateProvider);
  if (state['id'] != null && state['verification'] != null) {
    return service.updateVerification(state['id'], state['verification']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final VerificationDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(VerificationServiceProvider);
  final state = ref.watch(VerificationDeleteStateProvider);
  if (state != null) {
    return service.deleteVerification(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final VerificationUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final VerificationDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final VerificationLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(verificationProvider);
  final createAsync = ref.watch(VerificationCreateProvider);
  final updateAsync = ref.watch(VerificationUpdateProvider);
  final deleteAsync = ref.watch(VerificationDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
