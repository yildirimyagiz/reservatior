import 'package:reservatior/shared/repositories/guest_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetGuestByIdUseCase {
  final GuestRepository _repository;
  GetGuestByIdUseCase(this._repository);
  Future<Guest> execute(String id) => _repository.getById(id);
}

class GetGuestsUseCase {
  final GuestRepository _repository;
  GetGuestsUseCase(this._repository);
  Future<List<Guest>> execute({
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

class CreateGuestUseCase {
  final GuestRepository _repository;
  CreateGuestUseCase(this._repository);
  Future<Guest> execute(Guest item) => _repository.create(item);
}

class UpdateGuestUseCase {
  final GuestRepository _repository;
  UpdateGuestUseCase(this._repository);
  Future<Guest> execute(String id, Guest item) => _repository.update(id, item);
}

class DeleteGuestUseCase {
  final GuestRepository _repository;
  DeleteGuestUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
