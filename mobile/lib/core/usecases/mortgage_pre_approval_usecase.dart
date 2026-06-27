import 'package:reservatior/shared/repositories/mortgage_pre_approval_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetMortgagePreApprovalByIdUseCase {
  final MortgagePreApprovalRepository _repository;
  GetMortgagePreApprovalByIdUseCase(this._repository);
  Future<MortgagePreApproval> execute(String id) => _repository.getById(id);
}

class GetMortgagePreApprovalsUseCase {
  final MortgagePreApprovalRepository _repository;
  GetMortgagePreApprovalsUseCase(this._repository);
  Future<List<MortgagePreApproval>> execute({
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

class CreateMortgagePreApprovalUseCase {
  final MortgagePreApprovalRepository _repository;
  CreateMortgagePreApprovalUseCase(this._repository);
  Future<MortgagePreApproval> execute(MortgagePreApproval item) => _repository.create(item);
}

class UpdateMortgagePreApprovalUseCase {
  final MortgagePreApprovalRepository _repository;
  UpdateMortgagePreApprovalUseCase(this._repository);
  Future<MortgagePreApproval> execute(String id, MortgagePreApproval item) => _repository.update(id, item);
}

class DeleteMortgagePreApprovalUseCase {
  final MortgagePreApprovalRepository _repository;
  DeleteMortgagePreApprovalUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
