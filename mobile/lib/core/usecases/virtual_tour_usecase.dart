import 'package:reservatior/shared/repositories/virtual_tour_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetVirtualTourByIdUseCase {
  final VirtualTourRepository _repository;
  GetVirtualTourByIdUseCase(this._repository);
  Future<VirtualTour> execute(String id) => _repository.getById(id);
}

class GetVirtualToursUseCase {
  final VirtualTourRepository _repository;
  GetVirtualToursUseCase(this._repository);
  Future<List<VirtualTour>> execute({
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

class CreateVirtualTourUseCase {
  final VirtualTourRepository _repository;
  CreateVirtualTourUseCase(this._repository);
  Future<VirtualTour> execute(VirtualTour item) => _repository.create(item);
}

class UpdateVirtualTourUseCase {
  final VirtualTourRepository _repository;
  UpdateVirtualTourUseCase(this._repository);
  Future<VirtualTour> execute(String id, VirtualTour item) => _repository.update(id, item);
}

class DeleteVirtualTourUseCase {
  final VirtualTourRepository _repository;
  DeleteVirtualTourUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
