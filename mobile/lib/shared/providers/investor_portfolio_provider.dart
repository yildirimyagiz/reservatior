import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/investor_portfolio_service.dart';
import 'package:reservatior/shared/repositories/investor_portfolio_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final investorPortfolioServiceProvider = Provider<InvestorPortfolioService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return InvestorPortfolioService(dioClient);
});

final investorPortfolioRepositoryProvider = Provider<InvestorPortfolioRepository>((ref) {
  final service = ref.watch(investorPortfolioServiceProvider);
  return InvestorPortfolioRepositoryImpl(service);
});

final investorPortfolioListProvider = FutureProvider.autoDispose<List<InvestorPortfolio>>((ref) async {
  final repository = ref.watch(investorPortfolioRepositoryProvider);
  return repository.getAll();
});

final investorPortfolioCreateProvider = StateProvider<InvestorPortfolio?>((ref) => null);
final investorPortfolioUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final investorPortfolioDeleteProvider = StateProvider<String?>((ref) => null);
final investorPortfolioLoadingProvider = StateProvider<bool>((ref) => false);
