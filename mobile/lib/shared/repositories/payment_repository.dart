import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/payment_service.dart';

abstract class PaymentRepository {
  Future<Payment> getById(String id);
  Future<List<Payment>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<Payment> create(Payment item);
  Future<Payment> update(String id, Payment item);
  Future<void> delete(String id);
}

class PaymentRepositoryImpl implements PaymentRepository {
  final PaymentService _service;
  PaymentRepositoryImpl(this._service);

  @override
  Future<Payment> getById(String id) => _service.getPaymentById(id);

  @override
  Future<List<Payment>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getPayments(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<Payment> create(Payment item) => _service.createPayment(item);

  @override
  Future<Payment> update(String id, Payment item) => _service.updatePayment(id, item);

  @override
  Future<void> delete(String id) => _service.deletePayment(id);
}
