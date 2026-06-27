import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/ambassador_campaign_service.dart';

abstract class AmbassadorCampaignRepository {
  Future<AmbassadorCampaign> getById(String id);
  Future<List<AmbassadorCampaign>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<AmbassadorCampaign> create(AmbassadorCampaign item);
  Future<AmbassadorCampaign> update(String id, AmbassadorCampaign item);
  Future<void> delete(String id);
}

class AmbassadorCampaignRepositoryImpl implements AmbassadorCampaignRepository {
  final AmbassadorCampaignService _service;
  AmbassadorCampaignRepositoryImpl(this._service);

  @override
  Future<AmbassadorCampaign> getById(String id) => _service.getAmbassadorCampaignById(id);

  @override
  Future<List<AmbassadorCampaign>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getAmbassadorCampaigns(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<AmbassadorCampaign> create(AmbassadorCampaign item) => _service.createAmbassadorCampaign(item);

  @override
  Future<AmbassadorCampaign> update(String id, AmbassadorCampaign item) => _service.updateAmbassadorCampaign(id, item);

  @override
  Future<void> delete(String id) => _service.deleteAmbassadorCampaign(id);
}
