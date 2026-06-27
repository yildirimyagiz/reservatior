import 'package:reservatior/shared/repositories/mobile_device_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetMobileDeviceByIdUseCase {
  final MobileDeviceRepository _repository;
  GetMobileDeviceByIdUseCase(this._repository);
  Future<MobileDevice> execute(String id) => _repository.getById(id);
}

class GetMobileDevicesUseCase {
  final MobileDeviceRepository _repository;
  GetMobileDevicesUseCase(this._repository);
  Future<List<MobileDevice>> execute({
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

class CreateMobileDeviceUseCase {
  final MobileDeviceRepository _repository;
  CreateMobileDeviceUseCase(this._repository);
  Future<MobileDevice> execute(MobileDevice item) => _repository.create(item);
}

class UpdateMobileDeviceUseCase {
  final MobileDeviceRepository _repository;
  UpdateMobileDeviceUseCase(this._repository);
  Future<MobileDevice> execute(String id, MobileDevice item) => _repository.update(id, item);
}

class DeleteMobileDeviceUseCase {
  final MobileDeviceRepository _repository;
  DeleteMobileDeviceUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
