import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/payment_negotiation_service.dart';

abstract class PaymentNegotiationRepository {
  Future<PaymentNegotiation> getById(String id);
  Future<List<PaymentNegotiation>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<PaymentNegotiation> create(PaymentNegotiation item);
  Future<PaymentNegotiation> update(String id, PaymentNegotiation item);
  Future<void> delete(String id);
}

class PaymentNegotiationRepositoryImpl implements PaymentNegotiationRepository {
  final PaymentNegotiationService _service;
  PaymentNegotiationRepositoryImpl(this._service);

  @override
  Future<PaymentNegotiation> getById(String id) => _service.getPaymentNegotiationById(id);

  @override
  Future<List<PaymentNegotiation>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getPaymentNegotiations(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<PaymentNegotiation> create(PaymentNegotiation item) => _service.createPaymentNegotiation(item);

  @override
  Future<PaymentNegotiation> update(String id, PaymentNegotiation item) => _service.updatePaymentNegotiation(id, item);

  @override
  Future<void> delete(String id) => _service.deletePaymentNegotiation(id);
}
