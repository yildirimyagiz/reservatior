import '../../features/shared/services/brand_ambassador_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for BrandAmbassador

class GetBrandAmbassadorByIdUseCase {
  final BrandAmbassadorService _service;
  
  GetBrandAmbassadorByIdUseCase(this._service);
  
  Future<BrandAmbassador> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetBrandAmbassadorsUseCase {
  final BrandAmbassadorService _service;
  
  GetBrandAmbassadorsUseCase(this._service);
  
  Future<List<BrandAmbassador>> execute({
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

class CreateBrandAmbassadorUseCase {
  final BrandAmbassadorService _service;
  
  CreateBrandAmbassadorUseCase(this._service);
  
  Future<BrandAmbassador> execute(BrandAmbassador brandAmbassador) async {
    // Add validation logic here
    return await _service.create(brandAmbassador);
  }
}

class UpdateBrandAmbassadorUseCase {
  final BrandAmbassadorService _service;
  
  UpdateBrandAmbassadorUseCase(this._service);
  
  Future<BrandAmbassador> execute(String id, BrandAmbassador brandAmbassador) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, brandAmbassador);
  }
}

class DeleteBrandAmbassadorUseCase {
  final BrandAmbassadorService _service;
  
  DeleteBrandAmbassadorUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// BrandAmbassador Use Case Container
class BrandAmbassadorUseCases {
  final GetBrandAmbassadorByIdUseCase getById;
  final GetBrandAmbassadorsUseCase getAll;
  final CreateBrandAmbassadorUseCase create;
  final UpdateBrandAmbassadorUseCase update;
  final DeleteBrandAmbassadorUseCase delete;
  
  BrandAmbassadorUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory BrandAmbassadorUseCases.create(BrandAmbassadorService service) {
    return BrandAmbassadorUseCases(
      getById: GetBrandAmbassadorByIdUseCase(service),
      getAll: GetBrandAmbassadorsUseCase(service),
      create: CreateBrandAmbassadorUseCase(service),
      update: UpdateBrandAmbassadorUseCase(service),
      delete: DeleteBrandAmbassadorUseCase(service),
    );
  }
}
