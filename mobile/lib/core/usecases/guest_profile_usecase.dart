import 'package:reservatior/shared/repositories/guest_profile_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetGuestProfileByIdUseCase {
  final GuestProfileRepository _repository;
  GetGuestProfileByIdUseCase(this._repository);
  Future<GuestProfile> execute(String id) => _repository.getById(id);
}

class GetGuestProfilesUseCase {
  final GuestProfileRepository _repository;
  GetGuestProfilesUseCase(this._repository);
  Future<List<GuestProfile>> execute({
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

class CreateGuestProfileUseCase {
  final GuestProfileRepository _repository;
  CreateGuestProfileUseCase(this._repository);
  Future<GuestProfile> execute(GuestProfile item) => _repository.create(item);
}

class UpdateGuestProfileUseCase {
  final GuestProfileRepository _repository;
  UpdateGuestProfileUseCase(this._repository);
  Future<GuestProfile> execute(String id, GuestProfile item) => _repository.update(id, item);
}

class DeleteGuestProfileUseCase {
  final GuestProfileRepository _repository;
  DeleteGuestProfileUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
