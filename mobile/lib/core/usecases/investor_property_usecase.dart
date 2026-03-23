import '../../features/shared/services/investor_property_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for InvestorProperty

class GetInvestorPropertyByIdUseCase {
  final InvestorPropertyService _service;
  
  GetInvestorPropertyByIdUseCase(this._service);
  
  Future<InvestorProperty> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetInvestorPropertysUseCase {
  final InvestorPropertyService _service;
  
  GetInvestorPropertysUseCase(this._service);
  
  Future<List<InvestorProperty>> execute({
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

class CreateInvestorPropertyUseCase {
  final InvestorPropertyService _service;
  
  CreateInvestorPropertyUseCase(this._service);
  
  Future<InvestorProperty> execute(InvestorProperty investorProperty) async {
    // Add validation logic here
    return await _service.create(investorProperty);
  }
}

class UpdateInvestorPropertyUseCase {
  final InvestorPropertyService _service;
  
  UpdateInvestorPropertyUseCase(this._service);
  
  Future<InvestorProperty> execute(String id, InvestorProperty investorProperty) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, investorProperty);
  }
}

class DeleteInvestorPropertyUseCase {
  final InvestorPropertyService _service;
  
  DeleteInvestorPropertyUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// InvestorProperty Use Case Container
class InvestorPropertyUseCases {
  final GetInvestorPropertyByIdUseCase getById;
  final GetInvestorPropertysUseCase getAll;
  final CreateInvestorPropertyUseCase create;
  final UpdateInvestorPropertyUseCase update;
  final DeleteInvestorPropertyUseCase delete;
  
  InvestorPropertyUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory InvestorPropertyUseCases.create(InvestorPropertyService service) {
    return InvestorPropertyUseCases(
      getById: GetInvestorPropertyByIdUseCase(service),
      getAll: GetInvestorPropertysUseCase(service),
      create: CreateInvestorPropertyUseCase(service),
      update: UpdateInvestorPropertyUseCase(service),
      delete: DeleteInvestorPropertyUseCase(service),
    );
  }
}
