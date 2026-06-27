import 'package:reservatior/shared/repositories/rent_schedule_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetRentScheduleByIdUseCase {
  final RentScheduleRepository _repository;
  GetRentScheduleByIdUseCase(this._repository);
  Future<RentSchedule> execute(String id) => _repository.getById(id);
}

class GetRentSchedulesUseCase {
  final RentScheduleRepository _repository;
  GetRentSchedulesUseCase(this._repository);
  Future<List<RentSchedule>> execute({
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

class CreateRentScheduleUseCase {
  final RentScheduleRepository _repository;
  CreateRentScheduleUseCase(this._repository);
  Future<RentSchedule> execute(RentSchedule item) => _repository.create(item);
}

class UpdateRentScheduleUseCase {
  final RentScheduleRepository _repository;
  UpdateRentScheduleUseCase(this._repository);
  Future<RentSchedule> execute(String id, RentSchedule item) => _repository.update(id, item);
}

class DeleteRentScheduleUseCase {
  final RentScheduleRepository _repository;
  DeleteRentScheduleUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
