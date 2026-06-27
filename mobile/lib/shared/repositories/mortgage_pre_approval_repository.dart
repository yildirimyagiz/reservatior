import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/mortgage_pre_approval_service.dart';

abstract class MortgagePreApprovalRepository {
  Future<MortgagePreApproval> getById(String id);
  Future<List<MortgagePreApproval>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<MortgagePreApproval> create(MortgagePreApproval item);
  Future<MortgagePreApproval> update(String id, MortgagePreApproval item);
  Future<void> delete(String id);
}

class MortgagePreApprovalRepositoryImpl implements MortgagePreApprovalRepository {
  final MortgagePreApprovalService _service;
  MortgagePreApprovalRepositoryImpl(this._service);

  @override
  Future<MortgagePreApproval> getById(String id) => _service.getMortgagePreApprovalById(id);

  @override
  Future<List<MortgagePreApproval>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getMortgagePreApprovals(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<MortgagePreApproval> create(MortgagePreApproval item) => _service.createMortgagePreApproval(item);

  @override
  Future<MortgagePreApproval> update(String id, MortgagePreApproval item) => _service.updateMortgagePreApproval(id, item);

  @override
  Future<void> delete(String id) => _service.deleteMortgagePreApproval(id);
}
