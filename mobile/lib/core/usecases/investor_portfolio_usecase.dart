import '../../features/shared/services/investor_portfolio_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for InvestorPortfolio

class GetInvestorPortfolioByIdUseCase {
  final InvestorPortfolioService _service;
  
  GetInvestorPortfolioByIdUseCase(this._service);
  
  Future<InvestorPortfolio> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetInvestorPortfoliosUseCase {
  final InvestorPortfolioService _service;
  
  GetInvestorPortfoliosUseCase(this._service);
  
  Future<List<InvestorPortfolio>> execute({
    int page = 1,
    int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    if (page <= 0) {
      throw ArgumentError('Page must be greater than 0');
    }
    if (limit <= 0 || limit > 100) {
      throw ArgumentError('Limit must be between 1 and 100');
    }
    return await _service.getAll(
      page: page,
      limit: limit,
      filters: filters,
    );
  }
}

class CreateInvestorPortfolioUseCase {
  final InvestorPortfolioService _service;
  
  CreateInvestorPortfolioUseCase(this._service);
  
  Future<InvestorPortfolio> execute(InvestorPortfolio investorPortfolio) async {
    // Add validation logic here
    return await _service.create(investorPortfolio);
  }
}

class UpdateInvestorPortfolioUseCase {
  final InvestorPortfolioService _service;
  
  UpdateInvestorPortfolioUseCase(this._service);
  
  Future<InvestorPortfolio> execute(String id, InvestorPortfolio investorPortfolio) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, investorPortfolio);
  }
}

class DeleteInvestorPortfolioUseCase {
  final InvestorPortfolioService _service;
  
  DeleteInvestorPortfolioUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// InvestorPortfolio Use Case Container
class InvestorPortfolioUseCases {
  final GetInvestorPortfolioByIdUseCase getById;
  final GetInvestorPortfoliosUseCase getAll;
  final CreateInvestorPortfolioUseCase create;
  final UpdateInvestorPortfolioUseCase update;
  final DeleteInvestorPortfolioUseCase delete;
  
  InvestorPortfolioUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory InvestorPortfolioUseCases.create(InvestorPortfolioService service) {
    return InvestorPortfolioUseCases(
      getById: GetInvestorPortfolioByIdUseCase(service),
      getAll: GetInvestorPortfoliosUseCase(service),
      create: CreateInvestorPortfolioUseCase(service),
      update: UpdateInvestorPortfolioUseCase(service),
      delete: DeleteInvestorPortfolioUseCase(service),
    );
  }
}
