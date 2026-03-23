import '../../features/shared/services/payment_installment_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for PaymentInstallment

class GetPaymentInstallmentByIdUseCase {
  final PaymentInstallmentService _service;
  
  GetPaymentInstallmentByIdUseCase(this._service);
  
  Future<PaymentInstallment> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetPaymentInstallmentsUseCase {
  final PaymentInstallmentService _service;
  
  GetPaymentInstallmentsUseCase(this._service);
  
  Future<List<PaymentInstallment>> execute({
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

class CreatePaymentInstallmentUseCase {
  final PaymentInstallmentService _service;
  
  CreatePaymentInstallmentUseCase(this._service);
  
  Future<PaymentInstallment> execute(PaymentInstallment paymentInstallment) async {
    // Add validation logic here
    return await _service.create(paymentInstallment);
  }
}

class UpdatePaymentInstallmentUseCase {
  final PaymentInstallmentService _service;
  
  UpdatePaymentInstallmentUseCase(this._service);
  
  Future<PaymentInstallment> execute(String id, PaymentInstallment paymentInstallment) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, paymentInstallment);
  }
}

class DeletePaymentInstallmentUseCase {
  final PaymentInstallmentService _service;
  
  DeletePaymentInstallmentUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// PaymentInstallment Use Case Container
class PaymentInstallmentUseCases {
  final GetPaymentInstallmentByIdUseCase getById;
  final GetPaymentInstallmentsUseCase getAll;
  final CreatePaymentInstallmentUseCase create;
  final UpdatePaymentInstallmentUseCase update;
  final DeletePaymentInstallmentUseCase delete;
  
  PaymentInstallmentUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory PaymentInstallmentUseCases.create(PaymentInstallmentService service) {
    return PaymentInstallmentUseCases(
      getById: GetPaymentInstallmentByIdUseCase(service),
      getAll: GetPaymentInstallmentsUseCase(service),
      create: CreatePaymentInstallmentUseCase(service),
      update: UpdatePaymentInstallmentUseCase(service),
      delete: DeletePaymentInstallmentUseCase(service),
    );
  }
}
