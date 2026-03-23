import '../../features/shared/services/marketing_campaign_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for MarketingCampaign

class GetMarketingCampaignByIdUseCase {
  final MarketingCampaignService _service;
  
  GetMarketingCampaignByIdUseCase(this._service);
  
  Future<MarketingCampaign> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetMarketingCampaignsUseCase {
  final MarketingCampaignService _service;
  
  GetMarketingCampaignsUseCase(this._service);
  
  Future<List<MarketingCampaign>> execute({
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

class CreateMarketingCampaignUseCase {
  final MarketingCampaignService _service;
  
  CreateMarketingCampaignUseCase(this._service);
  
  Future<MarketingCampaign> execute(MarketingCampaign marketingCampaign) async {
    // Add validation logic here
    return await _service.create(marketingCampaign);
  }
}

class UpdateMarketingCampaignUseCase {
  final MarketingCampaignService _service;
  
  UpdateMarketingCampaignUseCase(this._service);
  
  Future<MarketingCampaign> execute(String id, MarketingCampaign marketingCampaign) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, marketingCampaign);
  }
}

class DeleteMarketingCampaignUseCase {
  final MarketingCampaignService _service;
  
  DeleteMarketingCampaignUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// MarketingCampaign Use Case Container
class MarketingCampaignUseCases {
  final GetMarketingCampaignByIdUseCase getById;
  final GetMarketingCampaignsUseCase getAll;
  final CreateMarketingCampaignUseCase create;
  final UpdateMarketingCampaignUseCase update;
  final DeleteMarketingCampaignUseCase delete;
  
  MarketingCampaignUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory MarketingCampaignUseCases.create(MarketingCampaignService service) {
    return MarketingCampaignUseCases(
      getById: GetMarketingCampaignByIdUseCase(service),
      getAll: GetMarketingCampaignsUseCase(service),
      create: CreateMarketingCampaignUseCase(service),
      update: UpdateMarketingCampaignUseCase(service),
      delete: DeleteMarketingCampaignUseCase(service),
    );
  }
}
