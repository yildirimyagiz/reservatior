import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/marketing_campaign_service.dart';

abstract class MarketingCampaignRepository {
  Future<MarketingCampaign> getById(String id);
  Future<List<MarketingCampaign>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<MarketingCampaign> create(MarketingCampaign item);
  Future<MarketingCampaign> update(String id, MarketingCampaign item);
  Future<void> delete(String id);
}

class MarketingCampaignRepositoryImpl implements MarketingCampaignRepository {
  final MarketingCampaignService _service;
  MarketingCampaignRepositoryImpl(this._service);

  @override
  Future<MarketingCampaign> getById(String id) => _service.getMarketingCampaignById(id);

  @override
  Future<List<MarketingCampaign>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getMarketingCampaigns(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<MarketingCampaign> create(MarketingCampaign item) => _service.createMarketingCampaign(item);

  @override
  Future<MarketingCampaign> update(String id, MarketingCampaign item) => _service.updateMarketingCampaign(id, item);

  @override
  Future<void> delete(String id) => _service.deleteMarketingCampaign(id);
}
