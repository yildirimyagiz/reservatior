import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/referral_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// Referral Providers

final ReferralServiceProvider = Provider<ReferralService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return ReferralService(dioClient);
});

// List Provider
final referralProvider = FutureProvider.autoDispose<List<Referral>>((ref) async {
  final service = ref.watch(ReferralServiceProvider);
  return service.getReferrals();
});

// Create Provider
final ReferralCreateProvider = FutureProvider.autoDispose<Referral>((ref) async {
  final service = ref.watch(ReferralServiceProvider);
  return service.createReferral(Referral());
});

// Update Provider  
final ReferralUpdateProvider = FutureProvider.autoDispose<Referral>((ref) async {
  final service = ref.watch(ReferralServiceProvider);
  final state = ref.watch(ReferralUpdateStateProvider);
  if (state['id'] != null && state['referral'] != null) {
    return service.updateReferral(state['id'], state['referral']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final ReferralDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(ReferralServiceProvider);
  final state = ref.watch(ReferralDeleteStateProvider);
  if (state != null) {
    return service.deleteReferral(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final ReferralUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final ReferralDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final ReferralLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(referralProvider);
  final createAsync = ref.watch(ReferralCreateProvider);
  final updateAsync = ref.watch(ReferralUpdateProvider);
  final deleteAsync = ref.watch(ReferralDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
