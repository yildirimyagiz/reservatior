import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/social_impact_record_service.dart';

abstract class SocialImpactRecordRepository {
  Future<SocialImpactRecord> getById(String id);
  Future<List<SocialImpactRecord>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<SocialImpactRecord> create(SocialImpactRecord item);
  Future<SocialImpactRecord> update(String id, SocialImpactRecord item);
  Future<void> delete(String id);
}

class SocialImpactRecordRepositoryImpl implements SocialImpactRecordRepository {
  final SocialImpactRecordService _service;
  SocialImpactRecordRepositoryImpl(this._service);

  @override
  Future<SocialImpactRecord> getById(String id) => _service.getSocialImpactRecordById(id);

  @override
  Future<List<SocialImpactRecord>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getSocialImpactRecords(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<SocialImpactRecord> create(SocialImpactRecord item) => _service.createSocialImpactRecord(item);

  @override
  Future<SocialImpactRecord> update(String id, SocialImpactRecord item) => _service.updateSocialImpactRecord(id, item);

  @override
  Future<void> delete(String id) => _service.deleteSocialImpactRecord(id);
}
