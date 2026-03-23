import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/investor_property_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// InvestorProperty Providers

final InvestorPropertyServiceProvider = Provider<InvestorPropertyService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return InvestorPropertyService(dioClient);
});

// List Provider
final investorPropertyProvider = FutureProvider.autoDispose<List<InvestorProperty>>((ref) async {
  final service = ref.watch(InvestorPropertyServiceProvider);
  return service.getInvestorPropertys();
});

// Create Provider
final InvestorPropertyCreateProvider = FutureProvider.autoDispose<InvestorProperty>((ref) async {
  final service = ref.watch(InvestorPropertyServiceProvider);
  return service.createInvestorProperty(InvestorProperty());
});

// Update Provider  
final InvestorPropertyUpdateProvider = FutureProvider.autoDispose<InvestorProperty>((ref) async {
  final service = ref.watch(InvestorPropertyServiceProvider);
  final state = ref.watch(InvestorPropertyUpdateStateProvider);
  if (state['id'] != null && state['investor_property'] != null) {
    return service.updateInvestorProperty(state['id'], state['investor_property']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final InvestorPropertyDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(InvestorPropertyServiceProvider);
  final state = ref.watch(InvestorPropertyDeleteStateProvider);
  if (state != null) {
    return service.deleteInvestorProperty(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final InvestorPropertyUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final InvestorPropertyDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final InvestorPropertyLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(investorPropertyProvider);
  final createAsync = ref.watch(InvestorPropertyCreateProvider);
  final updateAsync = ref.watch(InvestorPropertyUpdateProvider);
  final deleteAsync = ref.watch(InvestorPropertyDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
