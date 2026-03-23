import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/security_deposit_protection_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// SecurityDepositProtection Providers

final SecurityDepositProtectionServiceProvider = Provider<SecurityDepositProtectionService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return SecurityDepositProtectionService(dioClient);
});

// List Provider
final securityDepositProtectionProvider = FutureProvider.autoDispose<List<SecurityDepositProtection>>((ref) async {
  final service = ref.watch(SecurityDepositProtectionServiceProvider);
  return service.getSecurityDepositProtections();
});

// Create Provider
final SecurityDepositProtectionCreateProvider = FutureProvider.autoDispose<SecurityDepositProtection>((ref) async {
  final service = ref.watch(SecurityDepositProtectionServiceProvider);
  return service.createSecurityDepositProtection(SecurityDepositProtection());
});

// Update Provider  
final SecurityDepositProtectionUpdateProvider = FutureProvider.autoDispose<SecurityDepositProtection>((ref) async {
  final service = ref.watch(SecurityDepositProtectionServiceProvider);
  final state = ref.watch(SecurityDepositProtectionUpdateStateProvider);
  if (state['id'] != null && state['security_deposit_protection'] != null) {
    return service.updateSecurityDepositProtection(state['id'], state['security_deposit_protection']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final SecurityDepositProtectionDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(SecurityDepositProtectionServiceProvider);
  final state = ref.watch(SecurityDepositProtectionDeleteStateProvider);
  if (state != null) {
    return service.deleteSecurityDepositProtection(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final SecurityDepositProtectionUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final SecurityDepositProtectionDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final SecurityDepositProtectionLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(securityDepositProtectionProvider);
  final createAsync = ref.watch(SecurityDepositProtectionCreateProvider);
  final updateAsync = ref.watch(SecurityDepositProtectionUpdateProvider);
  final deleteAsync = ref.watch(SecurityDepositProtectionDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
