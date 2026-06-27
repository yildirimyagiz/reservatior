import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/payment_installment_service.dart';

abstract class PaymentInstallmentRepository {
  Future<PaymentInstallment> getById(String id);
  Future<List<PaymentInstallment>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<PaymentInstallment> create(PaymentInstallment item);
  Future<PaymentInstallment> update(String id, PaymentInstallment item);
  Future<void> delete(String id);
}

class PaymentInstallmentRepositoryImpl implements PaymentInstallmentRepository {
  final PaymentInstallmentService _service;
  PaymentInstallmentRepositoryImpl(this._service);

  @override
  Future<PaymentInstallment> getById(String id) => _service.getPaymentInstallmentById(id);

  @override
  Future<List<PaymentInstallment>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getPaymentInstallments(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<PaymentInstallment> create(PaymentInstallment item) => _service.createPaymentInstallment(item);

  @override
  Future<PaymentInstallment> update(String id, PaymentInstallment item) => _service.updatePaymentInstallment(id, item);

  @override
  Future<void> delete(String id) => _service.deletePaymentInstallment(id);
}
