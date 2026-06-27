import 'package:reservatior/shared/repositories/payment_negotiation_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetPaymentNegotiationByIdUseCase {
  final PaymentNegotiationRepository _repository;
  GetPaymentNegotiationByIdUseCase(this._repository);
  Future<PaymentNegotiation> execute(String id) => _repository.getById(id);
}

class GetPaymentNegotiationsUseCase {
  final PaymentNegotiationRepository _repository;
  GetPaymentNegotiationsUseCase(this._repository);
  Future<List<PaymentNegotiation>> execute({
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

class CreatePaymentNegotiationUseCase {
  final PaymentNegotiationRepository _repository;
  CreatePaymentNegotiationUseCase(this._repository);
  Future<PaymentNegotiation> execute(PaymentNegotiation item) => _repository.create(item);
}

class UpdatePaymentNegotiationUseCase {
  final PaymentNegotiationRepository _repository;
  UpdatePaymentNegotiationUseCase(this._repository);
  Future<PaymentNegotiation> execute(String id, PaymentNegotiation item) => _repository.update(id, item);
}

class DeletePaymentNegotiationUseCase {
  final PaymentNegotiationRepository _repository;
  DeletePaymentNegotiationUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
