import 'package:reservatior/shared/repositories/vendor_profile_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetVendorProfileByIdUseCase {
  final VendorProfileRepository _repository;
  GetVendorProfileByIdUseCase(this._repository);
  Future<VendorProfile> execute(String id) => _repository.getById(id);
}

class GetVendorProfilesUseCase {
  final VendorProfileRepository _repository;
  GetVendorProfilesUseCase(this._repository);
  Future<List<VendorProfile>> execute({
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

class CreateVendorProfileUseCase {
  final VendorProfileRepository _repository;
  CreateVendorProfileUseCase(this._repository);
  Future<VendorProfile> execute(VendorProfile item) => _repository.create(item);
}

class UpdateVendorProfileUseCase {
  final VendorProfileRepository _repository;
  UpdateVendorProfileUseCase(this._repository);
  Future<VendorProfile> execute(String id, VendorProfile item) => _repository.update(id, item);
}

class DeleteVendorProfileUseCase {
  final VendorProfileRepository _repository;
  DeleteVendorProfileUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
