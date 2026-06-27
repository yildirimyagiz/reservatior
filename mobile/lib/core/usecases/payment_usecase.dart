import 'package:reservatior/shared/repositories/payment_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetPaymentByIdUseCase {
  final PaymentRepository _repository;
  GetPaymentByIdUseCase(this._repository);
  Future<Payment> execute(String id) => _repository.getById(id);
}

class GetPaymentsUseCase {
  final PaymentRepository _repository;
  GetPaymentsUseCase(this._repository);
  Future<List<Payment>> execute({
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

class CreatePaymentUseCase {
  final PaymentRepository _repository;
  CreatePaymentUseCase(this._repository);
  Future<Payment> execute(Payment item) => _repository.create(item);
}

class UpdatePaymentUseCase {
  final PaymentRepository _repository;
  UpdatePaymentUseCase(this._repository);
  Future<Payment> execute(String id, Payment item) => _repository.update(id, item);
}

class DeletePaymentUseCase {
  final PaymentRepository _repository;
  DeletePaymentUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
