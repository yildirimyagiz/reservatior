import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/social_impact_counter_service.dart';

abstract class SocialImpactCounterRepository {
  Future<SocialImpactCounter> getById(String id);
  Future<List<SocialImpactCounter>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<SocialImpactCounter> create(SocialImpactCounter item);
  Future<SocialImpactCounter> update(String id, SocialImpactCounter item);
  Future<void> delete(String id);
}

class SocialImpactCounterRepositoryImpl implements SocialImpactCounterRepository {
  final SocialImpactCounterService _service;
  SocialImpactCounterRepositoryImpl(this._service);

  @override
  Future<SocialImpactCounter> getById(String id) => _service.getSocialImpactCounterById(id);

  @override
  Future<List<SocialImpactCounter>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getSocialImpactCounters(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<SocialImpactCounter> create(SocialImpactCounter item) => _service.createSocialImpactCounter(item);

  @override
  Future<SocialImpactCounter> update(String id, SocialImpactCounter item) => _service.updateSocialImpactCounter(id, item);

  @override
  Future<void> delete(String id) => _service.deleteSocialImpactCounter(id);
}
