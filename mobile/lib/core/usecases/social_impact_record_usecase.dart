import '../../features/shared/services/social_impact_record_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for SocialImpactRecord

class GetSocialImpactRecordByIdUseCase {
  final SocialImpactRecordService _service;
  
  GetSocialImpactRecordByIdUseCase(this._service);
  
  Future<SocialImpactRecord> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetSocialImpactRecordsUseCase {
  final SocialImpactRecordService _service;
  
  GetSocialImpactRecordsUseCase(this._service);
  
  Future<List<SocialImpactRecord>> execute({
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

class CreateSocialImpactRecordUseCase {
  final SocialImpactRecordService _service;
  
  CreateSocialImpactRecordUseCase(this._service);
  
  Future<SocialImpactRecord> execute(SocialImpactRecord socialImpactRecord) async {
    // Add validation logic here
    return await _service.create(socialImpactRecord);
  }
}

class UpdateSocialImpactRecordUseCase {
  final SocialImpactRecordService _service;
  
  UpdateSocialImpactRecordUseCase(this._service);
  
  Future<SocialImpactRecord> execute(String id, SocialImpactRecord socialImpactRecord) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, socialImpactRecord);
  }
}

class DeleteSocialImpactRecordUseCase {
  final SocialImpactRecordService _service;
  
  DeleteSocialImpactRecordUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// SocialImpactRecord Use Case Container
class SocialImpactRecordUseCases {
  final GetSocialImpactRecordByIdUseCase getById;
  final GetSocialImpactRecordsUseCase getAll;
  final CreateSocialImpactRecordUseCase create;
  final UpdateSocialImpactRecordUseCase update;
  final DeleteSocialImpactRecordUseCase delete;
  
  SocialImpactRecordUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory SocialImpactRecordUseCases.create(SocialImpactRecordService service) {
    return SocialImpactRecordUseCases(
      getById: GetSocialImpactRecordByIdUseCase(service),
      getAll: GetSocialImpactRecordsUseCase(service),
      create: CreateSocialImpactRecordUseCase(service),
      update: UpdateSocialImpactRecordUseCase(service),
      delete: DeleteSocialImpactRecordUseCase(service),
    );
  }
}
