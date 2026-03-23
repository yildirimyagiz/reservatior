import '../../features/shared/services/mobile_device_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for MobileDevice

class GetMobileDeviceByIdUseCase {
  final MobileDeviceService _service;
  
  GetMobileDeviceByIdUseCase(this._service);
  
  Future<MobileDevice> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetMobileDevicesUseCase {
  final MobileDeviceService _service;
  
  GetMobileDevicesUseCase(this._service);
  
  Future<List<MobileDevice>> execute({
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

class CreateMobileDeviceUseCase {
  final MobileDeviceService _service;
  
  CreateMobileDeviceUseCase(this._service);
  
  Future<MobileDevice> execute(MobileDevice mobileDevice) async {
    // Add validation logic here
    return await _service.create(mobileDevice);
  }
}

class UpdateMobileDeviceUseCase {
  final MobileDeviceService _service;
  
  UpdateMobileDeviceUseCase(this._service);
  
  Future<MobileDevice> execute(String id, MobileDevice mobileDevice) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, mobileDevice);
  }
}

class DeleteMobileDeviceUseCase {
  final MobileDeviceService _service;
  
  DeleteMobileDeviceUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// MobileDevice Use Case Container
class MobileDeviceUseCases {
  final GetMobileDeviceByIdUseCase getById;
  final GetMobileDevicesUseCase getAll;
  final CreateMobileDeviceUseCase create;
  final UpdateMobileDeviceUseCase update;
  final DeleteMobileDeviceUseCase delete;
  
  MobileDeviceUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory MobileDeviceUseCases.create(MobileDeviceService service) {
    return MobileDeviceUseCases(
      getById: GetMobileDeviceByIdUseCase(service),
      getAll: GetMobileDevicesUseCase(service),
      create: CreateMobileDeviceUseCase(service),
      update: UpdateMobileDeviceUseCase(service),
      delete: DeleteMobileDeviceUseCase(service),
    );
  }
}
