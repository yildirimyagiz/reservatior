import '../../features/shared/services/vendor_profile_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for VendorProfile

class GetVendorProfileByIdUseCase {
  final VendorProfileService _service;
  
  GetVendorProfileByIdUseCase(this._service);
  
  Future<VendorProfile> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetVendorProfilesUseCase {
  final VendorProfileService _service;
  
  GetVendorProfilesUseCase(this._service);
  
  Future<List<VendorProfile>> execute({
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

class CreateVendorProfileUseCase {
  final VendorProfileService _service;
  
  CreateVendorProfileUseCase(this._service);
  
  Future<VendorProfile> execute(VendorProfile vendorProfile) async {
    // Add validation logic here
    return await _service.create(vendorProfile);
  }
}

class UpdateVendorProfileUseCase {
  final VendorProfileService _service;
  
  UpdateVendorProfileUseCase(this._service);
  
  Future<VendorProfile> execute(String id, VendorProfile vendorProfile) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, vendorProfile);
  }
}

class DeleteVendorProfileUseCase {
  final VendorProfileService _service;
  
  DeleteVendorProfileUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// VendorProfile Use Case Container
class VendorProfileUseCases {
  final GetVendorProfileByIdUseCase getById;
  final GetVendorProfilesUseCase getAll;
  final CreateVendorProfileUseCase create;
  final UpdateVendorProfileUseCase update;
  final DeleteVendorProfileUseCase delete;
  
  VendorProfileUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory VendorProfileUseCases.create(VendorProfileService service) {
    return VendorProfileUseCases(
      getById: GetVendorProfileByIdUseCase(service),
      getAll: GetVendorProfilesUseCase(service),
      create: CreateVendorProfileUseCase(service),
      update: UpdateVendorProfileUseCase(service),
      delete: DeleteVendorProfileUseCase(service),
    );
  }
}
