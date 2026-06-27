import 'package:reservatior/shared/repositories/availability_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetAvailabilityByIdUseCase {
  final AvailabilityRepository _repository;
  GetAvailabilityByIdUseCase(this._repository);
  Future<Availability> execute(String id) => _repository.getById(id);
}

class GetAvailabilitysUseCase {
  final AvailabilityRepository _repository;
  GetAvailabilitysUseCase(this._repository);
  Future<List<Availability>> execute({
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

class CreateAvailabilityUseCase {
  final AvailabilityRepository _repository;
  CreateAvailabilityUseCase(this._repository);
  Future<Availability> execute(Availability item) => _repository.create(item);
}

class UpdateAvailabilityUseCase {
  final AvailabilityRepository _repository;
  UpdateAvailabilityUseCase(this._repository);
  Future<Availability> execute(String id, Availability item) => _repository.update(id, item);
}

class DeleteAvailabilityUseCase {
  final AvailabilityRepository _repository;
  DeleteAvailabilityUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
