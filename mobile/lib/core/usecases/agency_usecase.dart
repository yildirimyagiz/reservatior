import 'package:reservatior/shared/repositories/agency_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetAgencyByIdUseCase {
  final AgencyRepository _repository;
  GetAgencyByIdUseCase(this._repository);
  Future<Agency> execute(String id) => _repository.getById(id);
}

class GetAgencysUseCase {
  final AgencyRepository _repository;
  GetAgencysUseCase(this._repository);
  Future<List<Agency>> execute({
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

class CreateAgencyUseCase {
  final AgencyRepository _repository;
  CreateAgencyUseCase(this._repository);
  Future<Agency> execute(Agency item) => _repository.create(item);
}

class UpdateAgencyUseCase {
  final AgencyRepository _repository;
  UpdateAgencyUseCase(this._repository);
  Future<Agency> execute(String id, Agency item) => _repository.update(id, item);
}

class DeleteAgencyUseCase {
  final AgencyRepository _repository;
  DeleteAgencyUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
