import '../../features/shared/services/social_impact_counter_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for SocialImpactCounter

class GetSocialImpactCounterByIdUseCase {
  final SocialImpactCounterService _service;
  
  GetSocialImpactCounterByIdUseCase(this._service);
  
  Future<SocialImpactCounter> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetSocialImpactCountersUseCase {
  final SocialImpactCounterService _service;
  
  GetSocialImpactCountersUseCase(this._service);
  
  Future<List<SocialImpactCounter>> execute({
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

class CreateSocialImpactCounterUseCase {
  final SocialImpactCounterService _service;
  
  CreateSocialImpactCounterUseCase(this._service);
  
  Future<SocialImpactCounter> execute(SocialImpactCounter socialImpactCounter) async {
    // Add validation logic here
    return await _service.create(socialImpactCounter);
  }
}

class UpdateSocialImpactCounterUseCase {
  final SocialImpactCounterService _service;
  
  UpdateSocialImpactCounterUseCase(this._service);
  
  Future<SocialImpactCounter> execute(String id, SocialImpactCounter socialImpactCounter) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, socialImpactCounter);
  }
}

class DeleteSocialImpactCounterUseCase {
  final SocialImpactCounterService _service;
  
  DeleteSocialImpactCounterUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// SocialImpactCounter Use Case Container
class SocialImpactCounterUseCases {
  final GetSocialImpactCounterByIdUseCase getById;
  final GetSocialImpactCountersUseCase getAll;
  final CreateSocialImpactCounterUseCase create;
  final UpdateSocialImpactCounterUseCase update;
  final DeleteSocialImpactCounterUseCase delete;
  
  SocialImpactCounterUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory SocialImpactCounterUseCases.create(SocialImpactCounterService service) {
    return SocialImpactCounterUseCases(
      getById: GetSocialImpactCounterByIdUseCase(service),
      getAll: GetSocialImpactCountersUseCase(service),
      create: CreateSocialImpactCounterUseCase(service),
      update: UpdateSocialImpactCounterUseCase(service),
      delete: DeleteSocialImpactCounterUseCase(service),
    );
  }
}
