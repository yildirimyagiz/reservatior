import 'package:reservatior/shared/repositories/vacation_rental_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetVacationRentalByIdUseCase {
  final VacationRentalRepository _repository;
  GetVacationRentalByIdUseCase(this._repository);
  Future<VacationRental> execute(String id) => _repository.getById(id);
}

class GetVacationRentalsUseCase {
  final VacationRentalRepository _repository;
  GetVacationRentalsUseCase(this._repository);
  Future<List<VacationRental>> execute({
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

class CreateVacationRentalUseCase {
  final VacationRentalRepository _repository;
  CreateVacationRentalUseCase(this._repository);
  Future<VacationRental> execute(VacationRental item) => _repository.create(item);
}

class UpdateVacationRentalUseCase {
  final VacationRentalRepository _repository;
  UpdateVacationRentalUseCase(this._repository);
  Future<VacationRental> execute(String id, VacationRental item) => _repository.update(id, item);
}

class DeleteVacationRentalUseCase {
  final VacationRentalRepository _repository;
  DeleteVacationRentalUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
