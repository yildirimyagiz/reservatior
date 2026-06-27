import 'package:reservatior/shared/repositories/lead_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetLeadByIdUseCase {
  final LeadRepository _repository;
  GetLeadByIdUseCase(this._repository);
  Future<Lead> execute(String id) => _repository.getById(id);
}

class GetLeadsUseCase {
  final LeadRepository _repository;
  GetLeadsUseCase(this._repository);
  Future<List<Lead>> execute({
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

class CreateLeadUseCase {
  final LeadRepository _repository;
  CreateLeadUseCase(this._repository);
  Future<Lead> execute(Lead item) => _repository.create(item);
}

class UpdateLeadUseCase {
  final LeadRepository _repository;
  UpdateLeadUseCase(this._repository);
  Future<Lead> execute(String id, Lead item) => _repository.update(id, item);
}

class DeleteLeadUseCase {
  final LeadRepository _repository;
  DeleteLeadUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
