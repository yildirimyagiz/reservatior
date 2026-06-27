import 'package:reservatior/shared/repositories/investor_portfolio_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetInvestorPortfolioByIdUseCase {
  final InvestorPortfolioRepository _repository;
  GetInvestorPortfolioByIdUseCase(this._repository);
  Future<InvestorPortfolio> execute(String id) => _repository.getById(id);
}

class GetInvestorPortfoliosUseCase {
  final InvestorPortfolioRepository _repository;
  GetInvestorPortfoliosUseCase(this._repository);
  Future<List<InvestorPortfolio>> execute({
    int page = 1, 
    int limit = 20, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) => _repository.getAll(
    page: page, 
    limit: limit, 
    filters: filters,
    sortBy: sortBy,
    sortOrder: sortOrder,
  );
}

class CreateInvestorPortfolioUseCase {
  final InvestorPortfolioRepository _repository;
  CreateInvestorPortfolioUseCase(this._repository);
  Future<InvestorPortfolio> execute(InvestorPortfolio item) => _repository.create(item);
}

class UpdateInvestorPortfolioUseCase {
  final InvestorPortfolioRepository _repository;
  UpdateInvestorPortfolioUseCase(this._repository);
  Future<InvestorPortfolio> execute(String id, InvestorPortfolio item) => _repository.update(id, item);
}

class DeleteInvestorPortfolioUseCase {
  final InvestorPortfolioRepository _repository;
  DeleteInvestorPortfolioUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
