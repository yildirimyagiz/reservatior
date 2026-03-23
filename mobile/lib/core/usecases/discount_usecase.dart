import '../../features/shared/services/discount_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for Discount

class GetDiscountByIdUseCase {
  final DiscountService _service;
  
  GetDiscountByIdUseCase(this._service);
  
  Future<Discount> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetDiscountsUseCase {
  final DiscountService _service;
  
  GetDiscountsUseCase(this._service);
  
  Future<List<Discount>> execute({
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

class CreateDiscountUseCase {
  final DiscountService _service;
  
  CreateDiscountUseCase(this._service);
  
  Future<Discount> execute(Discount discount) async {
    // Add validation logic here
    return await _service.create(discount);
  }
}

class UpdateDiscountUseCase {
  final DiscountService _service;
  
  UpdateDiscountUseCase(this._service);
  
  Future<Discount> execute(String id, Discount discount) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, discount);
  }
}

class DeleteDiscountUseCase {
  final DiscountService _service;
  
  DeleteDiscountUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// Discount Use Case Container
class DiscountUseCases {
  final GetDiscountByIdUseCase getById;
  final GetDiscountsUseCase getAll;
  final CreateDiscountUseCase create;
  final UpdateDiscountUseCase update;
  final DeleteDiscountUseCase delete;
  
  DiscountUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory DiscountUseCases.create(DiscountService service) {
    return DiscountUseCases(
      getById: GetDiscountByIdUseCase(service),
      getAll: GetDiscountsUseCase(service),
      create: CreateDiscountUseCase(service),
      update: UpdateDiscountUseCase(service),
      delete: DeleteDiscountUseCase(service),
    );
  }
}
