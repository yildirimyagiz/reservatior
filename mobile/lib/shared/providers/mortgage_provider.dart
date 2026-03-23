import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/mortgage_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// Mortgage Providers

final MortgageServiceProvider = Provider<MortgageService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return MortgageService(dioClient);
});

// List Provider
final mortgageProvider = FutureProvider.autoDispose<List<Mortgage>>((ref) async {
  final service = ref.watch(MortgageServiceProvider);
  return service.getMortgages();
});

// Create Provider
final MortgageCreateProvider = FutureProvider.autoDispose<Mortgage>((ref) async {
  final service = ref.watch(MortgageServiceProvider);
  return service.createMortgage(Mortgage());
});

// Update Provider  
final MortgageUpdateProvider = FutureProvider.autoDispose<Mortgage>((ref) async {
  final service = ref.watch(MortgageServiceProvider);
  final state = ref.watch(MortgageUpdateStateProvider);
  if (state['id'] != null && state['mortgage'] != null) {
    return service.updateMortgage(state['id'], state['mortgage']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final MortgageDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(MortgageServiceProvider);
  final state = ref.watch(MortgageDeleteStateProvider);
  if (state != null) {
    return service.deleteMortgage(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final MortgageUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final MortgageDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final MortgageLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(mortgageProvider);
  final createAsync = ref.watch(MortgageCreateProvider);
  final updateAsync = ref.watch(MortgageUpdateProvider);
  final deleteAsync = ref.watch(MortgageDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
