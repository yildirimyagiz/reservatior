import '../../features/shared/services/mortgage_pre_approval_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for MortgagePreApproval

class GetMortgagePreApprovalByIdUseCase {
  final MortgagePreApprovalService _service;
  
  GetMortgagePreApprovalByIdUseCase(this._service);
  
  Future<MortgagePreApproval> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetMortgagePreApprovalsUseCase {
  final MortgagePreApprovalService _service;
  
  GetMortgagePreApprovalsUseCase(this._service);
  
  Future<List<MortgagePreApproval>> execute({
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

class CreateMortgagePreApprovalUseCase {
  final MortgagePreApprovalService _service;
  
  CreateMortgagePreApprovalUseCase(this._service);
  
  Future<MortgagePreApproval> execute(MortgagePreApproval mortgagePreApproval) async {
    // Add validation logic here
    return await _service.create(mortgagePreApproval);
  }
}

class UpdateMortgagePreApprovalUseCase {
  final MortgagePreApprovalService _service;
  
  UpdateMortgagePreApprovalUseCase(this._service);
  
  Future<MortgagePreApproval> execute(String id, MortgagePreApproval mortgagePreApproval) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, mortgagePreApproval);
  }
}

class DeleteMortgagePreApprovalUseCase {
  final MortgagePreApprovalService _service;
  
  DeleteMortgagePreApprovalUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// MortgagePreApproval Use Case Container
class MortgagePreApprovalUseCases {
  final GetMortgagePreApprovalByIdUseCase getById;
  final GetMortgagePreApprovalsUseCase getAll;
  final CreateMortgagePreApprovalUseCase create;
  final UpdateMortgagePreApprovalUseCase update;
  final DeleteMortgagePreApprovalUseCase delete;
  
  MortgagePreApprovalUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory MortgagePreApprovalUseCases.create(MortgagePreApprovalService service) {
    return MortgagePreApprovalUseCases(
      getById: GetMortgagePreApprovalByIdUseCase(service),
      getAll: GetMortgagePreApprovalsUseCase(service),
      create: CreateMortgagePreApprovalUseCase(service),
      update: UpdateMortgagePreApprovalUseCase(service),
      delete: DeleteMortgagePreApprovalUseCase(service),
    );
  }
}
