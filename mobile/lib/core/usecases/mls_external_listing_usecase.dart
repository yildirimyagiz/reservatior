import 'package:reservatior/shared/repositories/mls_external_listing_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetMlsExternalListingByIdUseCase {
  final MlsExternalListingRepository _repository;
  GetMlsExternalListingByIdUseCase(this._repository);
  Future<MlsExternalListing> execute(String id) => _repository.getById(id);
}

class GetMlsExternalListingsUseCase {
  final MlsExternalListingRepository _repository;
  GetMlsExternalListingsUseCase(this._repository);
  Future<List<MlsExternalListing>> execute({
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

class CreateMlsExternalListingUseCase {
  final MlsExternalListingRepository _repository;
  CreateMlsExternalListingUseCase(this._repository);
  Future<MlsExternalListing> execute(MlsExternalListing item) => _repository.create(item);
}

class UpdateMlsExternalListingUseCase {
  final MlsExternalListingRepository _repository;
  UpdateMlsExternalListingUseCase(this._repository);
  Future<MlsExternalListing> execute(String id, MlsExternalListing item) => _repository.update(id, item);
}

class DeleteMlsExternalListingUseCase {
  final MlsExternalListingRepository _repository;
  DeleteMlsExternalListingUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
