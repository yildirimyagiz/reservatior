import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/home_information_pack_service.dart';

abstract class HomeInformationPackRepository {
  Future<HomeInformationPack> getById(String id);
  Future<List<HomeInformationPack>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<HomeInformationPack> create(HomeInformationPack item);
  Future<HomeInformationPack> update(String id, HomeInformationPack item);
  Future<void> delete(String id);
}

class HomeInformationPackRepositoryImpl implements HomeInformationPackRepository {
  final HomeInformationPackService _service;
  HomeInformationPackRepositoryImpl(this._service);

  @override
  Future<HomeInformationPack> getById(String id) => _service.getHomeInformationPackById(id);

  @override
  Future<List<HomeInformationPack>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getHomeInformationPacks(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<HomeInformationPack> create(HomeInformationPack item) => _service.createHomeInformationPack(item);

  @override
  Future<HomeInformationPack> update(String id, HomeInformationPack item) => _service.updateHomeInformationPack(id, item);

  @override
  Future<void> delete(String id) => _service.deleteHomeInformationPack(id);
}
