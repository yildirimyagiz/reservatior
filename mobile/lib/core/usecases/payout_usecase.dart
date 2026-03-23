import '../../features/shared/services/payout_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for Payout

class GetPayoutByIdUseCase {
  final PayoutService _service;
  
  GetPayoutByIdUseCase(this._service);
  
  Future<Payout> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetPayoutsUseCase {
  final PayoutService _service;
  
  GetPayoutsUseCase(this._service);
  
  Future<List<Payout>> execute({
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

class CreatePayoutUseCase {
  final PayoutService _service;
  
  CreatePayoutUseCase(this._service);
  
  Future<Payout> execute(Payout payout) async {
    // Add validation logic here
    return await _service.create(payout);
  }
}

class UpdatePayoutUseCase {
  final PayoutService _service;
  
  UpdatePayoutUseCase(this._service);
  
  Future<Payout> execute(String id, Payout payout) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, payout);
  }
}

class DeletePayoutUseCase {
  final PayoutService _service;
  
  DeletePayoutUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// Payout Use Case Container
class PayoutUseCases {
  final GetPayoutByIdUseCase getById;
  final GetPayoutsUseCase getAll;
  final CreatePayoutUseCase create;
  final UpdatePayoutUseCase update;
  final DeletePayoutUseCase delete;
  
  PayoutUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory PayoutUseCases.create(PayoutService service) {
    return PayoutUseCases(
      getById: GetPayoutByIdUseCase(service),
      getAll: GetPayoutsUseCase(service),
      create: CreatePayoutUseCase(service),
      update: UpdatePayoutUseCase(service),
      delete: DeletePayoutUseCase(service),
    );
  }
}
