import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/investor_portfolio_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// InvestorPortfolio Providers

final InvestorPortfolioServiceProvider = Provider<InvestorPortfolioService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return InvestorPortfolioService(dioClient);
});

// List Provider
final investorPortfolioProvider = FutureProvider.autoDispose<List<InvestorPortfolio>>((ref) async {
  final service = ref.watch(InvestorPortfolioServiceProvider);
  return service.getInvestorPortfolios();
});

// Create Provider
final InvestorPortfolioCreateProvider = FutureProvider.autoDispose<InvestorPortfolio>((ref) async {
  final service = ref.watch(InvestorPortfolioServiceProvider);
  return service.createInvestorPortfolio(InvestorPortfolio());
});

// Update Provider  
final InvestorPortfolioUpdateProvider = FutureProvider.autoDispose<InvestorPortfolio>((ref) async {
  final service = ref.watch(InvestorPortfolioServiceProvider);
  final state = ref.watch(InvestorPortfolioUpdateStateProvider);
  if (state['id'] != null && state['investor_portfolio'] != null) {
    return service.updateInvestorPortfolio(state['id'], state['investor_portfolio']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final InvestorPortfolioDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(InvestorPortfolioServiceProvider);
  final state = ref.watch(InvestorPortfolioDeleteStateProvider);
  if (state != null) {
    return service.deleteInvestorPortfolio(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final InvestorPortfolioUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final InvestorPortfolioDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final InvestorPortfolioLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(investorPortfolioProvider);
  final createAsync = ref.watch(InvestorPortfolioCreateProvider);
  final updateAsync = ref.watch(InvestorPortfolioUpdateProvider);
  final deleteAsync = ref.watch(InvestorPortfolioDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
