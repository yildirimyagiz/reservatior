import 'package:reservatior/shared/repositories/payment_installment_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetPaymentInstallmentByIdUseCase {
  final PaymentInstallmentRepository _repository;
  GetPaymentInstallmentByIdUseCase(this._repository);
  Future<PaymentInstallment> execute(String id) => _repository.getById(id);
}

class GetPaymentInstallmentsUseCase {
  final PaymentInstallmentRepository _repository;
  GetPaymentInstallmentsUseCase(this._repository);
  Future<List<PaymentInstallment>> execute({
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

class CreatePaymentInstallmentUseCase {
  final PaymentInstallmentRepository _repository;
  CreatePaymentInstallmentUseCase(this._repository);
  Future<PaymentInstallment> execute(PaymentInstallment item) => _repository.create(item);
}

class UpdatePaymentInstallmentUseCase {
  final PaymentInstallmentRepository _repository;
  UpdatePaymentInstallmentUseCase(this._repository);
  Future<PaymentInstallment> execute(String id, PaymentInstallment item) => _repository.update(id, item);
}

class DeletePaymentInstallmentUseCase {
  final PaymentInstallmentRepository _repository;
  DeletePaymentInstallmentUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
