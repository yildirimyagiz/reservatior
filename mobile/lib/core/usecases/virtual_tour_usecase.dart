import '../../features/shared/services/virtual_tour_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for VirtualTour

class GetVirtualTourByIdUseCase {
  final VirtualTourService _service;
  
  GetVirtualTourByIdUseCase(this._service);
  
  Future<VirtualTour> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetVirtualToursUseCase {
  final VirtualTourService _service;
  
  GetVirtualToursUseCase(this._service);
  
  Future<List<VirtualTour>> execute({
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

class CreateVirtualTourUseCase {
  final VirtualTourService _service;
  
  CreateVirtualTourUseCase(this._service);
  
  Future<VirtualTour> execute(VirtualTour virtualTour) async {
    // Add validation logic here
    return await _service.create(virtualTour);
  }
}

class UpdateVirtualTourUseCase {
  final VirtualTourService _service;
  
  UpdateVirtualTourUseCase(this._service);
  
  Future<VirtualTour> execute(String id, VirtualTour virtualTour) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, virtualTour);
  }
}

class DeleteVirtualTourUseCase {
  final VirtualTourService _service;
  
  DeleteVirtualTourUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// VirtualTour Use Case Container
class VirtualTourUseCases {
  final GetVirtualTourByIdUseCase getById;
  final GetVirtualToursUseCase getAll;
  final CreateVirtualTourUseCase create;
  final UpdateVirtualTourUseCase update;
  final DeleteVirtualTourUseCase delete;
  
  VirtualTourUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory VirtualTourUseCases.create(VirtualTourService service) {
    return VirtualTourUseCases(
      getById: GetVirtualTourByIdUseCase(service),
      getAll: GetVirtualToursUseCase(service),
      create: CreateVirtualTourUseCase(service),
      update: UpdateVirtualTourUseCase(service),
      delete: DeleteVirtualTourUseCase(service),
    );
  }
}
