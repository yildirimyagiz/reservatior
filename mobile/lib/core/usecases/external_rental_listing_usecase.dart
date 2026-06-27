import 'package:reservatior/shared/repositories/external_rental_listing_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetExternalRentalListingByIdUseCase {
  final ExternalRentalListingRepository _repository;
  GetExternalRentalListingByIdUseCase(this._repository);
  Future<ExternalRentalListing> execute(String id) => _repository.getById(id);
}

class GetExternalRentalListingsUseCase {
  final ExternalRentalListingRepository _repository;
  GetExternalRentalListingsUseCase(this._repository);
  Future<List<ExternalRentalListing>> execute({
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

class CreateExternalRentalListingUseCase {
  final ExternalRentalListingRepository _repository;
  CreateExternalRentalListingUseCase(this._repository);
  Future<ExternalRentalListing> execute(ExternalRentalListing item) => _repository.create(item);
}

class UpdateExternalRentalListingUseCase {
  final ExternalRentalListingRepository _repository;
  UpdateExternalRentalListingUseCase(this._repository);
  Future<ExternalRentalListing> execute(String id, ExternalRentalListing item) => _repository.update(id, item);
}

class DeleteExternalRentalListingUseCase {
  final ExternalRentalListingRepository _repository;
  DeleteExternalRentalListingUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
