import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/deposit_protection_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// DepositProtection Providers

final depositProtectionServiceProvider = Provider<DepositProtectionService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return DepositProtectionService(dioClient);
});

// List Provider
final depositProtectionProvider = FutureProvider.autoDispose<List<DepositProtection>>((ref) async {
  final service = ref.watch(depositProtectionServiceProvider);
  return service.getDepositProtections();
});

// Create Provider
final depositProtectionCreateProvider = FutureProvider.autoDispose<DepositProtection>((ref) async {
  final service = ref.watch(depositProtectionServiceProvider);
  return service.createDepositProtection(DepositProtection());
});

// Update Provider  
final depositProtectionUpdateProvider = FutureProvider.autoDispose<DepositProtection>((ref) async {
  final service = ref.watch(depositProtectionServiceProvider);
  final state = ref.watch(depositProtectionUpdateStateProvider);
  if (state['id'] != null && state['deposit_protection'] != null) {
    return service.updateDepositProtection(state['id'], state['deposit_protection']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final depositProtectionDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(depositProtectionServiceProvider);
  final state = ref.watch(depositProtectionDeleteStateProvider);
  if (state != null) {
    return service.deleteDepositProtection(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final depositProtectionCreateStateProvider = StateProvider<DepositProtection?>((ref) => null);
final depositProtectionUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final depositProtectionDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final depositProtectionLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(depositProtectionProvider);
  final createAsync = ref.watch(depositProtectionCreateProvider);
  final updateAsync = ref.watch(depositProtectionUpdateProvider);
  final deleteAsync = ref.watch(depositProtectionDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
