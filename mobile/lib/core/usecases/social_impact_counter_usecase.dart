import 'package:reservatior/shared/repositories/social_impact_counter_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetSocialImpactCounterByIdUseCase {
  final SocialImpactCounterRepository _repository;
  GetSocialImpactCounterByIdUseCase(this._repository);
  Future<SocialImpactCounter> execute(String id) => _repository.getById(id);
}

class GetSocialImpactCountersUseCase {
  final SocialImpactCounterRepository _repository;
  GetSocialImpactCountersUseCase(this._repository);
  Future<List<SocialImpactCounter>> execute({
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

class CreateSocialImpactCounterUseCase {
  final SocialImpactCounterRepository _repository;
  CreateSocialImpactCounterUseCase(this._repository);
  Future<SocialImpactCounter> execute(SocialImpactCounter item) => _repository.create(item);
}

class UpdateSocialImpactCounterUseCase {
  final SocialImpactCounterRepository _repository;
  UpdateSocialImpactCounterUseCase(this._repository);
  Future<SocialImpactCounter> execute(String id, SocialImpactCounter item) => _repository.update(id, item);
}

class DeleteSocialImpactCounterUseCase {
  final SocialImpactCounterRepository _repository;
  DeleteSocialImpactCounterUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
