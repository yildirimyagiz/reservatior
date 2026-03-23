import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/mortgage_pre_approval_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// MortgagePreApproval Providers

final MortgagePreApprovalServiceProvider = Provider<MortgagePreApprovalService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return MortgagePreApprovalService(dioClient);
});

// List Provider
final mortgagePreApprovalProvider = FutureProvider.autoDispose<List<MortgagePreApproval>>((ref) async {
  final service = ref.watch(MortgagePreApprovalServiceProvider);
  return service.getMortgagePreApprovals();
});

// Create Provider
final MortgagePreApprovalCreateProvider = FutureProvider.autoDispose<MortgagePreApproval>((ref) async {
  final service = ref.watch(MortgagePreApprovalServiceProvider);
  return service.createMortgagePreApproval(MortgagePreApproval());
});

// Update Provider  
final MortgagePreApprovalUpdateProvider = FutureProvider.autoDispose<MortgagePreApproval>((ref) async {
  final service = ref.watch(MortgagePreApprovalServiceProvider);
  final state = ref.watch(MortgagePreApprovalUpdateStateProvider);
  if (state['id'] != null && state['mortgage_pre_approval'] != null) {
    return service.updateMortgagePreApproval(state['id'], state['mortgage_pre_approval']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final MortgagePreApprovalDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(MortgagePreApprovalServiceProvider);
  final state = ref.watch(MortgagePreApprovalDeleteStateProvider);
  if (state != null) {
    return service.deleteMortgagePreApproval(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final MortgagePreApprovalUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final MortgagePreApprovalDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final MortgagePreApprovalLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(mortgagePreApprovalProvider);
  final createAsync = ref.watch(MortgagePreApprovalCreateProvider);
  final updateAsync = ref.watch(MortgagePreApprovalUpdateProvider);
  final deleteAsync = ref.watch(MortgagePreApprovalDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
