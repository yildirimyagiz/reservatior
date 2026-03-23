import '../../features/shared/services/m_l_s_external_listing_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for MLSExternalListing

class GetMLSExternalListingByIdUseCase {
  final MLSExternalListingService _service;
  
  GetMLSExternalListingByIdUseCase(this._service);
  
  Future<MLSExternalListing> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetMLSExternalListingsUseCase {
  final MLSExternalListingService _service;
  
  GetMLSExternalListingsUseCase(this._service);
  
  Future<List<MLSExternalListing>> execute({
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

class CreateMLSExternalListingUseCase {
  final MLSExternalListingService _service;
  
  CreateMLSExternalListingUseCase(this._service);
  
  Future<MLSExternalListing> execute(MLSExternalListing mLSExternalListing) async {
    // Add validation logic here
    return await _service.create(mLSExternalListing);
  }
}

class UpdateMLSExternalListingUseCase {
  final MLSExternalListingService _service;
  
  UpdateMLSExternalListingUseCase(this._service);
  
  Future<MLSExternalListing> execute(String id, MLSExternalListing mLSExternalListing) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, mLSExternalListing);
  }
}

class DeleteMLSExternalListingUseCase {
  final MLSExternalListingService _service;
  
  DeleteMLSExternalListingUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// MLSExternalListing Use Case Container
class MLSExternalListingUseCases {
  final GetMLSExternalListingByIdUseCase getById;
  final GetMLSExternalListingsUseCase getAll;
  final CreateMLSExternalListingUseCase create;
  final UpdateMLSExternalListingUseCase update;
  final DeleteMLSExternalListingUseCase delete;
  
  MLSExternalListingUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory MLSExternalListingUseCases.create(MLSExternalListingService service) {
    return MLSExternalListingUseCases(
      getById: GetMLSExternalListingByIdUseCase(service),
      getAll: GetMLSExternalListingsUseCase(service),
      create: CreateMLSExternalListingUseCase(service),
      update: UpdateMLSExternalListingUseCase(service),
      delete: DeleteMLSExternalListingUseCase(service),
    );
  }
}
