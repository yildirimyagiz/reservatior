import '../../features/shared/services/payment_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for Payment

class GetPaymentByIdUseCase {
  final PaymentService _service;
  
  GetPaymentByIdUseCase(this._service);
  
  Future<Payment> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetPaymentsUseCase {
  final PaymentService _service;
  
  GetPaymentsUseCase(this._service);
  
  Future<List<Payment>> execute({
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

class CreatePaymentUseCase {
  final PaymentService _service;
  
  CreatePaymentUseCase(this._service);
  
  Future<Payment> execute(Payment payment) async {
    // Add validation logic here
    return await _service.create(payment);
  }
}

class UpdatePaymentUseCase {
  final PaymentService _service;
  
  UpdatePaymentUseCase(this._service);
  
  Future<Payment> execute(String id, Payment payment) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, payment);
  }
}

class DeletePaymentUseCase {
  final PaymentService _service;
  
  DeletePaymentUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// Payment Use Case Container
class PaymentUseCases {
  final GetPaymentByIdUseCase getById;
  final GetPaymentsUseCase getAll;
  final CreatePaymentUseCase create;
  final UpdatePaymentUseCase update;
  final DeletePaymentUseCase delete;
  
  PaymentUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory PaymentUseCases.create(PaymentService service) {
    return PaymentUseCases(
      getById: GetPaymentByIdUseCase(service),
      getAll: GetPaymentsUseCase(service),
      create: CreatePaymentUseCase(service),
      update: UpdatePaymentUseCase(service),
      delete: DeletePaymentUseCase(service),
    );
  }
}
