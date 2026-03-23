import '../../features/shared/services/deal_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for Deal

class GetDealByIdUseCase {
  final DealService _service;
  
  GetDealByIdUseCase(this._service);
  
  Future<Deal> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetDealsUseCase {
  final DealService _service;
  
  GetDealsUseCase(this._service);
  
  Future<List<Deal>> execute({
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

class CreateDealUseCase {
  final DealService _service;
  
  CreateDealUseCase(this._service);
  
  Future<Deal> execute(Deal deal) async {
    // Add validation logic here
    return await _service.create(deal);
  }
}

class UpdateDealUseCase {
  final DealService _service;
  
  UpdateDealUseCase(this._service);
  
  Future<Deal> execute(String id, Deal deal) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, deal);
  }
}

class DeleteDealUseCase {
  final DealService _service;
  
  DeleteDealUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// Deal Use Case Container
class DealUseCases {
  final GetDealByIdUseCase getById;
  final GetDealsUseCase getAll;
  final CreateDealUseCase create;
  final UpdateDealUseCase update;
  final DeleteDealUseCase delete;
  
  DealUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory DealUseCases.create(DealService service) {
    return DealUseCases(
      getById: GetDealByIdUseCase(service),
      getAll: GetDealsUseCase(service),
      create: CreateDealUseCase(service),
      update: UpdateDealUseCase(service),
      delete: DeleteDealUseCase(service),
    );
  }
}
