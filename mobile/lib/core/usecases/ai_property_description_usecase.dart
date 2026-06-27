import 'package:reservatior/shared/repositories/ai_property_description_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetAiPropertyDescriptionByIdUseCase {
  final AiPropertyDescriptionRepository _repository;
  GetAiPropertyDescriptionByIdUseCase(this._repository);
  Future<AiPropertyDescription> execute(String id) => _repository.getById(id);
}

class GetAiPropertyDescriptionsUseCase {
  final AiPropertyDescriptionRepository _repository;
  GetAiPropertyDescriptionsUseCase(this._repository);
  Future<List<AiPropertyDescription>> execute({
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

class CreateAiPropertyDescriptionUseCase {
  final AiPropertyDescriptionRepository _repository;
  CreateAiPropertyDescriptionUseCase(this._repository);
  Future<AiPropertyDescription> execute(AiPropertyDescription item) => _repository.create(item);
}

class UpdateAiPropertyDescriptionUseCase {
  final AiPropertyDescriptionRepository _repository;
  UpdateAiPropertyDescriptionUseCase(this._repository);
  Future<AiPropertyDescription> execute(String id, AiPropertyDescription item) => _repository.update(id, item);
}

class DeleteAiPropertyDescriptionUseCase {
  final AiPropertyDescriptionRepository _repository;
  DeleteAiPropertyDescriptionUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
