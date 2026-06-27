import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/virtual_tour_service.dart';

abstract class VirtualTourRepository {
  Future<VirtualTour> getById(String id);
  Future<List<VirtualTour>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<VirtualTour> create(VirtualTour item);
  Future<VirtualTour> update(String id, VirtualTour item);
  Future<void> delete(String id);
}

class VirtualTourRepositoryImpl implements VirtualTourRepository {
  final VirtualTourService _service;
  VirtualTourRepositoryImpl(this._service);

  @override
  Future<VirtualTour> getById(String id) => _service.getVirtualTourById(id);

  @override
  Future<List<VirtualTour>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getVirtualTours(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<VirtualTour> create(VirtualTour item) => _service.createVirtualTour(item);

  @override
  Future<VirtualTour> update(String id, VirtualTour item) => _service.updateVirtualTour(id, item);

  @override
  Future<void> delete(String id) => _service.deleteVirtualTour(id);
}
