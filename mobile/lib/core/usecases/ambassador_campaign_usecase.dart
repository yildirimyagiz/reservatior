import '../../features/shared/services/ambassador_campaign_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for AmbassadorCampaign

class GetAmbassadorCampaignByIdUseCase {
  final AmbassadorCampaignService _service;
  
  GetAmbassadorCampaignByIdUseCase(this._service);
  
  Future<AmbassadorCampaign> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetAmbassadorCampaignsUseCase {
  final AmbassadorCampaignService _service;
  
  GetAmbassadorCampaignsUseCase(this._service);
  
  Future<List<AmbassadorCampaign>> execute({
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

class CreateAmbassadorCampaignUseCase {
  final AmbassadorCampaignService _service;
  
  CreateAmbassadorCampaignUseCase(this._service);
  
  Future<AmbassadorCampaign> execute(AmbassadorCampaign ambassadorCampaign) async {
    // Add validation logic here
    return await _service.create(ambassadorCampaign);
  }
}

class UpdateAmbassadorCampaignUseCase {
  final AmbassadorCampaignService _service;
  
  UpdateAmbassadorCampaignUseCase(this._service);
  
  Future<AmbassadorCampaign> execute(String id, AmbassadorCampaign ambassadorCampaign) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, ambassadorCampaign);
  }
}

class DeleteAmbassadorCampaignUseCase {
  final AmbassadorCampaignService _service;
  
  DeleteAmbassadorCampaignUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// AmbassadorCampaign Use Case Container
class AmbassadorCampaignUseCases {
  final GetAmbassadorCampaignByIdUseCase getById;
  final GetAmbassadorCampaignsUseCase getAll;
  final CreateAmbassadorCampaignUseCase create;
  final UpdateAmbassadorCampaignUseCase update;
  final DeleteAmbassadorCampaignUseCase delete;
  
  AmbassadorCampaignUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory AmbassadorCampaignUseCases.create(AmbassadorCampaignService service) {
    return AmbassadorCampaignUseCases(
      getById: GetAmbassadorCampaignByIdUseCase(service),
      getAll: GetAmbassadorCampaignsUseCase(service),
      create: CreateAmbassadorCampaignUseCase(service),
      update: UpdateAmbassadorCampaignUseCase(service),
      delete: DeleteAmbassadorCampaignUseCase(service),
    );
  }
}
