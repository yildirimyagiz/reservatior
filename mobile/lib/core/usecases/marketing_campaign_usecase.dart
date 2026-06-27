import 'package:reservatior/shared/repositories/marketing_campaign_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetMarketingCampaignByIdUseCase {
  final MarketingCampaignRepository _repository;
  GetMarketingCampaignByIdUseCase(this._repository);
  Future<MarketingCampaign> execute(String id) => _repository.getById(id);
}

class GetMarketingCampaignsUseCase {
  final MarketingCampaignRepository _repository;
  GetMarketingCampaignsUseCase(this._repository);
  Future<List<MarketingCampaign>> execute({
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

class CreateMarketingCampaignUseCase {
  final MarketingCampaignRepository _repository;
  CreateMarketingCampaignUseCase(this._repository);
  Future<MarketingCampaign> execute(MarketingCampaign item) => _repository.create(item);
}

class UpdateMarketingCampaignUseCase {
  final MarketingCampaignRepository _repository;
  UpdateMarketingCampaignUseCase(this._repository);
  Future<MarketingCampaign> execute(String id, MarketingCampaign item) => _repository.update(id, item);
}

class DeleteMarketingCampaignUseCase {
  final MarketingCampaignRepository _repository;
  DeleteMarketingCampaignUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
