import '../../features/shared/services/payment_negotiation_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for PaymentNegotiation

class GetPaymentNegotiationByIdUseCase {
  final PaymentNegotiationService _service;
  
  GetPaymentNegotiationByIdUseCase(this._service);
  
  Future<PaymentNegotiation> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetPaymentNegotiationsUseCase {
  final PaymentNegotiationService _service;
  
  GetPaymentNegotiationsUseCase(this._service);
  
  Future<List<PaymentNegotiation>> execute({
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

class CreatePaymentNegotiationUseCase {
  final PaymentNegotiationService _service;
  
  CreatePaymentNegotiationUseCase(this._service);
  
  Future<PaymentNegotiation> execute(PaymentNegotiation paymentNegotiation) async {
    // Add validation logic here
    return await _service.create(paymentNegotiation);
  }
}

class UpdatePaymentNegotiationUseCase {
  final PaymentNegotiationService _service;
  
  UpdatePaymentNegotiationUseCase(this._service);
  
  Future<PaymentNegotiation> execute(String id, PaymentNegotiation paymentNegotiation) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, paymentNegotiation);
  }
}

class DeletePaymentNegotiationUseCase {
  final PaymentNegotiationService _service;
  
  DeletePaymentNegotiationUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// PaymentNegotiation Use Case Container
class PaymentNegotiationUseCases {
  final GetPaymentNegotiationByIdUseCase getById;
  final GetPaymentNegotiationsUseCase getAll;
  final CreatePaymentNegotiationUseCase create;
  final UpdatePaymentNegotiationUseCase update;
  final DeletePaymentNegotiationUseCase delete;
  
  PaymentNegotiationUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory PaymentNegotiationUseCases.create(PaymentNegotiationService service) {
    return PaymentNegotiationUseCases(
      getById: GetPaymentNegotiationByIdUseCase(service),
      getAll: GetPaymentNegotiationsUseCase(service),
      create: CreatePaymentNegotiationUseCase(service),
      update: UpdatePaymentNegotiationUseCase(service),
      delete: DeletePaymentNegotiationUseCase(service),
    );
  }
}
