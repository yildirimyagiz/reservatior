import 'package:reservatior/shared/repositories/lead_source_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetLeadSourceByIdUseCase {
  final LeadSourceRepository _repository;
  GetLeadSourceByIdUseCase(this._repository);
  Future<LeadSource> execute(String id) => _repository.getById(id);
}

class GetLeadSourcesUseCase {
  final LeadSourceRepository _repository;
  GetLeadSourcesUseCase(this._repository);
  Future<List<LeadSource>> execute({
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

class CreateLeadSourceUseCase {
  final LeadSourceRepository _repository;
  CreateLeadSourceUseCase(this._repository);
  Future<LeadSource> execute(LeadSource item) => _repository.create(item);
}

class UpdateLeadSourceUseCase {
  final LeadSourceRepository _repository;
  UpdateLeadSourceUseCase(this._repository);
  Future<LeadSource> execute(String id, LeadSource item) => _repository.update(id, item);
}

class DeleteLeadSourceUseCase {
  final LeadSourceRepository _repository;
  DeleteLeadSourceUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
