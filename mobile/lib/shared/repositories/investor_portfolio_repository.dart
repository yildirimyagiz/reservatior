import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/investor_portfolio_service.dart';

abstract class InvestorPortfolioRepository {
  Future<InvestorPortfolio> getById(String id);
  Future<List<InvestorPortfolio>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<InvestorPortfolio> create(InvestorPortfolio item);
  Future<InvestorPortfolio> update(String id, InvestorPortfolio item);
  Future<void> delete(String id);
}

class InvestorPortfolioRepositoryImpl implements InvestorPortfolioRepository {
  final InvestorPortfolioService _service;
  InvestorPortfolioRepositoryImpl(this._service);

  @override
  Future<InvestorPortfolio> getById(String id) => _service.getInvestorPortfolioById(id);

  @override
  Future<List<InvestorPortfolio>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getInvestorPortfolios(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<InvestorPortfolio> create(InvestorPortfolio item) => _service.createInvestorPortfolio(item);

  @override
  Future<InvestorPortfolio> update(String id, InvestorPortfolio item) => _service.updateInvestorPortfolio(id, item);

  @override
  Future<void> delete(String id) => _service.deleteInvestorPortfolio(id);
}
