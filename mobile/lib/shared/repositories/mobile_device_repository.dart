import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/mobile_device_service.dart';

abstract class MobileDeviceRepository {
  Future<MobileDevice> getById(String id);
  Future<List<MobileDevice>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<MobileDevice> create(MobileDevice item);
  Future<MobileDevice> update(String id, MobileDevice item);
  Future<void> delete(String id);
}

class MobileDeviceRepositoryImpl implements MobileDeviceRepository {
  final MobileDeviceService _service;
  MobileDeviceRepositoryImpl(this._service);

  @override
  Future<MobileDevice> getById(String id) => _service.getMobileDeviceById(id);

  @override
  Future<List<MobileDevice>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getMobileDevices(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<MobileDevice> create(MobileDevice item) => _service.createMobileDevice(item);

  @override
  Future<MobileDevice> update(String id, MobileDevice item) => _service.updateMobileDevice(id, item);

  @override
  Future<void> delete(String id) => _service.deleteMobileDevice(id);
}
