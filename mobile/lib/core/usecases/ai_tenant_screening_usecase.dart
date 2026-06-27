import 'package:reservatior/shared/repositories/ai_tenant_screening_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetAiTenantScreeningByIdUseCase {
  final AiTenantScreeningRepository _repository;
  GetAiTenantScreeningByIdUseCase(this._repository);
  Future<AiTenantScreening> execute(String id) => _repository.getById(id);
}

class GetAiTenantScreeningsUseCase {
  final AiTenantScreeningRepository _repository;
  GetAiTenantScreeningsUseCase(this._repository);
  Future<List<AiTenantScreening>> execute({
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

class CreateAiTenantScreeningUseCase {
  final AiTenantScreeningRepository _repository;
  CreateAiTenantScreeningUseCase(this._repository);
  Future<AiTenantScreening> execute(AiTenantScreening item) => _repository.create(item);
}

class UpdateAiTenantScreeningUseCase {
  final AiTenantScreeningRepository _repository;
  UpdateAiTenantScreeningUseCase(this._repository);
  Future<AiTenantScreening> execute(String id, AiTenantScreening item) => _repository.update(id, item);
}

class DeleteAiTenantScreeningUseCase {
  final AiTenantScreeningRepository _repository;
  DeleteAiTenantScreeningUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
