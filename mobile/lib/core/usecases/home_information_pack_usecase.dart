import '../../features/shared/services/home_information_pack_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for HomeInformationPack

class GetHomeInformationPackByIdUseCase {
  final HomeInformationPackService _service;
  
  GetHomeInformationPackByIdUseCase(this._service);
  
  Future<HomeInformationPack> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetHomeInformationPacksUseCase {
  final HomeInformationPackService _service;
  
  GetHomeInformationPacksUseCase(this._service);
  
  Future<List<HomeInformationPack>> execute({
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

class CreateHomeInformationPackUseCase {
  final HomeInformationPackService _service;
  
  CreateHomeInformationPackUseCase(this._service);
  
  Future<HomeInformationPack> execute(HomeInformationPack homeInformationPack) async {
    // Add validation logic here
    return await _service.create(homeInformationPack);
  }
}

class UpdateHomeInformationPackUseCase {
  final HomeInformationPackService _service;
  
  UpdateHomeInformationPackUseCase(this._service);
  
  Future<HomeInformationPack> execute(String id, HomeInformationPack homeInformationPack) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, homeInformationPack);
  }
}

class DeleteHomeInformationPackUseCase {
  final HomeInformationPackService _service;
  
  DeleteHomeInformationPackUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// HomeInformationPack Use Case Container
class HomeInformationPackUseCases {
  final GetHomeInformationPackByIdUseCase getById;
  final GetHomeInformationPacksUseCase getAll;
  final CreateHomeInformationPackUseCase create;
  final UpdateHomeInformationPackUseCase update;
  final DeleteHomeInformationPackUseCase delete;
  
  HomeInformationPackUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory HomeInformationPackUseCases.create(HomeInformationPackService service) {
    return HomeInformationPackUseCases(
      getById: GetHomeInformationPackByIdUseCase(service),
      getAll: GetHomeInformationPacksUseCase(service),
      create: CreateHomeInformationPackUseCase(service),
      update: UpdateHomeInformationPackUseCase(service),
      delete: DeleteHomeInformationPackUseCase(service),
    );
  }
}
