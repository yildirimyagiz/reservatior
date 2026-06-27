import 'package:reservatior/shared/repositories/vacation_rental_platform_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetVacationRentalPlatformByIdUseCase {
  final VacationRentalPlatformRepository _repository;
  GetVacationRentalPlatformByIdUseCase(this._repository);
  Future<VacationRentalPlatform> execute(String id) => _repository.getById(id);
}

class GetVacationRentalPlatformsUseCase {
  final VacationRentalPlatformRepository _repository;
  GetVacationRentalPlatformsUseCase(this._repository);
  Future<List<VacationRentalPlatform>> execute({
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

class CreateVacationRentalPlatformUseCase {
  final VacationRentalPlatformRepository _repository;
  CreateVacationRentalPlatformUseCase(this._repository);
  Future<VacationRentalPlatform> execute(VacationRentalPlatform item) => _repository.create(item);
}

class UpdateVacationRentalPlatformUseCase {
  final VacationRentalPlatformRepository _repository;
  UpdateVacationRentalPlatformUseCase(this._repository);
  Future<VacationRentalPlatform> execute(String id, VacationRentalPlatform item) => _repository.update(id, item);
}

class DeleteVacationRentalPlatformUseCase {
  final VacationRentalPlatformRepository _repository;
  DeleteVacationRentalPlatformUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
