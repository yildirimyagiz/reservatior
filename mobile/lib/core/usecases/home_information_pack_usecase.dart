import 'package:reservatior/shared/repositories/home_information_pack_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetHomeInformationPackByIdUseCase {
  final HomeInformationPackRepository _repository;
  GetHomeInformationPackByIdUseCase(this._repository);
  Future<HomeInformationPack> execute(String id) => _repository.getById(id);
}

class GetHomeInformationPacksUseCase {
  final HomeInformationPackRepository _repository;
  GetHomeInformationPacksUseCase(this._repository);
  Future<List<HomeInformationPack>> execute({
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

class CreateHomeInformationPackUseCase {
  final HomeInformationPackRepository _repository;
  CreateHomeInformationPackUseCase(this._repository);
  Future<HomeInformationPack> execute(HomeInformationPack item) => _repository.create(item);
}

class UpdateHomeInformationPackUseCase {
  final HomeInformationPackRepository _repository;
  UpdateHomeInformationPackUseCase(this._repository);
  Future<HomeInformationPack> execute(String id, HomeInformationPack item) => _repository.update(id, item);
}

class DeleteHomeInformationPackUseCase {
  final HomeInformationPackRepository _repository;
  DeleteHomeInformationPackUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
