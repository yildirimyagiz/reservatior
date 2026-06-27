import 'package:reservatior/shared/repositories/social_impact_record_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetSocialImpactRecordByIdUseCase {
  final SocialImpactRecordRepository _repository;
  GetSocialImpactRecordByIdUseCase(this._repository);
  Future<SocialImpactRecord> execute(String id) => _repository.getById(id);
}

class GetSocialImpactRecordsUseCase {
  final SocialImpactRecordRepository _repository;
  GetSocialImpactRecordsUseCase(this._repository);
  Future<List<SocialImpactRecord>> execute({
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

class CreateSocialImpactRecordUseCase {
  final SocialImpactRecordRepository _repository;
  CreateSocialImpactRecordUseCase(this._repository);
  Future<SocialImpactRecord> execute(SocialImpactRecord item) => _repository.create(item);
}

class UpdateSocialImpactRecordUseCase {
  final SocialImpactRecordRepository _repository;
  UpdateSocialImpactRecordUseCase(this._repository);
  Future<SocialImpactRecord> execute(String id, SocialImpactRecord item) => _repository.update(id, item);
}

class DeleteSocialImpactRecordUseCase {
  final SocialImpactRecordRepository _repository;
  DeleteSocialImpactRecordUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
